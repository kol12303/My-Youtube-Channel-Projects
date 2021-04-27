library(REAT)
library(ggplot2)
library(dplyr)
library(readxl)


PIB_R <- read_excel("C:/Users/lom/Desktop/PIB_R.xlsx", 
                    sheet = "PIB_hab")
#View(PIB_R)
#Calculat gini coefficients"unweighted version" from 2001 to 2015
#G2001<-gini(PIB_R$y2001)
#G2002<-gini(PIB_R$y2002)
#G2003<-gini(PIB_R$y2003)
#G2004<-gini(PIB_R$y2004)

#Lorenz curve for 2005 and 2012, 2015
#Lorenz curve for 2005
gini (PIB_R$y2005, lsize=1, lc=TRUE, le.col = "black",
        lc.col = "red", lcx = "Shares of companies", 
        lcy = "Shares of turnover / cars",
        lctitle = "Automotive industry: market concentration",
        lcg = TRUE, lcgn = TRUE, lcg.caption = "Turnover 2005:", 
        lcg.lab.x = 0, lcg.lab.y = 1)
#Lorenz curve for 2012
gini(PIB_R$y2012,lsize=1, lc = TRUE, add.lc = TRUE, 
        lc.col = "blue",
        lcg = TRUE, lcgn = TRUE, lcg.caption = "Turnover 2012:", 
        lcg.lab.x = 0, lcg.lab.y = 0.8)
#Lorenz curve for 2015
gini(PIB_R$y2015,lsize=1, lc = TRUE, add.lc = TRUE, 
     lc.col = "green",
     lcg = TRUE, lcgn = TRUE, lcg.caption = "Turnover 2015:", 
     lcg.lab.x = 0, lcg.lab.y = 0.6)
 ### Gini Coef for the rest of periods              
G2005<-gini(PIB_R$y2005)
G2006<-gini(PIB_R$y2006)
G2007<-gini(PIB_R$y2007)
G2008<-gini(PIB_R$y2008)
G2009<-gini(PIB_R$y2009)
G2010<-gini(PIB_R$y2010)
G2011<-gini(PIB_R$y2011)
G2012<-gini(PIB_R$y2012)
G2013<-gini(PIB_R$y2013)
G2014<-gini(PIB_R$y2014)
G2015<-gini(PIB_R$y2015)
#####creat a serie of gini coeff  
Gin<- c(G2001,G2002,G2003,G2004,G2005,G2006,G2007,G2008,G2009,G2010,G2011,G2012,G2013,G2014,G2015)
###########creat time period
#years<-2001:2015
years<-seq.Date(from = as.Date('2001-01-01'), to = as.Date('2015-01-01'), by = 'years')
#View(years)
#####creat data 
xg <- data.frame("gini" = Gin, "Years" = years)
####Plot evolution of gini_Coef
##
ggplot(data = xg, aes(x = years, y =Gin)) +
  geom_line(color = "#00AFBB", size = 2) +
  labs(x = "years",
       y = "Indice de gini",
       title = "L'evolution de l'indice de gini régionalede de 2001-2015 Unweighted ",
       subtitle = "xxxxxxxxxx")
#Calculat gini coefficients"weighted version" from 2004 to 2015
gini_w4<-gini(PIB_R$y2004, coefnorm = FALSE, weighting = PIB_R$p_y2004)
gini_w5<-gini(PIB_R$y2005, coefnorm = FALSE, weighting = PIB_R$p_y2005)
gini_w6<-gini(PIB_R$y2006, coefnorm = FALSE, weighting = PIB_R$p_y2006)
gini_w7<-gini(PIB_R$y2007, coefnorm = FALSE, weighting = PIB_R$p_y2007)
gini_w8<-gini(PIB_R$y2008, coefnorm = FALSE, weighting = PIB_R$p_y2008)
gini_w9<-gini(PIB_R$y2009, coefnorm = FALSE, weighting = PIB_R$p_y2009)
gini_w10<-gini(PIB_R$y2010, coefnorm = FALSE, weighting = PIB_R$p_y2010)
gini_w11<-gini(PIB_R$y2011, coefnorm = FALSE, weighting = PIB_R$p_y2011)
gini_w12<-gini(PIB_R$y2012, coefnorm = FALSE, weighting = PIB_R$p_y2012)
gini_w13<-gini(PIB_R$y2013, coefnorm = FALSE, weighting = PIB_R$p_y2013)
gini_w14<-gini(PIB_R$y2014, coefnorm = FALSE, weighting = PIB_R$p_y2014)
gini_w15<-gini(PIB_R$y2015, coefnorm = FALSE, weighting = PIB_R$p_y2015)
##Creat a variable of gini weighted
gini_w<- c(gini_w4,gini_w5,gini_w6,gini_w7,gini_w8,gini_w9,gini_w10,gini_w11,gini_w12,gini_w13,gini_w14,gini_w15)
###########creat time period
#years<-2004:2015
years<-seq.Date(from = as.Date('2004-01-01'), to = as.Date('2015-01-01'), by = 'years')
#View(years)
#####creat data 
yg <- data.frame("gini" = gini_w, "Years" = years)
####Plot evolution of gini_Coef
ggplot(data = yg, aes(x = years, y = gini_w))+
 geom_line(color = "#FF0000", size = 2)+
 labs(x = "years",
       y = "Indice de gini",
       title = "L'evolution de l'indice de gini régionalede de 2001-2015 Weighted",
       subtitle = "xxxxxxxxxx")

########### End Code By OUASSOU Elhoussin ######################












data(G.counties.gdp)
#View(G.counties.gdp)
# Loading GDP data for Germany (counties = Landkreise)
sigmaconv (PIB_R$y2005, 2005,PIB_R$y2006, 2006,
           sigma.measure = "cv", print.results = TRUE)
# Using the coefficient of variation
sigmaconv (G.counties.gdp$gdppc2010, 2010, G.counties.gdp$gdppc2011, 2011,
           sigma.log = TRUE, print.results = TRUE)
# Using the standard deviation with logged GDP per capita
"##############################################"
data(G.counties.gdp)
# Loading GDP data for Germany (counties = Landkreise)
# Sigma convergence 2010-2014:
sigmaconv.t (G.counties.gdp$gdppc2010, 2010, G.counties.gdp[65:68], 2014,
             sigma.plot = TRUE, print.results = TRUE)
# Using the standard deviation with logged GDP per capita
sigmaconv.t (G.counties.gdp$gdppc2010, 2010, G.counties.gdp[65:68], 2014,
             sigma.measure = "cv", sigma.log = FALSE, print.results = TRUE)
# Using the coefficient of variation (GDP per capita not logged)








