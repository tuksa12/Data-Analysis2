library(data.table)

library(magrittr)
ls()
DT <- data.table(
  x = rep(c("a","b","c"), each = 3),
  y = c(1,3),
  v = 1:9
)
# fread --> read data from disk
flights <- fread("C:/Users/usertest/Documents/Data Analysis/Lectures/Lecture2/Lecture02_extdata/Lecture02_extdata/flightsLAX.csv")

head(flights)

ncol(flights)
dim(flights)
summary(flights)

flights[,unique(AIRLINE)]#unique elements of AIRLINE
flights[,table(AIRLINE)] #how often each category occurs

#Sectio 2: Row subsetting
flights[2]
flights[1:4]
flights[c(3,5)]

flights[AIRLINE == "AA"] %>% head(n=5)
#is the same as
head(flights[AIRLINE == "AA"], n=5)

?head
10 %>% log(1000, .)

flights[AIRLINE=="AA" & DEPARTURE_TIME>600 & DEPARTURE_TIME<700] %>% tail(n=5)
# Both have the same result

#Section 3
flights[1:2, c(TAIL_NUMBER, ORIGIN_AIRPORT)]

flights[1:10, list(TAIL_NUMBER)]
flights[1:10, .(TAIL_NUMBER)]

#Section 4
flights[, .(mean_AIRTIME = mean(AIR_TIME, na.rm=TRUE)), by = AIRLINE]

#Section 5
flights[, .N]
flights[, .N, by = 'AIRLINE']

#Section 6
flights[, SPEED := DISTANCE / AIR_TIME * 60]
flights %>% head(n=5)

# flights[, TAIL_NUMBER := NULL] removes 
