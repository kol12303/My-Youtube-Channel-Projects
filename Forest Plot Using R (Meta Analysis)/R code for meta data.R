library(metafor) #download from Cran
library(CompQuadForm) #download from Cran  
library(meta) #download from Cran  
library(readxl) #download from Cran

# Loading Data
Meta_data <- read_excel("C:/Users/LOKMAN/Desktop/Meta-Analysis/tdx.xlsx",
                  sheet = "td")

# to View data 
View(Meta_data)


# Creat a data fram called y

y<-metabin(data=Meta_data, event.e, n.e ,event.c, n.c, studlab=country,sm="OR")


#..............to plot the forest for y variable 
#forest(y)
#forest(y, leftcols=c("studlab","effect"))
#forest(y, leftcols=c("studlab","effect"), rightcols=c("ci","w.random"))
forest(y, leftcols=c("studlab","effect"),rightcols=c("ci","w.random"),
       col.square = "red",col.diamond="blue ",print.tau2 = F,print.Q = T,print.I2 = T)




















# data is in Excel form so you need readxl package 
# excel file called tdx
#my pc called lom