

#install.packages(c("mnet","mlVAR","readxl","qgraph"))
library(mlVAR)
library(mnet)
library(readxl)
library(qgraph)
setwd("C:/Users/kolman/Desktop/Youtube Vids/1___Network Analysis (mlVAR) in R")
# Import the data
DATASET_CS <- read_excel("DATASET - CS.xlsx", 
                         sheet = "Data_colored_text")



# Create a vector containing the variables related to treat_1
t1 <- c("SurveyPlatform_t1", 
        "CESDR_1_t1",
        "CESDR_2_t1",
        "CESDR_3_t1",
        "CESDR_4_t1",
        "CESDR_5_t1",
        "CESDR_6_t1",
        "CESDR_7_t1",
        "CESDR_8_t1",
        "CESDR_9_t1",
        "CESDR_10_t1",
        "CESDR_11_t1",
        "CESDR_12_t1",
        "CESDR_13_t1",
        "CESDR_14_t1",
        "CESDR_15_t1",
        "CESDR_16_t1",
        "CESDR_17_t1",
        "CESDR_18_t1",
        "CESDR_19_t1",
        "CESDR_20_t1",
        "GAD7_1_t1", 
        "GAD7_2_t1", 
        "GAD7_3_t1", 
        "GAD7_4_t1", 
        "GAD7_5_t1", 
        "GAD7_6_t1", 
        "GAD7_7_t1",
        "Fatigue_7days_t1",
        "Fatigue_now_t1",
        "Fatigue_usual_t1",
        "Fatigue_worst_t1",
        "Fatigue_GA_t1",
        "Fatigue_mood_t1",
        "Fatigue_walk_t1",
        "Fatigue_work_t1",
        "Fatigue_relation_t1",
        "Fatigue_enjoy_t1")

# Subset the original dataset to keep only the desired variables
Treatment_1 <- DATASET_CS[, t1]

Treatment_1 <- Treatment_1[1:100, ]
dim(Treatment_1)


# Convert all variables to numeric
#Treatment_1 <- as.data.frame(lapply(Treatment_1, as.numeric))
# Replace NA values with empty strings in sub_data
#Treatment_1[Treatment_1 == "NA"] <- "1"
#Treatment_1[is.na(Treatment_1)] <- "0"

View(Treatment_1)



# Estimate using correlated random effects: 
fit1 <- mlVAR(data = Treatment_1, 
              vars = colnames(Treatment_1)[2:8],
              idvar = "SurveyPlatform_t1",
              contemporaneous = "correlated",
              temporal = "correlated",
              estimator = "lmer")

summary(fit1)


# True temporal relationships plot
plot(fit1, type = "temporal", 
     title = "Orthogonal Temporal Relationships", 
     layout = "spring",
     verbose = TRUE, 
     alpha = 0.1, 
     rule= "and",
     nonsig = "dashed")

# True contemporaneous relationships plot
plot(fit1, type = "contemporaneous", 
     title = "Orthogonal Contemporaneous Relationships", 
     layout = "spring",
     verbose = TRUE, 
     alpha = 0.1, 
     rule= "and",
     nonsig = "dashed")




fit2 <- mlVAR(data = Treatment_1, 
              vars = colnames(Treatment_1)[2:13],
              idvar = "SurveyPlatform_t1",
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
plot(fit2, type = "temporal", 
     title = "Orthogonal Temporal Relationships", 
     layout = "spring",
     verbose = TRUE, 
     alpha = 0.1, 
     rule= "and",
     nonsig = "dashed")

# True contemporaneous relationships plot
plot(fit2, type = "contemporaneous", 
     title = "Orthogonal Contemporaneous Relationships", 
     layout = "spring",
     verbose = TRUE, 
     alpha = 0.1, 
     rule= "and",
     nonsig = "dashed")




