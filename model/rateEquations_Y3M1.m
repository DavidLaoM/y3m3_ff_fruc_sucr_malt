% All reactions are calculated. The effect of the clamps is added outside 
% this code.

%% Adjustment of growth rate-dependent parameters
% Applies to vmitoNADH (NADX) and vATPase (AXP)
% experiment
km_sinkPYR      = 0.01; %0.000001; %0.01; %0.00001; %0.00001; %0.1; %0.000001;
dexp = d;
dref = 0.1;
polyexp = - 8.4853e+03 * dexp.^6 + 9.4027e+03 * dexp.^5 - 3.8027e+03 * dexp.^4 + 700.5 * dexp.^3 - 60.26 * dexp.^2 + 0.711 * dexp - 0.0356; % % INITIAL FIT
polyref = - 8.4853e+03 * dref.^6 + 9.4027e+03 * dref.^5 - 3.8027e+03 * dref.^4 + 700.5 * dref.^3 - 60.26 * dref.^2 + 0.711 * dref - 0.0356; % % INITIAL FIT
valexp = -polyexp * (PYR./(PYR + km_sinkPYR));
valref = -polyref * (PYR./(PYR + km_sinkPYR));

% ratioNADX
ratioNADH = 10.^(setup.x132.*(valexp-valref));
p.mitoNADHVmax = setup.ratioNADH.*ratioNADH;%100;
% ratioATPmito
ratioATP = 10.^(setup.x133.*(valexp-valref));
p.mitoVmax = setup.ratioATP.*ratioATP;%100;

% rationATPase
ratioATPase = 10.^(setup.x134.*(valexp-valref));
p.ATPaseK = setup.ratioATPase.*ratioATPase;%100;


% ratioADK1_k
ratioADK1_k = 10.^(setup.x135.*(valexp-valref));
p.ADK1_k = setup.ratioADK1_k.*ratioADK1_k;


% ratioADK1_Keq
ratioADK1_Keq = 10.^(setup.x136.*(valexp-valref));
p.ADK1_Keq = setup.ratioADK1_Keq.*ratioADK1_Keq;

%% Invertase (v_INV)
if setup.GPdataset.Sucr == 1
    v_INV = p.INV.VmINV.*SUCec./(p.INV.KmINV + SUCec);
else
    v_INV = 0;
end

%% UPPER GLYCOLYSIS

%% Glucose transport (v_GLT)
% Inhibition of glucose transport by fructose NOT taken into account
if setup.GLTinhibFRC == 0
    
    % Experimental GLCec baseline > 0 NOT taken into account
    if setup.ElevatedGLCecBaseline == 0
        v_GLT=p.GLT.VmGLT.*(GLCec - GLCi./p.GLT.KeqGLT)./...
            (p.GLT.KmGLTGLCo.*(1 + GLCec/p.GLT.KmGLTGLCo + GLCi/p.GLT.KmGLTGLCi + ...
            0.91.*GLCec.*GLCi./(p.GLT.KmGLTGLCi.*p.GLT.KmGLTGLCo)));
    
    % Experimental GLCec baseline > 0 taken into account 
    elseif setup.ElevatedGLCecBaseline == 1
        GLCec2 = GLCec - setup.GLCecmin;
        v_GLT=p.GLT.VmGLT.*(GLCec2 - GLCi./p.GLT.KeqGLT)./...
            (p.GLT.KmGLTGLCo.*(1 + GLCec2/p.GLT.KmGLTGLCo + GLCi/p.GLT.KmGLTGLCi + ...
            0.91.*GLCec2.*GLCi./(p.GLT.KmGLTGLCi.*p.GLT.KmGLTGLCo)));
    end
    
% Inhibition of glucose transport by fructose taken into account
elseif setup.GLTinhibFRC == 1
    
    % Experimental GLCec baseline > 0 NOT taken into account & experimental FRCec baseline > 0 NOT taken into account
    if (setup.ElevatedGLCecBaseline == 0) && (setup.ElevatedFRCecBaseline == 0)
        GLTinhibFRC = FRCec/p.GLT.KiGLTFRC;
        v_GLT=p.GLT.VmGLT.*(GLCec - GLCi./p.GLT.KeqGLT)./...
            (p.GLT.KmGLTGLCo.*(1 + GLCec/p.GLT.KmGLTGLCo + GLCi/p.GLT.KmGLTGLCi + ...
            0.91.*GLCec.*GLCi./(p.GLT.KmGLTGLCi.*p.GLT.KmGLTGLCo) + GLTinhibFRC));
    
    % Experimental GLCec baseline > 0 taken into account & experimental FRCec baseline > 0 NOT taken into account
    elseif (setup.ElevatedGLCecBaseline == 1) && (setup.ElevatedFRCecBaseline == 0)
        GLCec2 = GLCec - setup.GLCecmin;
        GLTinhibFRC = FRCec/p.GLT.KiGLTFRC;
        v_GLT=p.GLT.VmGLT.*(GLCec2 - GLCi./p.GLT.KeqGLT)./...
            (p.GLT.KmGLTGLCo.*(1 + GLCec2/p.GLT.KmGLTGLCo + GLCi/p.GLT.KmGLTGLCi + ...
            0.91.*GLCec2.*GLCi./(p.GLT.KmGLTGLCi.*p.GLT.KmGLTGLCo) + GLTinhibFRC));
      
    % Experimental GLCec baseline > 0 NOT taken into account & experimental FRCec baseline > 0 taken into account  
    elseif (setup.ElevatedGLCecBaseline == 0) && (setup.ElevatedFRCecBaseline == 1)
        FRCec2 = FRCec - setup.FRCecmin;
        GLTinhibFRC = FRCec2/p.GLT.KiGLTFRC;
        v_GLT=p.GLT.VmGLT.*(GLCec - GLCi./p.GLT.KeqGLT)./...
            (p.GLT.KmGLTGLCo.*(1 + GLCec/p.GLT.KmGLTGLCo + GLCi/p.GLT.KmGLTGLCi + ...
            0.91.*GLCec.*GLCi./(p.GLT.KmGLTGLCi.*p.GLT.KmGLTGLCo) + GLTinhibFRC));
        
    % Experimental GLCec baseline > 0 taken into account & experimental FRCec baseline > 0 taken into account
    elseif (setup.ElevatedGLCecBaseline == 1) && (setup.ElevatedFRCecBaseline == 1)
        GLCec2 = GLCec - setup.GLCecmin;
        FRCec2 = FRCec - setup.FRCecmin;
        GLTinhibFRC = FRCec2/p.GLT.KiGLTFRC;
        v_GLT=p.GLT.VmGLT.*(GLCec2 - GLCi./p.GLT.KeqGLT)./...
            (p.GLT.KmGLTGLCo.*(1 + GLCec2/p.GLT.KmGLTGLCo + GLCi/p.GLT.KmGLTGLCi + ...
            0.91.*GLCec2.*GLCi./(p.GLT.KmGLTGLCi.*p.GLT.KmGLTGLCo) + GLTinhibFRC));
    end
