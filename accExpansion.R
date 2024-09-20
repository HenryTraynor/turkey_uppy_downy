df.sample <- read.csv("13918.csv")

accX = vector(mode="numeric", length=length(seq(from=as.POSIXct("00:00:00", format="%H:%M:%OS",tz="UTC"), to=as.POSIXct("23:59:59", format="%H:%M:%OS", tz="UTC"), by=3.0)))
accY = vector(mode="numeric", length=length(accX))
accZ = vector(mode="numeric", length=length(accX))

accRaw <- strsplit(df.sample$eobs.accelerations.raw[1], split=" ")
accRaw[[1]][1]


accTime<-1

for (i in length(df.sample$eobs.accelerations.raw)) {
  accRaw <- strsplit(df.sample$eobs.accelerations.raw[i], split=" ")
  for(j in length(accRaw[[1]])) {
    if(j%%3==1) {
      accX[accTime]=as.numeric(accRaw[[1]][j])
    }
    if(j%%3==2) {
      accY[accTime]=as.numeric(accRaw[[1]][j])
    }
    else {
      accZ[accTime]=as.numeric(accRaw[[1]][j])
    }
    accTime=accTime+1
  }
}


df <- data.frame(
  timestamp= seq(from=as.POSIXct("00:00:00", format="%H:%M:%OS",tz="UTC"), to=as.POSIXct("23:59:59", format="%H:%M:%OS", tz="UTC"), by=3.0),
  acceleration.
)
