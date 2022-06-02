%% redefine_dataFF01Malt (Hugo Cloudt, 22-12-2021)
% Function that redefines the structure "dataFF01Malt" as such that it gets a similar structure as
% the structures "dataFF01", "dataFF03", and "dataFF04", which makes it possible to plot the data in
% "dataFF01Malt" in the same easy way as used for plotting the data in the structures "dataFF01", 
% "dataFF03", and "dataFF04" (i.e. storing the structure in "ExpData" and using it to plot in 
% "referencePlotSimulations.m").
%
% Input:
% dataFF01Malt = old dataFF01Malt, which needs to be redefined.
% 
% Output:
% dataFF01Malt_redefined = redefined dataFF01Malt

function [dataFF01Malt_redefined] = redefine_dataFF01Malt(dataFF01Malt)
    
    % Loading the old dataFF01Malt:
    dataFF01Malt_redefined = dataFF01Malt;
    
    % Replacing the structure in the "metabolites" field of the old 
    % dataFF01Malt with a cell array:
    dataFF01Malt_redefined.metabolites = cell(numel(fieldnames(dataFF01Malt.metabolites)),1);
    
    % Filling the created cell with the metabolite concentrations:
    dataFF01Malt_redefined.metabolites{1} = dataFF01Malt.metabolites.Glc_ec;
    dataFF01Malt_redefined.metabolites{2} = dataFF01Malt.metabolites.Fruc_ec;
    dataFF01Malt_redefined.metabolites{3} = dataFF01Malt.metabolites.Sucr_ec;
    dataFF01Malt_redefined.metabolites{4} = dataFF01Malt.metabolites.Malt_ec;
    dataFF01Malt_redefined.metabolites{5} = dataFF01Malt.metabolites.Tre_ec;
    dataFF01Malt_redefined.metabolites{6} = dataFF01Malt.metabolites.Glc_ic;
    dataFF01Malt_redefined.metabolites{7} = dataFF01Malt.metabolites.Fruc_ic;
    dataFF01Malt_redefined.metabolites{8} = dataFF01Malt.metabolites.Malt_ic;
    dataFF01Malt_redefined.metabolites{9} = dataFF01Malt.metabolites.Tre_cyt;
    dataFF01Malt_redefined.metabolites{10} = dataFF01Malt.metabolites.Tre_vac;
    dataFF01Malt_redefined.metabolites{11} = dataFF01Malt.metabolites.Tre_ic;
    dataFF01Malt_redefined.metabolites{12} = dataFF01Malt.metabolites.T6P;
    dataFF01Malt_redefined.metabolites{13} = dataFF01Malt.metabolites.Glyc;
    dataFF01Malt_redefined.metabolites{14} = dataFF01Malt.metabolites.G1P;
    dataFF01Malt_redefined.metabolites{15} = dataFF01Malt.metabolites.UDPGlc;
    dataFF01Malt_redefined.metabolites{16} = dataFF01Malt.metabolites.G6P;
    dataFF01Malt_redefined.metabolites{17} = dataFF01Malt.metabolites.F6P;
    dataFF01Malt_redefined.metabolites{18} = dataFF01Malt.metabolites.FBP;
    dataFF01Malt_redefined.metabolites{19} = dataFF01Malt.metabolites.DHAP;
    dataFF01Malt_redefined.metabolites{20} = dataFF01Malt.metabolites.GAP;
    dataFF01Malt_redefined.metabolites{21} = dataFF01Malt.metabolites.threePG;
    dataFF01Malt_redefined.metabolites{22} = dataFF01Malt.metabolites.twoPG;
    dataFF01Malt_redefined.metabolites{23} = dataFF01Malt.metabolites.PEP;
    dataFF01Malt_redefined.metabolites{24} = dataFF01Malt.metabolites.Pyr;
    dataFF01Malt_redefined.metabolites{25} = dataFF01Malt.metabolites.G3P;
    dataFF01Malt_redefined.metabolites{26} = dataFF01Malt.metabolites.NADH;
    dataFF01Malt_redefined.metabolites{27} = dataFF01Malt.metabolites.NAD;
    dataFF01Malt_redefined.metabolites{28} = dataFF01Malt.metabolites.ATP;
    dataFF01Malt_redefined.metabolites{29} = dataFF01Malt.metabolites.ADP;
    dataFF01Malt_redefined.metabolites{30} = dataFF01Malt.metabolites.AMP;
    dataFF01Malt_redefined.metabolites{31} = dataFF01Malt.metabolites.UTP;
    dataFF01Malt_redefined.metabolites{32} = dataFF01Malt.metabolites.UDP;
    
    % Replacing the structure in the "metabolites_ss" field of the old
    % dataFF01Malt with a cell array:
    dataFF01Malt_redefined.metabolites_ss = cell(numel(fieldnames(dataFF01Malt.metabolites_ss)),1);
    
    % Filling the created cell with the metabolite concentrations:
    dataFF01Malt_redefined.metabolites_ss{1} = dataFF01Malt.metabolites_ss.Glc_ec;
    dataFF01Malt_redefined.metabolites_ss{2} = dataFF01Malt.metabolites_ss.Fruc_ec;
    dataFF01Malt_redefined.metabolites_ss{3} = dataFF01Malt.metabolites_ss.Sucr_ec;
    dataFF01Malt_redefined.metabolites_ss{4} = dataFF01Malt.metabolites_ss.Malt_ec;
    dataFF01Malt_redefined.metabolites_ss{5} = dataFF01Malt.metabolites_ss.Tre_ec;
    dataFF01Malt_redefined.metabolites_ss{6} = dataFF01Malt.metabolites_ss.Glc_ic;
    dataFF01Malt_redefined.metabolites_ss{7} = dataFF01Malt.metabolites_ss.Fruc_ic;
    dataFF01Malt_redefined.metabolites_ss{8} = dataFF01Malt.metabolites_ss.Malt_ic;
    dataFF01Malt_redefined.metabolites_ss{9} = dataFF01Malt.metabolites_ss.Tre_cyt;
    dataFF01Malt_redefined.metabolites_ss{10} = dataFF01Malt.metabolites_ss.Tre_vac;
    dataFF01Malt_redefined.metabolites_ss{11} = dataFF01Malt.metabolites_ss.Tre_ic;
    dataFF01Malt_redefined.metabolites_ss{12} = dataFF01Malt.metabolites_ss.T6P;
    dataFF01Malt_redefined.metabolites_ss{13} = dataFF01Malt.metabolites_ss.Glyc;
    dataFF01Malt_redefined.metabolites_ss{14} = dataFF01Malt.metabolites_ss.G1P;
    dataFF01Malt_redefined.metabolites_ss{15} = dataFF01Malt.metabolites_ss.UDPGlc;
    dataFF01Malt_redefined.metabolites_ss{16} = dataFF01Malt.metabolites_ss.G6P;
    dataFF01Malt_redefined.metabolites_ss{17} = dataFF01Malt.metabolites_ss.F6P;
    dataFF01Malt_redefined.metabolites_ss{18} = dataFF01Malt.metabolites_ss.FBP;
    dataFF01Malt_redefined.metabolites_ss{19} = dataFF01Malt.metabolites_ss.DHAP;
    dataFF01Malt_redefined.metabolites_ss{20} = dataFF01Malt.metabolites_ss.GAP;
    dataFF01Malt_redefined.metabolites_ss{21} = dataFF01Malt.metabolites_ss.threePG;
    dataFF01Malt_redefined.metabolites_ss{22} = dataFF01Malt.metabolites_ss.twoPG;
    dataFF01Malt_redefined.metabolites_ss{23} = dataFF01Malt.metabolites_ss.PEP;
    dataFF01Malt_redefined.metabolites_ss{24} = dataFF01Malt.metabolites_ss.Pyr;
    dataFF01Malt_redefined.metabolites_ss{25} = dataFF01Malt.metabolites_ss.G3P;
    dataFF01Malt_redefined.metabolites_ss{26} = dataFF01Malt.metabolites_ss.NADH;
    dataFF01Malt_redefined.metabolites_ss{27} = dataFF01Malt.metabolites_ss.NAD;
    dataFF01Malt_redefined.metabolites_ss{28} = dataFF01Malt.metabolites_ss.ATP;
    dataFF01Malt_redefined.metabolites_ss{29} = dataFF01Malt.metabolites_ss.ADP;
    dataFF01Malt_redefined.metabolites_ss{30} = dataFF01Malt.metabolites_ss.AMP;
    dataFF01Malt_redefined.metabolites_ss{31} = dataFF01Malt.metabolites_ss.UTP;
    dataFF01Malt_redefined.metabolites_ss{32} = dataFF01Malt.metabolites_ss.UDP;
   
end