library(plm)
library(pdynmc)
library(readxl)

#     Loading Data


Analysisdata <- read_excel("C:/Users/LOKMAN/Desktop/Analysis/Analysisdata.xlsx")

#......define Data as panel data
Regional <- pdata.frame(Analysisdata, index=c("ID", "Year"))
#View(Regional)
dat2 <- Regional

#View(Regional)
m1 <- pdynmc(dat =dat2 , 
             varname.i = "ID", 
             varname.t = "Year",
use.mc.diff = TRUE # instruments in levels should be used
,use.mc.lev = FALSE #instruments in differences should be used 
,use.mc.nonlin = FALSE #whether nonlinear (quadratic) moment conditions should be used
,inst.stata=TRUE
,include.y = TRUE, 
varname.y = "lnZ" #the independent variable 
,lagTerms.y = 1 #indicating the number of lags of the dependent variable used as explanatory variables.
,maxLags.y =2 #the maximum number of lags of the dependent variable from which instruments should be derived.
,fur.con = TRUE, 
fur.con.diff = TRUE, 
fur.con.lev = FALSE,
varname.reg.fur = c("FdiGDP","PopGr","CORR", "ExpGDP","kHwpc"),
lagTerms.reg.fur = c(0,0,0,0,0),
varname.reg.ex="CORR",
include.dum = TRUE #time dummy variables
,dum.diff = FALSE 
,dum.lev = FALSE
,varname.dum = "Year" #which time dummies should be derived  
,w.mat = "iid.err"
,w.mat.stata=TRUE
,std.err = "corrected", 
estimation = "twostep"
,opt.meth = "none")
#############
summary(m1)
print(m1)


#.............EXTRACTING INFORMATION........

# Extract Coef???cient Estimates of Fitted Model.
coef(m1)

# Extract Coef???cient Estimates of Time Dummies of Fitted Model.
dummy.coef(m1)

# Extract Fitted Values of Fitted Model.
fitted(m1, step = "2", na.rm = FALSE)

# Extract Instrument Matrix of Fitted Model.
model.matrix(m1, sparse = TRUE)

# Extract Instrument Count of Fitted Model.
ninst(m1)

# Extract Number of Observations of Fitted Model.
nobs(m1)

# Extract Residuals of Fitted Model.
residuals(m1, na.rm = TRUE)

#Extract Variance Covariance Matrix of Fitted Model.
vcov(m1, step = "2")

#Extract Weighting Matrix of Fitted Model.
wmat(m1, step = 2) # step 1 if you specify onestep GMM


# Extract Input Parameters of Numeric Optimization of Fitted Model.
optimIn(m2) #if you carried a Numerical optimization

#....................Ploting ......................

# Plot Coef???cient Estimates and Corresponding Ranges of Fitted Model.

plot(m1)
plot(m1, type = "coef.range")
plot(m1, type = "coef.path")

#Plot on Structure of Unbalanced Panel Data Set.
strucUPD.plot(dat2, i.name = "id", t.name = "year")



#....................TESTS.................

#Arrelano and Bond (1991) serial correlation test of degree 1 
mtest.fct(m1, )


# Arrelano and Bond (1991) serial correlation test of degree 1
mtest.fct(m1, t.order=2)

# Hansen J-Test.
jtest.fct(m1)


# Wald Test.
wald.fct(param="all", m1)







