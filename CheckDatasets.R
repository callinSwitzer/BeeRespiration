ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if(length(new.pkg)) install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c('ggplot2', 'car', 'lme4', 'gsheet', "MASS", 'influence.ME', 'sjPlot', "tidyverse")
ipak(packages)

theme_set(theme_bw())

# read in data -- google sheet called "Bumble mumble grumble"
bdta <- gsheet2tbl("https://docs.google.com/spreadsheets/d/1GUUoFq41Ep3sJNFXiyMcp7fZhYmQCzTcLnhVXdr4WRo/edit?usp=sharing")



# read in data -- google sheet called "Final Bee Resp Data"
url = 'https://docs.google.com/spreadsheets/d/1wT-QxSJJElhhJcIXlg2hDpFKHbLyFGuqNNj2iYvA8Vo/edit?usp=sharing'
bdta2 <- data.frame(gsheet2tbl(url)) %>% as.tbl()
summary(bdta)
summary(bdta2)


b1 <- bdta %>%
  select(`Bee ID`, `Treatment order`, Mstarved, MF, `IT Span`, `wbf(aud)`, `av resp (CO2 mL/hr)`, load )
b1
b2 <- bdta2 %>%
  select(BeeID, order, Mstarved, MF, Itspan, freq, M2, MetR) %>%
  mutate(Itspan = Itspan * 1000, 
         load2 =  M2 - Mstarved) %>%
  select(-M2)
b2

all(as.matrix(b1) == as.matrix(b2))
