library(WDI)
library(plm)

# NY.GDP.PCAP.KD.ZG -----> GDP per capita growth (annual %)
# SP.POP.GROW   ------> Population growth (annual %)


# Download Data from WDI servers.
Download_data<-WDI(
  country = c("JPN","MAR"),
  indicator = c("NY.GDP.PCAP.KD.ZG","SP.POP.GROW"),
  start = 2000,
  end = 2020,
  extra = FALSE,
  cache = NULL)

# Save data as Panel data Frame.
data <- pdata.frame(Download_data, index=c("country", "year"))
View(data)

# Rename indicators on the fly (Method 1).
WDI(country = c('MAR',"JPN"), 
    indicator = c('GDP per capita growth (annual %)' = 'NY.GDP.PCAP.KD.ZG',
    'Population growth (annual %)' = 'SP.POP.GROW'))

View(data)

# Rename variables (Method 2).
pop_grow=data$SP.POP.GROW
gdp_pc<-data$NY.GDP.PCAP.KD.ZG

# Save data the ".RData" extension will help RStudio to identify your R datasets.
save(data, file = "Model.RData")

# Save data as CSV
save(data, file = "Model.csv")


