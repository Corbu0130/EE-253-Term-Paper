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
Vth = 0.8;

VSM = blf(psm,Zf);
[AoVI,AAI] = calcindex(psm,VSM,Vth);
result.VSM.blf = VSM;
result.AoVI.blf = AoVI;
result.AAI.blf = AAI;

VSM = slg(psm,Zf);
[AoVI,AAI] = calcindex(psm,VSM,Vth);
result.VSM.slg = VSM;
result.AoVI.slg = AoVI;
result.AAI.slg = AAI;

VSM = l2l(psm,Zf);
[AoVI,AAI] = calcindex(psm,VSM,Vth);
result.VSM.l2l = VSM;
result.AoVI.l2l = AoVI;
result.AAI.l2l = AAI;

VSM = dlg(psm,Zf);
[AoVI,AAI] = calcindex(psm,VSM,Vth);
result.VSM.dlg = VSM;
result.AoVI.dlg = AoVI;
result.AAI.dlg = AAI;