function v = ODE_model_Y3M1_FFsims(t,IC,p,f,d,setup, data)
% system of ODE equations in the Y3M1 model. The clamps affect the
% calculation of reaction rates in rateEquations_Y3M1.

% recall metabolite concentrations
IC = real(IC);
ACE=IC(1);
BPG=IC(2);
F16BP=IC(3);
F6P=IC(4);
G6P=IC(5);
GLCi=IC(6);
NAD=IC(7);
NADH=IC(8);
ATP=IC(9); 
P2G=IC(10);
P3G=IC(11);
PEP=IC(12);
PYR=IC(13);
GLYCERAL3P=IC(14);
ADP=IC(15);
AMP=IC(16); 
DHAP=IC(17);
GLYC3P=IC(18);
GLYCEROL=IC(19);
ETOH=IC(20);
G1P=IC(21);
UTP=IC(22);
UDP=IC(23);
UDP_GLC=IC(24);
TRE=IC(25);
T6P=IC(26);
PI=IC(27);
IMP=IC(28);
INO=IC(29);
HYP=IC(30);
ETOHec=IC(31);
GLYCec=IC(32);
FRCi = IC(33); 
FRCec = IC(34);
SUCec = IC(35);
GLCec = IC(36);
TREec = IC(37);
TREvac = IC(38);
Vbroth = IC(39);
Glycogen_cyt = IC(40);
MALTec = IC(41);
MALTic = IC(42);

% clamping options
if setup.stage == 1
    UDP_GLC_exp = data.FF01.metabolites.ICUDPG.conc(1);
elseif setup.stage == 2
    UDP_GLC_exp = interp1(data.FF01.metabolites.ICUDPG.time,data.FF01.metabolites.ICUDPG.conc,t,'pchip','extrap');
end
% specific clamps for individual glycolytic intermediates
if((setup.stage == 2)&&(isfield(setup,'clamp20'))&&(setup.clamp20.G6P == 1)) % G6P
    if setup.GPdataset.Fruc == 1
        G6P = interp1(data.FF01Fruc.metabolites.G6P.time(1:15), data.FF01Fruc.metabolites.G6P.conc(1:15), t, 'pchip', 'extrap');
    elseif setup.GPdataset.Sucr == 1
        G6P = interp1(data.FF01Sucr.metabolites.G6P.time, data.FF01Sucr.metabolites.G6P.conc, t, 'pchip', 'extrap');
    elseif setup.GPdataset.Malt == 1
        G6P = interp1(data.FF01Malt.metabolites.G6P.time, data.FF01Malt.metabolites.G6P.conc, t, 'pchip', 'extrap');
    end
end
if((setup.stage == 2)&&(isfield(setup,'clamp20'))&&(setup.clamp20.F6P == 1)) % F6P
    if setup.GPdataset.Fruc == 1
        F6P = interp1(data.FF01Fruc.metabolites.F6P.time(1:15), data.FF01Fruc.metabolites.F6P.conc(1:15), t, 'pchip', 'extrap');
    elseif setup.GPdataset.Sucr == 1
        F6P = interp1(data.FF01Sucr.metabolites.F6P.time, data.FF01Sucr.metabolites.F6P.conc, t, 'pchip', 'extrap');
    elseif setup.GPdataset.Malt == 1
        F6P = interp1(data.FF01Malt.metabolites.F6P.time, data.FF01Malt.metabolites.F6P.conc, t, 'pchip', 'extrap');
    end
end
if((setup.stage == 2)&&(isfield(setup,'clamp20'))&&(setup.clamp20.FBP == 1)) % F16BP <- FBP
    if setup.GPdataset.Fruc == 1
        F16BP = interp1(data.FF01Fruc.metabolites.FBP.time(1:15), data.FF01Fruc.metabolites.FBP.conc(1:15), t, 'pchip', 'extrap');
    elseif setup.GPdataset.Sucr == 1
        F16BP = interp1(data.FF01Sucr.metabolites.FBP.time, data.FF01Sucr.metabolites.FBP.conc, t, 'pchip', 'extrap');
    elseif setup.GPdataset.Malt == 1
        F16BP = interp1(data.FF01Malt.metabolites.FBP.time, data.FF01Malt.metabolites.FBP.conc, t, 'pchip', 'extrap');
    end
end
if((setup.stage == 2)&&(isfield(setup,'clamp20'))&&(setup.clamp20.DHAP == 1)) % DHAP
    if setup.GPdataset.Fruc == 1
        DHAP = interp1(data.FF01Fruc.metabolites.DHAP.time(1:15), data.FF01Fruc.metabolites.DHAP.conc(1:15), t, 'pchip', 'extrap');
    elseif setup.GPdataset.Sucr == 1
        DHAP = interp1(data.FF01Sucr.metabolites.DHAP.time, data.FF01Sucr.metabolites.DHAP.conc, t, 'pchip', 'extrap');
    elseif setup.GPdataset.Malt == 1
        DHAP = interp1(data.FF01Malt.metabolites.DHAP.time, data.FF01Malt.metabolites.DHAP.conc, t, 'pchip', 'extrap');
    end
