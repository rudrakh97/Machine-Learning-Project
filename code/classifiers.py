# Author: Rudrakh97
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC
from sklearn.naive_bayes import BernoulliNB
from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import train_test_split
from sklearn.model_selection import GridSearchCV
from sklearn import metrics

loc = './new_attributes_14.csv'
data = pd.read_csv(loc)
input = data.iloc[:,0:13]
output = data.iloc[:,14]
X_tr, X_tst, y_tr, y_tst = train_test_split(input, output, test_size=0.1)

clf1=RandomForestClassifier()
clf1.fit(X_tr, y_tr)
predicted= clf1.predict(X_tst)
print "Accuracy using Random forest classifier: "
print metrics.accuracy_score(y_tst, predicted) # Score: 0.466

clf2=SVC()
clf2.fit(X_tr, y_tr)
predicted= clf2.predict(X_tst)
print "Accuracy using SVM classifier: "
print metrics.accuracy_score(y_tst, predicted) # Score: 0.503

clf3=BernoulliNB()
clf3.fit(X_tr, y_tr)
predicted= clf3.predict(X_tst)
print "Accuracy using Naive Bayes classifier: "
print metrics.accuracy_score(y_tst, predicted) # Score: 0.584

clf4=KNeighborsClassifier()
clf4.fit(X_tr, y_tr)
predicted= clf4.predict(X_tst)
print "Accuracy using KNeighbors classifier: "
print metrics.accuracy_score(y_tst, predicted) #Score: 0.4738

clf5=DecisionTreeClassifier()
clf5.fit(X_tr, y_tr)
predicted= clf5.predict(X_tst)
print "Accuracy using Decision Tree classifier: "
print metrics.accuracy_score(y_tst, predicted) #Score: 0.4415

clf5 = MLPClassifier(solver='sgd', alpha=1e-5, hidden_layer_sizes=(40, 15), tol=0.000000001, random_state=0, learning_rate='adaptive',max_iter=1000,shuffle=True,verbose=True)
clf5.fit(X_tr,y_tr)
predicted = clf5.predict(X_tst)
print "Accuracy using MLP classifier: "
print metrics.accuracy_score(y_tst, predicted) # Score: 0.586



