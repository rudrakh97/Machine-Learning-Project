filename = 'Player_Attributes.xlsx';
input_var1 = xlsread(filename);

u = zeros(38,1);

%   calculate mean matrix
cnt = 0;
for i = 1:1:38
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

for j = 1:38
    for i = 1:183798
        %   inputs not available set to mean
        if isnan(input_var1(i,j))
            input_var1(i,j) = (u(j));
        end
		input_var1(i,j) = log(input_var1(i,j))
    end
end

dlmwrite('D:/Player_Attributes.csv', input_var1) ;