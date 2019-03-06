strainSpeedFind <-function(mapName)
{
  fileConverter(mapName)
  library(readr)
  map <- read_csv("~/map.csv")
  speedCalc1(map=map)
}