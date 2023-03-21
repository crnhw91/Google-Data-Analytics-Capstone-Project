# Load Libraries
library(tidyverse)
library(lubridate)
library(hms)
library(data.table)
library(dplyr)

#Load original .csv files
jan_data <- read_csv("202201-divvy-tripdata-clean.csv")
feb_data <- read_csv("202202-divvy-tripdata-clean.csv")
mar_data <- read_csv("202203-divvy-tripdata-clean.csv")
apr_data <- read_csv("202204-divvy-tripdata-clean.csv")
may_data <- read_csv("202205-divvy-tripdata-clean.csv")
june_data <- read_csv("202206-divvy-tripdata-clean.csv")
july_data <- read_csv("202207-divvy-tripdata-clean.csv")
aug_data <- read_csv("202208-divvy-tripdata-clean.csv")
sep_data <- read_csv("202209-divvy-tripdata-clean.csv")
oct_data <- read_csv("202210-divvy-tripdata-clean.csv")
nov_data <- read_csv("202211-divvy-tripdata-clean.csv")
dec_data <- read_csv("202212-divvy-tripdata-clean.csv")

#Combine all data into one data frame
cyclistic_all_data <- rbind(jan_data, feb_data, mar_data, apr_data, may_data,
              june_data, july_data, sep_data, oct_data, nov_data, dec_data)

#remove month data frames to clean up space in environment pane
remove(jan_data, feb_data, mar_data, apr_data, may_data, june_data, july_data,
       aug_data, sep_data, oct_data, nov_data, dec_data)

#move data to a data frame to work with
cyclistic_df_2 <- cyclistic_all_data

#Remove rows with NA values
cyclistic_df_2 <- na.omit(cyclistic_df_2)

#Remove duplicate rows
cyclistic_df_2 <- distinct(cyclistic_df_2)

#Create new columns with easier time formats to work with
cyclistic_df_2$new_start_time <- mdy_hms(cyclistic_df_2$started_at, truncated=1)
cyclistic_df_2$new_end_time <- mdy_hms(cyclistic_df_2$ended_at, truncated=1)

#Make a column with the ride lengths
cyclistic_df_2 <- mutate(cyclistic_df_2, 
ride_length = difftime(cyclistic_df_2$new_end_time, cyclistic_df_2$new_start_time, units="mins"))

#Remove any ride lengths with 0 or negative values
cyclistic_df_2 <- cyclistic_df_2[!(cyclistic_df_2$ride_length <=0),]

#Calculate the average ride length between annual members and casual riders
cyclistic_df_2 %>%
  group_by(member_casual) %>%
  summarise_at(vars(ride_length), mean)

#Plot for the average ride length between annual members and casual riders
ggplot(cyclistic_df_2, aes(x=member_casual, y=ride_length, fill = member_casual)) + stat_summary(fun = mean, geom = "bar") + labs(title = "Average Ride Length Per Membership Type", y = "Ride Length (in Minutes)", x = "Membership Type")

#Made a data frame with the total number of rides between annual members and casual riders
count_data_2 <- cyclistic_df_2 %>%
  group_by(member_casual) %>%
  count(member_casual)

#Plot for the total rides per membershipt type
ggplot(count_data_2, aes(x=member_casual, y=n, fill = member_casual)) + geom_bar(stat = "identity") + labs(title = "Total Rides Per Membership Type", x = "Membership Type", y = "Number of Rides") + geom_text(aes(label = n), vjust = 1)

#Made a data frame with the total number of rides per each bike type
type_of_bike_data_2 <- cyclistic_df_2 %>%
  group_by(rideable_type, member_casual) %>%
  count(rideable_type) 

#Calculate the percentage of each bike type used by casual riders
casual_typebike_2 <- type_of_bike_data_2 %>%
  filter(member_casual == "casual") %>%
  mutate(percent = n/2047799)

#Plot the percentage of each bike type used by casual riders
ggplot(casual_typebike_2, aes(x=rideable_type, y=n, fill = rideable_type)) + geom_bar(stat = "identity") + labs(title = "Bike type used by Casual members", x = "Bike Type", y = "Number of Rides") + geom_text(aes(label = scales::percent(percent)), vjust = 1)

#Calculate the percentage of each bike type by annual members
member_typebike_2 <- type_of_bike_data_2 %>%
  filter(member_casual == "member") %>%
  mutate(percent = n/2864525)

#Plot the percentage of each bike type used by annual members
ggplot(member_typebike_2, aes(x=rideable_type, y=n, fill = rideable_type)) + geom_bar(stat = "identity") + labs(title = "Bike type used by members", x = "Bike Type", y = "Number of Rides") + geom_text(aes(label = scales::percent(percent)), vjust = 1)

#Add a column for the day of the week
cyclistic_df_2$day_of_week <- wday(cyclistic_df_2$new_start_time, label=TRUE, abbr = FALSE)

#Add a column for the Month
cyclistic_df_2$month <- format(as.Date(cyclistic_df_2$new_start_time, format="%Y-%m-%d"),"%B")

#Add a column for the hour of the day
cyclistic_df_2$hour <- hour(cyclistic_df_2$new_start_time)

#Add calculate the total rides for each day of the week between casual riders and annual members
Total_rides_weekday_2 <- cyclistic_df %>%
  group_by(member_casual) %>%
  count(day_of_week)

#Plot the total rides for each day of the week between annual members and casual riders
ggplot(Total_rides_weekday_2, aes(x=day_of_week, y=n, fill = member_casual)) + geom_bar(stat = "identity", position = "dodge") + labs(title = "Total number of rides by day", x = "Day of the Week", y = "Number of Rides") + geom_text(aes(label = n, vjust = 1, group = member_casual), position = position_dodge(0.9), size = 1.2) + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

#Calculate the average ride length for each day of the week between casual riders and annual members
Averagetime_per_day_2 <- cyclistic_df_2 %>%
  group_by(day_of_week, member_casual) %>%
  summarise_at(vars(ride_length),mean)

#Plot the average ride length for each day of the week between annual members and casual riders
ggplot(Averagetime_per_day_2, aes(x=day_of_week, y=ride_length, fill = member_casual)) + geom_bar(stat = "identity", position = "dodge") + labs(title = "Average ride length by day", x = "Day of the Week", y = "Average Ride Length (Min)") + geom_text(aes(label = round(ride_length, digits=2), vjust = 1), position = position_dodge(0.9), size = 1.5) + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

#Calculate the total rides for each month between annual members and casual riders
Total_rides_month_2 <- cyclistic_df_2 %>%
  mutate(month = factor(month, levels=month.name)) %>%
  group_by(member_casual) %>%
  arrange(month) %>%
  count(month)

#Plot the total rides for each month
ggplot(Total_rides_month_2, aes(x=month, y=n, fill = member_casual)) + geom_bar(stat = "identity", position = "dodge") + labs(title = "Total Rides Per Month", x = "Months", y = "Number of Rides") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

#Calculate the total rides per each hour of the day
totalrides_per_hour <- cyclistic_df_2 %>%
  group_by(member_casual) %>%
  count(hour)

#Plot the total rides per each hour of the day
ggplot(totalrides_per_hour, aes(x=hour, y=n, fill = member_casual)) + geom_bar(stat = "identity", position = "dodge") + labs(title = "Total Rides Per Hour", x = "Hour of the Day", y = "Number of Rides")