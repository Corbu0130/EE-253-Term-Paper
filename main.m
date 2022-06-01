clc; clear;

global a;
a = cos(2*pi/3) + 1i*sin(2*pi/3);

psm.gen = readtable("Generator.xlsx");
psm.branch = readtable("Branch.xlsx");
lfa = readtable("PrefaultVoltage.xlsx");

psm = makezdata(psm);
Vm = lfa.Vm;
Va = lfa.Va.*pi./180;
psm.E = Vm.*cos(Va) + 1i.*Vm.*sin(Va);
psm.n = max(lfa.Number);
psm.Vth = 0.8;
psm.N = 1e4;

psm.zbus0 = makeZbus(psm.zdata0);
psm.zbus1 = makeZbus(psm.zdata1);
psm.zbus2 = makeZbus(psm.zdata2);

[AoVI(1,1),AAI(1,1)] = case1(psm);
[AoVI(2,1),AAI(2,1)] = case2(psm);
[AoVI(3,1),AAI(3,1)] = case3(psm);
[AoVI(4,1),AAI(4,1)] = case4(psm);
result = table(AoVI,AAI)