end

%% Fructose Transport (v_FRT)
if (setup.GPdataset.Fruc == 1) || (setup.GPdataset.Sucr == 1)

    % Inhibition of fructose transport by glucose NOT taken into account
    if setup.FRTinhibGLC == 0
        
        % Experimental FRCec baseline > 0 NOT taken into account
        if setup.ElevatedFRCecBaseline == 0
            v_FRT=p.FRT.VmFRT.*(FRCec-FRCi./p.FRT.KeqFRT)./...
                (p.FRT.KmFRTFRCo.*(1 + FRCec/p.FRT.KmFRTFRCo + FRCi/p.FRT.KmFRTFRCi + ...
                0.91.*FRCec.*FRCi./(p.FRT.KmFRTFRCi.*p.FRT.KmFRTFRCo)));
            
        % Experimental FRCec baseline > 0 taken into account
        elseif setup.ElevatedFRCecBaseline == 1
            FRCec2 = FRCec - setup.FRCecmin;
            v_FRT=p.FRT.VmFRT.*(FRCec2-FRCi./p.FRT.KeqFRT)./...
                (p.FRT.KmFRTFRCo.*(1 + FRCec2/p.FRT.KmFRTFRCo + FRCi/p.FRT.KmFRTFRCi + ...
                0.91.*FRCec2.*FRCi./(p.FRT.KmFRTFRCi.*p.FRT.KmFRTFRCo)));
        end
        
    % Inhibition of fructose transport by glucose taken into account
    elseif setup.FRTinhibGLC == 1
        
        % Experimental FRCec baseline > 0 NOT taken into account && experimental GLCec baseline > 0 NOT taken into account
        if (setup.ElevatedFRCecBaseline == 0) && (setup.ElevatedGLCecBaseline == 0)
            FRTinhibGLC = GLCec/p.FRT.KiFRTGLC;
            v_FRT=p.FRT.VmFRT.*(FRCec-FRCi./p.FRT.KeqFRT)./...
                (p.FRT.KmFRTFRCo.*(1 + FRCec/p.FRT.KmFRTFRCo + FRCi/p.FRT.KmFRTFRCi + ...
                0.91.*FRCec.*FRCi./(p.FRT.KmFRTFRCi.*p.FRT.KmFRTFRCo) + FRTinhibGLC));
            
        % Experimental FRCec baseline > 0 taken into account & experimental GLCec baseline > 0 NOT taken into account
        elseif (setup.ElevatedFRCecBaseline == 1) && (setup.ElevatedGLCecBaseline == 0)
            FRCec2 = FRCec - setup.FRCecmin;
            FRTinhibGLC = GLCec/p.FRT.KiFRTGLC;
            v_FRT=p.FRT.VmFRT.*(FRCec2-FRCi./p.FRT.KeqFRT)./...
                (p.FRT.KmFRTFRCo.*(1 + FRCec2/p.FRT.KmFRTFRCo + FRCi/p.FRT.KmFRTFRCi + ...
                0.91.*FRCec2.*FRCi./(p.FRT.KmFRTFRCi.*p.FRT.KmFRTFRCo) + FRTinhibGLC));
            
        % Experimental FRCec baseline > 0 NOT taken into account & experimental GLCec baseline > 0 taken into account
        elseif (setup.ElevatedFRCecBaseline == 0) && (setup.ElevatedGLCecBaseline == 1)
            GLCec2 = GLCec - setup.GLCecmin;
            FRTinhibGLC = GLCec2/p.FRT.KiFRTGLC;
            v_FRT=p.FRT.VmFRT.*(FRCec-FRCi./p.FRT.KeqFRT)./...
                (p.FRT.KmFRTFRCo.*(1 + FRCec/p.FRT.KmFRTFRCo + FRCi/p.FRT.KmFRTFRCi + ...
                0.91.*FRCec.*FRCi./(p.FRT.KmFRTFRCi.*p.FRT.KmFRTFRCo) + FRTinhibGLC));
            
        % Experimental FRCec baseline > 0 taken into account & experimental GLCec baseline > 0 taken into account
        elseif (setup.ElevatedFRCecBaseline == 1) && (setup.ElevatedGLCecBaseline == 1)
            FRCec2 = FRCec - setup.FRCecmin;
            GLCec2 = GLCec - setup.GLCecmin;
            FRTinhibGLC = GLCec2/p.FRT.KiFRTGLC;
            v_FRT=p.FRT.VmFRT.*(FRCec2-FRCi./p.FRT.KeqFRT)./...
                (p.FRT.KmFRTFRCo.*(1 + FRCec2/p.FRT.KmFRTFRCo + FRCi/p.FRT.KmFRTFRCi + ...
                0.91.*FRCec2.*FRCi./(p.FRT.KmFRTFRCi.*p.FRT.KmFRTFRCo) + FRTinhibGLC));
        end
    end
    
