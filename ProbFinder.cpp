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
double prob(double s,NumericVector ISsorted,NumericVector frequency,int time, int objectCount) {
  double total = 0;
  for(int k=0;k<(2*objectCount-1);k++){
    if(ISsorted[k] > s){
      break;
    }
    else if(k>0){
      total+=frequency[k-1]*log(ISsorted[k]/ISsorted[k-1]);
    }
    else{
      total+=frequency[k]*log(ISsorted[k]/ISsorted[k]);
      //this equals 0, just put it for clarity
    }
  }
  double P = -1000/(log(0.15)*time)*total;
  return P;
}


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//

