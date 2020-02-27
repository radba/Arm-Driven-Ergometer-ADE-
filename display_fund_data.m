% This program is a short code for display data

clear all;
close all;

legActivation = 1;
leftArmActivation1 = 2;
leftArmActivation2 = 3;
leftArmActivation3 = 4;
leftArmActivation4 = 5;
leftArmActivation5 = 6;
leftArmActivation6 = 7;
leftArmActivation7 = 8;
leftArmActivation8 = 9;

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
figure(legActivation);
hold on;grid on;
plot(DataLeg.data(:,1),DataLeg.data(:,2));
plot(DataLeg.data(:,1),DataLeg.data(:,3));

xlabel('angle [deg]');
ylabel('activation');
legend('Left Quad.','Left Hamst,');
xlim([0,360]);ylim([0,1.1]);

%%

figure(leftArmActivation1);                    % Comper single cahnels activities differences according the strengt of the arm cycling.
hold on;grid on;
plot(DataLeftArm1(:,1),DataLeftArm1(:,2));                  % Level 1 
plot(DataLeftArm1(:,1),DataLeftArm2(:,2));                  % Level 3
plot(DataLeftArm1(:,1),DataLeftArm3(:,2));                  % Level 5

xlabel('angle [deg]');
ylabel('activation');
legend('Level1','Level3','level5');
xlim([0,360]);ylim([0,1.1]);

%%

figure(leftArmActivation2);                    % Comper single cahnels activities differences according the strengt of the arm cycling.
hold on;grid on;
plot(DataLeftArm1(:,1),DataLeftArm1(:,3));                  % Level 1 
plot(DataLeftArm1(:,1),DataLeftArm2(:,3));                  % Level 3
plot(DataLeftArm1(:,1),DataLeftArm3(:,3));                  % Level 5

xlabel('angle [deg]');
ylabel('activation');
legend('Level1','Level3','level5');
xlim([0,360]);ylim([0,1.1]);

%%

figure(leftArmActivation3);                    % Comper single cahnels activities differences according the strengt of the arm cycling.
hold on;grid on;
plot(DataLeftArm1(:,1),DataLeftArm1(:,4));                  % Level 1 
plot(DataLeftArm1(:,1),DataLeftArm2(:,4));                  % Level 3
plot(DataLeftArm1(:,1),DataLeftArm3(:,4));                  % Level 5

xlabel('angle [deg]');
ylabel('activation');
legend('Level1','Level3','level5');
xlim([0,360]);ylim([0,1.1]);

%%

figure(leftArmActivation4);                    % Comper single cahnels activities differences according the strengt of the arm cycling.
hold on;grid on;
plot(DataLeftArm1(:,1),DataLeftArm1(:,5));                  % Level 1 
plot(DataLeftArm1(:,1),DataLeftArm2(:,5));                  % Level 3
plot(DataLeftArm1(:,1),DataLeftArm3(:,5));                  % Level 5

xlabel('angle [deg]');
ylabel('activation');
legend('Level1','Level3','level5');
xlim([0,360]);ylim([0,1.1]);

%%

figure(leftArmActivation5);                    % Comper single cahnels activities differences according the strengt of the arm cycling.
hold on;grid on;
plot(DataLeftArm1(:,1),DataLeftArm1(:,6));                  % Level 1 
plot(DataLeftArm1(:,1),DataLeftArm2(:,6));                  % Level 3
plot(DataLeftArm1(:,1),DataLeftArm3(:,6));                  % Level 5

xlabel('angle [deg]');
ylabel('activation');
legend('Level1','Level3','level5');
xlim([0,360]);ylim([0,1.1]);

%%

figure(leftArmActivation6);                    % Comper single cahnels activities differences according the strengt of the arm cycling.
hold on;grid on;
plot(DataLeftArm1(:,1),DataLeftArm1(:,7));                  % Level 1 
plot(DataLeftArm1(:,1),DataLeftArm2(:,7));                  % Level 3
plot(DataLeftArm1(:,1),DataLeftArm3(:,7));                  % Level 5

xlabel('angle [deg]');
ylabel('activation');
legend('Level1','Level3','level5');
xlim([0,360]);ylim([0,1.1]);

%%

figure(leftArmActivation7);                    % Comper single cahnels activities differences according the strengt of the arm cycling.
hold on;grid on;
plot(DataLeftArm1(:,1),DataLeftArm1(:,8));                  % Level 1 
plot(DataLeftArm1(:,1),DataLeftArm2(:,8));                  % Level 3
plot(DataLeftArm1(:,1),DataLeftArm3(:,8));                  % Level 5

xlabel('angle [deg]');
ylabel('activation');
legend('Level1','Level3','level5');
xlim([0,360]);ylim([0,1.1]);

%%

figure(leftArmActivation8);                    % Comper single cahnels activities differences according the strengt of the arm cycling.
hold on;grid on;
plot(DataLeftArm1(:,1),DataLeftArm1(:,9));                  % Level 1 
plot(DataLeftArm1(:,1),DataLeftArm2(:,9));                  % Level 3
plot(DataLeftArm1(:,1),DataLeftArm3(:,9));                  % Level 5

xlabel('angle [deg]');
ylabel('activation');
legend('Level1','Level3','level5');
xlim([0,360]);ylim([0,1.1]);

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