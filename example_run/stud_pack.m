%This is a run on example data (not package data)
filename = 'C:\Users\Rudrakh97\Downloads\ENB2012_data.xlsx';
var_matrix = xlsread(filename);
input_var = var_matrix([1:768],[1:8]);%input variable matrix extracted from excel matrix
output_var = var_matrix([1:768],[9,10]);%output variable matrix extracted from excel matrix
%The first prediction is using normalization method
theta_matrix = pinv(transpose(input_var)*input_var)*transpose(input_var)*output_var;%theta = (XTX)^(-1)*XT*Y
%Using inbuilt function for greater accuracy
options = optimset('GradObj', 'on' ,'MaxIter', 150);
initialTheta = zeros(8,2);
[optTheta, functionVal, exitFlag] = fminunc(@costFunction, initialTheta, options);
%optTheta is the theta matrix obtained from inbuilt function
%theta_matrix is obtained by normalisation method
