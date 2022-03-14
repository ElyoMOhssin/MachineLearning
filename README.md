# Machine Learning Model to predict missing values
Data is dynamic and can be easily lost or corrupted if data administrators and users are not careful about it. A retail dataset from 
Flora company has an issue regarding the type of customer classification: some data is missing. Fortunately, we had developed 2 classification models 
to statistically predict the missing data values with a Logistic Regression model (accuracy: 83%) and a Knn model (accuracy: 83%, not overfitted). 
Concluding, models can be improved by the iteration process of the seed’s values and other classification models such as Naïve-Bayes 
to better understand the variables and their relationships with the type of customer.

In this analysis we will keep the following order:

1.- Import Data with a SQL query from database

2.- Feature engineering in both the continuous and categorical data.

3.- Logistic regression model.

4.- Knn regression model.

5.- Predicting the unknown variables

6.- Overall conclusions.
