GLCin = 0;
FRCin = 0;
SUCin = 7.5e3/180/2; % g/L -> mg/L -> mmol/L
MALTin = 0;

% Chemostat phase
if setup.stage == 1
    Fin = d*Vbroth/3600; %L/h -> L/s
    Fout = Fin;
    Cx = 3.554; % gDW/L - checked!

% Feast/famine cycle
else
    Cx = 3.451; % gDW/L - checked!
    if t <= 20
        Fin = 43e-3/20; % L/s
        Fout = 0;
    elseif t <= 280
        Fin = 0;
        Fout = 0.166e-3; % L/s
    else
        Fin = 0;
        Fout = 0;
    end
end