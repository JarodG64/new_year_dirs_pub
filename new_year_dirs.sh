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