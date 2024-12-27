# Nouveaux dossiers pour la nouvelle annee

> Debut du projet le 24/12/2024.  
> Fin du projet le 27/12/2024.

Il s'agit d'automatiser la creation a chaque nouvelle annee des dossiers requis pour le stockage de donnees professionnelles. Cette mise a jour sera faite sur le serveur au moyen d'un script **Bash** et d'un couple service / timer de **systemd**. Les nouveaux dossiers seront ensuite repliques sur les autres systemes via [Syncthing](https://syncthing.net/).

## Script BASH

Le chemin de base sera le suivant : */mnt/dietpi_userdata/syncthing_data/professionnel/EIRL_Rigolini_Julien/*.  
Il faudra ensuite creer un dossier *&YEAR* dans les dossiers suivants :

+ *Comptabilite/Caisses/*
+ *Comptabilite/Factures/*
+ *Interlocuteurs/FDJ/Rapports_journaliers_de_Tirage/*
+ *Interlocuteurs/PMU/Rapports_journaliers/*
+ *Interlocuteurs/Pau_Diffusion_Presse/BCI/*
+ *Interlocuteurs/Pau_Diffusion_Presse/BL-BI/*
+ *Banque_BPACA/Commandes_de_monnaie/*
+ *Banque_BPACA/Releves/Compte_courant/*
+ *Banque_BPACA/Releves/Compte_FDJ/*
+ *Banque_BPACA/Releves/Compte_PMU/*
+ *Banque_BPACA/Releves/Releves_LCR/*
+ *Banque_NICKEL/*
+ *Social/Employes/Plannings/*

new_year_dirs.sh :

```bash
#! /bin/bash

# Creation des dossiers pour le stockage de donnees professionnelles pour l'annee en cours
# Version 1

# Definitions de variables
ARRAY_DIRS=("Comptabilite/Caisses/" \
"Comptabilite/Factures/" \
"Interlocuteurs/FDJ/Rapports_journaliers_de_Tirage/" \
"Interlocuteurs/PMU/Rapports_journaliers/" \
"Interlocuteurs/Pau_Diffusion_Presse/BCI/" \
"Interlocuteurs/Pau_Diffusion_Presse/BL-BI/" \
"Banque_BPACA/Commandes_de_monnaie/" \
"Banque_BPACA/Releves/Compte_courant/" \
"Banque_BPACA/Releves/Compte_FDJ/" \
"Banque_BPACA/Releves/Compte_PMU/" \
"Banque_BPACA/Releves/Releves_LCR/" \
"Banque_NICKEL/" \
"Social/Employes/Plannings/")
BASE="/mnt/dietpi_userdata/syncthing_data/professionnel/EIRL_Rigolini_Julien/"
YEAR=$(date +%Y)

# Creation des dossiers
for ITEM in ${ARRAY_DIRS[@]}
  do
    mkdir -p $BASE$ITEM$YEAR 2> /dev/null
done

exit 0
```

## SYSTEMD

### Service :

*/etc/systemd/system/new_year_dirs.service*

```ini
[Unit]
Description=Creation annuelle de dossiers de stockage
After=network.target syslog.target
Wants=network.target
ConditionFileIsExecutable=/usr/local/bin/new_year_dirs.sh

[Service]
Type=simple
ExecStart=/usr/local/bin/new_year_dirs.sh
User=dietpi
Group=dietpi

[Install]
WantedBy=multi-user.target
```

### Timer :

*/etc/systemd/system/new_year_dirs.timer*

```ini
[Unit]
Description=Creation annuelle de dossiers de stockage

[Timer]
OnBootSec=60
OnCalendar=*-1-1 00:10:00
Persistent=true

[Install]
WantedBy=timers.target
```

## Installation :

Il faut cloner le depot du projet puis executer le script *install.sh*.

```bash
git clone git@gitea.com:JarodG64/new_year_dirs_pub.git
cd new_year_dirs_pub/
./install.sh
```

install.sh :

```bash
#! /bin/bash

# Script d'installation pour new_year_dirs
# Version 1

# Installe le script et configure les permissions
echo "Installation du script :"
sudo cp -v new_year_dirs.sh /usr/local/bin/new_year_dirs.sh
sudo chmod 755 /usr/local/bin/new_year_dirs.sh

# Installe les services et configure les permissions
echo " "
echo "Installation du service et du timer :"
sudo cp -v new_year_dirs.service /etc/systemd/system/new_year_dirs.service
sudo chmod 644 /etc/systemd/system/new_year_dirs.service
sudo cp -v new_year_dirs.timer /etc/systemd/system/new_year_dirs.timer
sudo chmod 644 /etc/systemd/system/new_year_dirs.timer
sudo systemctl daemon-reload
echo " "
echo "Configuration du service et du timer :"
sudo systemctl enable new_year_dirs.service
sudo systemctl enable new_year_dirs.timer
sudo systemctl start new_year_dirs.timer
sudo systemctl status new_year_dirs.service
echo " "
sudo systemctl status new_year_dirs.timer

exit 0
```

## References :

+ [Baeldung : Running multi-line shell code](https://www.baeldung.com/linux/run-multi-line-shell-code)
+ [LinuxSimply : 3 ways to iterate an array in Bash](https://linuxsimply.com/bash-scripting-tutorial/array/elements-of-array/iterate-array/)
+ [Linuxtricks.fr : Creer des services timers](https://www.linuxtricks.fr/wiki/systemd-creer-des-services-timers-unites)
+ [Manpages.org : cp](https://fr.manpages.org/cp)


#bash #configuration #mdp #projet #systemd #timer