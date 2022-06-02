%% InitCond_FF01Malt (Hugo Cloudt, 22-12-2021)
% Function to set the initial conditions to be used when the model is set to simulate the FF01Malt experiment
% (FF experiment conducted in the same way as FF01, but with maltose as substrate) 
% 
% Inputs:
% Vbroth = volume of the broth during the experiment (L)
% dataFF01Malt = data of the FF01Malt experiment (as loaded into MATLAB by the "readFF01Malt" function)
% 
% Output:
% ICFF01Malt = initial conditions to be used when the model is set to simulate the FF01Malt experiment

function [ICFF01Malt] = InitCond_FF01Malt(Vbroth,dataFF01Malt)

    % Set the structure of ICFF01Malt
    ICFF01Malt = zeros(42,1);

    % Fill the created ICFF01Malt
    %ICFF01Malt(1) = [];                                            % ACE (mM)          % NOT measured during FF01Malt!
    %ICFF01Malt(2) = [];                                            % BPG (mM)          % NOT measured during FF01Malt!
    ICFF01Malt(3) = dataFF01Malt.metabolites.FBP.conc(1);           % FBP (mM)
    ICFF01Malt(4) = dataFF01Malt.metabolites.F6P.conc(1);           % F6P (mM)
    ICFF01Malt(5) = dataFF01Malt.metabolites.G6P.conc(1);           % G6P (mM)
    ICFF01Malt(6) = dataFF01Malt.metabolites.Glc_ic.conc(1);        % Glc_ic (mM)
    ICFF01Malt(7) = dataFF01Malt.metabolites.NAD.conc(1);           % NAD (mM)
    ICFF01Malt(8) = dataFF01Malt.metabolites.NADH.conc(1);          % NADH (mM)
    ICFF01Malt(9) = dataFF01Malt.metabolites.ATP.conc(1);           % ATP (mM)
    ICFF01Malt(10) = dataFF01Malt.metabolites.twoPG.conc(1);        % 2PG (mM)
    ICFF01Malt(11) = dataFF01Malt.metabolites.threePG.conc(1);      % 3PG (mM)
    ICFF01Malt(12) = dataFF01Malt.metabolites.PEP.conc(1);          % PEP (mM)
    %ICFF01Malt(13) = dataFF01Malt.metabolites.Pyr.conc(1);         % Pyr (mM)          % NOT measured during FF01Malt, although a field for this metabolite is included in Excel file for FF01Malt
    ICFF01Malt(14) = dataFF01Malt.metabolites.GAP.conc(1);          % GAP (mM)
    ICFF01Malt(15) = dataFF01Malt.metabolites.ADP.conc(1);          % ADP (mM)
    ICFF01Malt(16) = dataFF01Malt.metabolites.AMP.conc(1);          % AMP (mM)
    ICFF01Malt(17) = dataFF01Malt.metabolites.DHAP.conc(1);         % DHAP (mM)
    %ICFF01Malt(18) = dataFF01Malt.metabolites.G3P.conc(1);         % G3P (mM)          % NOT measured during FF01Malt, although a field for this metabolite is included in Excel file for FF01Malt
    %ICFF01Malt(19) = [];                                           % Glycerol (mM)     % NOT measured during FF01Malt!
    %ICFF01Malt(20) = [];                                           % EtOH (mM)         % NOT measured during FF01Malt!
    %ICFF01Malt(21) = dataFF01Malt.metabolites.G1P.conc(1);         % G1P (mM)          % NOT measured during FF01Malt, although a field for this metabolite is included in Excel file for FF01Malt
    ICFF01Malt(22) = dataFF01Malt.metabolites.UTP.conc(1);          % UTP (mM)
    ICFF01Malt(23) = dataFF01Malt.metabolites.UDP.conc(1);          % UDP (mM)
    %ICFF01Malt(24) = dataFF01Malt.metabolites.UDPGlc.conc(1);      % UDPGlc (mM)       % NOT measured during FF01Malt, although a field for this metabolite is included in Excel file for FF01Malt
    ICFF01Malt(25) = 0.1*dataFF01Malt.metabolites.Tre_ic.conc(1);   % Tre_cyt (mM)      % Tre_cyt is approximately 10% of the Tre_ic measured during FF01Malt
    ICFF01Malt(26) = dataFF01Malt.metabolites.T6P.conc(1);          % T6P (mM)
    %ICFF01Malt(27) = [];                                           % PI (mM)           % NOT measured during FF01Malt!
    %ICFF01Malt(28) = [];                                           % IMP (mM)          % NOT measured during FF01Malt!
    %ICFF01Malt(29) = [];                                           % INO (mM)          % NOT measured during FF01Malt!
    %ICFF01Malt(30) = [];                                           % HYP (mM)          % NOT measured during FF01Malt!
    %ICFF01Malt(31) = [];                                           % EtOH_ec (mM)      % NOT measured during FF01Malt!
    %ICFF01Malt(32) = [];                                           % Glycerol_ec (mM)  % NOT measured during FF01Malt!
    %ICFF01Malt(33) = dataFF01Malt.metabolites.Fruc_ic.conc(1);     % Fruc_ic (mM)      % NOT measured during FF01Malt, although a field for this metabolite is included in Excel file for FF01Malt
    %ICFF01Malt(34) = dataFF01Malt.metabolites.Fruc_ec.conc(1);     % Fruc_ec (mM)      % NOT measured during FF01Malt, although a field for this metabolite is included in Excel file for FF01Malt
    %ICFF01Malt(35) = dataFF01Malt.metabolites.Sucr_ec.conc(1);     % Sucr_ec (mM)      % NOT measured during FF01Malt, although a field for this metabolite is included in Excel file for FF01Malt
    %ICFF01Malt(36) = dataFF01Malt.metabolites.Glc_ec.conc(1);      % Glc_ec (mM)       % NOT measured during FF01Malt, although a field for this metabolite is included in Excel file for FF01Malt
    %ICFF01Malt(37) = dataFF01Malt.metabolites.Tre_ec.conc(1);      % Tre_ec (mM)       % NOT measured during FF01Malt, although a field for this metabolite is included in Excel file for FF01Malt
    ICFF01Malt(38) = 0.9*dataFF01Malt.metabolites.Tre_ic.conc(1);   % Tre_vac (mM)      % Tre_vac is approximately 90% of the Tre_ic measured during FF01Malt
    ICFF01Malt(39) = Vbroth;                                        % Vbroth (L)
    ICFF01Malt(40) = 100;                                           % Glyc (mM)         % Constant value at which the Glyc concentration probably approximately stays during the FF01 experiment
    ICFF01Malt(41) = dataFF01Malt.metabolites.Malt_ec.conc(1);      % Malt_ec (mM)
    %ICFF01Malt(42) = dataFF01Malt.metabolites.Malt_ic.conc(1);     % Malt_ic (mM)      % NOT measured during FF01Malt, although a field for this metabolite is included in Excel file for FF01Malt
end