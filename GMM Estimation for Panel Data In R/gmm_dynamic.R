library(sandwich);library(plm);library(readxl)
#...........
Model_Regional <- read_excel("C:/Users/lom/Desktop/Data/Model_Regional - Copy.xlsx")
#............................define Data as panel data
Regional <- pdata.frame(Model_Regional, index=c("id", "year"))
#View(Regional)..................Load Data...................................

# Dynamic 
######################################################################
#  effect = c("individual","twoways")
#  model = c("onestep","twosteps")
# transformation=c("ld","d")
# fsm=c("GI","G","I","full")........."full" if transformation is "ld"
year.dummies <- factor(Regional$year)
dummies = model.matrix(~year.dummies-1)
View(dummies)

z1 <- pgmm(lgdp_hab ~ lag(lgdp_hab)+diff(lgini_contri, 1:1)+diff(cap_hum, 1:1)+ diff(cap_phy,1:1)
           | lag(lgdp_hab, 2:12)
           |lag(lgdp_hab,2)+diff(lgini_contri, 2:2)+diff(cap_hum, 2:2)+ diff(cap_phy,2:2),
           data = Regional,  effect = "individual",  model = "twosteps",
           collapse=TRUE,  transformation="ld",fsm="full" ,subset = sample == 1)

summary(z1,time.dummies=TRUE)
zz1 <- update(z1, effect ="individual",model = "twosteps")
summary(zz2,time.dummies=TRUE)
coef(zz1)
#Test of serial correlation for models estimated by GMM
#Arellano-Bond test of Serial Correlation> #######################################################################
 #######################################################################
 library(sandwich);library(plm);library(readxl)
 Model<- read_excel("C:/Users/lom/Desktop/Model_Regional - Copy.xlsx")
 #............................define Data as panel data
 Regional2 <- pdata.frame(Model, index=c("id", "year"))
 
 
 z2 <- pgmm(lgdp_hab ~ lag(lgdp_hab)+diff(lgini_contri, 1:1)+diff(cap_hum, 1:1)+ diff(cap_phy,1:1)
            | lag(lgdp_hab, 2:12)
            |lag(lgdp_hab,2)+diff(lgini_contri, 2:2)+diff(cap_hum, 2:2)+ diff(cap_phy,2:2),
            data = Regional2,  effect = "individual",  model = "twosteps",
            collapse=TRUE,  transformation="ld",fsm="full" ,subset = sample == 1)


summary(z2,time.dummies=TRUE)
#######################################################################