else
    v_FRT = 0;
end

%% Maltose transport (v_MAT)
if setup.GPdataset.Malt == 1
    
    % Experimental Maltec baseline > 0 NOT taken into account
    if setup.ElevatedMaltecBaseline == 0
        v_MAT = (p.MAT.VmMAT./(p.MAT.KmMAT_ATP.*p.MAT.KmMAT_Maltec)).*...
                (ATP.*MALTec./((1+ATP./p.MAT.KmMAT_ATP).*(1+MALTec./p.MAT.KmMAT_Maltec)));
    
    % Experimental Maltec baseline > 0 taken into account
    elseif setup.ElevatedMaltecBaseline == 1
        MALTec2 = MALTec - setup.Maltecmin;
        v_MAT = (p.MAT.VmMAT./(p.MAT.KmMAT_ATP.*p.MAT.KmMAT_Maltec)).*...
                (ATP.*MALTec2./((1+ATP./p.MAT.KmMAT_ATP).*(1+MALTec2./p.MAT.KmMAT_Maltec)));
    end
    
else 
    v_MAT = 0;
end

%% Maltose hydrolysis (v_MALX2)
if setup.GPdataset.Malt == 1
    v_MALX2 = p.MALX2.VmMALX2.*MALTic./(p.MALX2.KmMALX2_Maltic + MALTic);
else
    v_MALX2 = 0;
end

%% HXK1 consensus
% Glucose (v_GLK)
% ATP + D-glucose = ADP + "D-glucose 6-phosphate" + H+

% Inhibition by fructose NOT taken into account
if setup.GLKinhibFRC == 0
    v_GLK=p.HXK_ExprsCor.*(((p.HXK1_kcatglc.*(f.HXK1+f.HXK2))./(p.HXK1_Katp.*p.HXK1_Kglc).*(ATP.*GLCi - ((ADP.*G6P)./p.HXK1_Keqglc)))./...
        ((1 + ATP./p.HXK1_Katp + ADP./p.HXK1_Kadp).*(1 + GLCi./p.HXK1_Kglc + G6P./p.HXK1_Kg6p + T6P./p.HXK1_Kit6p)));

% Inhibition by fructose taken into account
elseif setup.GLKinhibFRC == 1
    GLKinhibFRC = FRCi/p.HXK1_KiFRC;
    v_GLK=p.HXK_ExprsCor.*(((p.HXK1_kcatglc.*(f.HXK1+f.HXK2))./(p.HXK1_Katp.*p.HXK1_Kglc).*(ATP.*GLCi - ((ADP.*G6P)./p.HXK1_Keqglc)))./...
        ((1 + ATP./p.HXK1_Katp + ADP./p.HXK1_Kadp).*(1 + GLCi./p.HXK1_Kglc + G6P./p.HXK1_Kg6p + T6P./p.HXK1_Kit6p + GLKinhibFRC)));
end

% Fructose (v_FRK)
% ATP + D-fructose = ADP + "D-fructose 6-phosphate" + H+
if (setup.GPdataset.Fruc == 1) || (setup.GPdataset.Sucr == 1)

    % Inhibition by glucose NOT taken into account
    if setup.FRKinhibGLC == 0
        v_FRK=p.HXK_ExprsCor.*(((p.HXK1_kcatfrc.*(f.HXK1+f.HXK2))./(p.HXK1_Katp.*p.HXK1_Kfrc).*(ATP.*FRCi - ((ADP.*F6P)./p.HXK1_Keqfrc)))./...
            ((1 + ATP./p.HXK1_Katp + ADP./p.HXK1_Kadp).*(1 + FRCi./p.HXK1_Kfrc + F6P./p.HXK1_Kf6p + T6P./p.HXK1_Kit6p)));
        
    % Inhibition by glucose taken into account
    elseif setup.FRKinhibGLC == 1
        FRKinhibGLC = GLCi/p.HXK1_KiGLC;
        v_FRK=p.HXK_ExprsCor.*(((p.HXK1_kcatfrc.*(f.HXK1+f.HXK2))./(p.HXK1_Katp.*p.HXK1_Kfrc).*(ATP.*FRCi - ((ADP.*F6P)./p.HXK1_Keqfrc)))./...
            ((1 + ATP./p.HXK1_Katp + ADP./p.HXK1_Kadp).*(1 + FRCi./p.HXK1_Kfrc + F6P./p.HXK1_Kf6p + T6P./p.HXK1_Kit6p + FRKinhibGLC)));
    end

else
    v_FRK = 0;
end
%% PGI1 consensus
% D-glucose 6-phosphate = D-fructose 6-phosphate 
v_PGI=p.PGI_ExprsCor.*((((p.PGI1_kcat*f.PGI1)./p.PGI1_Kg6p).*(G6P-(F6P./p.PGI1_Keq)))./...
    (1+G6P./p.PGI1_Kg6p+1+F6P./p.PGI1_Kf6p-1));

