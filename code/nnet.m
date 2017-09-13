file = 'C:/Users/Rudrakh97/Desktop/ICSE 2017/codes/new_attributes_14.xlsx';
A = xlsread(file);
input = A(:,1:14);
output = A(:,15);
x = input';
t = output';

trainFcn = 'trainbr';  % Scaled conjugate gradient backpropagation.

% Varying number of layers to check change in accuracy

% for i = 1:1:50
%     % Create a Pattern Recognition Network
%     hiddenLayerSize = i;
%     net = patternnet(hiddenLayerSize);
% 
%     % Setup Division of Data for Training, Validation, Testing
%     net.divideParam.trainRatio = 70/100;
%     net.divideParam.valRatio = 15/100;
%     net.divideParam.testRatio = 15/100;
% 
%     % Train the Network
%     [net,tr] = train(net,x,t);
% 
%     % Test the Network
%     y = net(x);
%     e = gsubtract(t,y);
%     performance(i) = perform(net,t,y)
%     tind = vec2ind(t);
%     yind = vec2ind(y);
%     percentErrors = sum(tind ~= yind)/numel(tind);
% end
% 
% plot(1:1:50, performance)
 % Create a Pattern Recognition Network
    hiddenLayerSize = 17;
    net = patternnet(hiddenLayerSize);

    % Setup Division of Data for Training, Validation, Testing
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;

    % Train the Network
    [net,tr] = train(net,x,t);

    % Test the Network
    y = net(x);
    e = gsubtract(t,y);
    performance = perform(net,t,y);
    tind = vec2ind(t);
    yind = vec2ind(y);
    percentErrors = sum(tind ~= yind)/numel(tind);
    disp(performance); % 0.6822
% View the Network
% view(net)
% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotconfusion(t,y)
%figure, plotroc(t,y)

