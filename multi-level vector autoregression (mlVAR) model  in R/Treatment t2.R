
library(mnet)
library(mlVAR)
library(readxl)
library(qgraph)
setwd("C:/Users/KOLMAN/OneDrive - um5.ac.ma/Desktop/Network Analysis in R")
# Import the data
DATASET_CS <- read_excel("DATASET - CS.xlsx", sheet = "Data_colored_text")



# Create a vector containing the variables retaed to t1
t2 <- c("SurveyPlatform_t2", 
        "CESDR_4_t2",
        "CESDR_6_t2", 
        "CESDR_8_t2", 
        "CESDR_10_t2", 
        "CESDR_14_t2",
        "GAD7_1_t2", 
        "GAD7_2_t2", 
        "GAD7_3_t2", 
        "GAD7_4_t2", 
        "GAD7_5_t2", 
        "GAD7_6_t2", 
        "GAD7_7_t2")

# Subset the original dataset to keep only the desired variables
Treatment_2 <- DATASET_CS[, t2]


# Select only the first 100 rows without missing values
Treatment_2 <- Treatment_2[complete.cases(Treatment_2), ][1:100, ]

dim(Treatment_2)



View(Treatment_2)



# Estimate using correlated random effects: 
fit1 <- mlVAR(data = Treatment_2, 
              vars = colnames(Treatment_2)[2:13],
              idvar = "SurveyPlatform_t2",
              contemporaneous = "correlated",
              temporal = "correlated",
              estimator = "lmer")

summary(fit1)


# True temporal relationships plot
plot(fit1, type = "temporal", title = "Orthogonal Temporal Relationships", 
     layout = "spring",verbose = TRUE, alpha = 0.1, rule= "and",
     nonsig = "dashed")

# True contemporaneous relationships plot
plot(fit1, type = "contemporaneous", title = "Orthogonal Contemporaneous Relationships", 
     layout = "spring",verbose = TRUE, alpha = 0.1, rule= "and",
     nonsig = "dashed")




fit2 <- mlVAR(data = Treatment_2, 
              vars = colnames(Treatment_2)[2:13],
              idvar = "SurveyPlatform_t2",
              lags = 2,
              contemporaneous = "orthogonal",
              temporal = "orthogonal",
              estimator = "lmer",
              nCores=1,
              verbose=TRUE,
              scale=TRUE,
              iterations = "(2000)",
              chains = nCores)
summary(fit2)


# True temporal relationships plot
plot(fit2, type = "temporal", title = "Orthogonal Temporal Relationships", 
     layout = "spring",verbose = TRUE, alpha = 0.1, rule= "and",
     nonsig = "dashed")

# True contemporaneous relationships plot
plot(fit2, type = "contemporaneous", title = "Orthogonal Contemporaneous Relationships", 
     layout = "spring",verbose = TRUE, alpha = 0.1, rule= "and",
     nonsig = "dashed")












