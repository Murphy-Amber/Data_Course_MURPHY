mtcars
data()
df_car = mtcars
print(df_car)
nrow(df_car)
ncol(df_car)
str(df_car)
dim(df_car)
names(df_car)

ma = max(df_car$mpg)
mi = min(df_car$mpg)
me = mean(df_car$mpg)
vec = c(ma, mi, me)

df_car[df_car$mpg >20, ]
good_car = df_car[df_car$mpg >20, ]

