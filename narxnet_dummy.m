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

lastInputs = 5;

net = narxnet(1:lastInputs,1:30,10);
%net = narxnet(1:20,1:5,10);
[Xs,Xi,Ai,Ts] = preparets(net,X,{},T);
net = train(net,Xs,Ts,Xi,Ai);
%view(net);
[Y,Xf,Af]= net(Xs,Xi,Ai);
plotresponse(Ts,Y);



figure(23);
plot(cell2mat(Ts));hold on;grid on;
plot(cell2mat(Y));

%Y2 = net(cel(:,21),cel(:,1:20),Ai);



%%


sequence = [X;T];

% prev_steps = sequence(:,1:lastInputs);
% Y2 = {};
% 
% for i=lastInputs+1:400
%     
%     
%     y2 = net(sequence(:,i),prev_steps,Ai);
%     Y2 = [Y2,y2];
%     prev_steps(:,lastInputs+1) = sequence(:,i);
%     prev_steps = prev_steps(:,2:lastInputs+1);
%     
%     
%     
% end
% 
% figure(3);
% plot(cell2mat(Y2));hold on;

save('net.mat', 'net');


%%

perf = perform(net,Ts,Y);
[netc,Xic,Aic] = closeloop(net,Xf,Af);
%view(netc);

prev_steps = sequence(1,1:lastInputs);
Y2 = {};

for i=lastInputs+1:1080
    
    
    y2 = netc(cell(0,lastInputs),prev_steps,Aic);
    Y2 = [Y2,y2(1)];
    prev_steps(lastInputs+1) = sequence(1,i);
    prev_steps = prev_steps(2:lastInputs+1);
    
    
    
end

figure(3);
plot(cell2mat(Y2));hold on;