end
if((setup.stage == 2)&&(isfield(setup,'clamp20'))&&(setup.clamp20.GAP == 1)) % GLYCERAL3P <- GAP
    if setup.GPdataset.Fruc == 1
        GLYCERAL3P = interp1(data.FF01Fruc.metabolites.GAP.time(1:15), data.FF01Fruc.metabolites.GAP.conc(1:15), t, 'pchip', 'extrap');
    elseif setup.GPdataset.Sucr == 1
        GLYCERAL3P = interp1(data.FF01Sucr.metabolites.GAP.time, data.FF01Sucr.metabolites.GAP.conc, t, 'pchip', 'extrap');
    elseif setup.GPdataset.Malt == 1
        GLYCERAL3P = interp1(data.FF01Malt.metabolites.GAP.time, data.FF01Malt.metabolites.GAP.conc, t, 'pchip', 'extrap');
    end
end
if((setup.stage == 2)&&(isfield(setup,'clamp20'))&&(setup.clamp20.threePG == 1)) % P3G <- threePG
    if setup.GPdataset.Fruc == 1
        P3G = interp1(data.FF01Fruc.metabolites.threePG.time(1:15), data.FF01Fruc.metabolites.threePG.conc(1:15), t, 'pchip', 'extrap');
    elseif setup.GPdataset.Sucr == 1
        P3G = interp1(data.FF01Sucr.metabolites.threePG.time, data.FF01Sucr.metabolites.threePG.conc, t, 'pchip', 'extrap');
    elseif setup.GPdataset.Malt == 1
        P3G = interp1(data.FF01Malt.metabolites.threePG.time, data.FF01Malt.metabolites.threePG.conc, t, 'pchip', 'extrap');
    end
end
if((setup.stage == 2)&&(isfield(setup,'clamp20'))&&(setup.clamp20.twoPG == 1)) % P2G <- twoPG
    if setup.GPdataset.Fruc == 1
        P2G = interp1(data.FF01Fruc.metabolites.twoPG.time(1:15), data.FF01Fruc.metabolites.twoPG.conc(1:15), t, 'pchip', 'extrap');
    elseif setup.GPdataset.Sucr == 1
        P2G = interp1(data.FF01Sucr.metabolites.twoPG.time, data.FF01Sucr.metabolites.twoPG.conc, t, 'pchip', 'extrap');
    elseif setup.GPdataset.Malt == 1
        P2G = interp1(data.FF01Malt.metabolites.twoPG.time, data.FF01Malt.metabolites.twoPG.conc, t, 'pchip', 'extrap');
    end
end
% extracellular glucose and feed regimes
f.GLCo = GLCec;
if setup.GPdataset.GP400WT        == 1
    GlucoseFeed400s;
elseif setup.GPdataset.GP1800WT 	== 1
    GlucoseFeed1800s;
elseif setup.GPdataset.GP400M     == 1
    GlucoseFeed400s;
elseif setup.GPdataset.Fruc == 1
    FructoseFeed400s;
elseif setup.GPdataset.Sucr == 1
    SucroseFeed400s;
elseif setup.GPdataset.Malt == 1
    MaltoseFeed400s;
end

% calculate reaction rates
rateEquations_Y3M1;

% clamps on the reaction rates
if setup.clamp.TRE == 1 % Trehalose cycle
    v_PGM1 = zeros(size(v_PGM1));
    v_TPS1 = zeros(size(v_TPS1));
    v_TPS2 = zeros(size(v_TPS2));
    v_NTH1 = zeros(size(v_NTH1));
    v_UGP = zeros(size(v_UGP));
    v_ATH1ec = zeros(size(v_ATH1ec));
    v_ATH1vac = zeros(size(v_ATH1vac));
    v_AGT1 = zeros(size(v_AGT1));
    v_vacuoleT = zeros(size(v_vacuoleT));
end
if setup.clamp.IXP == 1 % IXP cycle
    v_Amd1 = zeros(size(v_Amd1));
    v_Ade13_v_Ade12 = zeros(size(v_Ade13_v_Ade12));
    v_Isn1 = zeros(size(v_Isn1));
    v_Pnp1 = zeros(size(v_Pnp1));
    v_Hpt1 = zeros(size(v_Hpt1));
    dAXPdt = 0; % meanwhile developing AXP and IXP
    dAXPdD = 0; % meanwhile developing AXP and IXP
end

% system of ODEs
ODES

% v=real(v);
v = v';
end