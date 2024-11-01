library(zoo)
library(moments)
intervalAnalysis <- function(df.sample, funCall, dataCol, windowLength, windowStep) {
  colNum = which(colnames(df.sample)==dataCol)
  #calculation of statistic values
  stat <- rollapply(df.sample[,colNum],
                    FUN=fun.call,
                    width=windowLength,
                    by = windowStep,
                    by.column = TRUE,
                    align = "right")
  
  #combining stat values with time indices
  stat <- data.frame(time=seq(from=windowLength, to=time.max, length.out=nrow(stat)), stat)
  
  return(stat)
}
