#!/bin/bash
YEL=$'\e[1;33m'
RED=$'\033[0;31m'
NC=$'\033[0m' # No Color
PRPL=$'\033[1;35m'
GRN=$'\e[1;32m'
BLUE=$'\e[3;49;34m'

printf "${BLUE}\n"
echo "██╗  ██╗███████╗████████╗ █████╗ ████████╗██╗   ██╗███████╗"
echo "██║ ██╔╝██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██║   ██║██╔════╝"
echo "█████╔╝ ███████╗   ██║   ███████║   ██║   ██║   ██║███████╗"
echo "██╔═██╗ ╚════██║   ██║   ██╔══██║   ██║   ██║   ██║╚════██║"
echo "██║  ██╗███████║   ██║   ██║  ██║   ██║   ╚██████╔╝███████║"
echo "╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝"
printf "\nPowered by KeepSec Technologies Inc.™\n"
printf "${NC}\n"

sudo -v &> /dev/null || printf "${RED}\nThis script must be run with sudo privileges${NC}\n";
printf "${GRN}\nThis script must be run with 'autoexpect' (see https://github.com/KeepSec-Technologies/KStatus)${NC}\n"
sleep 1
echo""
echo ""

read -p "How often in ${YEL}minutes${NC} do you want the cron job to run (0-60) : " cron
echo""
read -p "What is the ${YEL}email${NC} address that you want to receive your notifications : " to
echo""
read -p "What is the ${YEL}domain${NC} that will be used to send emails : " domain
echo""
printf "${GRN}Assure yourself that the domain is pointing to the IP of your server${NC}\n"
echo ""
sleep 1

read -p "What is the (${YEL}1${NC}) service you want to get notifications for : " service1
echo""
read -p "Do you want a second service? (Y/N) " yn1

if [[ $yn1 == Y || $yn1 == y ]]; then 
echo""
read -p "What is the (${YEL}2${NC}) service you want to get notifications for : " service2
echo""
read -p "Do you want a third service? (Y/N) " yn2
echo""
    if [[ $yn2 == Y || $yn2 == y ]]; then 
    read -p "What is the (${YEL}3${NC}) service you want to get notifications for : " service3
    echo""
    read -p "Do you want a fourth service? (Y/N) " yn3
    echo""
      if [[ $yn3 == Y || $yn3 == y ]]; then 
        echo""
        read -p "What is the (${YEL}4${NC}) service you want to get notifications for : " service4
        echo""
        read -p "Do you want a fifth service? (Y/N) " yn4
        e
        echo""
        if [[ $yn4 == Y || $yn4 == y ]]; then 
        echo""
        read -p "What is the (${YEL}5${NC}) service you want to get notifications for : " service5
        echo""
        fi
      fi
    fi
fi 

if [[ $yn1 == N || $yn1 == n ]]; then 

echo""

fi

function installing {
  tput civis
  spinner="⣾⣽⣻⢿⡿⣟⣯⣷"
  while :
  do
    for i in `seq 0 7`
    do
      printf "${PRPL}${spinner:$i:1}"
      printf "\010${NC}"
      sleep 0.2
    done
  done
}

installing &
SPIN_PID=$!
disown
printf "${PRPL}\nInstalling Postfix and Mailx ➜ ${NC}"

if [ -n "`command -v apt-get`" ]; then

sudo apt-get install -y debconf &> /dev/null
echo "postfix postfix/mailname string $domain" | debconf-set-selections
echo "postfix postfix/protocols select  all" | debconf-set-selections
echo "postfix postfix/mynetworks string  127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128" | debconf-set-selections
echo "postfix postfix/mailbox_limit string  0" | debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
echo "postfix postfix/compat_conversion_warning   boolean true" | debconf-set-selections
echo "postfix postfix/protocols select all" | debconf-set-selections
echo "postfix postfix/procmail boolean false" | debconf-set-selections
echo "postfix postfix/relayhost string" | debconf-set-selections
echo "postfix postfix/chattr boolean false" | debconf-set-selections
echo "postfix postfix/destinations string  $domain" | debconf-set-selections