%% PFK consensus
F26BP=p.PFK.F26BP;
PFK_nom=(p.PFK_kcat.*f.PFK.*p.PFK_gR.*(F6P./p.PFK_Kf6p).*(ATP./p.PFK_Katp).*(1+(F6P./p.PFK_Kf6p)+(ATP./p.PFK_Katp)+p.PFK_gR.*((F6P./p.PFK_Kf6p).*(ATP./p.PFK_Katp))));
PFK_denom=(1+F6P./p.PFK_Kf6p+ATP./p.PFK_Katp+(p.PFK_gR.*(F6P./p.PFK_Kf6p).*(ATP./p.PFK_Katp))).^2+...
    p.PFK_L.*...
    ((1+p.PFK_Ciatp.*(ATP./p.PFK_Kiatp))./(1+ATP./p.PFK_Kiatp)).^2.*...
    ((1+p.PFK_Camp.*(AMP./p.PFK_Kamp))./(1+AMP./p.PFK_Kamp)).^2.*...
    ((1+((p.PFK_Cf26bp*F26BP)./(p.PFK_Kf26bp))+((p.PFK_Cf16bp.*F16BP)./(p.PFK_Kf16bp)))./(1+(F26BP./p.PFK_Kf26bp)+(F16BP./p.PFK_Kf16bp))).^2.*...
    (1+p.PFK_Catp.*(ATP./p.PFK_Katp)).^2;
v_PFK=p.PFK_ExprsCor.*(PFK_nom./PFK_denom);

%% FBA1/ALD consensus
% "D-fructose 1,6-bisphosphate" = "glyceraldehyde 3-phosphate" + "glycerone phosphate";
v_ALD=p.FBA_ExprsCor.*(((p.FBA1_kcat.*f.FBA1)./p.FBA1_Kf16bp.*(F16BP-(GLYCERAL3P.*DHAP)./p.FBA1_Keq))./...
    (1+F16BP./p.FBA1_Kf16bp+(1+GLYCERAL3P./p.FBA1_Kglyceral3p).*(1+DHAP./p.FBA1_Kdhap)-1));

%% TPI1 consensus
% "glycerone phosphate" = "glyceraldehyde 3-phosphate";  "triose-phosphate isomerase 
v_TPI1=(((p.TPI1_kcat*f.TPI1)./p.TPI1_Kdhap.*(DHAP-GLYCERAL3P./p.TPI1_Keq))./...
    (1+DHAP./p.TPI1_Kdhap+1+GLYCERAL3P./p.TPI1_Kglyceral3p-1));

%% LOWER GLYCOLYSIS

%% TDH1/GAPDH consensus
% "glyceraldehyde 3-phosphate" + NAD+ + phosphate = "3-phospho-D-glyceroyl dihydrogen phosphate" + H+ + NADH;
GLYCERATE13BP=BPG;
v_GAPDH=p.GAPDH_ExprsCor.*((((p.TDH1_kcat.*(f.TDH1+f.TDH2+f.TDH3))./(p.TDH1_Kglyceral3p.*p.TDH1_Knad.*p.TDH1_Kpi)).*(GLYCERAL3P.*NAD.*PI-(GLYCERATE13BP.*NADH)./p.TDH1_Keq))./...
    ((1+GLYCERAL3P./p.TDH1_Kglyceral3p).*(1+NAD./p.TDH1_Knad).*(1+PI./p.TDH1_Kpi)+(1+GLYCERATE13BP./p.TDH1_Kglycerate13bp).*(1+NADH./p.TDH1_Knadh)-1));

%% PGK teusink
% "3-phospho-D-glyceroyl dihydrogen phosphate" + ADP = "3-phospho-D-glyceric acid" + ATP;  
v_PGK=p.PGK_ExprsCor.*p.PGK.VmPGK.*((p.PGK.KeqPGK.*BPG.*ADP)-ATP.*P3G)./...
      (p.PGK.KmPGKATP*p.PGK.KmPGKP3G.*(1+ADP./p.PGK.KmPGKADP + ATP./p.PGK.KmPGKATP).*(1+BPG/p.PGK.KmPGKBPG+P3G/p.PGK.KmPGKP3G));
  
%% GPM1 Consensus
% "3-phospho-D-glyceric acid" = "2-phospho-D-glyceric acid"; 
p.PGM_ExprsCor=1;
v_PGM=p.PGM_ExprsCor.*((((p.GPM1_kcat.*(f.GPM1+f.GPM2+f.GPM3))./p.GPM1_K3pg).*(P3G-P2G./p.GPM1_Keq))./...
    (1+P3G./p.GPM1_K3pg+1+P2G./p.GPM1_K2pg-1));

%% ENO1
% "2-phospho-D-glyceric acid" = phosphoenolpyruvate + water;  
p.ENO_ExprsCor=1; 
v_ENO=p.ENO_ExprsCor.*((((p.ENO1_kcat.*(f.ENO1+f.ENO2))./p.ENO1_K2pg).*(P2G-PEP./p.ENO1_Keq))./...
    (1+P2G./p.ENO1_K2pg+1+PEP./p.ENO1_Kpep-1));

%% PYK1 Consensus
% ADP + H+ + phosphoenolpyruvate -> ATP + pyruvate;  
v_PYK=p.PYK_ExprsCor.*((((p.PYK1_kcat.*(f.PYK1+f.PYK2))./(p.PYK1_Kadp.*p.PYK1_Kpep).*ADP.*PEP)./...
    ((1+ADP./p.PYK1_Kadp).*(1+PEP./p.PYK1_Kpep))).*...
    ((PEP./p.PYK1_Kpep+1).^p.PYK1_hill./(p.PYK1_L.*((ATP./p.PYK1_Katp+1)./(F16BP./p.PYK1_Kf16bp+1)).^p.PYK1_hill+(PEP./p.PYK1_Kpep+1).^p.PYK1_hill)));

