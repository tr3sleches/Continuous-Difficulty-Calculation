#include <Rcpp.h>
#include <fstream>
#include <string>
using namespace Rcpp;

// This is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp 
// function (or via the Source button on the editor toolbar). Learn
// more about Rcpp at:
//
//   http://www.rcpp.org/
//   http://adv-r.had.co.nz/Rcpp.html
//   http://gallery.rcpp.org/
//

// [[Rcpp::export]]
int fileConverter (std::string fileName) {
  std::string strReplace = "[HitObjects]";
  std::string strNew = "xpos,ypos,time,type,hitSound,sliderType curvePoints,repeat,pixelLength,edgeHitsounds,edgeAdditions,extras";
  std::ifstream rawMap(fileName.c_str());

/*  while(true)
  {
    std::string infilename;
    std::getline(std::cin,infilename);
    rawMap.open(infilename.c_str());
    if(rawMap){break;}
  }*/
  std::ofstream map("map.csv");
  bool hitObjects = false;
  if(!rawMap && !map)
  {
    return 3;
  }
  if(!rawMap)
  {
    return 1;
  }
  if(!map)
  {
    return 2;
  }
  std::string strTemp;
  while(rawMap >> strTemp)
  {
    if(strTemp == strReplace){
      strTemp=strNew;
      hitObjects = true;
    }
    strTemp += "\n";
    if(hitObjects)
    {
      map << strTemp;  
    }
  }
  return 0;
}


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//

