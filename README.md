# Google-Data-Analytics-Capstone-Project

I worked on the Google Data Analytics Capstone Project, Track 1, Case Study 1. I will talk about the background of the project, my data cleaning process, analyzing and visualizing the data, and my final suggestions and summary of the data. 


## Scenario

You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director
of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore,
your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights,
your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives
must approve your recommendations, so they must be backed up with compelling data insights and professional data
visualizations.


## Background of Cyclistic

Cyclistic is a bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself
apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with
disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about
8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to
commute to work each day.

Goal: Make a marketing strategy to convert casual riders into annual members.

Business Question: How do annual members and casual riders use Cyclistic bikes differently?

## Prepare Data

I downloaded the data from here [link](https://divvy-tripdata.s3.amazonaws.com/index.html). I wanted to analyze all the data from 2022, so I downloaded the following files:

202201-divvy-tripdata.zip (January 2022)
202202-divvy-tripdata.zip (February 2022)
202203-divvy-tripdata.zip (March 2022)
202204-divvy-tripdata.zip (April 2022)
202205-divvy-tripdata.zip (May 2022)
202206-divvy-tripdata.zip (June 2022)
202207-divvy-tripdata.zip (July 2022)
202208-divvy-tripdata.zip (August 2022)
202209-divvy-tripdata.zip (September 2022)
202210-divvy-tripdata.zip (October 2022)
202211-divvy-tripdata.zip (November 2022)
202212-divvy-tripdata.zip (December 2022)

After downloading the files I inspected them to see what data I was working with. I noticed that there was some data that I didn't need, so I deleted some unneeded columns in excel. I deleted the columns ride_id, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng. 

After doing some cleaning in excel I wanted to use R to analyze the data because it could handle all of the information quicker than Excel, and I wanted to work on my R skills. Below is a general list of my process in R.

## Process Data

1. I loaded the following libraries: tidyverse, lubridate, hms, date.table, and dplyr.

2. I uploaded my data to rstudio using the read_csv function. I saved them into there own data frames.

3. I combined all of the monthly data frames into 1 data frame with all the data using the rbind() function. I called it cyclistic_all_data.

4. Then I removed the individual month data to clear up space in my environment pane.

5. I created a different data frame to work with called cyclistic_df_2.

6. Cleaned data by:
  * Removing duplicate rows
  * Removing rows with NA values
  * Removed where ride length was 0 or a negative value

7. Created new columns for:
  * Ride Length - did this by subtracting the end time from the start time.
  * Day of the week
  * Month
  * Hour of the day
  * New columns for the end time and start time (easier to work with date time type)
  
8. Calculated:
  * The average ride length between casual riders and annual members.
  * The ride length for all the rides.
  * The total number of rides between casual riders and annual members.
  * The percentages of each type of bike used by casual riders and annual members.
  * The total number of rides for each day of the week between casual riders and annual members.
  * The average ride length for each day of the week between casual riders and annual members.
  * The total number of rides for each month between casual riders and annual members.
  * The total number of rides for each hour of the day between casual riders and annual members.

## Analyze Data

Next I started to analyze the data by making visualizations in R from my previous calculations. 

1. The total number of rides between the annual members and casual riders.
![Total Rides per membership type](https://user-images.githubusercontent.com/128507587/226688148-3f634696-d642-4e98-9c10-b0c66cfa0872.png)

Members had more rides with 2,864,525 total rides or 58% and casual riders had 2,047,799 total rides or 42%.

2. The average ride length between the annual members and casual riders.
![Average Ride Length Per Membership Type](https://user-images.githubusercontent.com/128507587/226703464-61c94ed8-96d4-428f-9960-9c8cdc1af026.png)

For casual riders the average ride length was 30.72 minutes while annual members was 13.47 minutes. 

3. The percentage used of each type of bike by casual riders.

![Percentage of each bike type by casual riders](https://user-images.githubusercontent.com/128507587/226704589-81f90fb9-81cb-4eb3-b8eb-4c4a5f015a42.png)

Electric bikes were used the most by casual riders.

4. The percentage used of each type of bike by annual members.

![Percentage of each bike type used by members](https://user-images.githubusercontent.com/128507587/226705002-0f851cc5-40c9-463e-b166-3f3bbc8b195e.png)

Classic bikes were used slightly more than electric bikes. Also annual members didn't use the dock bikes that year.

5. Total number of rides for each day of the week between annual members and casual riders.

![Total number of rides per day](https://user-images.githubusercontent.com/128507587/226705675-af661740-a407-477a-8d10-193cd8451e37.png)

Saturday was the most popular weekday for total rides. Annual members tend to ride more consistly through the week than the casual riders.

6. Average ride length for each day of the week between annual members and casual riders.
![Average ride length by day](https://user-images.githubusercontent.com/128507587/226706226-29187c30-0af6-45f5-bc15-682282f924d4.png)

For the average ride length per weekday both casual riders and members had an increase in the average ride length on the weekends.

7. Total rides per month between annual members and casual riders.

![Total Rides Per Month](https://user-images.githubusercontent.com/128507587/226706648-8306a037-f2ce-4a03-af9d-2c23dc1042da.png)

July was the busiest month combining casual riders and annual members. August was the busiest month for annual members. The winter months seemed to be the least busy months of the year. 

8. Total rides for each hour of the day between annual members and casual riders.

![Total Rides Per Hour of the day](https://user-images.githubusercontent.com/128507587/226707139-a26d7b05-6385-4b18-9e03-265810322274.png)

5PM or 17:00 was the busiest hour for both members and casual riders. Typically rides began increasing in the morning at 6AM and rose until 5PM then dropped afterwards. The afternoon was the busiest for both rider types. 4AM was the least popular hour. 

## Share

Here I will share my summary of the data.
* Busiest time of the day was around 5PM for both the casual riders and annual members. The annual members tend to ride more in the morning around 7AM and 8AM, which makes me think that a lot more annual members use cyclistic to get to work in the morning. 
* The busiest day of the week is Saturday. Casual riders use cyclistic more during the weekend than annual members. Annual members use cyclistic more during Monday through Friday.
* The busiest time of the year for both types of riders is during the summer months.
* Casual members ride on average longer than annual members.

## Act

These are my suggestions for the marketing team to convert casual riders to annual members:

1. Market more about the benefits of having a cyclistic membership during busy times like the Summer and the weekend.
2. Based on the data it appears a lot of annual use cyclistic as a way to get to work while casual riders tend to use cyclistic after work or on the weekends. I would promote to casual riders the benefits of using cyclistic as a way to commute to work.
3. Hold community events in the City during the Summer to help promote the benefits of a membership.
