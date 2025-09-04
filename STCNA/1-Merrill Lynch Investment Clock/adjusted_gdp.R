# 安装并加载必要的包
# install.packages("seasonal")
# install.packages("readxl")
library(seasonal)
library(readxl)

# install.packages("writexl")
library(writexl)

# 读取数据（假设你的Excel文件已经加载到R中的dataframe叫df）
df <- read_excel("C:/Users/20201/Desktop/output gap.xlsx")  # 替换为你的文件路径

# 将time列转换为Date类型（假设是季度数据）
df$time <- as.Date(df$time)

# 提取年份和季度
df$year <- as.numeric(format(df$time, "%Y"))  # 提取年份
df$quarter <- as.numeric(format(df$time, "%m")) %/% 3 + 1  # 提取季度：1 = Q1, 2 = Q2, 3 = Q3, 4 = Q4

# 使用seasonal包进行季节性调整
gdp_ts <- ts(df$`actual gdp`, start=c(df$year[1], df$quarter[1]), frequency=4)

# 使用X-13ARIMA-SEATS方法进行季节性调整
adjusted_gdp <- seas(gdp_ts)

# 查看调整后的结果
summary(adjusted_gdp)

# 获取去除季节性的GDP数据
df$gdp_adjusted <- final(adjusted_gdp)

# 可视化调整前后的数据
plot(df$time, df$`actual gdp`, type="l", col="blue", ylim=range(c(df$`actual gdp`, df$gdp_adjusted)), xlab="Time", ylab="GDP", main="GDP Seasonality Adjustment")
lines(df$time, df$gdp_adjusted, col="red")
legend("topright", legend=c("Actual GDP", "Adjusted GDP"), col=c("blue", "red"), lty=1)

# 创建一个新的数据框，包含需要导出的列
output_df <- df[, c("time", "actual gdp", "gdp_adjusted")]

# 将数据导出为Excel文件
write_xlsx(output_df, "C:/Users/20201/Desktop/output_gap_adjusted.xlsx")  # 输出文件名为output_gap_adjusted.xlsx

# 提示文件已保存
cat("文件已保存为 'output_gap_adjusted.xlsx' \n")
