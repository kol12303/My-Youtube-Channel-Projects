library(knitr)
library(kableExtra)
library(htmltools)
library(tidyverse)
library(scales)
library(dplyr)
library(readxl)
library(plm)
library(ExPanDaR)# needs to download
create_sample <- function(df, df_def) {
# Set infinite numerical variables to NA
df[, df_def$var_name[df_def$type == "numeric"]] <-
    lapply(df[, df_def$var_name[df_def$type == "numeric"]],
           function(x) ifelse(is.finite(x), x, NA))
# Delete numerical variables that only contain NAs
all_na_vars <- sapply(df, function (x) all(is.na(x)))
  df_def <- df_def[!all_na_vars,]
  df <- df[, df_def$var_name]
# Drop observations that are NA in variables that are not allowed to
df <- df[complete.cases(df[, df_def$var_name[which(df_def$can_be_na == FALSE)]]), ]
df <- droplevels(df)
return(list(df = df, df_def = df_def))}

load("C:/Users/lom/Desktop/Panel/ExPanD_descri.Rdata")
smp_list <- create_sample(nb_df, nb_df_def)
smp <- smp_list$df
smp_def <- smp_list$df_def
##################################################################################
#.............................UNIT ROOT TEST.....................................#
##################################################################################
Model_Regional <- read_excel("C:/Users/lom/Desktop/Data/Model_Regional - Copy.xlsx")
# define Data as panel data
Regional <- pdata.frame(Model_Regional, index=c("id", "year"))
#####################################################################################
#.............Levin-Lin-Chu Unit-Root Test..........#################################
agdp<-purtest(lgdp_hab ~ trend, data = Regional, index = c("id", "year"),lags="AIC",
               pmax = 2, test = "levinlin")
summary(agdp)
print(agdp)
#.........................for lgini_contri variable
bgini<-purtest(lgini_contri ~ trend, data = Regional, index = c("id", "year"),lags="AIC",
                pmax = 2, test = "levinlin")
summary(bgini)
print(bgini)
#.......................for cap_hum variable
bhum<-purtest(cap_hum ~ trend, data = Regional, index = c("id", "year"),lags="AIC",
               pmax = 2, test = "levinlin")
summary(bhum)
print(bhum)
#........................for cap_phy variable
Model_Regional_Copy <- read_excel("C:/Users/lom/Desktop/Data/Model_Regional - Copy.xlsx", 
                                  sheet = "cap_phy_test")
Regional_cap_phy <- pdata.frame(Model_Regional_Copy, index=c("id", "year"))
ph_test<-purtest(cap_phy ~ trend, data = Regional_cap_phy, index = c("id", "year"),lags="AIC",
            pmax = 2, test = "levinlin")
summary(ph_test)
print(ph_test)
###########################################################################
#.........................END CODE........................................#
###########################################################################


