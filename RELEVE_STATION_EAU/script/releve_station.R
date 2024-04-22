################ Relevé des informations de hauteurs d'eau aux stations     

##############################################################################################################
###Observations en mm, il faut les diviser par 1000 pour les convertir en mètres (grandeur_hydro = H)      ###
###Observations en l/s, il faut les diviser par 1000 pour les convertir en m3 (grandeur_hydro = Q)         ###
###                                                                                                        ###
###L'heure est indiqué en UTC, pour obtenir l'heure française il faut rajouter :                           ###
###- +1 en été;                                                                                            ###
###- +2 en hiver.                                                                                          ###
##############################################################################################################

# Chargement de la liste des stations
liste_station <- read.csv("data/Liste_Station.csv", header = TRUE, sep=",")

for (ii in 1:2)
{
  # Initialisation de l'indice de la colonne avec la grandeur d'eau
  ifelse(ii == 1,
         {print("*** RECUPERATION DES HAUTEURS D'EAU AUX STATIONS ***")
          g_hydro <- 3 
         },
         {print("*** RECUPERATION DES DEBITS D'EAU AUX STATIONS ***")
          g_hydro <- 4  
         })
  
  # Initialisation des variables
  releve_station <- data.frame()

  for (i in 1:nrow(liste_station))
  {
    if(liste_station[i,g_hydro] != "")
      {
        # Création du lien de la station d'eau
        lien_station <- paste("https://hubeau.eaufrance.fr/api/v1/hydrometrie/observations_tr.csv?grandeur_hydro=",
                              paste(liste_station[i,g_hydro], "&code_entite=", sep = ""),
                              paste(liste_station[i, 2], 
                                    paste("&size=", nb_releve, sep = ""),
                                    sep =""),
                              sep = "")
        
        # Récupération des données
        station <- read.delim(lien_station,
                              sep =";",
                              stringsAsFactors = FALSE)
        
        # Mise en forme des données reçues
        station <- station %>%
                   # Ajout du nom de la station
                   mutate(nom_station = liste_station[i, 1]) %>%
                   # Conversion du résultat en m3 ou en mm en fonction du code hydro
                   mutate(resultat_obs = round(resultat_obs/1000,2)) %>%
                   # Indication du type de résultat
                   mutate(type_obs = ifelse(g_hydro == 3, "m","m3")) %>%
                   select(nom_station, code_station, date_obs, resultat_obs, type_obs, grandeur_hydro, longitude, latitude)
        
        # Affichage d'un message d'information sur le téléchargemebt des données
        print(paste("OK ----------------> ",liste_station[i, 1], sep =""))
        
        # Regroupement des données de chaque station dans une seule base de données
        releve_station <- rbind(releve_station, station)
    }
    
  }
  
  # Création d'une base en fonction du type de la grandeur hydro
  ifelse(g_hydro == 3,
         releve_station_m <- releve_station,
         releve_station_m3 <- releve_station
        )
}

# Assemblage des 2 types de relevés
releve_station <- rbind(releve_station, releve_station_m)

# Suppression des variables devenues inutiles
remove(g_hydro, i, ii, lien_station, nb_station, station, liste_station)

# Export des données
write.table(releve_station_m,
            file = "result/releve_station_m.csv",
            fileEncoding = "UTF-8",
            sep =";",
            row.names = FALSE)

write.table(releve_station_m3,
            file = "result/releve_station_m3.csv",
            fileEncoding = "UTF-8",
            sep =";",
            row.names = FALSE)
