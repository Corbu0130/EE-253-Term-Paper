function res = blf(psm,f,Zf)
% Balanced Fault Analysis
    disp("============Balanced Fault at Bus "+num2str(f)+...
        "============");
    global A;
    N = psm.N;
    V0 = psm.V0;
%     zdata1 = psm.zdata1;
%     zdata0 = psm.zdata0;
%     zdata2 = psm.zdata2;
    zbus0 = psm.zbus0;
    zbus1 = psm.zbus1;
    zbus2 = psm.zbus2;
    
    zth = zbus1(f,f)+Zf;
    If = V0(f)/zth;
    fprintf("\nFault Current = %.4f pu\n",abs(If));

    Ibus = zeros(N,1);
    Ibus(f) = -If;
    Vbus = V0 + zbus1*Ibus;

    fprintf("\n=====Bus Voltage=====\n")
    fprintf("Bus \tVoltage \tAngle \n");
    fprintf("No. \tMagnitude \tDegrees \n");
    for j=1:N
        V = abs(Vbus(j));
        a = angle(Vbus(j))*180/pi;
        fprintf("%3i \t%.4f \t\t%2.4f \n",...
            j,V,a);
    end
    
%     LC = [];
%     for j=1:size(zdata1,1)
%         fbus = zdata1(j,1);
%         tbus = zdata1(j,2);
%         z = zdata1(j,3);
%         if fbus==0
%             continue
%         else
%             I = (Vbus(fbus)-Vbus(tbus))/z;
%         end
%         LC(end+1,:) = [ fbus tbus I ];
%     end
%     LC = [ f inf If; LC ];
%     fprintf("\n=====Line Current=====\n");
%     fprintf("Bus \tno. \tVoltage \tAngle \n");
%     fprintf("From \tTo \t\tMagnitude \tDegrees \n");
%     for j=1:N
%         a = LC(j,:);
%         V = abs(a(3));
%         ang = angle(a(3))*180/pi;
%         fbus = num2str(a(2));
%         if a(2)==inf
%             fbus = "F";
%         end
%         fprintf("%4i \t%4s \t%.4f \t\t%.4f\n",...
%             a(1),fbus,V,ang);
%     end
    fprintf("\n===============================================\n");
    
    res.If = If;
    res.Vbus = Vbus;
%     res.LC = LC;

end