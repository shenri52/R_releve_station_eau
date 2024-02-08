# Script R : releve_station_eau

 Ce script permet de récupérer les relevés aux stations d'eaux diffusés sur le site https://www.vigicrues.gouv.fr/.
 
Il utilise l'API Hydrométrie.

Les données publiques de l'API "Hydrométrie" sont issues de la Plate-forme HYDRO Centrale (PHyC), opérée par le Service Central d’Hydrométéorologie et d’Appui à la Prévision des Inondations (SCHAPI). Cette Plate-forme stocke les mesures quasi temps-réel provenant d’environ 3000 stations hydrométriques qui constituent le réseau de mesure français, opéré par les DREAL ou autres producteurs.

## Descriptif du contenu

* Racine : emplacement du projet R --> "RELEVE_STATION_EAU.Rproj"
* Un dossier "data" pour stocker le fichier de configuration des stations
* Un dossier "result" pour le stockage du résultat
* Un dosssier script qui contient :
  * prog_releve_station.R --> script principal
  * librairie.R --> script contenant les librairies utiles au programme
  * releve_station.R --> script de téléchargement et de mise en forme des données
  * suppression_gitkeep.R --> script de suppression des .gitkeep
  * script en cours de développement et non appelé dans le script principal :
      * graph_releve.R --> graphiques des relevés par station

## Fonctionnement

1. Modifier le fichier "Liste_Station" dans le dossier "data" :
   * nom_station : saisir le nom de la station
   * num_station : saisir le numéro de la station
   * hauteur : saisir H si la station délivre la hauteur d'eau sinon laisser vide
   * debit : saisir Q si la station délivre le débit d'eau sinon laisser vide
2. Modifier la valeur affectée à la variable "nb_releve" pour indiquer le nombre de relevé souhaité
3. Lancer le script intitulé "prog_releve_station" qui se trouve dans le dossier "script"

## Résultat

Le dossier "result" contiendra:
  * un fichier csv nommé "releve_station_m" avec les relevés par stations en métre (hauteur)
  * un fichier csv nommé "releve_station_m3" avec les relevés par stations en m3 (débit)

