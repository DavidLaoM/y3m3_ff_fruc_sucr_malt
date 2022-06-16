%% InitCond_FF01Fruc (Hugo Cloudt, 8-10-2021)
% Function to set the initial conditions to be used when the model is set to simulate the FF01Fruc experiment
% (FF experiment conducted in the same way as FF01, but with fructose as substrate) 
% 
% Inputs:
% Vbroth = volume of the broth during the experiment (L)
% dataFF01Fruc = data of the FF01Fruc experiment (as loaded into MATLAB by the "readFF01Fruc" function)
% 
% Output:
% ICFF01Fruc = initial conditions to be used when the model is set to simulate the FF01Fruc experiment

function [ICFF01Fruc] = InitCond_FF01Fruc(Vbroth,dataFF01Fruc)

    % Set the structure of ICFF01Fruc
    ICFF01Fruc = zeros(42,1);

    % Fill the created ICFF01Fruc
    %ICFF01Fruc(1) = [];                                            % ACE (mM)          % NOT measured during FF01Fruc!
    %ICFF01Fruc(2) = [];                                            % BPG (mM)          % NOT measured during FF01Fruc!
    ICFF01Fruc(3) = dataFF01Fruc.metabolites.FBP.conc(1);           % FBP (mM)
    ICFF01Fruc(4) = dataFF01Fruc.metabolites.F6P.conc(1);           % F6P (mM)
    ICFF01Fruc(5) = dataFF01Fruc.metabolites.G6P.conc(1);           % G6P (mM)
    ICFF01Fruc(6) = dataFF01Fruc.metabolites.Glc_ic.conc(1);        % Glc_ic (mM)
    ICFF01Fruc(7) = dataFF01Fruc.metabolites.NAD.conc(1);           % NAD (mM)
%     ICFF01Fruc(7) = 5;           % NAD (mM)
    ICFF01Fruc(8) = dataFF01Fruc.metabolites.NADH.conc(1);          % NADH (mM)
    ICFF01Fruc(9) = dataFF01Fruc.metabolites.ATP.conc(1);           % ATP (mM)
    ICFF01Fruc(10) = dataFF01Fruc.metabolites.twoPG.conc(1);        % 2PG (mM)
    ICFF01Fruc(11) = dataFF01Fruc.metabolites.threePG.conc(1);      % 3PG (mM)
    %ICFF01Fruc(12) = dataFF01Fruc.metabolites.PEP.conc(1);         % PEP (mM)          % NOT measured during FF01Fruc, although a field for this metabolite is included in Excel file for FF01Fruc
    %ICFF01Fruc(13) = dataFF01Fruc.metabolites.Pyr.conc(1);         % Pyr (mM)          % NOT measured during FF01Fruc, although a field for this metabolite is included in Excel file for FF01Fruc
    ICFF01Fruc(14) = dataFF01Fruc.metabolites.GAP.conc(1);          % GAP (mM)
    ICFF01Fruc(15) = dataFF01Fruc.metabolites.ADP.conc(1);          % ADP (mM)
    ICFF01Fruc(16) = dataFF01Fruc.metabolites.AMP.conc(1);          % AMP (mM)
    ICFF01Fruc(17) = dataFF01Fruc.metabolites.DHAP.conc(1);         % DHAP (mM)
    ICFF01Fruc(18) = dataFF01Fruc.metabolites.G3P.conc(1);          % G3P (mM)
    %ICFF01Fruc(19) = [];                                           % Glycerol (mM)     % NOT measured during FF01Fruc!
    %ICFF01Fruc(20) = [];                                           % EtOH (mM)         % NOT measured during FF01Fruc!
    %ICFF01Fruc(21) = dataFF01Fruc.metabolites.G1P.conc(1);         % G1P (mM)          % NOT measured during FF01Fruc, although a field for this metabolite is included in Excel file for FF01Fruc
    ICFF01Fruc(22) = dataFF01Fruc.metabolites.UTP.conc(1);          % UTP (mM)
    ICFF01Fruc(23) = dataFF01Fruc.metabolites.UDP.conc(1);          % UDP (mM)
    %ICFF01Fruc(24) = dataFF01Fruc.metabolites.UDPGlc.conc(1);      % UDPGlc (mM)       % NOT measured during FF01Fruc, although a field for this metabolite is included in Excel file for FF01Fruc
    ICFF01Fruc(25) = 0.1*dataFF01Fruc.metabolites.Tre_ic.conc(1);   % Tre_cyt (mM)      % Tre_cyt is approximately 10% of the Tre_ic measured during FF01Fruc
    ICFF01Fruc(26) = dataFF01Fruc.metabolites.T6P.conc(1);          % T6P (mM)
    %ICFF01Fruc(27) = [];                                           % PI (mM)           % NOT measured during FF01Fruc!
    %ICFF01Fruc(28) = [];                                           % IMP (mM)          % NOT measured during FF01Fruc!
    %ICFF01Fruc(29) = [];                                           % INO (mM)          % NOT measured during FF01Fruc!
    %ICFF01Fruc(30) = [];                                           % HYP (mM)          % NOT measured during FF01Fruc!
    %ICFF01Fruc(31) = [];                                           % EtOH_ec (mM)      % NOT measured during FF01Fruc!
    %ICFF01Fruc(32) = [];                                           % Glycerol_ec (mM)  % NOT measured during FF01Fruc!
    %ICFF01Fruc(33) = dataFF01Fruc.metabolites.Fruc_ic.conc(1);     % Fruc_ic (mM)      % NOT measured during FF01Fruc, although a field for this metabolite is included in Excel file for FF01Fruc
    ICFF01Fruc(34) = dataFF01Fruc.metabolites.Fruc_ec.conc(1);      % Fruc_ec (mM)
    %ICFF01Fruc(35) = dataFF01Fruc.metabolites.Sucr_ec.conc(1);     % Sucr_ec (mM)      % NOT measured during FF01Fruc, although a field for this metabolite is included in Excel file for FF01Fruc
    %ICFF01Fruc(36) = dataFF01Fruc.metabolites.Glc_ec.conc(1);      % Glc_ec (mM)       % NOT measured during FF01Fruc, although a field for this metabolite is included in Excel file for FF01Fruc
    %ICFF01Fruc(37) = dataFF01Fruc.metabolites.Tre_ec.conc(1);      % Tre_ec (mM)       % NOT measured during FF01Fruc, although a field for this metabolite is included in Excel file for FF01Fruc
    ICFF01Fruc(38) = 0.9*dataFF01Fruc.metabolites.Tre_ic.conc(1);   % Tre_vac (mM)      % Tre_vac is approximately 90% of the Tre_ic measured during FF01Fruc
    ICFF01Fruc(39) = Vbroth;                                        % Vbroth (L)
    ICFF01Fruc(40) = 100;                                           % Glyc (mM)         % Constant value at which the Glyc concentration probably approximately stays during the FF01 experiment
    %ICFF01Fruc(41) = dataFF01Fruc.metabolites.Malt_ec.conc(1);     % Malt_ec (mM)      % NOT measured during FF01Fruc, although a field for this metabolite is included in Excel file for FF01Fruc
    %ICFF01Fruc(42) = dataFF01Fruc.metabolites.Malt_ic.conc(1);     % Malt_ic (mM)      % NOT measured during FF01Fruc, although a field for this metabolite is included in Excel file for FF01Fruc
end