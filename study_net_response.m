%% Input signal types

clear all;
close all;

net = load('net.mat');
net = net.net;



%% Uniform dist Noise

Signal = rand(4,400);
Signal = con2seq(Signal); 

prev_steps = Signal(:,1:20);
Y2 = {};
Ai = cell(2,0);

for i=21:400
    
    
    y2 = net(Signal(:,i),prev_steps(:,1:20),Ai);
    Y2 = [Y2,y2];
    prev_steps(:,21) = Signal(:,i);
    prev_steps = prev_steps(:,2:21);
    
    
    
end

figure(3);
plot(cell2mat(Y2));hold on;


%% Gaussian




%% Sinus




%% Triangle




%% Frequnecy chaning



