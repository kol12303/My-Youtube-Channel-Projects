library(panelvar)
library(plm)
library(readxl)

# Loading Data As Excel File.
# change the path to your directory
Synthetic_data <- read_excel("C:/Users/LOKMAN/Desktop/panelVar/Synthetic_data.xlsx")

#     define Data as panel data
Dataset <- pdata.frame(Synthetic_data, index=c("id", "year"))

View(Dataset)
# estimating the VAR MODEL


# That's can take more then 15min it depend on your PC Configurations

# Estimating the VAR model
VAR_Model <- pvargmm(dependent_vars = c("variable1", "variable2","variable3"),
                      lags = 3,
                      predet_vars="variable4",
                      transformation = "fod",
                      data = Dataset,
                      panel_identifier=c("id", "year"),
                      steps = c("twostep"),
                      system_instruments = FALSE,
                      pca_instruments=TRUE,
                      max_instr_dependent_vars = 60,
                      max_instr_predet_vars = 60,
                      min_instr_dependent_vars = 2L,
                      min_instr_predet_vars = 1L,
                      collapse =FALSE,
                      progressbar=TRUE)
summary(VAR_Model)


# Before estimating the VAR model we most choose the lag order using one the criteria

#Andrews Lu MMSC Criteria based on Hansen-J-Statistic lag=1
Andrews_Lu_MMSC(VAR_Model, HQ_criterion = 2.1)

#As result we choose tha lag=2 so we will use the PANEL_VAR for the rest of Analysis

# Sargan-Hansen-J-Test for Overidentification
hansen_j_test(VAR_Model)

#Empirical estimation of PVAR Impulse Response Confidence Bands
# That's can take more then 30min it depend od your PC Configurations
PVAR_Impulse_Response<-bootstrap_irf(VAR_Model, typeof_irf="GIRF", n.ahead=6, 
                                     nof_Nstar_draws=2,confidence.band=0.95)

# Forecast Error Variance Decomposition for PVAR
fevd_orthogonal(VAR_Model, n.ahead = 20)

# Generalized Impulse Response Function

girf<-girf(VAR_Model, n.ahead=6,ma_approx_steps=8)
plot(girf)

# Orthogonal Impulse Response Function
oirf<-oirf(VAR_Model, n.ahead=6)
plot(oirf)

plot(girf,PVAR_Impulse_Response)
plot(oirf,PVAR_Impulse_Response)

# Stability of PVAR(p) model
VAR_Model_stability<-stability(VAR_Model)
print(VAR_Model_stability)
plot(VAR_Model_stability)

