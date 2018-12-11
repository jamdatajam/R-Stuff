getwd()
setwd("C:/Users/Jam/Documents/R")
getwd()

movies <- read.csv("Movie-Ratings.csv")
head(movies)
colnames(movies) <- c("Film", "Genre", "CriticRating", "AudienceRating", "BudgetMillions", "Year")
head(movies)
tail(movies)
str(movies)
summary(movies)


#convert all factors to be correct, whether they will be compared or calculated
factor(movies$Year) #convert years column into a factor
movies$Year <- factor(movies$Year)

summary(movies)
str(movies)

#Aesthetics in ggplot
library(ggplot2)

ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) #stronger plot than the fast plot we used earlier

#needs to be told the geometry
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) +
  geom_point()

#add color
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        colour = Genre)) +
  geom_point()

#add size
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        colour = Genre, size=BudgetMillions)) +
  geom_point()
#>>> This is #1 (We will improve it)


#Plot with layers
#make the plot into an object
p <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                             colour = Genre)) +
  geom_point()

#layers = plots as objects
p + geom_point() #makes p the base layer, then we add new layers on top

p + geom_line() #overlays a geometry

#multiple layers
p + geom_point() + geom_line() #dots and lines, it sets the order of operations

#overwriting aesthetics
q <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                             colour = Genre, size=BudgetMillions))

#add geom layes
q + geom_point()
#this inherits the aesthetics from q and then modifies it
#then can override it

#overriding aesthetics
#ex1
q + geom_point(aes(size=CriticRating))

#ex2
q + geom_point(aes(colour = BudgetMillions))

#these modifications are not permanent to the q object, just temporary
q+geom_point()

#can even override x and y
#ex3
q +geom_point(aes(x = BudgetMillions))
#leaves the titles the same when you override aesthetics, need to fix:
q + geom_point(aes(x= BudgetMillions)) + xlab("Budget Millions $$$")

#ex4
q + geom_line(size = 1) + geom_point()
#this is setting, as per mapping versus setting

#map v set
r <- ggplot(data = movies, aes(x = CriticRating, y = AudienceRating))
r + geom_point()

#Mapping 
r + geom_point(aes(colour = Genre))
#Setting:
r + geom_point(colour = "DarkGreen")
#Error:
#r + geom_point(aes(colour = "DarkGreen")) #makes it orange because it sets a variable name not an aesthetic

#create histograms/barplots
s <- ggplot(data=movies, aes(x = BudgetMillions))
s + geom_histogram(binwidth=10)

#add colour
s + geom_histogram(binwidth=10, fill="Green")
#OR
s + geom_histogram(binwidth=10, aes(fill=Genre))
#now add a border
s + geom_histogram(binwidth=10, aes(fill = Genre), colour = "Black")

#still need to improve this ...

#But now we will do a density chart
s + geom_density(aes(fill = Genre))
#Then to stack them
s + geom_density(aes(fill = Genre), position = "stack")

#starting layer
t <- ggplot(data=movies, aes(x=AudienceRating))
t + geom_histogram(binwidth=10,
                   fill="White", colour = "Blue")

#another way
t <- ggplot(data=movies)
t + geom_histogram(binwidth=10,
                   aes(x = AudienceRating),
                   fill="White", colour = "Blue")
#4 -> dont have to overwrite the t object
t + geom_histogram(binwidth=10,
                   aes(x = CriticRating),
                   fill="White", colour = "Blue")
#5 -> 

#can use this just to set the existence of the plot and then modify to add data later

t <- ggplot()

#transforms
u <- ggplot(data= movies, aes(x = CriticRating, y = AudienceRating,
                              colour = Genre))
u + geom_point() + geom_smooth(fill = NA)

#boxplots
u <- ggplot(data = movies, aes(x=Genre, y = AudienceRating,
                               colour=Genre))
u + geom_boxplot()
u + geom_boxplot(size=1.2)
u + geom_boxplot(size=1.2) + geom_point()
# fun hack:
u + geom_boxplot(size=1.2) + geom_jitter()

#another way
u + geom_jitter() + geom_boxplot(size = 1.2, alpha = 0.5)


#making facets
v <- ggplot(data = movies, aes(x = BudgetMillions))
v + geom_histogram(binwidth=10, aes(fill=Genre),
                   colour = "Black")
#Facets
v + geom_histogram(binwidth=10, aes(fill=Genre),
                   colour = "Black") + 
  facet_grid(Genre~., scales = "free") #ex. (rows~columns)

#Facets to scatterplots
w <- ggplot(data=movies, aes(x = CriticRating, y= AudienceRating,
                             colour=Genre))

w + geom_point(size = 3)

#facets:
w + geom_point(size=3) +
  facet_grid(Genre~.)

w + geom_point(size=3) +
  facet_grid(.~Year)

w + geom_point(size=3) +
  facet_grid(Genre~Year)

w + geom_point(size = 3) + 
  geom_smooth() + 
  facet_grid(Genre~Year)

w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() + 
  facet_grid(Genre~Year)

#1, but still can be improved


#Coordinates
m<- ggplot(data = movies, aes(x = CriticRating, y = AudienceRating,
                              size = BudgetMillions,
                              colour=Genre))
m + geom_point()
m + geom_point() + 
  xlim(50,100) + 
  ylim(50, 100)

#wont always work well
n <- ggplot(data= movies, aes(x = BudgetMillions))
n + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black")

n + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black") + 
  ylim(0, 50)

#instead - zoom
n + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black") + 
  coord_cartesian(ylim = c(0,50))

#now apply to #1 plot
w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() + 
  facet_grid(Genre~Year) + 
  coord_cartesian(ylim=c(0,100))

#theme
o <- ggplot(data = movies, aes(x = BudgetMillions))
h <- o + geom_histogram(binwidth=10, aes(fill=Genre), colour = "black")

#axis labels
h + xlab("Money Axis") + 
  ylab("Number of Movies") +

#label formatting
  theme(axis.title.x = element_text(colour = "DarkGreen", size = 30),
      axis.title.y = element_text(colour = "Red", size = 30),
      axis.text.x = element_text(size = 20),
      axis.text.y = element_text(size = 20))

?theme

# now legend formatting
h + 
  xlab("Money Axis") + 
  ylab("Number of Movies") +
  ggtitle("Movie Budget Distro") + 
  theme(axis.title.x = element_text(colour = "DarkGreen", size = 30),
        axis.title.y = element_text(colour = "Red", size = 30),
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20),
        
        legend.title = element_text(size = 30),
        legend.text = element_text(size = 20),
        legend.position = c(1,1),
        legend.justification = c(1,1),

        plot.title = element_text(colour = "DarkBlue",
                                  size = 40,
                                  family = "Candara"))

