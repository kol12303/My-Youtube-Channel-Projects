library(REAT)
library(ggplot2)
library(readxl)

PIB_Decomposition <- read_excel("C:/Users/LOKMAN/Desktop/Theil_Index/Theil_index_Method-2/PIB_Decomposition.xlsx", 
                                sheet = "PIB_Decomp")

View(PIB_Decomposition)
#View(PIB_Decomposition)
#............Un-weighted theil coefficients from 2004 to 2015..........

theil_u2 <- apply (PIB_Decomposition[5:16], MARGIN = 2, FUN = theil)

years<-seq.Date(from = as.Date('2004-01-01'), to = as.Date('2015-01-01'), by = 'years')

theil_y <- data.frame("theil" = theil_u2, "Years" = years)
################
ggplot(data = theil_y, aes(x = years, y = theil_u2)) +
  geom_line(color = "red", size = 2) +
  labs(x = "years",
       y = "Indice de theil",
       title = "L'evolution de l'indice de theil régionale de 2004-2015 ",
       subtitle = "xxxxxxxxxx")
#View(theil_y)
#............weighted theil coefficients from 2004 to 2015..........
theil_w2 <- apply (PIB_Decomposition[5:16], MARGIN = 2,weighting = PIB_Decomposition[21:32], FUN = theil)

years<-seq.Date(from = as.Date('2004-01-01'), to = as.Date('2015-01-01'), by = 'years')
theil_yw <- data.frame("theil" = theil_w2, "Years" = years)
#View(theil_yw)...................................................

ggplot(data = theil_yw, aes(x = years, y = theil_w2,colour = variable)) +
geom_line(color = "#00AFBB", size = 2) +
  labs(x = "years",
  y = "Indice de theil",
  title = "L'evolution de l'indice de theil régionale de 2004-2015 ",
  subtitle = "xxxxxxxxxx")

#.......END CODE BY EL HOUSSIN OUASSOU................
Years<-2004:2015
b <- data.frame("Years" = Years,"Theil_weighted" = theil_w2,
                "Theil_unweighted" = theil_u2)
openxlsx::write.xlsx (b, file = "theil2_04-15.xlsx")
############################################
ggplot(data=b)+
geom_line(mapping=aes(y=theil_w2,x= years,color="Theil_weighted"),size=1.5 ) +
geom_line(mapping=aes(y=theil_u2,x= years,color="Theil_unweighted"),size=1.5) +
scale_color_manual(values = c(
    'Theil_weighted' = 'deepskyblue',
    'Theil_unweighted' = 'red')) +
  theme(legend.position="bottom", legend.box = "horizontal")+
  labs(x = "years",y = "Indice de Theil",color = '',
       title = "L'evolution de l'indice de Theil régionale de 2001-2015 ",
       subtitle = "Weighted et Unweighted")






 





