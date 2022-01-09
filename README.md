# LifeExpectancy_LinReg
project using the software R-Studio.
The datasaet is "Liffe Expectancy (WHO)" and can be found on https://www.kaggle.com/kumarajarshi/life-expectancy-who. Moreover, the dataset involved all the countries in the time span 2000-2015. However, to provide insights closer to the actual period, the analysis focused only on the year 2015.
The analysis was carried out through a linear regression model in order to identify the main factors that influence life Expectancy.
The target variable is life expectancy and is expressed in years-old.
The first task was data preprocessing:
1 - extracting the data referred to the year 2015;
2 - excluding all the istance rows that had NA, therefore missing values;
3 - merging all the vaccine per desease variable in just one variable;
4 - creating a Bernoulli variable for developing and not developing countries
5 - correlation matrix in order to identify the most correlated predictors and, in case of high correlation, leave them out. In addition, correlation matrix was useful also to detect high correlation between the predictors and the target variable. In case of high correlation, those variable could be highly informative;

Once completed the per-processing phase the focus was on the detecting the best model, therefore  from the full model the not significative variable have been removed. The procedure to identify the best model was based on all subset regression, using BIC as metric.
The best model was composed of the variables: Adult.Mortaly, Polio, Schooling and HIV.AIDS

The model diagnositcs was carried out through the following hypothesis tests:
1 - Test of normality (Shapiro/Wilk test, Kolmogorov/Smirnov test, Anderson/Darling test, Cramer/Von Mises test, Pearson test, Lilliefors test, Shapiro/Francia test)
Normality hypothesis not rejected. Furthermore, normality was also checked through the analysis of residuals;
2 - Test for homoskedasticity  (Breusch/Pagan test);
3 - Test for incorrelation (Durbin/Watson test).

The linearity property was checked through partial regression plot
