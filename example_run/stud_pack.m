%This is a run on example data (not package data)
filename = 'C:\Users\Rudrakh97\Downloads\ENB2012_data.xlsx';
var_matrix = xlsread(filename);
input_var = var_matrix([1:768],[1:8]);%input variable matrix extracted from excel matrix
%%%%%%%%%%%%%%%%MEAN NORMALIZATION OF INPUT VARIABLES FOR BETTER
%%%%%%%%%%%%%%%%ACCURACY%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u = zeros(8,1);%finding mean matrix
for i = 1:8
    u(i)=mean(input_var([1:768],i));
end
s = zeros(8,1);%finding variance matrix
for j = 1:8
    mini = 1000000000;
    maxi = -1000000000;
    for i = 1:768
        if(input_var(i,j)<mini)
            mini = input_var(i,j);
        end
        if(input_var(i,j)>maxi)
            maxi = input_var(i,j);
        end
    end
    s(j) = (maxi-mini);
end
for j = 1:8
    for i = 1:768
        input_var(i,j) = (input_var(i,j)-u(j))/s(j);%x(i)=x(i)-u(i)/s(i)
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output_var = var_matrix([1:768],[9,10]);%output variable matrix extracted from excel matrix
%The first prediction is using normalization method
theta_matrix = pinv(transpose(input_var)*input_var)*transpose(input_var)*output_var;%theta = (XTX)^(-1)*XT*Y
%Using inbuilt function for greater accuracy
options = optimset('GradObj', 'on' ,'MaxIter', 150);
initialTheta = zeros(8,2);
[optTheta, functionVal, exitFlag] = fminunc(@costFunction, initialTheta, options);
%optTheta is the theta matrix obtained from inbuilt function
%theta_matrix is obtained by normalisation method