fi

if [ -n "`command -v apt-get`" ];

then sudo apt-get -y install postfix > /dev/null  && sudo apt-get -y install bsd-mailx > /dev/null; 

elif [ -n "`command -v yum`" ]; 

then sudo yum install -y postfix > /dev/null  && sudo yum install -y mailx > /dev/null; 

elif [ -n "`command -v pacman`" ];

then sudo pacman -y install postfix > /dev/null  && sudo pacman install -y mailx > /dev/null; 

fi

sudo adduser --disabled-password --gecos "" notification &> /dev/null

if [ -n "`command -v yum`" ]; then

sudo sed -i -e "s/inet_interfaces = localhost/inet_interfaces = all/g" /etc/postfix/main.cf &> /dev/null
sudo sed -i -e "s/#mydomain =.*/mydomain = $domain/g" /etc/postfix/main.cf &> /dev/null 
sudo sed -i -e "s/#myorigin = $mydomain/myorigin = $mydomain/g" /etc/postfix/main.cf &> /dev/null
sudo sed -i -e "s/#mynetworks =.*/mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128/g" /etc/postfix/main.cf &> /dev/null
sudo sed -i -e "s/mydestination =.*/mydestination = mail."'$mydomain'", "'$mydomain'"/g" /etc/postfix/main.cf &> /dev/null
sudo sed -i -e "117d" /etc/postfix/main.cf &> /dev/null

fi

sudo systemctl enable postfix &> /dev/null
sudo systemctl start postfix > /dev/null
sudo systemctl reload postfix > /dev/null

#1
subject1="SERVICE DOWN: $service1"
status1="$(sudo systemctl show $service1 --no-page)"
status_text1=$(echo "${status1}" | grep 'ActiveState=' | cut -f2 -d=)


if [ "${status_text1}" == "inactive" ]; then

printf "The service '$service1' is currently down!\n\n Please check it out." | mail -r "notification" -s "$subject1" "$to"

fi

#2
subject2="SERVICE DOWN: $service2"
status2="$(sudo systemctl show $service2 --no-page)"
status_text2=$(echo "${status2}" | grep 'ActiveState=' | cut -f2 -d=)

if [ "${status_text2}" == "inactive" ]; then

printf "The service '$service2' is currently down!\n\n Please check it out." | mail -r "notification" -s "$subject2" "$to"

fi

#3
subject3="SERVICE DOWN: $service3"
status3="$(sudo systemctl show $service3 --no-page)"
status_text3=$(echo "${status3}" | grep 'ActiveState=' | cut -f2 -d=)

if [ "${status_text3}" == "inactive" ]; then

printf "The service '$service3' is currently down!\n\n Please check it out." | mail -r "notification" -s "$subject3" "$to"

fi

#4
subject4="SERVICE DOWN: $service4"
status4="$(sudo systemctl show $service4 --no-page)"
status_text4=$(echo "${status4}" | grep 'ActiveState=' | cut -f2 -d=)

if [ "${status_text4}" == "inactive" ]; then

printf "The service '$service4' is currently down!\n\n Please check it out." | mail -r "notification" -s "$subject4" "$to"

fi

#5
subject5="SERVICE DOWN: $service5"
status5="$(sudo systemctl show $service5 --no-page)"
status_text5=$(echo "${status5}" | grep 'ActiveState=' | cut -f2 -d=)

if [ "${status_text5}" == "inactive" ]; then

printf "The service '$service5' is currently down!\n\n Please check it out." | mail -r "notification" -s "$subject5" "$to"

fi

sudo chmod +x script.exp &> /dev/null
$Path1=$(echo $PWD)

croncmd="/usr/bin/expect $Path1/script.exp &> /dev/null"
cronjob="*/$cron * * * * $croncmd"

( crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | crontab -

kill -9 $SPIN_PID &> /dev/null
tput cnorm
echo ""
printf "${GRN}\n\nWe're done!${NC}"
echo ""

exit 0
