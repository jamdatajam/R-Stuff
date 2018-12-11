
#Method 1: Select the file manually
stats <-read.csv(file.choose())
stats

#Method 2: Set woking directoy (WD) and Read Data
#getwd()
#Windows Version
#setwd("C:\\ ...")
#Mac
#setwd("/Users/...")

stats
nrow(stats) #tells you how many rows
ncol(stats) #number of columns
head(stats) #top six rows
tail(stats, n=10) #bottom ten rows; Default: bottom six rows
str(stats) #"Structure" tells a bit of info about the columns
#automatically assigns numerical values to categorical variables
summary(stats) #gives a summary of the data

#need to know str() and runif()

head(stats)
stats[3,3] #gives Angola and birth rate
stats[3, "Birth.rate"]
#but can't put stats["Angola", 3] 
#dollar sign allows columns in data frames to be selected
stats$Internet.users
#returns vectors with all the information
stats$Internet.users[2]
stats[,"Internet.users"]#this is the same as the the above, $ specifies the column

#one more application of $
#how to see the other factors that are referenced:
levels(stats$Income.Group)

################

#subsetting
stats[1:10,]
stats[3:9,]
stats[c(4,100),]

#remember how [] works
stats[1,]
is.data.frame(stats[1,])
#in data frame removing one row, leaves it as a data frame
stats[,1]
is.data.frame(stats[,1])
#now it is no longer a dataframe
#so now to keep it as a data frame:
stats[,1,drop = F]
is.data.frame(stats[,1,drop = F])
#only applies when extacting a column

head(stats)
stats$Birth.rate * stats$Internet.users
stats$Birth.rate + stats$Internet.users

#how to add a cloumn to a data frame
stats$MyCalc <- stats$Birth.rate * stats$Internet.users
head(stats)

#test knowledge
stats$xyz <- 1:5
head(stats)
#this puts a repeated fill of the array assigned to it
#needs to be divisible into the total number of items

#how to remove a column?
stats$MyCalc <- NULL
stats$xyz <-NULL
head(stats)

################

#Filter Data Frames
#working with rows usually
head(stats)
#create a filter
filter <- stats$Internet.users < 2
#then go through and show the rows with true filter values, ignore those with false filter values
stats[filter, ]

#uses a true false vector to show desired values
stats[stats$Birth.rate > 40,]

#now both conditions need to be true
stats[stats$Birth.rate > 40 & stats$Internet.users < 2,]

#filter by income group
stats[stats$Income.Group == "High income",]

#find malta
stats[stats$Country.Name == "Malta",]

################

#Qplot
#library(ggplot2)
#?qplot
qplot(data = stats, x = Internet.users)
qplot(data = stats, x = Income.Group, y = Birth.rate, size = I(3), colour = I("blue"))
qplot(data = stats, x = Income.Group, y = Birth.rate, geom = "boxplot")

#Visualize
qplot(data=stats, x = Internet.users, y = Birth.rate)
qplot(data=stats, x = Internet.users, y = Birth.rate, size=I(4))
qplot(data=stats, x = Internet.users, y = Birth.rate, colour = I("red"), size = I(4))
qplot(data=stats, x = Internet.users, y = Birth.rate, colour = Income.Group, size = I(4))

#Creating data frames
mydf <-data.frame(Countries_2012_Dataset, Codes_2012_Dataset, Regions_2012_Dataset)
head(mydf)
#colnames(mydf) <- c("Country", "Code", "Region")
#head(mydf)

rm(mydf) #removes the dataframe

#makes the names for the columns at the same time you build the dataframe
mydf <- data.frame(Country = Countries_2012_Dataset, Code = Codes_2012_Dataset, Region = Regions_2012_Dataset)
head(mydf)
tail(mydf)
summary(mydf)


################

#Merge Data Frames
#how to combine everything into a signle dataframe
#could do it by country or by country code
#fucntion is called merge
merged <- merge(stats, mydf, by.x = "Country.Code", by.y = "Code")
#says country code = code
head(merged)

#ends up with a duplicate column
#Country and Country.Code are duplicates
#so remove one of them
merged$Country <- NULL
str(merged)
tail(merged)


#QPlot again
qplot(data = merged, x = Internet.users, y = Birth.rate)
qplot(data = merged, x = Internet.users, y = Birth.rate, colour = Region)
qplot(data = merged, x = Internet.users, y = Birth.rate, colour = Region, size=I(5), shape = I(23))

#Now looking at transparency
qplot(data = merged, x = Internet.users, y = Birth.rate, colour = Region, size=I(5), shape = I(19),
      alpha=I(0.6))

#Adding Titles
qplot(data = merged, x = Internet.users, y = Birth.rate, colour = Region, size=I(5), shape = I(19),
      alpha=I(0.6),
      main = "Birth rate v. Internet users")
