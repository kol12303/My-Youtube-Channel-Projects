






#...............................Sources:..............................
 # https://github.com/massimoaria/bibliometrix
# https://www.bibliometrix.org/vignettes/Introduction_to_bibliometrix.html


########################################################
library(bibliometrix)
library(readxl)


# change the directory to where you put the two files 'wos.bib' 
# and 'scopus.csv'


setwd("C:/Users/KOLMAN/OneDrive - um5.ac.ma/Desktop/Bibliometric & Scientometric Analysis")


##################################################################
# Step 1................scopus database..........................
# convert scopus dbs to biblio
scopus<- convert2df("scopus_growth.bib", dbsource = "scopus", format = "bibtex")
# see the dimension of the data

dim(scopus)
View(scopus)
################################################################
# Step 2...........................wos database.................
# convert wos dbs to biblio
WoS<- convert2df("wos_growth.bib", dbsource = "wos", format = "bibtex")
# see the dimension of the data
dim(WoS)
View(WoS)
###############################################################
#......Step 3.......................................
# Now combine the two dbs
combined <- mergeDbSources(scopus, WoS, remove.duplicated=TRUE)
View(combined)
# see the dimension of the data
dim(combined)


# save the data as biblio in excel 
library(openxlsx)
write.xlsx(combined,"combined_growth.xlsx")


# now the combined data after removing the duplicate (found xxx duplicate)
# xxx duplicated documents have been removed


bibliometrix::biblioshiny()


