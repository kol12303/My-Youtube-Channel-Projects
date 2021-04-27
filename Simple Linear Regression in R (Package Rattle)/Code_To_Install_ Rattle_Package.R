#install.packages("rattle", dependencies=c("Depends", "Suggests"))
#install.packages("RGtk2")
#install.packages('rpart')
#install.packages('rpart.plot')
Sys.setenv(LANGUAGE="en")# To change the interface to English.





library(rattle)
library(rpart)
library(rpart.plot)
library(RGtk2)
rattle()

corrplot(crs$cor, mar=c(0,0,1,0))
title(main="Correlation using Pearson",
      sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))