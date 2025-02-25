rm(list = ls())

#数据类型
is.numeric(3428)    #是否为数值型

is.character("KX-5")   #是否为字符型

is.logical(NA)       

is.complex(11438+148i)


#确认数据类型
typeof(c(sample(10)))
typeof(c(runif(10)+sample(10)))
mode(c(runif(1)+1i))    #这三步同时确定了向上兼容的顺序


#数值型数据的精度问题
sqrt(2)^2==2
is.numeric(sqrt(2)^2)

#复数型数据运算实例
sqrt(-17)
sqrt(-17+0i)
exp(pi*1i)     #欧拉公式$\exp{i\theta}=\cos{\theta}+i\sin{\theta}$


#判断语句示例
#示例1
if(length(c(NA,Inf,NULL))==3){
  print("Hi Jack!")
}else{
  print("Hello the world!")   #第一步Hello the world完成
}


#数据结构

#矩阵
z0 <- matrix(c(1:9), nrow = 3, byrow = F)
z0
z1 <- matrix(c(1:9), nrow = 3, byrow = T)
z1
z0%*%z1
eigen(z1)


#生成向量
rep(0,10)
seq(4,1,by = -0.5)


#指示向量中的位置以及向量的加法与数乘
x <- c(sample(10))
x[1]
y <- c(sample(10))
x+y
3*x


#数据框相关操作
#自主建立数据框
dds <- data.frame(x = c(sample(10)),y = c(sample(10)),z = c(sample(10)))
str(dds)
summary(dds)

install.packages(psych)
library(psych)
psych::describe(dds)

install.packages(pastecs)
library(pastecs)
pastecs::stat.desc(dds)


#实际操作
library(nycflights13)    #记录了2013年美国各州共336776条航班信息
dat <- flights
?flights                #数据表详情

summary(dat)

psych::describe(dat)  #与stat.desc均为描述性统计用，计算量相对较大，较慢

stat.desc(dat, basic = T, desc = T, norm = F)

#使用R自带函数进行分组统计
table(x = dat$carrier)   #不同承运商航班频数

aggregate(x = dat$distance, by = list(dat$carrier), FUN = mean) #不同承运商机场距离均值

mode(aggregate(x = dat$distance, by = list(dat$carrier), FUN = mean))

#使用dplyr包高性能处理
#install.packages("tidyverse")   #dplyr、ggplot2等包都属于tidyverse
install.packages("dplyr")

library(dplyr)

help(package = "dplyr")

library(help = "dplyr")

summarise(group_by(dat, carrier),mean(distance))#等效于aggregate函数

group_by(dat,carrier)%>%
  summarize(mean(distance))     #管道函数写法



filter(dat,carrier == c("OO","F9","HA","AS")) %>%   #过滤出四家公司
  mutate(distance1 = 2*distance)%>%   #创建变量distance1，为distance的2倍
    arrange(desc(time_hour))%>%        #按时间降序排列
      group_by(carrier)%>%               #按照carrier分组
        select(ends_with("distance1"))%>%  #挑选合适的变量，按照变量名尾部挑选
          summarise(mean(distance1))         #计算四家公司distance1的均值

