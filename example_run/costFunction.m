function [jVal, gradient] = costFunction(theta)
    filename = 'C:\Users\Rudrakh97\Downloads\ENB2012_data.xlsx';%whatever is the filepath
    var_matrix = xlsread(filename);
    input_var = var_matrix([1:768],[1:8]);%input variable matrix extracted from excel matrix
    output_var = var_matrix([1:768],[9,10]);%output variable matrix extracted from excel matrix
    h_theta = input_var*theta;
    costfunc = h_theta - output_var;
    jVal = 0;
    for i = 1:768
        for j = 1:2
            jVal = jVal + costfunc(i,j)*costfunc(i,j);
        end
    end
    gradient = transpose(input_var)*costfunc;
end