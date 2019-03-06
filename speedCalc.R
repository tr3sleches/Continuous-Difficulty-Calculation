speedCalc1 <- function(map)
{
  dt=diff(map$time)
  objectCount=length(dt)+1
  T=map$time[objectCount]
  dx=diff(map$xpos)
  dy=diff(map$ypos)
  distance=sqrt(dx^2+dy^2)
  distance*CSbonus
  spacingWeight = rep(0,objectCount-1)
  speedSpacing(spacingWeight,distance,objectCount)
  decay=.3^(dt/1000)
  supremum=rep(0,objectCount-1)
  infimum=rep(0,objectCount-1)
  strains=rep(0,objectCount-1)
  strains[1]=1400*spacingWeight[1]/dt[1];
  if(!strains[1])
  {
    strains[1]=1
  }
  supremum[1]=strains[1]
  infimum[1]=supremum[1]*decay[1]
  for(i in 2:(objectCount-1)){
    strains[i]=infimum[i-1]+1400*spacingWeight[i]/dt[i];
    supremum[i]=strains[i];
    infimum[i]=supremum[i]*decay[i];
  }
  IS=c(infimum,supremum)
  ISsorted=sort(IS)
  frequency=rep(0,2*(objectCount-1))
  Rcpp::sourceCpp('ProbFinder.cpp')
  Prob=rep(0,2*(objectCount-1))
  for(j in 1:(2*(objectCount-1))) {
    if(is.element(ISsorted[j],infimum)){frequency[j]=frequency[j]+1}
    if(is.element(ISsorted[j],supremum)){frequency[j]=frequency[j]-1}
    if(j<2*(objectCount-1)){frequency[j+1]=frequency[j]}
    if(j>1)
    {
      Prob[j] = prob(ISsorted[j],ISsorted,frequency,T,objectCount);
    }
  }
  Prob=Prob/max(Prob)
  sumStrain = 0;
  avgStrain = 0;
  weightedStrains = rep(0,2*(objectCount-1))
  Weight = 0;
  p = (5*log(0.9))/(2*log(0.15));
  for(k in 2:(2*(objectCount-1))){
    weightedStrains[k]=0.9^((T/400)*(1-Prob[k-1]))*ISsorted[k-1]^(-p*frequency[k-1])*(ISsorted[k]^(2+p*frequency[k-1])-ISsorted[k-1]^(2+p*frequency[k-1]))/(2+p*frequency[k-1])
    sumStrain = sumStrain + 0.9^((T/400)*(1-Prob[k-1]))*ISsorted[k-1]^(-p*frequency[k-1])*(ISsorted[k]^(2+p*frequency[k-1])-ISsorted[k-1]^(2+p*frequency[k-1]))/(2+p*frequency[k-1])
    Weight = Weight + 0.9^((T/400)*(1-Prob[k-1]))*ISsorted[k-1]^(-p*frequency[k-1])*(ISsorted[k]^(1+p*frequency[k-1])-ISsorted[k-1]^(1+p*frequency[k-1]))/(1+p*frequency[k-1])
  }
  avgStrain = sumStrain/Weight
  Stars = 0
  Stars=0.0675*sqrt(10*avgStrain)
  dISsort=rep(0,2*(objectCount-1))
  dISsort=c(0,diff(ISsorted))
  par(mfrow=c(2,2))
  plot(frequency~ISsorted,pch=20,cex=.001,xlab="strain")
  plot(Prob~ISsorted,pch=20,cex=0.01,xlab="strain",ylab="Cumulative Probability")
  plot(weightedStrains/dISsort~ISsorted,pch=20,cex=.001,xlab="strain",ylab = "Weighted Strain")
  Stars
}