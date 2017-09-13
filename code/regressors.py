# Author: Rudrakh97
import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.neural_network import MLPRegressor
from sklearn.model_selection import train_test_split
from sklearn import metrics

loc = './Player_attributes.csv'
print "Extracting data..."
raw_data = pd.read_csv(loc)
input = raw_data.iloc[:,5:37]
output = raw_data.iloc[:,3]

X_tr, X_tst, y_tr, y_tst = train_test_split(input, output, test_size=0.2)

print "..."

linear_model = LinearRegression()
linear_model = linear_model.fit(X_tr,y_tr)
print linear_model.coef_
# [-0.01105124  0.01284472  0.0995664   0.07643569 -0.00101271 -0.01030301
  # 0.0102208   0.01150189  0.01656917  0.22943356  0.04132547  0.04709093
 # -0.01472849  0.27945379  0.00355886  0.022818    0.01367363 -0.01787418
  # 0.06344327 -0.01969741  0.01051378  0.01884652 -0.01878591  0.00645808
  # 0.01618825  0.03421365  0.01221396 -0.02911852  0.22247502  0.07017427
 # -0.02438447  0.08707998]
print linear_model.score(X_tst,y_tst) # Score: 0.78448

print "..."

mlp_model = MLPRegressor()
mlp_model = mlp_model.fit(X_tr,y_tr)
print mlp_model.coefs_[0]
print mlp_model.score(X_tst,y_tst) # Score: 0.96546