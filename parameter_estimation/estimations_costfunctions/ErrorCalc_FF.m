function [Y, V] = ErrorCalc_FF(simResults,canelas_SS,data,dataset,setup)
% This code recalls the simulated and experimental data and creates the
% error matrix structure. - only for Feast-Famine dataset FF01 !
% 2020-12-17 Ana


% Recall data for GP_FF Suarez simulations
if isfield(setup,'GPdataset')
    Tgpff = simResults.TgpFF;
    Ygpff = simResults.YgpFF;
    Vgpff = simResults.VgpFF;
    %     [EYgpff,EVgpff] = reorderGPFFsuarez_3(Tgpff,Ygpff,Vgpff,dataset,setup);
    
    reorganiseTUDdata; % puts it in order for easily coding in the next section
    [legenda] = legendaFull;
    
    % EXPERIMENTAL DATA
    if((setup.GPdataset.GP400WT == 1)&&(setup.GPdataset.GP1800WT == 0)&&(setup.GPdataset.GP400M == 0))
        
        % metabolites
        Y.exptime = dataset.FF01.time_mets;
        Y.exptimeECgluc = dataset.FF01.timeECgluc;
        Y.expG6P = dataset.FF01.metabolites.ICG6P.conc;
        Y.expF6P = dataset.FF01.metabolites.ICF6P.conc;
        Y.expFBP = dataset.FF01.metabolites.ICFBP.conc;
        Y.expGAP = dataset.FF01.metabolites.ICGAP.conc;
        Y.expDHAP = dataset.FF01.metabolites.ICDHAP.conc;
        Y.exp2PG = dataset.FF01.metabolites.IC2PG.conc;
        Y.expPG3 = dataset.FF01.metabolites.IC3PG.conc;
        Y.expPEP = dataset.FF01.metabolites.ICPEP.conc;
        Y.expPYR = dataset.FF01.metabolites.ICPYR.conc;
        Y.expG1P = dataset.FF01.metabolites.ICG1P.conc;
        Y.expUDP_GLC = dataset.FF01.metabolites.ICUDPG.conc;
        Y.expT6P = dataset.FF01.metabolites.ICT6P.conc;
% % % %         % changed 2021-06-09
% % % %         Y.expTREic = 0.1 .* dataset.FF01.metabolites.ICtreh.conc;
        Y.expTREic = dataset.FF01.metabolites.ICtreh.conc;
        Y.expG3P = dataset.FF01.metabolites.ICG3P.conc;
        Y.expATP = dataset.FF01.metabolites.ICATP.conc;
        Y.expAMP = dataset.FF01.metabolites.ICAMP.conc;
        Y.expADP = dataset.FF01.metabolites.ICADP.conc;
        Y.expGLCic = dataset.FF01.metabolites.ICglucose.conc;
        Y.expGLYC = dataset.FF01.metabolites.ICglyc.conc;
        Y.expTREec = dataset.FF01.metabolites.ECtreh.conc;
        Y.expGLCec = dataset.FF01.metabolites.ECglucose.conc(1:15);
        Y.expTREvac = 0.9 .* dataset.FF01.metabolites.ICtreh.conc;
        
        % fluxes
        V.exptime   = dataset.FF01.fluxes_times';
        V.expGLT = dataset.FF01.fluxes{1}';
        V.expGLK = dataset.FF01.fluxes{1}';
        V.expHXK = dataset.FF01.fluxes{1}';
        V.expPGI = dataset.FF01.fluxes{2}' - dataset.FF01.fluxes{3}';
        V.expPFK = dataset.FF01.fluxes{4}';
        V.expALD = dataset.FF01.fluxes{5}';
        V.expPGM = dataset.FF01.fluxes{8}';
        V.expPGM1 = dataset.FF01.fluxes{39}' - dataset.FF01.fluxes{40}';
        V.expUGP = dataset.FF01.fluxes{41}';
        V.expTPS1 = dataset.FF01.fluxes{11}';
        V.expTPS2 = dataset.FF01.fluxes{12}' - dataset.FF01.fluxes{13}';
        V.expNTH1 = dataset.FF01.fluxes{14}';
        V.expATH1 = dataset.FF01.fluxes{34}';
        V.expAGT1 = dataset.FF01.fluxes{32}' - dataset.FF01.fluxes{33}';
        %         V.expvacuoleT= interp1(V.exptime, V.xpvacuoleT, interp_time);
        
        V.expATH1ec = 0.9.* V.expATH1;
        V.expATH1vac = 0.1.* V.expATH1;
        
    end
    
    % SIMULATED DATA
    
    % metabolites
    Y.simG6P = interp1(Tgpff, Ygpff(:,5), Y.exptime);
    Y.simF6P = interp1(Tgpff, Ygpff(:,4), Y.exptime);
    Y.simFBP = interp1(Tgpff, Ygpff(:,3), Y.exptime);
    Y.simGAP = interp1(Tgpff, Ygpff(:,14), Y.exptime);
    Y.simPG3 = interp1(Tgpff, Ygpff(:,11), Y.exptime);
    Y.simPEP = interp1(Tgpff, Ygpff(:,12), Y.exptime);
    Y.simG1P = interp1(Tgpff, Ygpff(:,21), Y.exptime);
    Y.simT6P = interp1(Tgpff, Ygpff(:,26), Y.exptime);
