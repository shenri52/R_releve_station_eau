#######################################################################################
# Ce script permet de récupérer les relevés aux stations d'eaux diffusés sur le site  # 
# https://www.vigicrues.gouv.fr/                                                      #
#                                                                                     #                                                   ###
# Il utilise l'API Hydrométrie :                                                      #                                                   ###
#     Les données publiques de l'API "Hydrométrie" sont issues de la Plate-forme      #
#     HYDRO Centrale (PHyC), opérée par le Service Central d’Hydrométéorologie et     #
#     d’Appui à la Prévision des Inondations (SCHAPI).                                #
#     Cette Plate-forme stocke les mesures quasi temps-réel provenant d’environ 3000  #
#     stations hydrométriques qui constituent le réseau de mesure français, opéré     #
#     par les DREAL ou autres producteurs                                             #
#######################################################################################
# Fonctionnement :                                                                    #
#     1 - Compléter ou modifier le fichier 'Liste_Station' avec les stations :        #
#           * nom de la station                                                       #
#           * numéro de la station                                                    #
#           * un H dans la colonne hauteur si la station donne cette information      #
#           * un Q dans la colonne debit si la station donne cette information        #
#     2 - Téléchargement des 70 derniers relevés (paramétrables)                      #
#                                                                                     #
# Résultat :                                                                          #
#     - un fichier csv nommé 'releve_station_m' dans le dossier "result" avec les     #
#     relevés par stations en m (hauteur)                                             #
#     - un tableau nommé 'releve_station_m3' dans le dossier "result" avec les        #
#     relevés par stations en m3 (débit)                                              #
#######################################################################################


################ Indication du nombre de relevés souhaités
nb_releve <- 70

################ Chargement des librairies

source("./script/librairie.R")

#################### Suppression des fichiers gitkeep

source("script/suppression_gitkeep.R")

################ Relevé des informations aux stations 

source("./script/releve_station.R")