library(REAT)
library(ggplot2)
library(readxl)

PIB_Decomposition <- read_excel("C:/Users/LOKMAN/Desktop/Theil_Index/PIB_Decomposition.xlsx", 
                                sheet = "PIB_Decomp")
View(PIB_Decomposition)

#Calculat theil coefficients from 2001 to 2015 Un-weighted 

#theil1<-theil(PIB_Decomposition$y2001)
#theil2<-theil(PIB_Decomposition$y2002)
#theil3<-theil(PIB_Decomposition$y2003)
theil4<-theil(PIB_Decomposition$year_2004,weighting = NULL)
theil_4<-theil(PIB_Decomposition$year_2004)
theil5<-theil(PIB_Decomposition$year_2005)
theil6<-theil(PIB_Decomposition$year_2006)
theil7<-theil(PIB_Decomposition$year_2007)
theil8<-theil(PIB_Decomposition$year_2008)
theil9<-theil(PIB_Decomposition$year_2009)
theil10<-theil(PIB_Decomposition$year_2010)
theil11<-theil(PIB_Decomposition$year_2011)
theil12<-theil(PIB_Decomposition$year_2012)
theil13<-theil(PIB_Decomposition$year_2013)
theil14<-theil(PIB_Decomposition$year_2014)
theil15<-theil(PIB_Decomposition$year_2015)
#####creat a serie of theil coeff  
Theil_un<- c(theil4,theil5,theil6,theil7,theil8,theil9,theil10,theil11,theil12,theil13,theil14,theil15)
###########creat time period
#years<-2001:2015
years<-seq.Date(from = as.Date('2004-01-01'), to = as.Date('2015-01-01'), by = 'years')
#View(years)
#####creat data 
xt <- data.frame("theil" = Theil_un, "Years" = years)
####Plot evolution of theil_Coef
ggplot(data = xt, aes(x = years, y = Theil_un)) +
  geom_line(color = "#00AFBB", size = 2) +
  labs(x = "years",
       y = "Indice de theil",
       title = "L'evolution de l'indice de theil régionalede de 2004-2015 Unweighted ",
       subtitle = "xxxxxxxxxx")
###############################################################
#theil_w1<-theil(PIB_Decomposition$y2001,   weighting = PIB_Decomposition$p_y2001)
#theil_w2<-theil(PIB_Decomposition$y2002,   weighting = PIB_Decomposition$p_y2002)
#theil_w3<-theil(PIB_Decomposition$y2003,   weighting = PIB_Decomposition$p_y2003)

theil_w4<-theil(PIB_Decomposition$year_2004,na.rm = TRUE, weighting = PIB_Decomposition$p_y2004)
theil_w5<-theil(PIB_Decomposition$year_2005,   weighting = PIB_Decomposition$p_y2005)
theil_w6<-theil(PIB_Decomposition$year_2006,   weighting = PIB_Decomposition$p_y2006)
theil_w7<-theil(PIB_Decomposition$year_2007,   weighting = PIB_Decomposition$p_y2007)
theil_w8<-theil(PIB_Decomposition$year_2008,   weighting = PIB_Decomposition$p_y2008)
theil_w9<-theil(PIB_Decomposition$year_2009,   weighting = PIB_Decomposition$p_y2009)
theil_w10<-theil(PIB_Decomposition$year_2010,   weighting = PIB_Decomposition$p_y2010)
theil_w11<-theil(PIB_Decomposition$year_2011,   weighting = PIB_Decomposition$p_y2011)
theil_w12<-theil(PIB_Decomposition$year_2012,   weighting = PIB_Decomposition$p_y2012)
theil_w13<-theil(PIB_Decomposition$year_2013,   weighting = PIB_Decomposition$p_y2013)
theil_w14<-theil(PIB_Decomposition$year_2014,   weighting = PIB_Decomposition$p_y2014)
theil_w15<-theil(PIB_Decomposition$year_2015,   weighting = PIB_Decomposition$p_y2015)
##Creat theil variable
theil_w<- c(theil_w4,theil_w5,theil_w6,theil_w7,theil_w8,theil_w9,theil_w10,theil_w11,theil_w12,theil_w13,theil_w14,theil_w15)
###########creat time period
#years<-2004:2015
years<-seq.Date(from = as.Date('2004-01-01'), to = as.Date('2015-01-01'), by = 'years')
#View(years)
#####creat data 
yt <- data.frame("theil" = theil_w, "Years" = years)
####Plot evolution of theil_Coef
ggplot(data = yt, aes(x = years, y = theil_w))+
  geom_line(color = "#FF0000", size = 2)+
  labs(x = "years",
       y = "Indice de theil",
       title = "L'evolution de l'indice de theil régionale de 2004-2015 Weighted",
       subtitle = "xxxxxxxxxx")

###########End Code By OUASSOU Elhoussin ######################
# export data to excel.................
Years<-2004:2015
b <- data.frame("Years" = Years,"Theil_weighted" = theil_w,
                "Theil_unweighted" = Theil_un)
openxlsx::write.xlsx (b, file = "theil_04-15.xlsx")
