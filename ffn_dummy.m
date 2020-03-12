%% FFN

clear all;
close all;



path = "/home/radar/Dokumentumok/Neuromorph/Önlab2/data";

fileNameLeg = "h2_láb.xlsx";
fileNameLeftArm1 = "MaLi_ActivityPattern30_ldh1.xls";
fileNameLeftArm2 = "MaLi_ActivityPattern30_ldh3.xls";
fileNameLeftArm3 = "MaLi_ActivityPattern30_ldh5.xls";

DataLeg = importdata(strcat(path,'/',fileNameLeg));
DataLeftArm1 = importdata(strcat(path,'/',fileNameLeftArm1));
DataLeftArm2 = importdata(strcat(path,'/',fileNameLeftArm2));
DataLeftArm3 = importdata(strcat(path,'/',fileNameLeftArm3));

activation = zeros(size(DataLeftArm1,1),2);
activation(:,1) = DataLeftArm1(:,2);
activation(:,2) = DataLeftArm1(:,4);
activation(:,3) = DataLeftArm1(:,6);
activation(:,4) = DataLeftArm1(:,8);


Target1 = DataLeg.data(:,2)';
Target2 = DataLeg.data(:,3)';

%%

RepSignal = repeatPattern(activation,3);
RepTarget1 = repeatPattern(Target1,3);
show = 0;

if(show)

    figure(1);
    heatmap(downsample(activation,4));

    figure(2);
    heatmap(downsample(RepSignal,12));

end



%%


X = con2seq(RepSignal'); 
T = con2seq(RepTarget1');



%net = feedforwardnet(50);
%net = patternnet(10);
net= fitnet(20,'trainlm');
net = train(net,X,T);
view(net)
Y = net(X);
perf = perform(net,Y,T);

figure(1);
plot(cell2mat(Y));hold on;plot(cell2mat(T));
