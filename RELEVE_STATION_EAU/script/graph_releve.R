################ Graphiques des relevés des informations aux stations    

# Initialisation de la variable pour l'affichage de 8 relevés en X
nb_x <- as.integer(nb_releve/8)

for (ii in 1:2)
{
  # Initialisation ddes variables pour création d'un graphique par station et grandeur d'eau
  ifelse(ii == 1,
         {liste_station <- as.data.frame(unique(releve_station_m$nom_station))
           g_hydro <- "H"
         },
         {liste_station <- as.data.frame(unique(releve_station_m3$nom_station))
           g_hydro <- "Q"  
         })
  
  # Initialisation de variable
  nb_station <- count(liste_station)
  
  for (i in 1:nb_station$n)
  {
    # Filtre des stations par nom et grandeur d'eau
    station <- releve_station %>%
               filter(nom_station == liste_station[i,1],
               grandeur_hydro == g_hydro) %>%
               # Remodelage de la date et de l'heure pour les étiquettes du graphiques
               mutate(dh_obs = paste(as.character(format(as_date(date_obs), "%d-%m")),
                                     substr(as.character(as_hms(as_datetime(date_obs))), 1, 5),
                                     sep = "\n"))
      
    # Classement des dates de relevés : plus ancienne à la plus récente
    station <- station[order(station$date_obs, decreasing = F),]

    # Construction du graphique
    station_graph <- ggplot(station) +
                    # Indication des axes
                    geom_line(aes( x= dh_obs, y = resultat_obs, group = 1), color = "darkblue") +
                    # Définition titre, sous-titre et légende
                    labs(title = paste("Station : ", station[i,1], sep = ""),
                         subtitle = paste(ifelse(station[i,6] == "H", "Hauteur d'eau (m)", "Débit d'eau (m3)"), 
                                          paste("pour la période du ",
                                                paste(as_datetime(station[i,3]), as_datetime(station[nb_releve,3]), sep = " au "),
                                          sep = ""),
                                    sep = " "),
                         caption = "Source : API Hub'eau") +
                    # Affichage de 8 valeurs en x
                    scale_x_discrete(breaks = c(station[nb_x,9], station[(nb_x*2),9],
                                                station[(nb_x*3),9], station[(nb_x*4),9],
                                                station[(nb_x*5),9], station[(nb_x*6),9],
                                                station[(nb_x*7),9], station[nb_releve,9])) +
                    # Modification d'u thème'autres élèments du graphique
                    theme(axis.text.x = element_text(hjust=0.5, size = 7),
                          axis.text.y = element_text(vjust=0, size = 7),
                          axis.title.y = element_blank(),
                          axis.title.x = element_blank(),
                          plot.title = element_text(size = 10, face = "bold"),
                          plot.subtitle = element_text(size = 8),
                          plot.caption = element_text(size = 7))
    
    ggsave(station_graph,
           filename = paste("result/", 
                        paste(station[i,1], 
                              paste(station[i,5], ".png", sep =""),
                        sep = "_"),
                  sep = ""),
           # Largeur / hauteur de l'image
           width = 6,
           height = 5,
           # Format de l'image
           device = "png")
  }
}

# Suppression des variables devenues inutiles
remove(g_hydro, i, ii, nb_station, station, liste_station, station_graph)
