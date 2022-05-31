clc; clear;

global a;
a = cos(2*pi/3) + 1i*sin(2*pi/3);

result = struct();
psm.gen = readtable("Generator.xlsx");
psm.branch = readtable("Branch.xlsx");
lfa = readtable("PrefaultVoltage.xlsx");

psm = makezdata(psm);
Vm = lfa.Vm;
Va = lfa.Va.*pi./180;
psm.E = Vm.*cos(Va) + 1i.*Vm.*sin(Va);
psm.n = max(lfa.Number);

psm.zbus0 = makeZbus(psm.zdata0);
psm.zbus1 = makeZbus(psm.zdata1);
psm.zbus2 = makeZbus(psm.zdata2);

Zf = 0;

VSM.blf = blf(psm,Zf);
VSM.slg = slg(psm,Zf);
VSM.l2l = l2l(psm,Zf);
VSM.dlg = dlg(psm,Zf);