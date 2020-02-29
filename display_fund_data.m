% This program is a short code for display data

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


%%
figure(10);
activationLeftArm = DataLeftArm1(:,2:9);
heatmap(activationLeftArm);
%%
activationLeftLeg = DataLeg.data(:,2:5);
heatmap(activationLeftLeg);

%%

activation = zeros(size(DataLeftArm1,1),size(DataLeftArm1,2)+1);
activation(:,1:8) = DataLeftArm1(:,2:9);
activation(:,9:10) = DataLeg.data(:,2:3);
heatmap(activation);

%%
clf;

activation = zeros(size(DataLeftArm1,1),6);
activation(:,1) = DataLeftArm1(:,2);
activation(:,2) = DataLeftArm1(:,4);
activation(:,3) = DataLeftArm1(:,6);
activation(:,4) = DataLeftArm1(:,8);
activation(:,5:6) = DataLeg.data(:,2:3);
heatmap(activation);

% Logic function for leg c1 %%%%%%%%%%%%%%%%%%%
%----------------------------------------------
% (!x1 ^ x2 ^ x3 ^ x4) || (!x1 ^ !x2 ^ x3 ^ x4)
%----------------------------------------------


% Logic function for leg c2 %%%%%%%%%%%%%%%%%%%
%----------------------------------------------
% (x1 ^ !x2 ^ x3 ^ x4) || (x1 ^ x2 ^ x3 ^ x4) || (x1 ^ x2 ^ ! x3 ^ x4) ||
% (x1 ^ x2 ^ x3 ^ !x4) | (x1 ^ !x2 ^ !x3 ^ x4)
%----------------------------------------------

[c1,c2] = logic_activationLev1(activation(:,1:4));
activation(:,7) = c1;
activation(:,8) = c2;
heatmap(activation);