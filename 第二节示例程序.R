rm(list = ls())

library(readxl)

dat <- readxl::read_xlsx("C:/Users/lenovo/Desktop/example-2/beijing.xlsx")#这里填写自己的路径

library(dplyr)

head(dat)   #展示数据表头以及前六行

summary(dat)   #简单汇总

mutate(dat, total = AREA*price) %>% #%>%为管道，新增列总价=price*AREA
  filter(subway == 1) %>%           #筛选subway == 1的个体
    filter(CATE == "haidian") %>%   #筛选海淀区的个体
      select(ends_with("total")) %>%   #筛选变量，这里是仅仅保留"total"
        summarise(mean(total))  #计算"total"的均值，即海淀区地铁旁边房总价均值