%% PDC1 consensus
% pyruvate + H+ -> acetaldehyde + "carbon dioxide" 
v_PDC=p.PDC_ExprsCor.*((p.PDC1_kcat.*(f.PDC1).*(PYR./p.PDC1_Kpyr).^p.PDC1_hill)./...
    (1+(PYR./p.PDC1_Kpyr).^p.PDC1_hill+PI./p.PDC1_Kpi));

%% ADH teusink
% acetaldehyde + H+ + NADH = ethanol + NAD+;  
v_ADH=-p.ADH_ExprsCor.*(p.ADH.VmADH./(p.ADH.KiADHNAD.*p.ADH.KmADHETOH).*(NAD.*ETOH-NADH.*ACE./p.ADH.KeqADH)./...
    (1+NAD./p.ADH.KiADHNAD+p.ADH.KmADHNAD.*ETOH./(p.ADH.KiADHNAD*p.ADH.KmADHETOH)+p.ADH.KmADHNADH.*ACE./(p.ADH.KiADHNADH.*p.ADH.KmADHACE)...
    +NADH./p.ADH.KiADHNADH+NAD.*ETOH./(p.ADH.KiADHNAD.*p.ADH.KmADHETOH)+p.ADH.KmADHNADH.*NAD.*ACE./(p.ADH.KiADHNAD.*p.ADH.KiADHNADH.*p.ADH.KmADHACE)...
    +p.ADH.KmADHNAD.*ETOH.*NADH./(p.ADH.KiADHNAD.*p.ADH.KmADHETOH.*p.ADH.KiADHNADH)+NADH.*ACE./(p.ADH.KiADHNADH.*p.ADH.KmADHACE)+...
    NAD.*ETOH.*ACE./(p.ADH.KiADHNAD*p.ADH.KmADHETOH.*p.ADH.KiADHACE)+ETOH.*NADH.*ACE./(p.ADH.KiADHETOH*p.ADH.KiADHNADH*p.ADH.KmADHACE)));

%% DOWNSTREAM METABOLISM
v_ACE=p.VmaxACE*ACE./(ACE+p.KmACE);%canelas.mtlD.v_PDC(exp)-canelas.mtlD.v_ADH(exp);
v_PDH=p.PDH_Vmax.*(PYR.^p.PDH_n)./(p.PDH_K50.^p.PDH_n+PYR.^p.PDH_n);

%% GLYCEROL BRANCH

%% GPD1 Consensus
% "glycerone phosphate" + H+ + NADH = NAD+ + "sn-glycerol 3-phosphate" 
v_G3PDH=((((p.GPD1_kcat.*f.GPD1)./(p.GPD1_Kdhap.*p.GPD1_Knadh)).*(DHAP.*NADH-(GLYC3P.*NAD)./p.GPD1_Keq))./...
    ((1+F16BP./p.GPD1_Kf16bp+ATP./p.GPD1_Katp+ADP./p.GPD1_Kadp).*(1+DHAP./p.GPD1_Kdhap+GLYC3P./p.GPD1_Kglyc3p).*(1+NADH./p.GPD1_Knadh+NAD./p.GPD1_Knad)));

%% HOR2 consensus
% %RHR2 consensus
% "sn-glycerol 3-phosphate" + water -> glycerol + phosphate; 
v_HOR2=(((p.HOR2_kcat.*f.HOR2)./p.HOR2_Kglyc3p.*GLYC3P)./...
    ((1+PI./p.HOR2_Kpi).*(1+GLYC3P./p.HOR2_Kglyc3p)));
v_RHR2=0;

%% TREHALOSE CYCLE

%% PGM1 consensus
% "D-glucose 1-phosphate" = "D-glucose 6-phosphate";  
v_PGM1=(((p.PGM1_kcat.*(f.PGM1+f.PGM2+f.PGM3))./p.PGM1_Kg1p.*(G1P-G6P./p.PGM1_Keq))./...
    (1+G1P./p.PGM1_Kg1p+G6P./p.PGM1_Kg6p));

%% UTP + "D-glucose 1-phosphate" + H+ -> UDP-D-glucose + diphosphate
% Smallbone
v_UGP = (p.UGP_kcat.*f.UGP) * ( ( UTP./p.UGP_Kutp ).*( G1P./p.UGP_Kg1p ) ) ./...
    ( p.UGP_Ki_utp/p.UGP_Kutp + UTP./p.UGP_Kutp + G1P./p.UGP_Kg1p + ( UTP./p.UGP_Kutp ).*( G1P./p.UGP_Kg1p ) + ( p.UGP_Ki_utp/p.UGP_Kutp ).*( UDP_GLC./p.UGP_Ki_udp_glc ) + ( G1P./p.UGP_Kg1p ).*( UDP_GLC./p.UGP_Ki_udp_glc ) );


%% TPS1     Smallbone2011
% "D-glucose 6-phosphate" + UDP-D-glucose -> "alpha,alpha-trehalose 6-phosphate" + H+ + UDP;  
v_TPS1=(F6P./(F6P+p.TPS1_KmF6P)).*(((p.TPS1_kcat.*f.TPS1)./(p.TPS1_Kg6p.*p.TPS1_Kudp_glc).*G6P.*UDP_GLC./...
    ((1+G6P./p.TPS1_Kg6p).*(1+UDP_GLC./p.TPS1_Kudp_glc).*(1+PI./p.TPS1_Kpi))));

%% TPS2     Smallbone2011
% "alpha,alpha-trehalose 6-phosphate" + water -> alpha,alpha-trehalose + phosphate; 
v_TPS2=(((p.TPS2_kcat.*f.TPS2).*T6P.*PI)./...
    ((p.TPS2_Kt6p.*p.TPS2_Kpi)+(p.TPS2_Kt6p+T6P).*PI));


