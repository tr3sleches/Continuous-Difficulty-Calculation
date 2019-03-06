#include <Rcpp.h>
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
NumericVector speedSpacing(NumericVector W,NumericVector distance,int objectCount) {
  for(int i = 0; i < objectCount; i++)
  {
    if(distance[i]<45){W[i] = 0.95;}
    else if(distance[i]<90){W[i] = 0.95+0.25*(distance[i]-45)/45;}
    else if(distance[i]<110){W[i] = 1.2+0.4*(distance[i]-20)/20;}
    else if(distance[i]<150){W[i] = 1.6+0.9*(distance[i]-40)/40;}
    else{W[i] = 2.5;}
  }
  return W;
}


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//