% % % %         % changed 2021-06-09
% % % %     Y.simTREic = interp1(Tgpff, Ygpff(:,25), Y.exptime);
    Y.simTREic = interp1(Tgpff, Ygpff(:,25) + Ygpff(:,38), Y.exptime);
    Y.simUDP_GLC = interp1(Tgpff, Ygpff(:,24), Y.exptime);
    Y.simGLCic = interp1(Tgpff, Ygpff(:,6), Y.exptime);
    Y.simGLCec = interp1(Tgpff, Ygpff(:,36), Y.exptimeECgluc);
    Y.simTREec = interp1(Tgpff, Ygpff(:,37), Y.exptime);
    Y.simTREvac = interp1(Tgpff, Ygpff(:,38), Y.exptime);
    Y.simATP = interp1(Tgpff, Ygpff(:,9), Y.exptime);
    Y.simAMP = interp1(Tgpff, Ygpff(:,15), Y.exptime);
    Y.simADP = interp1(Tgpff, Ygpff(:,16), Y.exptime);
    Y.simPI = interp1(Tgpff, Ygpff(:,27), Y.exptime);
    Y.simDHAP = interp1(Tgpff, Ygpff(:,17), Y.exptime);
    Y.sim2PG = interp1(Tgpff, Ygpff(:,10), Y.exptime);
    Y.simPYR = interp1(Tgpff, Ygpff(:,13), Y.exptime);
    Y.simG3P = interp1(Tgpff, Ygpff(:,18), Y.exptime);
    
    % fluxes
    V.simGLT    = interp1(Tgpff, Vgpff(:,1), V.exptime);
    V.simGLK    = interp1(Tgpff, Vgpff(:,2), V.exptime);
    V.simPGI    = interp1(Tgpff, Vgpff(:,3), V.exptime);
    V.simPFK    = interp1(Tgpff, Vgpff(:,4), V.exptime);
    V.simALD    = interp1(Tgpff, Vgpff(:,5), V.exptime);
    V.simPGM1    = interp1(Tgpff, Vgpff(:,17), V.exptime);
    V.simTPS1    = interp1(Tgpff, Vgpff(:,21), V.exptime);
    V.simTPS2    = interp1(Tgpff, Vgpff(:,19), V.exptime);
    V.simNTH1    = interp1(Tgpff, Vgpff(:,20), V.exptime);
    V.simUGP     = interp1(Tgpff, Vgpff(:,18), V.exptime);
    V.simAGT1    = interp1(Tgpff, Vgpff(:,47), V.exptime);
    V.simATH1ec  = interp1(Tgpff, Vgpff(:,45), V.exptime);
    V.simATH1vac = interp1(Tgpff, Vgpff(:,46), V.exptime);
    V.simvacuoleT= interp1(Tgpff, Vgpff(:,48), V.exptime);
    
    % added glycogen
    % errorGlycogen
    Y.expGlycogen = [100 100]';
    Y.simGlycogen = interp1(Tgpff, Ygpff(:,40), [0 399]');
    % errorGlycSynth
    V.expGlySynth = dataset.FF01.fluxes{42}';
    V.simGlySynth = interp1(Tgpff, Vgpff(:,50), V.exptime);
    % errorGlycDeg
% % % %     V.expGlyDeg = dataset.FF01.fluxes{43}' - dataset.FF01.fluxes{44}';
    V.expGlyDeg = dataset.FF01.fluxes{43}' - dataset.FF01.fluxes{44}' + dataset.FF01.fluxes{45}';
    V.simGlyDeg = interp1(Tgpff, Vgpff(:,51), V.exptime);




else
    Y = 1;
    V = 1;
end

end