#!/bin/bash
case $1 in
        normal)
                #update & upgrade
                sudo apk update && sudo apk upgrade && sudo apk add vim pstree
                #讓提示字元有顏色
                sed 's/export PS1=\"/#export PS1=\"/' /etc/profile | sudo tee /etc/profile &>/dev/null
                sudo cp /etc/profile.d/color_prompt.sh.disabled /etc/profile.d/color_prompt.sh
                echo ' 
                # Setup a red prompt for root and a green one for users.
                # Symlink this file to color_prompt.sh to actually enable it.

                if [ "$USER" = "bigred" ] || [ "$USER" = "root" ]; then
                        PS1="\e[34;1m\u\e[m@\e[91;1m\h\e[m:\e[32;1m\w\e[m\e[33;1m# \e[m"
                else
                        PS1="\e[33;1m\u\e[m@\e[91;1m\h\e[m:\e[32;1m\w\e[m\e[33;1m# \e[m"
                fi' | sudo tee /etc/profile.d/color_prompt.sh &>/dev/null
                exit
        ;;

        setk8s)
                #設定M1 K8S環境
                sudo apk add kubeadm kubelet kubectl --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted && sudo rc-update add kubelet default
                sudo reboot
        ;;

        continuek8s)
                #設定M1 kubeadm環境
                echo 'Please input your domain name:' && read
                sudo kubeadm init --service-cidr 10.98.0.0/24 --pod-network-cidr 10.244.0.0/16  --service-dns-domain=$REPLY --apiserver-advertise-address $IP
                #設定M1 bigred為管理者
                mkdir -p $HOME/.kube; sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config; sudo chown $(id -u):$(id -g) $HOME/.kube/config
                #設定m1機器為master也是node
                kubectl taint node m1 node-role.kubernetes.io/master- node-role.kubernetes.io/control-plane-
                #設定W1 W2 K8S環境
                ssh w1 sudo apk add kubeadm kubelet --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted && ssh w1 sudo rc-update add kubelet default
                ssh w2 sudo apk add kubeadm kubelet --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted && ssh w2 sudo rc-update add kubelet default
                #下載flannel
                kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
                #將w1 & w2加入k8s cluster
                export join=$(echo "sudo `kubeadm token create --print-join-command 2>/dev/null`")
                ssh w1 "$join"
                ssh w2 "$join"
                echo
                echo 'Reboot after 5 seconds!'
                sleep 5
                ssh w1 sudo reboot &>/dev/null
                ssh w2 sudo reboot &>/dev/null
                sudo reboot
        ;;

        *)
                echo Please input parameter [normal/setk8s/continuek8s].
        ;;
esac