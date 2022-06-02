%% InitCond_FF01Sucr (Hugo Cloudt, 19-10-2021)
% Function to set the initial conditions to be used when the model is set to simulate the FF01Sucr experiment
% (FF experiment conducted in the same way as FF01, but with sucrose as substrate) 
% 
% Inputs:
% Vbroth = volume of the broth during the experiment (L)
% dataFF01Sucr = data of the FF01Sucr experiment (as loaded into MATLAB by the "readFF01Sucr" function)
% 
% Output:
% ICFF01Sucr = initial conditions to be used when the model is set to simulate the FF01Sucr experiment

function [ICFF01Sucr] = InitCond_FF01Sucr(Vbroth,dataFF01Sucr)

    % Set the structure of ICFF01Sucr
    ICFF01Sucr = zeros(42,1);

    % Fill the created ICFF01Sucr
    %ICFF01Sucr(1) = [];                                            % ACE (mM)          % NOT measured during FF01Sucr!
    %ICFF01Sucr(2) = [];                                            % BPG (mM)          % NOT measured during FF01Sucr!
    ICFF01Sucr(3) = dataFF01Sucr.metabolites.FBP.conc(1);           % FBP (mM)
    ICFF01Sucr(4) = dataFF01Sucr.metabolites.F6P.conc(1);           % F6P (mM)
    ICFF01Sucr(5) = dataFF01Sucr.metabolites.G6P.conc(1);           % G6P (mM)
    ICFF01Sucr(6) = dataFF01Sucr.metabolites.Glc_ic.conc(1);        % Glc_ic (mM)
    ICFF01Sucr(7) = dataFF01Sucr.metabolites.NAD.conc(1);           % NAD (mM)
    ICFF01Sucr(8) = dataFF01Sucr.metabolites.NADH.conc(1);          % NADH (mM)
    ICFF01Sucr(9) = dataFF01Sucr.metabolites.ATP.conc(1);           % ATP (mM)
    ICFF01Sucr(10) = dataFF01Sucr.metabolites.twoPG.conc(1);        % 2PG (mM)
    ICFF01Sucr(11) = dataFF01Sucr.metabolites.threePG.conc(1);      % 3PG (mM)
    ICFF01Sucr(12) = dataFF01Sucr.metabolites.PEP.conc(1);          % PEP (mM)
    %ICFF01Sucr(13) = dataFF01Sucr.metabolites.Pyr.conc(1);         % Pyr (mM)          % NOT measured during FF01Sucr, although a field for this metabolite is included in Excel file for FF01Sucr
    ICFF01Sucr(14) = dataFF01Sucr.metabolites.GAP.conc(1);          % GAP (mM)
    ICFF01Sucr(15) = dataFF01Sucr.metabolites.ADP.conc(1);          % ADP (mM)
    ICFF01Sucr(16) = dataFF01Sucr.metabolites.AMP.conc(1);          % AMP (mM)
    ICFF01Sucr(17) = dataFF01Sucr.metabolites.DHAP.conc(1);         % DHAP (mM)
    %ICFF01Sucr(18) = dataFF01Sucr.metabolites.G3P.conc(1);         % G3P (mM)          % NOT measured during FF01Sucr, although a field for this metabolite is included in Excel file for FF01Sucr
    %ICFF01Sucr(19) = [];                                           % Glycerol (mM)     % NOT measured during FF01Sucr!
    %ICFF01Sucr(20) = [];                                           % EtOH (mM)         % NOT measured during FF01Sucr!
    %ICFF01Sucr(21) = dataFF01Sucr.metabolites.G1P.conc(1);         % G1P (mM)          % NOT measured during FF01Sucr, although a field for this metabolite is included in Excel file for FF01Sucr
    ICFF01Sucr(22) = dataFF01Sucr.metabolites.UTP.conc(1);          % UTP (mM)
    ICFF01Sucr(23) = dataFF01Sucr.metabolites.UDP.conc(1);          % UDP (mM)
    %ICFF01Sucr(24) = dataFF01Sucr.metabolites.UDPGlc.conc(1);      % UDPGlc (mM)       % NOT measured during FF01Sucr, although a field for this metabolite is included in Excel file for FF01Sucr
    ICFF01Sucr(25) = 0.1*dataFF01Sucr.metabolites.Tre_ic.conc(1);   % Tre_cyt (mM)      % Tre_cyt is approximately 10% of the Tre_ic measured during FF01Sucr
    ICFF01Sucr(26) = dataFF01Sucr.metabolites.T6P.conc(1);          % T6P (mM)
    %ICFF01Sucr(27) = [];                                           % PI (mM)           % NOT measured during FF01Sucr!
    %ICFF01Sucr(28) = [];                                           % IMP (mM)          % NOT measured during FF01Sucr!
    %ICFF01Sucr(29) = [];                                           % INO (mM)          % NOT measured during FF01Sucr!
    %ICFF01Sucr(30) = [];                                           % HYP (mM)          % NOT measured during FF01Sucr!
    %ICFF01Sucr(31) = [];                                           % EtOH_ec (mM)      % NOT measured during FF01Sucr!
    %ICFF01Sucr(32) = [];                                           % Glycerol_ec (mM)  % NOT measured during FF01Sucr!
    %ICFF01Sucr(33) = dataFF01Sucr.metabolites.Fruc_ic.conc(1);     % Fruc_ic (mM)      % NOT measured during FF01Sucr, although a field for this metabolite is included in Excel file for FF01Sucr
    ICFF01Sucr(34) = dataFF01Sucr.metabolites.Fruc_ec.conc(1);      % Fruc_ec (mM)
    %ICFF01Sucr(35) = dataFF01Sucr.metabolites.Sucr_ec.conc(1);     % Sucr_ec (mM)      % NOT measured during FF01Sucr, although a field for this metabolite is included in Excel file for FF01Sucr
    ICFF01Sucr(36) = dataFF01Sucr.metabolites.Glc_ec.conc(1);       % Glc_ec (mM)
    %ICFF01Sucr(37) = dataFF01Sucr.metabolites.Tre_ec.conc(1);      % Tre_ec (mM)       % NOT measured during FF01Sucr, although a field for this metabolite is included in Excel file for FF01Sucr
    ICFF01Sucr(38) = 0.9*dataFF01Sucr.metabolites.Tre_ic.conc(1);   % Tre_vac (mM)      % Tre_vac is approximately 90% of the Tre_ic measured during FF01Sucr
    ICFF01Sucr(39) = Vbroth;                                        % Vbroth (L)
    ICFF01Sucr(40) = 100;                                           % Glyc (mM)         % Constant value at which the Glyc concentration probably approximately stays during the FF01 experiment
    %ICFF01Sucr(41) = dataFF01Sucr.metabolites.Malt_ec.conc(1);     % Malt_ec (mM)      % NOT measured during FF01Sucr, although a field for this metabolite is included in Excel file for FF01Sucr
    %ICFF01Sucr(42) = dataFF01Sucr.metabolites.Malt_ic.conc(1);     % Malt_ic (mM)      % NOT measured during FF01Sucr, although a field for this metabolite is included in Excel file for FF01Sucr
end