function res = llg(psm,f,Zf)
% Double Line to Ground Fault Analysis
    disp("=====Double Line to Ground Fault at Bus "+num2str(f)+...
        "=====");
    global A;
    N = psm.N;
    V0 = psm.V0;
%     zdata1 = psm.zdata1;
%     zdata0 = psm.zdata0;
%     zdata2 = psm.zdata2;
    zbus0 = psm.zbus0;
    zbus1 = psm.zbus1;
    zbus2 = psm.zbus2;
    
    zth = zbus1(f,f)+(zbus2(f,f)*(zbus0(f,f)+3*Zf))/...
        (zbus2(f,f)+zbus0(f,f)+3*Zf);
    If012 = zeros(3,1);
    If012(2) = V0(f)/zth;
    If012(1) = -(V0(f)-zbus1(f,f)*If012(2))/...
        zbus0(f,f);
    If012(3) = -(V0(f)-zbus1(f,f)*If012(2))/...
        zbus2(f,f);
    Ifabc = A*If012;
    If = sum(Ifabc(2:3));
    fprintf("\nFault Current = %.4f pu\n",abs(If));

    for j=1:N
        V012(j,1) = -zbus0(j,f)*If012(1);
        V012(j,2) = V0(j)-zbus1(j,f)*If012(2);
        V012(j,3) = -zbus2(j,f)*If012(3);
    end

    Vabc = (A*V012.').';
    fprintf("\n=====Bus Voltage Magnitude=====\n")
    fprintf("Bus \ta \t\tb \t\tc \n");
    for j=1:size(Vabc,1)
        a = abs(Vabc(j,:));
        fprintf("%3i \t%.4f \t%.4f \t%.4f\n",...
            j,a(1),a(2),a(3));
    end
    
%     LC012 = [];
%     for j=1:size(zdata1,1)
%         fbus = zdata1(j,1);
%         tbus = zdata1(j,2);
%         z1 = zdata1(j,3);
%         z2 = z1;
%         j0 = find((zdata0(:,1)==fbus).*(zdata0(:,2)==tbus));
%         z0 = zdata0(j0,3);
%         z = [ z0 z1 z2 ];
%         if fbus==0
%             continue
%         else
%             LC = (V012(fbus,:)-V012(tbus,:))./z;
%         end
%         LC012(end+1,:) = [ fbus tbus LC ];
%     end
%     LCabc = (A*LC012(:,3:end).').';
%     LCabc = [ f inf Ifabc'; LC012(:,1:2) LCabc ];
%     fprintf("\n=====Line Current Magnitude=====\n")
%     fprintf("\nBus \tBus \ta \t\tb \t\tc \n");
%     for j=1:size(LCabc,1)
%         a = abs(LCabc(j,:));
%         fbus = num2str(a(2));
%         if a(2)==inf
%             fbus = "F";
%         end
%         fprintf("%3i \t%3s \t%.4f \t%.4f \t%.4f\n",...
%             a(1),fbus,a(3),a(4),a(5));
%     end
    fprintf("\n===============================================\n");
    
    res.If012 = If012;
    res.V012 = V012;
    res.Vabc = Vabc;
%     res.LCabc = LCabc;

end