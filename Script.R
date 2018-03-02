uberdata<- read.csv("Uber Request Data.csv", header = TRUE, stringsAsFactors = TRUE)
head(uberdata)
str(uberdata)
# Variable descriptions
# 1. Request id : Unique id, integer value - nominal data point.
# 2. Pickup. Point : Factor with 2 levels
# 3. Driver.id : Unique id- nominal data point
# 4. Status: is trip status with 3 levels "completed", "cancelled" or
# "no cars available" 
# 5. Request.timestamp: Picked up as a factor need to convert to data & time
# 6. Drop.timestamp: picked up as a factor need to covert to date & time. 

library(tidyverse)
ggplot(data = uberdata, mapping = aes(x = uberdata$Status))+
  geom_bar(fill = c("darkred","red","green"))
uberdata %>% count(uberdata$Status)
# there seems to be high cancellations. 
# there seem to be a extremely high no cars available status.

completed_trip<- mutate(filter(uberdata$Status == "Trip Completed"))


ggplot(data = uberdata, mapping = aes(x = uberdata$Pickup.point))+
  geom_bar(fill= c("red","darkred"))
uberdata %>% count(uberdata$Pickup.point)
# the pickups from city is slightly higer than from airport.
# no red flags as such. 

# Lets look at the Interaction of Pickup point & Trip Status.
ggplot(data = uberdata)+
  geom_count(mapping = aes(x = uberdata$Status,
                           y = uberdata$Pickup.point))

uberdata %>% count(uberdata$Status,uberdata$Pickup.point)
# We can frame the following hypthesis
# cancellation are higher in city.
# No cars available status is most frequent in airport. 
# Trip completed does not show any picularity. 

Completed_trip_by_request = 2831/6745
Completed_trip_by_request
# Here in lies the problem number one. 
# Only 42% of trip request actually are honored.

cancel_request = 1264/6745
cancel_request
# 19 % request are cancelled 

non_avialability_on_request = 2630/6745
non_avialability_on_request
# 39% of request are not honoured for non availability of cars. 


ggplot(data = uberdata, mapping = aes(x = uberdata$Driver.id))+
  geom_bar()
uberdata %>% count(uberdata$Driver.id)
