library(dineq)
library(readxl)

#Loading data 
PIB_Decomposition <- read_excel("C:/Users/LOKMAN/Desktop/Gini Decomposition/PIB_Decomposition.xlsx", 
                                sheet = "PIB_Decomp")
View(PIB_Decomposition)


# For one year 2004
Regional_Decomp<-gini_decomp(x=PIB_Decomposition$year_2004,
            z=PIB_Decomposition$PIB_Re_par_hab)


Regional_Decomp["gini_decomp"]
Regional_Decomp["gini_group"]
Regional_Decomp["share_groups"]

#From 2004 to 2015
Regional_inequality<-apply(PIB_Decomposition[5:16], MARGIN = 2,
                   z=PIB_Decomposition$PIB_Re_par_hab,
                   FUN =gini_decomp)

# To see the results of decomposition.
Regional_inequality


#####      Code END







library(dineq)
library(readxl)
pop_ratio <- read_excel("C:/Users/lom/Desktop/pop_ratio.xlsx", 
                        sheet = "PIB_inter")
View(pop_ratio)
gini_decomp(x=pop_ratio$y2004,z=pop_ratio$Region)
gini_decomp(x=pop_ratio$y2005,z=pop_ratio$Region)

GINI_intra<-apply(pop_ratio[3:14], MARGIN = 2,z=pop_ratio$Region,
                   FUN =gini_decomp )

GINI_intra
View(GINI_intra)
#####################################################


