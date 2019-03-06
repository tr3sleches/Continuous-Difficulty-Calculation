strainAimFind <-function(mapName)
{
  fileConverter(mapName)
  library(readr)
  map <- read_csv("~/map.csv")
  aimCalc1(map=map)
}