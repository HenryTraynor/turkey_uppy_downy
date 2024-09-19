# Add VEDBA to ACC data
library(plyr)
library(data.table)
library(dplyr)
#Read in ACC Data

df=read.csv("D:/ACC/10274_samples.csv")

#Calculate dynamic body acceleration (DBA) by row for each x,y,and z measurment 
df$ax=df$acceleration.x-df$acc.xmean
df$ay=df$acceleration.y-df$acc.ymean 
df$az=df$acceleration.z-df$acc.zmean

#Add up all the absolute values of DBA to get OBDA for each row 
df$odba=(abs(df$ax)+abs(df$ay)+abs(df$az)) 

#add all of the obda values for the first 40 rows to see if it equals 76.7, the output OBDA from firetail
sum(df$odba[1:40]) #It does are math is correct!

# Calculate VeDBA by row
df$VeDBA=sqrt(df$ax^2+df$ay^2+df$az^2)

#Calculate log of average VeDBA for each burst

calculate_rolling_average <- function(column, window_size = 40) {
  sapply(seq_along(column), function(i) {
    start <- floor((i - 1) / window_size) * window_size + 1
    end <- min(start + window_size - 1, length(column))
    mean(column[start:end])
  })
}

df=df%>%
  mutate(AVG_VeDBA=calculate_rolling_average(VeDBA))

df$log_avg_VeDBA=log(df$AVG_VeDBA)

df$dt=as.POSIXct(strptime(paste(df$burst.start.timestamp ,tz="GMT"),"%Y-%m-%d %H:%M"))

plot(df$dt, df$AVG_VeDBA)

#Calculate rolling median of the log VeDBA for 6 minute window

calculate_rolling_median <- function(column, window_size = 120) {
  sapply(seq_along(column), function(i) {
    start <- floor((i - 1) / window_size) * window_size + 1
    end <- min(start + window_size - 1, length(column))
    median(column[start:end])
  })
}

df=df%>%
  mutate(median_VeDBA=calculate_rolling_median(log_avg_VeDBA))

plot(df$dt, df$median_VeDBA)

#Calculate rolling median of the avg VeDBA for 6 minute window

df=df%>%
  mutate(median_VeDBA=calculate_rolling_median(AVG_VeDBA))

plot(df$dt, df$median_VeDBA)