%% NTH1     Smallbone2011
% alpha,alpha-trehalose + water -> 2 * D-glucose;  
v_NTH1=(((p.NTH1_kcat.*f.NTH1)./p.NTH1_Ktre.*TRE)./...
    (1+TRE./p.NTH1_Ktre));

%% ATH1 ec and vac

% v_ATH1ec = 0;
v_ATH1ec = (p.ATH1_kcat .* f.ATH1ec).* ( (TREec./p.ATH1_Ktre)./ ( 1+(TREec./p.ATH1_Ktre) ) );

% v_ATH1vac = 0;
v_ATH1vac = (p.ATH1_kcat .* f.ATH1vac).* ( (TREvac./p.ATH1_Ktre)./ ( 1+(TREvac./p.ATH1_Ktre) ) );

%% AGT1 Trehalose transporter to the periplasm (reversible MM)
% reverse: TREic -> TREec with inhibition
v_AGT1 = (p.AGT1_kcat .* f.AGT1).* (1./ p.AGT1_Ktre) .* ( TRE - TREec./p.AGT1_Keq )./ ( 1+TRE./p.AGT1_Ktre + TREec./p.AGT1_Ktre_ec + (UDP_GLC./p.AGT1_Ki) ) ;

%% vacuoleT vacuolar membrane transport of trehalose
v_vacuoleT = p.vacuoleT_vmax .* (1./p.vacuoleT_Ktre) .* ( TRE - TREvac./p.vacuoleT_Keq) ./ ( 1 + TRE./ p.vacuoleT_Ktre + TREvac./ p.vacuoleT_Ktre);


%% COFACTOR METABOLISM

%% vac_Pi_import
v_vacuolePi=p.vacuolePi_k.*(p.vacuolePi_steadyStatePi-PI);

%% ADK1 consensus
% 2 * ADP = AMP + ATP;
v_ADK1=p.ADK1_k.*((ADP.*ADP)-(AMP.*ATP)./p.ADK1_Keq);

%% ATPase
v_ATPase=ATP./ADP.*p.ATPaseK;

%% mito(ATP)
v_mito=p.mitoVmax.*ADP./(ADP+p.mitoADPKm).*(PI./(PI+p.mitoPiKm));

%% mitoNADH
v_mitoNADH=p.mitoNADHVmax.*(NADH./(NADH+p.mitoNADHKm));

%% IXP cycle
v_Amd1=(p.Amd1_Vmax.*AMP)./(p.Amd1_K50.*(1+PI./p.Amd1_Kpi)+AMP);
v_Ade13_v_Ade12=IMP.*p.Ade13_Ade12_k;
v_Isn1=IMP.*p.Isn1_k; 
v_Pnp1=INO.*p.Pnp1_k;
v_Hpt1=HYP.*p.Hpt1_k;

%% TRANSPORT REACTIONS (v_GLT, v_FRT, and v_MAT not included)

%% Ethanol transport
v_ETOHtransport=p.kETOHtransport*(ETOH-ETOHec);

%% Glycerol transport
v_GLYCEROLtransport=p.GlycerolTransport.*(GLYCEROL-GLYCec);

%% SINK REACTIONS 
% Sink reactions when biomass is added. The equations still need to change.
% G6P
km_sinkG6P      = 0.1; %0;% 0.01; %0.1; %5; %0.001; %5; %1; %2;
poly_sinkG6P    = 3.6854 * d.^3 -   1.4119 * d.^2 -  0.6312 * d    - 0.0043; % % CHANGED
ratioG6P        = 1;
v_sinkG6P       = ratioG6P .* poly_sinkG6P .* (G6P./(G6P + km_sinkG6P));
%v_sinkG6P = 0; % to exclude v_sinkG6P from model
% F6P
km_sinkF6P      = 0.01;
poly_sinkF6P    = 519.3740 * d.^6 - 447.7990 * d.^5 + 97.2843 * d.^4 + 8.0698 * d.^3 - 4.4005 * d.^2 + 0.6254 * d - 0.0078; % % CHANGED
v_sinkF6P       = poly_sinkF6P * (F6P./(F6P + km_sinkF6P));
%v_sinkF6P = 0; % to exclude v_sinkF6P from model
% GAP
km_sinkGAP      = 0.0005;
poly_sinkGAP    = 170.8447 * d.^6 - 113.2975 * d.^5 + 2.6494 * d.^4 + 10.2461 * d.^3 - 1.8002 * d.^2 + 0.1988 * d + 0.0012; % % CHANGED
v_sinkGAP       = poly_sinkGAP * (GLYCERAL3P./(GLYCERAL3P + km_sinkGAP));
%v_sinkGAP = 0; % to exclude v_sinkGAP from model
% P3G
km_sinkP3G      = 0.001; %0.1; %5;
poly_sinkP3G    = -0.2381 * d.^2 -0.0210 * d   -0.0034; % % CHANGED
v_sinkP3G       = poly_sinkP3G * (P3G./(P3G + km_sinkP3G));
%v_sinkP3G = 0; % to exclude v_sinkP3G from model
% PEP
km_sinkPEP      = 0.001; %0.1;
poly_sinkPEP    = -   0.0637 * d.^2 -   0.0617 * d   -  0.0008; % % CHANGED
v_sinkPEP       = poly_sinkPEP * (PEP./(PEP + km_sinkPEP));
%v_sinkPEP = 0; % to exclude v_sinkPEP from model
% PYR
% % km_sinkPYR      = 0.01; %0.000001; %0.01; %0.00001; %0.00001; %0.1; %0.000001; % it's above right now
% km_sinkPYR      = 1;
poly_sinkPYR    = - 8.4853e+03 * d.^6 + 9.4027e+03 * d.^5 - 3.8027e+03 * d.^4 + 700.5 * d.^3 - 60.26 * d.^2 + 0.711 * d - 0.0356; % % INITIAL FIT
v_sinkPYR       = poly_sinkPYR * (PYR./(PYR + km_sinkPYR));
%v_sinkPYR = 0; % to exclude v_sinkPYR from model
% ACE
km_sinkACE      = 0.0001; %0.00000001; %0.0001;
poly_sinkACE    =     118.8562 * d.^6 - 352.3943 * d.^5 + 245.6092 * d.^4 - 75.2550 * d.^3 + 11.1153 * d.^2 - 1.0379 * d + 0.0119; % % CHANGED
v_sinkACE       = poly_sinkACE * (ACE./(ACE + km_sinkACE));
%v_sinkACE = 0; % to exclude v_sinkACE from model

