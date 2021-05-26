getwd()
setwd("C:/Users/hibbe/Downloads")
data.df <- read.csv("superstore_dataset2011-2015(1) (1).csv")

library(dplyr)
variable.names(data.df)
#"Row.ID"         "Order.ID"       "Order.Date"     "Ship.Date"      "Ship.Mode"      "Customer.ID"    "Customer.Name" 
#"Segment"        "City"           "State"          "Country"        "Postal.Code"    "Market"         "Region"        
#"Product.ID"     "Category"       "Sub.Category"   "Product.Name"   "Sales"          "Quantity"       "Discount"      
#"Profit"         "Shipping.Cost"  "Order.Priority"

total_profit <- data.df %>%
  group_by(Customer.Name) %>%
  summarise(total_profit = sum(Profit),
            total_discount = sum(Discount),
            total_sales = sum(Sales))

total_profit

data.df <- total_profit %>% left_join(data.df)
head(data.df,20)
str(data.df)

#changing date from character to date structure
a <- as.Date(data.df$Order.Date,format="%m/%d/%Y") # Produces NA when format is not "%m/%d/%Y"
b <- as.Date(data.df$Order.Date,format="%d-%m-%Y") # Produces NA when format is not "%d-%m-%Y"
a[is.na(a)] <- b[!is.na(b)] # Combine both while keeping their ranks
data.df$Order.Date <- a

summary(data.df$Order.Date)
rfm.df<-data.df
#define frequency
frequency <- rfm.df %>%count(Customer.Name) 
frequency
rfm.df <- frequency %>% left_join(rfm.df)

#define recency
recency <- rfm.df %>%
  group_by(Customer.Name) %>%
  summarise(last_date = max(Order.Date))
rfm.df <- recency %>% left_join(rfm.df)
variable.names(rfm.df)#check to make sure last_date and n columns have been added to rfm.df
rfm.df %>% mutate(frequency=n,recency=last_date,monetary=total_profit)->rfm.df
head(rfm.df)
summary(rfm.df$frequency)
rfm.df %>% mutate(Findex=cut(frequency,breaks=c(28,58,67,77,109),labels=c("1","2","3","4")))->rfm.df
summary(rfm.df$recency)
date1 <- as.Date("2015-01-01", tz="UTC")

as.numeric(difftime(date1, rfm.df$recency, units="days"))->rfm.df$Rdays
summary(rfm.df$Rdays)
rfm.df %>% mutate(Rindex=cut(frequency,breaks=c(0,7,17,36,430),labels=c("1","2","3","4")))->rfm.df             
summary(rfm.df$total_profit)
rfm.df %>% mutate(Mindex=cut(frequency,breaks=c(-6153,1040,1834,2673,8674),labels=c("1","2","3","4")))->rfm.df
variable.names(rfm.df)
# you can combine these three indices in anyway you want; to segment your market
# for example, have a linear combination
rfm.df %>% mutate(CLV=33.33*as.numeric(Findex)/5+33.33*as.numeric(Rindex)/5+33.33*as.numeric(Mindex)/5)->rfm.df
summary(rfm.df$CLV) #33.33% Frequency, 33.33% Recency, 33.33% Monetary
#Findex = frequency index, Rindex = recency index, Mindex = monetary index


Customer_Freq<-as.data.frame(table(rfm.df$Customer.Name))
Customer_Freq #795 unique Customer Names

#Questions we want to answer

#Who is most valuable?
rfm.df %>% group_by(Customer.Name,clmns=CLV) %>% summarize(N=n())->CLV.df
CLV.df[order(CLV.df$clmns,decreasing=TRUE),]->CLV.df
head(CLV.df,n=50)->Top50_CLV
Top50_CLV #shows top 50 Customer Names and their CLV in clmns
#customers who have the same CLV are ordered alphabetically
#the max CLV is 60


