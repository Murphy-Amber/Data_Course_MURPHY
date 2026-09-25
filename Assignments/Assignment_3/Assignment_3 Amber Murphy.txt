###########################
#                         #
#    Assignment Week 3    #
#                         # 
###########################

# YOUR REMAINING HOMEWORK ASSIGNMENT (Fill in with code) ####

# 1.  Get a subset of the "iris" data frame where it's just even-numbered rows

seq(2,150,2) # here's the code to get a list of the even numbers between 2 and 150
#tried using tidyverse but that would not work, the filter command is the wrong one to use, go back to a regular data frame
iris[seq(2,150,2), ] #sequence to call every other row, iris is the data frame, leave column blank to pull every column this works

# 2.  Create a new object called iris_chr which is a copy of iris, except where every column is a character class
iris_chr = as.character(iris)
print(iris_chr)

# 3.  Create a new numeric vector object named "Sepal.Area" which is the product of Sepal.Length and Sepal.Width
Sepal.Area = iris$Sepal.Length*iris$Sepal.Width
print(Sepal.Area)

# 4.  Add Sepal.Area to the iris data frame as a new column
library(tidyverse) #apparently summarize will not work for this, R wants me to use reframe instead
# this part is wrong and will not work 
iris %>% 
  reframe(Sepal.Area = iris$Sepal.Length*iris$Sepal.Width) %>%
  mutate(new_col = 'Sepal.Area') #this is not working and is only giving me the characters in the column not the numeric values
#going to try with a regular data frame

iris$Sepal.Area = iris$Sepal.Length*iris$Sepal.Width
print(iris)
#that was way easier, maybe I can fix the tidyverse similarly

iris_new = iris %>% #made a new object to keep track but that is not strictly necessary, I will show the rest of the code using both options
  mutate(Sepal.Area = iris$Sepal.Length*iris$Sepal.Width)
print(iris_new) #this worked! So I was just overthinking what I had to do

# 5.  Create a new dataframe that is a subset of iris using only rows where Sepal.Area is greater than 20 
      # (name it big_area_iris)
big_area_iris = iris_new[iris_new$Sepal.Area >20, ]
print(big_area_iris) #or using tidyverse

big_area_iris = iris_new %>%
  filter(Sepal.Area >20)
print(big_area_iris) #or if we want to only use the original iris

big_area_iris = iris[iris$Sepal.Area>20, ]
print(big_area_iris) #or using tidyverse again this time with no new_iris

big_area_iris = iris %>%
  filter(iris$Sepal.Area >20)
print(big_area_iris) #that is all the ways I can think of to do it

# 6.  Upload the last numbered section of this R script (with all answers filled in and tasks completed) 
      # to canvas
      # I should be able to run your R script and get all the right objects generated
