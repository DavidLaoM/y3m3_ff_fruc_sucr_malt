function [error] = costfun_FF01_all(x_temp,setup,x,plotflag,selPars,lambda,w)

    % current parameter set
    x(selPars) = x_temp;

    % simulate
    simulate_all
    
    % cost function
    define_error
    error = [...
        w(101) * error_gluc.GLCec; ...%= (Ysim_gluc.ECglucose(1:15) - dataset.FF01.metabolites.ECglucose.conc(1:15) ) ./ dataset.FF01.metabolites.ECglucose.conc(1:15);% GLCec
        w(102) * error_gluc.TREec; ...%= (Ysim_gluc.ECtreh - dataset.FF01.metabolites.ECtreh.conc ) ./ dataset.FF01.metabolites.ECtreh.conc;% TREec
        w(103) * error_gluc.TREic; ...%= (TREtot_gluc - dataset.FF01.metabolites.ICtreh.conc ) ./ dataset.FF01.metabolites.ICtreh.conc;% TREtot
        w(104) * error_gluc.T6P; ...%= (Ysim_gluc.ICT6P - dataset.FF01.metabolites.ICT6P.conc ) ./ dataset.FF01.metabolites.ICT6P.conc;% T6P
        w(105) * error_gluc.G1P; ...%= (Ysim_gluc.ICG1P - dataset.FF01.metabolites.ICG1P.conc ) ./ dataset.FF01.metabolites.ICG1P.conc;% G1P
        w(106) * error_gluc.UDPG; ...%= (Ysim_gluc.ICUDPG - dataset.FF01.metabolites.ICUDPG.conc ) ./ dataset.FF01.metabolites.ICUDPG.conc;% UDPGlc
        w(107) * error_gluc.G6P; ...%= (Ysim_gluc.ICG6P - dataset.FF01.metabolites.ICG6P.conc ) ./ dataset.FF01.metabolites.ICG6P.conc;% G6P
        w(108) * error_gluc.F6P; ...%= (Ysim_gluc.ICF6P - dataset.FF01.metabolites.ICF6P.conc ) ./ dataset.FF01.metabolites.ICF6P.conc;% F6P
        w(109) * error_gluc.FBP; ...%= (Ysim_gluc.ICFBP - dataset.FF01.metabolites.ICFBP.conc ) ./ dataset.FF01.metabolites.ICFBP.conc;% FBP
        w(110) * error_gluc.DHAP; ...%= (Ysim_gluc.ICDHAP - dataset.FF01.metabolites.ICDHAP.conc ) ./ dataset.FF01.metabolites.ICDHAP.conc;% DHAP
        w(111) * error_gluc.GAP; ...%= (Ysim_gluc.ICGAP - dataset.FF01.metabolites.ICGAP.conc ) ./ dataset.FF01.metabolites.ICGAP.conc;% GAP
        w(112) * error_gluc.P3G; ...%= (Ysim_gluc.IC3PG - dataset.FF01.metabolites.IC3PG.conc ) ./ dataset.FF01.metabolites.IC3PG.conc;% 3PG
        w(113) * error_gluc.P2G; ...%= (Ysim_gluc.IC2PG - dataset.FF01.metabolites.IC2PG.conc ) ./ dataset.FF01.metabolites.IC2PG.conc;% 2PG
        w(114) * error_gluc.PEP; ...%= (Ysim_gluc.ICPEP - dataset.FF01.metabolites.ICPEP.conc ) ./ dataset.FF01.metabolites.ICPEP.conc;% PEP
        w(115) * error_gluc.G3P; ...%= (Ysim_gluc.ICG3P - dataset.FF01.metabolites.ICG3P.conc ) ./ dataset.FF01.metabolites.ICG3P.conc;% G3P
        w(116) * error_gluc.ATP; ...%= (Ysim_gluc.ICATP - dataset.FF01.metabolites.ICATP.conc ) ./ dataset.FF01.metabolites.ICATP.conc;% ATP
        w(117) * error_gluc.ADP; ...%= (Ysim_gluc.ICADP - dataset.FF01.metabolites.ICADP.conc ) ./ dataset.FF01.metabolites.ICADP.conc;% ADP
        w(118) * error_gluc.AMP; ...%= (Ysim_gluc.ICAMP - dataset.FF01.metabolites.ICAMP.conc ) ./ dataset.FF01.metabolites.ICAMP.conc;% AMP
        w(120) * error_gluc.uptake; ...%= (Ysim_gluc.ICAMP - dataset.FF01.metabolites.ICAMP.conc ) ./ dataset.FF01.metabolites.ICAMP.conc;% AMP
        w(201) * error_fruc.FRUCec; ... %= (Ysim_fruct.Fruc_ec - save_dataFruc.metabolites.Fruc_ec.conc) ./ save_dataFruc.metabolites.Fruc_ec.conc;% FRUCec
        w(202) * error_fruc.TREtot; ... %= (TREtot_fruc(1:15) - save_dataFruc.metabolites.Tre_ic.conc(1:15)) ./ save_dataFruc.metabolites.Tre_ic.conc(1:15);% TREtot
        w(203) * error_fruc.T6P; ... %= (Ysim_fruct.T6P(1:15) - save_dataFruc.metabolites.T6P.conc(1:15)) ./ save_dataFruc.metabolites.T6P.conc(1:15);% T6P
        w(204) * error_fruc.G6P; ... %= (Ysim_fruct.G6P(1:15) - save_dataFruc.metabolites.G6P.conc(1:15)) ./ save_dataFruc.metabolites.G6P.conc(1:15);% G6P
        w(205) * error_fruc.F6P; ... %= (Ysim_fruct.F6P(1:15) - save_dataFruc.metabolites.F6P.conc(1:15)) ./ save_dataFruc.metabolites.F6P.conc(1:15);% F6P
        w(206) * error_fruc.FBP; ... %= (Ysim_fruct.FBP(1:15) - save_dataFruc.metabolites.FBP.conc(1:15)) ./ save_dataFruc.metabolites.FBP.conc(1:15);% FBP
        w(207) * error_fruc.DHAP; ... %= (Ysim_fruct.DHAP(1:15) - save_dataFruc.metabolites.DHAP.conc(1:15)) ./ save_dataFruc.metabolites.DHAP.conc(1:15);% DHAP
        w(208) * error_fruc.GAP; ... %= (Ysim_fruct.GAP(1:15) - save_dataFruc.metabolites.GAP.conc(1:15)) ./ save_dataFruc.metabolites.GAP.conc(1:15);% GAP
        w(209) * error_fruc.threePG; ... %= (Ysim_fruct.threePG(1:15) - save_dataFruc.metabolites.threePG.conc(1:15)) ./ save_dataFruc.metabolites.threePG.conc(1:15);% 3PG
        w(210) * error_fruc.twoPG; ... %= (Ysim_fruct.twoPG(1:15) - save_dataFruc.metabolites.twoPG.conc(1:15)) ./ save_dataFruc.metabolites.twoPG.conc(1:15);% 2PG
        w(211) * error_fruc.G3P; ... %= (Ysim_fruct.G3P(1:15) - save_dataFruc.metabolites.G3P.conc(1:15)) ./ save_dataFruc.metabolites.G3P.conc(1:15);% G3P
        w(212) * error_fruc.ATP; ... %= (Ysim_fruct.ATP(1:15) - save_dataFruc.metabolites.ATP.conc(1:15)) ./ save_dataFruc.metabolites.ATP.conc(1:15);% ATP
        w(213) * error_fruc.ADP; ... %= (Ysim_fruct.ADP(1:15) - save_dataFruc.metabolites.ADP.conc(1:15)) ./ save_dataFruc.metabolites.ADP.conc(1:15);% ADP
        w(214) * error_fruc.AMP; ... %= (Ysim_fruct.AMP(1:15) - save_dataFruc.metabolites.AMP.conc(1:15)) ./ save_dataFruc.metabolites.AMP.conc(1:15);% AMP
        w(220) * error_fruc.uptake; ... %= (Ysim_fruct.AMP(1:15) - save_dataFruc.metabolites.AMP.conc(1:15)) ./ save_dataFruc.metabolites.AMP.conc(1:15);% AMP
        w(301) * error_sucr.GLCec;... %= (Ysim_sucr.Glc_ec(1:16) - save_dataSucr.metabolites.Glc_ec.conc(1:16)) ./ save_dataSucr.metabolites.Glc_ec.conc(1:16);% GLCec
        w(302) * error_sucr.FRUCec;... %= (Ysim_sucr.Fruc_ec(1:16) - save_dataSucr.metabolites.Fruc_ec.conc(1:16)) ./ save_dataSucr.metabolites.Fruc_ec.conc(1:16);% FRUCec
        w(303) * error_sucr.TREtot;... %= (TREtot_sucr - save_dataSucr.metabolites.Tre_ic.conc) ./ save_dataSucr.metabolites.Tre_ic.conc;% TREtot
        w(304) * error_sucr.T6P;... %= (Ysim_sucr.T6P - save_dataSucr.metabolites.T6P.conc) ./ save_dataSucr.metabolites.T6P.conc;% T6P
        w(305) * error_sucr.G6P;... %= (Ysim_sucr.G6P - save_dataSucr.metabolites.G6P.conc) ./ save_dataSucr.metabolites.G6P.conc;% G6P
        w(306) * error_sucr.F6P;... %= (Ysim_sucr.F6P - save_dataSucr.metabolites.F6P.conc) ./ save_dataSucr.metabolites.F6P.conc;% F6P
        w(307) * error_sucr.FBP;... %= (Ysim_sucr.FBP - save_dataSucr.metabolites.FBP.conc) ./ save_dataSucr.metabolites.FBP.conc;% FBP
        w(308) * error_sucr.DHAP;... %= (Ysim_sucr.DHAP - save_dataSucr.metabolites.DHAP.conc) ./ save_dataSucr.metabolites.DHAP.conc;% DHAP
        w(309) * error_sucr.GAP;... %= (Ysim_sucr.GAP - save_dataSucr.metabolites.GAP.conc) ./ save_dataSucr.metabolites.GAP.conc;% GAP
        w(310) * error_sucr.threePG;... %= (Ysim_sucr.threePG - save_dataSucr.metabolites.threePG.conc) ./ save_dataSucr.metabolites.threePG.conc;% 3PG
        w(311) * error_sucr.twoPG;... %= (Ysim_sucr.twoPG - save_dataSucr.metabolites.twoPG.conc) ./ save_dataSucr.metabolites.twoPG.conc;% 2PG
        w(312) * error_sucr.PEP;... %= (Ysim_sucr.PEP - save_dataSucr.metabolites.PEP.conc) ./ save_dataSucr.metabolites.PEP.conc;% PEP
        w(313) * error_sucr.ATP;... %= (Ysim_sucr.ATP - save_dataSucr.metabolites.ATP.conc) ./ save_dataSucr.metabolites.ATP.conc;% ATP
        w(314) * error_sucr.ADP;... %= (Ysim_sucr.ADP - save_dataSucr.metabolites.ADP.conc) ./ save_dataSucr.metabolites.ADP.conc;% ADP
        w(315) * error_sucr.AMP;... %= (Ysim_sucr.AMP - save_dataSucr.metabolites.AMP.conc) ./ save_dataSucr.metabolites.AMP.conc;% AMP
        w(320) * error_sucr.uptake;... %= (Ysim_sucr.AMP - save_dataSucr.metabolites.AMP.conc) ./ save_dataSucr.metabolites.AMP.conc;% AMP
        w(401) *error_malt.MALTec;... %= (Ysim_malt.Malt_ec - save_dataMalt.metabolites.Malt_ec.conc) ./ save_dataMalt.metabolites.Malt_ec.conc;% MALTec
        w(402) *error_malt.TREtot;... %= (TREtot_malt - save_dataMalt.metabolites.Tre_ic.conc) ./ save_dataMalt.metabolites.Tre_ic.conc;% TREtot
        w(403) *error_malt.T6P;... %= (Ysim_malt.T6P - save_dataMalt.metabolites.T6P.conc) ./ save_dataMalt.metabolites.T6P.conc;% T6P
        w(404) *error_malt.G6P;... %= (Ysim_malt.G6P - save_dataMalt.metabolites.G6P.conc) ./ save_dataMalt.metabolites.G6P.conc;% G6P
        w(405) *error_malt.F6P;... %= (Ysim_malt.F6P - save_dataMalt.metabolites.F6P.conc) ./ save_dataMalt.metabolites.F6P.conc;% F6P
        w(406) *error_malt.FBP;... %= (Ysim_malt.FBP - save_dataMalt.metabolites.FBP.conc) ./ save_dataMalt.metabolites.FBP.conc;% FBP
        w(407) *error_malt.DHAP;... %= (Ysim_malt.DHAP - save_dataMalt.metabolites.DHAP.conc) ./ save_dataMalt.metabolites.DHAP.conc;% DHAP
        w(408) *error_malt.GAP;... %= (Ysim_malt.GAP - save_dataMalt.metabolites.GAP.conc) ./ save_dataMalt.metabolites.GAP.conc;% GAP
        w(409) *error_malt.threePG;... %= (Ysim_malt.threePG - save_dataMalt.metabolites.threePG.conc) ./ save_dataMalt.metabolites.threePG.conc;% 3PG
        w(410) *error_malt.twoPG;... %= (Ysim_malt.twoPG - save_dataMalt.metabolites.twoPG.conc) ./ save_dataMalt.metabolites.twoPG.conc;% 2PG
        w(411) *error_malt.PEP;... %= (Ysim_malt.PEP - save_dataMalt.metabolites.PEP.conc) ./ save_dataMalt.metabolites.PEP.conc;% PEP
        w(412) *error_malt.ATP;... %= (Ysim_malt.ATP - save_dataMalt.metabolites.ATP.conc) ./ save_dataMalt.metabolites.ATP.conc;% ATP
        w(413) *error_malt.ADP;... %= (Ysim_malt.ADP - save_dataMalt.metabolites.ADP.conc) ./ save_dataMalt.metabolites.ADP.conc;% ADP
        w(414) *error_malt.AMP;... %= (Ysim_malt.AMP - save_dataMalt.metabolites.AMP.conc) ./ save_dataMalt.metabolites.AMP.conc;% AMP
        w(420) *error_malt.uptake;... %= (Ysim_malt.AMP - save_dataMalt.metabolites.AMP.conc) ./ save_dataMalt.metabolites.AMP.conc;% AMP
        lambda *error_reg;...
    ];
end

% x_temp
% setup
% xarray
% plotflag

