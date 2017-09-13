% @Author: Rudrakh97
filename = 'Player_Attributes.xlsx';
var_matrix = xlsread(filename);
input_var1 = var_matrix(:,(6:38));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%INPUT FEATURE SCALING%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%AND DATA PROCESSING%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   initialize mean matrix
u = zeros(33,1);

%   calculate mean matrix
cnt = 0;
for i = 1:1:33
    for j = 1:1:183798
        %   ignore inputs not available
        if(isnan(input_var1(j,i)))
            continue;
        end
        u(i) = u(i) + input_var1(j,i);
        cnt = cnt + 1;
    end
    if cnt==0
        continue;
    end
    u(i) = u(i)/cnt;
    cnt = 0;
end

%   initialize variance matrix
s = zeros(33,1);

%   calculate variance matrix
for j = 1:33
    mini = 1000000000;
    maxi = -1000000000;
    for i = 1:183798
        if(input_var1(i,j)<mini)
            mini = input_var1(i,j);
        end
        if(input_var1(i,j)>maxi)
            maxi = input_var1(i,j);
        end
    end
    s(j) = (maxi-mini);
end

%   Feature Scaling using the Standardization technique
for j = 1:33
    if s(j)==0
        continue;
    end
    for i = 1:183798
        %   inputs not available set to mean
        if isnan(input_var1(i,j))
            input_var1(i,j) = log(u(j));
        end
        input_var1(i,j) = log(input_var1(i,j));
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output_var1 = var_matrix(:,4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%DATA PROCESSING%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   calculate mean
cnt = 0;
u1 = 0;
for i = 1:1:183798
    if(isnan(output_var1(i)))
        continue;
    end
    u1 = u1 + output_var1(i);
    cnt = cnt + 1;
end
if cnt~=0
    u1 = u1/cnt;
end

%   replace NaN with the mean
for i = 1:1:183798
    if(isnan(output_var1(i)))
        output_var1(i) = u1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   normalization method theta = (XTX)^(-1)*XT*Y
X = [eye(183978,1) input_var1];
XT = transpose([eye(183978,1) input_var1]);
theta_matrix1 = pinv(XT*X)*XT*output_var1;
%   theta_matrix -> matrix of weights to each parameter

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%GRAPH PLOT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
params = {'crossing','finishing','heading accuracy','short passing','volleys','dribbling','curve','free kick accuracy','long passing','ball control','accerelation','sprint speed','agility','reactions','balance','shot power','jumping','stamina','strength','long shots','aggression','interceptions','positioning','vision','penalties','marking','standing tackle','sliding tackle','gk diving','gk handling','gk kicking','gk positioning','gk reflexes'}; 
bar(theta_matrix1(2:34,1));
title('The effect of various player attributes on player performance');
xlabel('Feature number');
ylabel('Weight obtained after regression');
for i = 1:1:33
    h = text(i,0,params(i));
    g = text(i,0,char(theta_matrix1(i+1)));
    if(theta_matrix1(i+1) > 0)
        set(h, 'Rotation', -90);
        set(g, 'Rotation', 90);
        continue;
    end
    set(h, 'Rotation', 90);
    set(g, 'Rotation', -90);
end