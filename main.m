% Stochastic Method of AoV for the Mindanao Grid
% Engr. John Michael P. Corbeta, REE

clc; clear;

% Declaring phase shift variable as global
global a;
a = cos(2*pi/3) + 1i*sin(2*pi/3);

%% Importing system data as tables from excel files
psm.gen = readtable("Generator.xlsx");
psm.branch = readtable("Branch.xlsx");
psm.bus = readtable("Bus.xlsx");

%% Prepping precalculation variables
Vm = psm.bus.Vm;
Va = psm.bus.Va.*pi./180;
psm.E = Vm.*cos(Va) + 1i.*Vm.*sin(Va); % Prefault Bus Voltages
psm.n = max(psm.bus.Number); % Number of system buses
psm.Vth = 0.8; % Threshold Voltage
psm.segments = 4; % Number segments to divide the lines
psm.N = 1e4; % Number of iterations for Monte Carlo
psm = makezdata(psm); % Generating sequence impedance data

%% Generating bus impedance matrices
psm.zbus0 = makeZbus(psm.zdata0);
psm.zbus1 = makeZbus(psm.zdata1);
psm.zbus2 = makeZbus(psm.zdata2);


% Simulating Cases ================================

%% Case 1: Bolted SLG Fault
result.case1 = case1(psm);
AoVI(1,1) = max(result.case1.AoVI);
AAI(1,1) = max(result.case1.AAI);

%% Case 2: Bolted Random Fault Type
result.case2 = case2(psm);
AoVI(2,1) = max(result.case2.AoVI);
AAI(2,1) = max(result.case2.AAI);

%% Case 3: Random Fault Type and Impedance
% mean=5ohms, s=1
result.case3 = case3(psm);
AoVI(3,1) = max(result.case3.AoVI);
AAI(3,1) = max(result.case3.AAI);

%% Case 4: Random Fault Type and Impedance
% mean=10ohms, s=1
result.case4 = case4(psm);
AoVI(4,1) = max(result.case4.AoVI);
AAI(4,1) = max(result.case4.AAI);

%% Tabulate Result
result.tab = table(AoVI,AAI);
result.tab