#Locations of our most valuable customers?
rfm.df %>% group_by(Customer.Name,clmns=CLV) %>% summarize(N=n(),Region=Region,Market=Market,Country=Country)->CLV2.df
CLV2.df #includes Region, Market,and Country. Customer Names repeats if the customer has ordered from multiple locations
#also shows frequency of each location
CLV2.df[order(CLV.df$clmns,decreasing=TRUE),]->CLV2.df
head(CLV2.df,n=1000)->Top1000_CLV_Location
Top1000_CLV_Location #shows one line for each order a top customer placed

#Most frequent country of top customers(1000 orders)
table(Top1000_CLV_Location$Country)
country_freq.df<-as.data.frame(table(Top1000_CLV_Location$Country))
country_freq.df[order(country_freq.df$Freq,decreasing=TRUE),]->country_freq.df
head(country_freq.df,n=10)->Mostvaluable_countries
Mostvaluable_countries #shows 10 countries that appear most in top 1000 orders of top customers

#Most frequent market of top customers
market_freq.df<-as.data.frame(table(Top1000_CLV_Location$Market))
market_freq.df[order(market_freq.df$Freq,decreasing=TRUE),]->market_freq.df
head(market_freq.df,n=10)->Mostvaluable_markets
Mostvaluable_markets

#Most frequent region of top customers
region_freq.df<-as.data.frame(table(Top1000_CLV_Location$Region))
region_freq.df[order(region_freq.df$Freq,decreasing=TRUE),]->region_freq.df
head(region_freq.df,n=10)->Mostvaluable_regions
Mostvaluable_regions

#Create df with Customer Name, CLV, product category, and sub category
rfm.df %>% group_by(Customer.Name,clmns=CLV) %>% summarize(N=n(),Product_Category=Category,Sub_Category=Sub.Category)->CLV3.df
CLV3.df#includes product category and sub-category
CLV3.df[order(CLV3.df$clmns,decreasing=TRUE),]->CLV3.df
head(CLV3.df,n=1000)->Top1000_CLV_Products

#Most frequent product category
category_freq.df<-as.data.frame(table(Top1000_CLV_Products$Product_Category))
category_freq.df[order(category_freq.df$Freq,decreasing=TRUE),]->category_freq.df
head(category_freq.df,n=3)->Mostvaluable_productcategories #only 3 product categories
Mostvaluable_productcategories

#Most frequent sub-category
sub_freq.df<-as.data.frame(table(Top1000_CLV_Products$Sub_Category))
sub_freq.df[order(sub_freq.df$Freq,decreasing=TRUE),]->sub_freq.df
head(sub_freq.df,n=20)->Mostvaluable_subcategories
Mostvaluable_subcategories

###EVERYTHING BELOW DOES NOT FACTOR IN CLV
#Where are our customers they located? Only frequency, Not factoring in CLV
country_count.df<-as.data.frame(table(rfm.df$Country))
country_count.df[order(country_count.df$Freq,decreasing=TRUE),]->country_count.df
head(country_count.df,n=10)->Top10_Countries
Top10_Countries

state_count.df<-as.data.frame(table(rfm.df$State))
state_count.df[order(state_count.df$Freq,decreasing = TRUE),]->state_count.df
state_count.df
head(state_count.df,n=50)->Top50_States
Top50_States

city_count.df<-as.data.frame(table(rfm.df$City))
city_count.df[order(city_count.df$Freq,decreasing=TRUE),]->city_count.df
head(city_count.df,n=50)->Top50_Cities
Top50_Cities

region_count.df<-as.data.frame(table(rfm.df$Region))
region_count.df[order(region_count.df$Freq,decreasing=TRUE),]->region_count.df
head(region_count.df,n=5)->Top5_Regions #13 regions total
Top5_Regions

market_count.df<-as.data.frame(table(rfm.df$Market))
market_count.df[order(market_count.df$Freq,decreasing=TRUE),]->market_count.df
head(market_count.df,n=10)->Top_Market_Freq #only 7 markets so I just did frequency of each
Market_Freq


