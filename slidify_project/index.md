---
title       : Stock Charts
subtitle    : Developing Data Products Project
author      : Trent Baur
job         : Coursera Data Science Student
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : default      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Stock Charts Application Overview

The Stock Charts Application allows one to display a daily price chart of a user-selected stock symbol and date range. Along with basic charting ability, the application also provides the following additional functionality:
- Displays summary data for selected time range. (Total Days, Days Up/Down, Percent Up)
- Displays calculated metrics such as Min, Max, Mean, Median and Standard Deviation of daily price movements. These metrics can be calculated against two types of daily price movements (Open to Close or Low to High) and the user can toggle between each calculation method.
- Allows user to modify the "Moving Average - Days" parameter for the Moving Average that is overlaid onto the chart.

--- 

## Underlying Data

Data used by the Stock Chart Application comes from an API call to Yahoo Finance using the <a href="http://www.quantmod.com/">quantmod</a> package.  

Below is a sample of live data for QQQ that is returned by the API call. It shows the 6 most recent dates for which data exists is displayed. (Excludes weekends/holidays.)


```
##            QQQ.Open QQQ.High QQQ.Low QQQ.Close QQQ.Volume QQQ.Adjusted
## 2015-03-13   105.67   106.12  104.68    105.34   42021100       105.34
## 2015-03-16   105.76   106.74  105.62    106.70   25674100       106.70
## 2015-03-17   106.41   107.04  106.16    106.87   19603800       106.87
## 2015-03-18   106.57   108.41  106.03    107.92   40622200       107.92
## 2015-03-19   108.03   108.38  107.87    108.08   29571900       108.08
## 2015-03-20   108.72   109.07  108.51    108.53   29515500       108.53
```

---&columns


## Stock Chart User Interface

*** =left

The application has the following controls:

<img src = 'assets\img\controls.JPG'></img>

*** =right

<b>Symbol</b>
- Choose the symbol and date range with the first set of controls.

<b>Intraday Range Type</b>
- Changes the calculations displayed in the Statistics table.

<b>Moving Average - Days</b>
- Controls the number of days used in calculating the moving average curve applied to the chart. (A  moving average is the unweighted mean of the previous n data.)


---&columns

## Interpretting Results

*** =left

<img src = 'assets\img\results.JPG'></img>


*** =right

Along with a chart of daily price movements, summary statistics are provided in the General Performance data table.

Modifying the Intraday Range Type control will change how calculations are made in the Statistics data table. This allows the user to evaluate overall performance or general volatility of price action.

By changing the number of days used in the moving average, the blue line on the chart will either follow the price bars more or less closely.



