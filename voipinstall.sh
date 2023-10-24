#!/bin/bash

Infon() {
	printf "\033[1;32m$@\033[0m"
}
Info()
{
	Infon "$@\n"
}
Error()
{
	printf "\033[1;31m$@\033[0m\n"
}
Error_n()
{
	Error "$@"
}
Error_s()
{
	Error "============================================"
}
log_s()
{
	Info "============================================= "
}
log_n()
{
	Info " $@"
}
log_t()
{
	log_s
	Info "$@"
	log_s
}

menu()
{
	clear
	Info
	log_t "VOIP AutoSetup"
	Info "- 1  -  Install Asterisk"
	Info "- 2  -  Install FreePBX "
	Info "- 0  -  Выход"
	log_s
	Info
	read -p "Пожалуйста, введите пункт меню:" case
	case $case in
		1) asterisk;;   
                2) pbx;;   
		0) exit;;
	esac
}
menu

asterisk()
{
	clear
	Info
	log_t "Инсталяция"
	timedatectl set-timezone Europe/Moscow
 	apt install chrony
  	systemctl enable chrony --now
   	echo "Configure FireWall"
   	iptables -I INPUT -p tcp --match multiport --dports 5060,5061 -j ACCEPT
    	iptables -I INPUT -p udp --match multiport --dports 5060,5061 -j ACCEPT
     	iptables -I INPUT -p tcp --match multiport --dports 80,443 -j ACCEPT
      	iptables -I INPUT -p udp --dport 10000:20000 -j ACCEPT
       	apt install iptables-persistent
	netfilter-persistent save
 	useradd asterisk -m

}
asterisk

pbx()
{
	clear
	Info
	echo "Configure WebServer "
	apt install mariadb-server
 	systemctl enable mariadb --now
 	mysqladmin -u root password
  	echo "NGINX Configure"
   	apt isntall nginx
	echo "client_max_body_size 128M;" | sudo tee -a /etc/nginx/nginx.conf > /dev/null
	systemctl enable nginx
	systemctl restart nginx
 	apt install php php-fpm php-bcmath php-gd php-json php-mbstring php-mysqlnd php-pear php-snmp php-zip php-curl php-xml
  	systemctl disable apache2
}
pbx
