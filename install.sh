#! /bin/bash

# Script d'installation pour new_year_dirs
# Version 1

# Installe le script et configure les permissions
echo "Installation du script :"
sudo cp -uv new_year_dirs.sh /usr/local/bin/new_year_dirs.sh
sudo chmod 755 /usr/local/bin/new_year_dirs.sh

# Installe les services et configure les permissions
echo " "
echo "Installation du service et du timer :"
sudo cp -uv new_year_dirs.service /etc/systemd/system/new_year_dirs.service
sudo chmod 644 /etc/systemd/system/new_year_dirs.service
sudo cp -uv new_year_dirs.timer /etc/systemd/system/new_year_dirs.timer
sudo chmod 644 /etc/systemd/system/new_year_dirs.timer
sudo systemctl daemon-reload
echo " "
echo "Configuration du service et du timer :"
sudo systemctl enable new_year_dirs.service
sudo systemctl enable new_year_dirs.timer
#sudo systemctl stop new_year_dirs.service
sudo systemctl start new_year_dirs.timer
echo " "
sudo systemctl status new_year_dirs.service
echo " "
sudo systemctl status new_year_dirs.timer

exit 0