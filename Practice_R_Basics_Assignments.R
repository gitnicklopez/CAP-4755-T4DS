# This script analyzes the Orange data set and plots the circumference growth
# over the age of the plant in 3 different measurements (years, months, days)
# for age. A line of best fit is also plotted in each plot as a dashed line.

# initiate libraries
library(datasets)
library(lubridate) # used for date calc

#Load Orange data set
data(Orange)

# define key variables
plant_dt = as.Date("1968-12-31") # from help doc
max_Tree = max(as.numeric(Orange$Tree))

# create vec of measurments
measurments = c("years", "months")

# add measurment age
for (m in measurments) {
  name = paste("age_", m, sep = "")
  Orange[name] = round(time_length(difftime(plant_dt + Orange$age, plant_dt), m))
}

# Rename age field to specify the measument
colnames(Orange)[colnames(Orange) == "age"] <- "age_days"

# create vec for each age field
age_fields = c(colnames(Orange)[grepl("age", colnames(Orange))])

# Create a plot for each age measurement
for (age in sort(age_fields, decreasing = TRUE)) {
  print(age)
  # plot line chart to see circumfence growth over age for all measurments
  plot(
    x = Orange[age][Orange["Tree"] == "1"],
    y = Orange$circumference[Orange$Tree == "1"],
    type = "b",
    main = "Circumference Growth Over Age",
    xlab = paste("Age (", sub("age_", "", age), ")", ""),
    ylab = "Circumference (mm)",
    col = 2,
    asp = 2
  )
  
  # plot remaining Trees
  for (t in 2:max_Tree) {
    points(x = Orange[age][Orange["Tree"] == t],
           y = Orange$circumference[Orange$Tree == t],
           col = t + 1)
    lines(x = Orange[age][Orange["Tree"] == t],
          y = Orange$circumference[Orange$Tree == t],
          col = t + 1)
  }
  
  # add legend
  legend(
    "topleft",
    legend = 1:max_Tree,
    col = 1:max_Tree,
    pch = 1
  )
  
  # add line of best fit
  abline(lm(unlist(Orange["circumference"]) ~ unlist(Orange[age])),
         lty = 5,
         lwd = 1)
}