%% lumped glycogen synthesis and degradation
% first test of single glyc_synthDeg reaction
if isfield(setup,'glycSynthDeg')
    if setup.glycSynthDeg == 1
        v_glycSynthDeg = p.glycSynthDeg_K .* UDP_GLC;
    else
        v_glycSynthDeg = 0;
    end
else
    v_glycSynthDeg = 0;
end
% updated with separate glyc_synth and glyc_deg reaction
if isfield(setup,'glycSynthDeg_separate')
    if setup.glycSynthDeg_separate == 1
        v_glycSynthDeg = 0;
        if (setup.GPdataset.GP400WT == 1) || (setup.GPdataset.GP1800WT == 1) || (setup.GPdataset.GP400M == 1)
            v_glycSynth = p.glycSynth_K .* UDP_GLC; % GLYCOGEN 100% INCLUDED IN MODEL
            v_glycDeg = p.glycDeg_K .* Glycogen_cyt; % GLYCOGEN 100% INCLUDED IN MODEL
        elseif setup.GPdataset.Fruc == 1
            v_glycSynth = 0.46.*p.glycSynth_K .* UDP_GLC; % GLYCOGEN 46% INCLUDED IN MODEL
            v_glycDeg = 0.46.*p.glycDeg_K .* Glycogen_cyt; % GLYCOGEN 46% INCLUDED IN MODEL
        elseif setup.GPdataset.Sucr == 1
            v_glycSynth = 0.73.*p.glycSynth_K .* UDP_GLC; % GLYCOGEN 73% INCLUDED IN MODEL
            v_glycDeg = 0.73.*p.glycDeg_K .* Glycogen_cyt; % GLYCOGEN 73% INCLUDED IN MODEL
        elseif setup.GPdataset.Malt == 1
            v_glycSynth = p.glycSynth_K .* UDP_GLC; % GLYCOGEN 100% INCLUDED IN MODEL
            v_glycDeg = p.glycDeg_K .* Glycogen_cyt; % GLYCOGEN 100% INCLUDED IN MODEL
        end
    else
        v_glycSynth = 0;
        v_glycDeg = 0;
    end
else
    v_glycSynth = 0;
    v_glycDeg = 0;
end
% inhibition by T6P
if isfield(setup,'ATHinhibitionT6P')
    if setup.ATHinhibitionT6P == 1
        v_ATH1ec = (p.ATH1_kcat .* f.ATH1ec).* ( (TREec./p.ATH1_Ktre)./ ( 1+(TREec./p.ATH1_Ktre)+(T6P./p.ATH1_Kt6p) ) );
        v_ATH1vac = (p.ATH1_kcat .* f.ATH1vac).* ( (TREvac./p.ATH1_Ktre)./ ( 1+(TREvac./p.ATH1_Ktre)+(T6P./p.ATH1_Kt6p) ) );
    else
    end
else
end
% separate ATH1 _vac and _ec
if isfield(setup,'ATH_separate_EC_VAC')
    if setup.ATH_separate_EC_VAC == 1
        v_ATH1ec = (p.ATH1_kcat_ec .* f.ATH1ec).* ( (TREec./p.ATH1_Ktre_ec)./ ( 1+(TREec./p.ATH1_Ktre_ec)+(T6P./p.ATH1_Kt6p_ec) ) );
        v_ATH1vac = (p.ATH1_kcat .* f.ATH1vac).* ( (TREvac./p.ATH1_Ktre)./ ( 1+(TREvac./p.ATH1_Ktre)+(T6P./p.ATH1_Kt6p) ) );
    else
    end
