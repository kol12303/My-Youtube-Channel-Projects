library(plm)
library(readxl)

#Loading data
pwt91 <- read_excel("C:/Users/LOKMAN/Desktop/pwt91.xlsx", 
                    sheet = "Data")

#......define Data as panel data
Regional <- pdata.frame(pwt91, index=c("country", "year"))
View(Regional)

######################################################################
test_00 <- pgmm(rgdpe ~ lag(rgdpe,1:1)+lag(pop, 1:1)+diff(emp, 1:1)
                | lag(rgdpe, 2:12)|diff(pop, 2:2)+diff(emp, 1:1),
           data = Regional,  effect = "individual", model = "twosteps",collapse=TRUE,  
           transformation="ld",fsm="full",subset = sample == 1,time.dummies="TRUE")


summary(test_00)
summary(test_01, robust = TRUE) 

# Update 
test_02 <- update(test_01, effect ="individual",model = "twosteps")
summary(test_02)

# the vector (or the list for ???xed effects) of coef???cients,
coef(test_02)

# the vector of residuals,
residuals(test_02)

# the covariance matrix of the coef???cients,
vcov(test_02)

# the vector of ???tted values,
fitted.values(test_02)

# effect = "twoways"
summary(test_01, robust = TRUE,) 




