#Task four and five
read.csv(file = 'Data/iris.csv')
obj = read.csv(file = 'Data/iris.csv')
getwd()
list.files(path = 'Data' , pattern = '.csv')
obj = list.files(path = 'Data' , pattern = '.csv')
obj
obj = read.csv(file = 'Data/iris.csv')
obj
csv_file = list.files(path = 'Data' , pattern = '.csv')
obj = csv_file
obj
length(csv_file)

#Task six
read.csv(file = 'Data/wingspan_vs_mass.csv')
df = read.csv(file = 'Data/wingspan_vs_mass.csv')
obj = df
length(df)
#To see type of data
str(df)
names(df)
View(df)
#To see number of rows and columns respectively
nrow(df)
ncol(df)
#Or you can see both rows and columns at once with this
dim(df)

#Task seven
head(df, n = 5)
tail(df, n = 5)

#Task eight
list.files(path = 'Data' , recursive = TRUE)
obj = list.files(path = 'Data' , recursive = TRUE)
length(obj)
list.files(path = 'Data' , pattern = '^B' , ignore.case = TRUE , recursive = TRUE)
list.files(path = 'Data' , pattern = 'b$' , ignore.case = TRUE , recursive = TRUE)
# means start with
# $ means end with

#Task nine
for(i in list.files(path = 'Data' , pattern = '^B' , ignore.case = TRUE , recursive = TRUE , full.names = TRUE)){
  first_line = readLines(i, n = 1)
  print(first_line)
}

#Task ten
for(i in list.files(path = 'Data' , pattern = '.csv' , recursive = TRUE , full.names = TRUE)){
  first_lines = readLines(i, n = 1)
  print(first_lines)
}

#Extra learning commands not a part of assignment two, see data frame at the end.
vec = c(1+2+3)
vec + 1
length(vec)

mdat <- matrix (c(1,2,3, 11,12,13), nrow = 2, ncol = 3, byrow = TRUE, 
                dimnames = list(c("row1", "row2"),c("C.1", "C.2", "C.3")))

?array
arr = array(1:12, dim = c(2,2,6))
print(arr)

dat = data.frame(
  id = c(1,2,3),
  weight = c(4,5,6),
  color = c('purple', 'green', 'red', 'blue', 'yellow', 'orange')
)

my_func = function(x, y){
  out = x + y
  print(out)
}
my_func(344,767)

Maths = c('Sum' , 'Subtract' , 'Multiply' , 'Divide')

for(variable in Maths){
  out = paste(Maths)
  print(out)
}

i = 1
while (i < 6) {
  print('cool')
  i = i+1
}

# Food text file
df_foods = data.frame(
  Foods = c('Shrimp' , 'Chicken' , 'Apple' , 'Fish'),
  cal = c(99, 335, 95, 366)
)
df_foods$calories_100 = df_foods$cal + 100
print(df_foods)
write.csv(df_foods, 'df_foods.csv')
read.csv('df_foods.csv')
write.table(df_foods)