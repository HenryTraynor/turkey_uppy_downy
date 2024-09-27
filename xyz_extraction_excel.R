require(readr)

df<- read_csv("11197_2.csv")

# Load required libraries
library(dplyr)
library(tidyr)

#change name of columns
df<-df%>% rename(ID =`individual-local-identifier`, accel=`eobs:accelerations-raw`)

# Function to split 'accel' column into groups of three values (x, y, z axes)
split_accel_data <- function(accel_col) {
  accel_values <- unlist(strsplit(accel_col, " "))
  matrix(accel_values, ncol = 3, byrow = TRUE)
}

# Initialize an empty dataframe to store the expanded data
expanded_df <- data.frame()

# Iterate through each row in the dataframe
for (i in 1:nrow(df)) {
  # Split accel column into x, y, z values
  accel_matrix <- split_accel_data(df$accel[i])
  
  # Create a temporary dataframe for the current row, repeating the timestamp, date, year, and tag-local-identifier for each sample
  temp_df <- data.frame(
    Time = rep(df$Time[i], nrow(accel_matrix)),
    Date = rep(df$Date[i], nrow(accel_matrix)),
    Year = rep(df$Year[i], nrow(accel_matrix)),
    ID = rep(df$ID[i], nrow(accel_matrix)),
    sample_num = 1:nrow(accel_matrix),  # Add a sample number for each sample
    x_axis = accel_matrix[, 1],
    y_axis = accel_matrix[, 2],
    z_axis = accel_matrix[, 3]
  )
  
  # Append the temporary dataframe to the expanded dataframe
  expanded_df <- rbind(expanded_df, temp_df)
}

# Show the first few rows of the expanded dataframe
head(expanded_df)







