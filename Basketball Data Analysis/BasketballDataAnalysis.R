#This script is meant to analyze basketball stats from 2005 to 2014

#Data is in matrix form in BasketballData.R (run that first)

Salary
Games
MinutesPlayed

#matrix() function for forming matrixes
#rbind() attaches vectors in rows
#cbind() attaches vectors in columns

#Matplot
matplot(t(FieldGoals/Games), type = "b", pch=15:18, col=c(1:4, 6)) #plots columns, we have rows
#add a legend
legend("bottomleft", inset=0.01, legend= Players, col=c(1:4,6), pch=15:18, horiz = F)

#FieldGoals
#t(FieldGoals) #transpose

################

#Subsetting
Games
Games[1:3,6:10]

#compare top and bottom paid players
Games[c(1,10),]

#2008
Games[,c("2008", "2009")]

#extract games first column
Games[1,]

is.matrix(Games[1,])
#not a matrix, is a vector
#because R is assuming you want a vector instead of the matrix
#R shortcuts when possible to speed up calculations

#the fix to get a matrix instead:
Games[1,,drop=F] #dropping rows or columns = False
is.matrix(Games[1,,drop=F])

################

#visualize the subsets
Data <- MinutesPlayed[1,,drop = F]

matplot(t(Data), type = "b", pch=15:18, col=c(1:4, 6)) #plots columns, we have rows
#add a legend
legend("bottomleft", inset=0.01, legend= Players[1], col=c(1:4,6), pch=15:18, horiz = F)

Data

################

#encapsulate this code so we dont have to retype over and over

myplot <- function(table, rows=1:10){ #rows = 1:10 sets a default value
  Data <- table[rows,,drop = F]
  matplot(t(Data), type = "b", pch=15:18, col=c(1:4, 6)) #plots columns, we have rows
  legend("bottomleft", inset=0.01, legend= Players[rows], col=c(1:4,6), pch=15:18, horiz = F)
}

myplot(MinutesPlayed, 1:3)

################


#Salary
myplot(Salary)
myplot(Salary / Games)
myplot(Salary / FieldGoals)