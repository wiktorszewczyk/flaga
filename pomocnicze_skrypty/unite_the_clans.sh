#!/bin/bash

# Warcraft 2 code - win scenario instantly.


# Ten code to cheat-mode: wygrana przygody 5 komendami :)

# Na świeżym serwerze:

# 1. wejdź na root (utwórz go jeżeli jeszcze nie robiłeś).
#
#    Napisz:
#    echo $USER
#    
#    jak pokazuje root to idź dalej. Jeżeli nie, utwórz hasło dla root:
#
#    sudo passwd
#    su

# 2. Update paczek.
#
#    apt update

# 3. Git.
#
#    apt install git
#    git clone https://github.com/ZPXD/flaga.git

# 4. Przypisz wartości zmiennym:
#
#    NEW_USER=ja_xd
#    DOMENA=domena.pl

# 5. Pozwól skryptowi działać i go uruchom:
#
#    source flaga/pomocnicze_skrypty/unite_the_clans.sh $NEW_USER $DOMENA 

#    gotowe!


# SCRIPT:

# Zmienne.
the_user=$1
domena=$2
klucz=xd_$1
flaga_start=`pwd`/flaga

# Update paczek.
apt upgrade

# Użytkownicy.
adduser $the_user
adduser $the_user sudo
adduser $the_user www-data


# Klucze RSA.
mkdir /home/$the_user/.ssh
chmod 700 /home/$the_user/.ssh
cd  /home/$the_user/.ssh
ssh-keygen -f /home/$the_user/.ssh/$klucz -C $the_user -N ''
cat /home/$the_user/.ssh/$klucz.pub > /home/$the_user/.ssh/authorized_keys
chmod 600 /home/$the_user/.ssh/authorized_keys
chown $the_user:$the_user /home/$the_user/.ssh
# IF UBUNTU IN HOME:
if [ $(getent passwd ubuntu) ] ; then
    echo "UBUNTU. COPYING KEY:"
    sudo cp $klucz /home/ubuntu/$klucz
    sudo chown ubuntu:ubuntu /home/ubuntu/$klucz
fi

# var/www
mkdir /var/www
chown -R www-data:www-data /var/www
chmod -R 775 /var/www

# Flaga
cd
mv $flaga_start /var/www/
rm -r $flaga_start 

# Dogranie paczek.
python3 /var/www/flaga/pomocnicze_skrypty/xD.py

# Środowisko.
python3 -m venv /var/www/flaga/flagaenv
source /var/www/flaga/flagaenv/bin/activate
export FLASK_APP=app.py
pip3 install -r /var/www/flaga/requirements.txt

# Serwerowe pliki i uruchomienie usługi i serwera.
python3 /var/www/flaga/pomocnicze_skrypty/xd.py $domena

chown -R $the_user:$the_user /var/www/flaga

# How to download the key:
server_ip=`curl -s http://checkip.amazonaws.com`
if [ $(getent passwd ubuntu) ] ; then
    echo "Get your key by using command:"
    echo "Paste below command into your terminal in computer"
    echo " while being in /.shh folder:"
    echo " "
    echo "scp -i klucz.pem ubuntu@$server_ip:/home/ubuntu/$klucz $klucz"
else
    echo "Get your key by using command:"
    echo "Paste below command into your terminal in computer"
    echo " while being in /.shh folder:"
    echo " "
    echo "scp root@$server_ip:/home/$the_user/.ssh/$klucz $klucz"
fi

# INFO:
echo "Stworzony użytkownik:" $the_user
echo "Stworzona strona na domenie:" $domena
echo " "
echo "Sprawdź Twoją domenę w przeglądarce."

su $the_user
