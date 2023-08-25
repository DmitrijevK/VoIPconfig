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
  apt isntall
  cd /etc/asterisk
}
asterisk

pbx()
{
	clear
	Info
	log_t "VDS настройки и конфигурации"
  apt-get update
  apt -y Asterisk

}
pbx