else
end
% glycogen metabolism as sink reactions
if isfield(setup,'glycogenReactionsSink')
    if setup.glycogenReactionsSink == 1
        if setup.stage == 2
            if exist('t','var')
                v_glycSynthDeg = 0;
                % updated with Km
                temp_v_glycSynth = interp1(setup.dataset.FF01.fluxes_times', setup.dataset.FF01.fluxes{42}', t, 'pchip');%p.glycSynth_K .* UDP_GLC;
                temp_v_glycDeg = interp1(setup.dataset.FF01.fluxes_times', setup.dataset.FF01.fluxes{43}' - setup.dataset.FF01.fluxes{44}' + setup.dataset.FF01.fluxes{45}', t, 'pchip');%p.glycDeg_K .* Glycogen_cyt;
                if (setup.GPdataset.GP400WT == 1) || (setup.GPdataset.GP1800WT == 1) || (setup.GPdataset.GP400M == 1)
                    v_glycSynth = temp_v_glycSynth .* UDP_GLC ./ (UDP_GLC + 0.0001); % GLYCOGEN 100% INCLUDED IN MODEL
                    v_glycDeg = temp_v_glycDeg .* Glycogen_cyt ./ (Glycogen_cyt + 0.0001); % GLYCOGEN 100% INCLUDED IN MODEL
                elseif setup.GPdataset.Fruc == 1
                    v_glycSynth = 0.46.*temp_v_glycSynth .* UDP_GLC ./ (UDP_GLC + 0.0001); % GLYCOGEN 46% INCLUDED IN MODEL
                    v_glycDeg = 0.46.*temp_v_glycDeg .* Glycogen_cyt ./ (Glycogen_cyt + 0.0001); % GLYCOGEN 46% INCLUDED IN MODEL
                elseif setup.GPdataset.Sucr == 1
                    v_glycSynth = 0.73.*temp_v_glycSynth .* UDP_GLC ./ (UDP_GLC + 0.0001); % GLYCOGEN 73% INCLUDED IN MODEL
                    v_glycDeg = 0.73.*temp_v_glycDeg .* Glycogen_cyt ./ (Glycogen_cyt + 0.0001); % GLYCOGEN 73% INCLUDED IN MODEL
                elseif setup.GPdataset.Malt == 1
                    v_glycSynth = temp_v_glycSynth .* UDP_GLC ./ (UDP_GLC + 0.0001); % GLYCOGEN 100% INCLUDED IN MODEL
                    v_glycDeg = temp_v_glycDeg .* Glycogen_cyt ./ (Glycogen_cyt + 0.0001); % GLYCOGEN 100% INCLUDED IN MODEL
                end
            elseif exist('T','var')
                v_glycSynthDeg = 0;
                % updated with Km
                temp_v_glycSynth = interp1(setup.dataset.FF01.fluxes_times', setup.dataset.FF01.fluxes{42}', T, 'pchip');%p.glycSynth_K .* UDP_GLC;
                temp_v_glycDeg = interp1(setup.dataset.FF01.fluxes_times', setup.dataset.FF01.fluxes{43}' - setup.dataset.FF01.fluxes{44}' + setup.dataset.FF01.fluxes{45}', T, 'pchip');%p.glycDeg_K .* Glycogen_cyt;
                if (setup.GPdataset.GP400WT == 1) || (setup.GPdataset.GP1800WT == 1) || (setup.GPdataset.GP400M == 1)
                    v_glycSynth = temp_v_glycSynth .* UDP_GLC ./ (UDP_GLC + 0.0001); % GLYCOGEN 100% INCLUDED IN MODEL
                    v_glycDeg = temp_v_glycDeg .* Glycogen_cyt ./ (Glycogen_cyt + 0.0001); % GLYCOGEN 100% INCLUDED IN MODEL
                elseif setup.GPdataset.Fruc == 1
                    v_glycSynth = 0.46.*temp_v_glycSynth .* UDP_GLC ./ (UDP_GLC + 0.0001); % GLYCOGEN 46% INCLUDED IN MODEL
                    v_glycDeg = 0.46.*temp_v_glycDeg .* Glycogen_cyt ./ (Glycogen_cyt + 0.0001); % GLYCOGEN 46% INCLUDED IN MODEL
                elseif setup.GPdataset.Sucr == 1
                    v_glycSynth = 0.73.*temp_v_glycSynth .* UDP_GLC ./ (UDP_GLC + 0.0001); % GLYCOGEN 73% INCLUDED IN MODEL
                    v_glycDeg = 0.73.*temp_v_glycDeg .* Glycogen_cyt ./ (Glycogen_cyt + 0.0001); % GLYCOGEN 73% INCLUDED IN MODEL
                elseif setup.GPdataset.Malt == 1
                    v_glycSynth = temp_v_glycSynth .* UDP_GLC ./ (UDP_GLC + 0.0001); % GLYCOGEN 100% INCLUDED IN MODEL
                    v_glycDeg = temp_v_glycDeg .* Glycogen_cyt ./ (Glycogen_cyt + 0.0001); % GLYCOGEN 100% INCLUDED IN MODEL
                end
            end
        end
    else
    end
else
end
% inhibition by T6P on AGT1
if isfield(setup,'updated_bmf_Cx_ATH1ec2')
    if setup.updated_bmf_Cx_ATH1ec2 == 1
        v_AGT1 = (p.AGT1_kcat .* f.AGT1).* (1./ p.AGT1_Ktre) .* ( TRE - TREec./p.AGT1_Keq )./ ( 1+TRE./p.AGT1_Ktre + TREec./p.AGT1_Ktre_ec + (T6P./p.AGT1_Kt6p) ) ;
    else
    end
else
end
% option to clamp ath1vac and agt1
if isfield(setup,'clampd_ATHec_AGT1')
    if setup.clampd_ATHec_AGT1 == 1
        if setup.stage == 2
            if exist('t','var')
                % t -> to use within ODE solver
                v_ATH1ec = interp1(setup.dataset.FF01.fluxes_times', p.temp*0.9*setup.dataset.FF01.fluxes{34}', t, 'pchip');
                v_AGT1 = interp1(setup.dataset.FF01.fluxes_times', setup.dataset.FF01.fluxes{32}' - setup.dataset.FF01.fluxes{33}', t, 'pchip');
            elseif exist('T','var')
                % T -> to use within calcFluxes
                v_ATH1ec = interp1(setup.dataset.FF01.fluxes_times', p.temp*0.9*setup.dataset.FF01.fluxes{34}', T, 'pchip');
                v_AGT1 = interp1(setup.dataset.FF01.fluxes_times', dataset.FF01.fluxes{32}' - dataset.FF01.fluxes{33}', T, 'pchip');
            end
        end
    else
    end
else
end

