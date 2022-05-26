% John Michael P. Corbeta
% Replication of Napao2015 study to the Mindanao Grid
clc; clear;

a = cos(2*pi/3)+1i*sin(2*pi/3);
global A;
A = [ 1     1       1;
      1     a^2     a;
      1     a       a^2
    ];

% csv files extracted from Ybus and PF Voltages of 
% Mindanao Grid PW case 
tab0 = readcell("Ybus0.csv");
tab1 = readcell("Ybus1.csv");
tab2 = readcell("Ybus2.csv");
tabV = csvread("V0.csv");

psm.V0 = tabV(:,1).*cos(tabV(:,2).*180/pi) + ...
    tabV(:,1).*sin(tabV(:,2).*180/pi).*1i;
psm.N = size(tab1,1);
% psm.V0 = ones(psm.N,1);
psm.zbus0 = y2z(tab0);
psm.zbus1 = y2z(tab1);
psm.zbus2 = y2z(tab2);

% Conducting Faults
% f = 8;
Zf = 0;
output = struct();

for f=1:psm.N 
    res = slg(psm,f,Zf);
    output.slg(f) = res;
end

for f=1:psm.N
    res = l2l(psm,f,Zf);
    output.l2l(f) = res;
end

for f=1:psm.N
    res = llg(psm,f,Zf);
    output.llg(f) = res;
end

for f=1:psm.N
    res = blf(psm,f,Zf);
    output.blf(f) = res;
end