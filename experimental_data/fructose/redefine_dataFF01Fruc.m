%% redefine_dataFF01Fruc (Hugo Cloudt, 12-10-2021)
% Function that redefines the structure "dataFF01Fruc" as such that it gets a similar structure as
% the structures "dataFF01", "dataFF03", and "dataFF04", which makes it possible to plot the data in
% "dataFF01Fruc" in the same easy way as used for plotting the data in the structures "dataFF01", 
% "dataFF03", and "dataFF04" (i.e. storing the structure in "ExpData" and using it to plot in 
% "referencePlotSimulations.m").
%
% Input:
% dataFF01Fruc = old dataFF01Fruc, which needs to be redefined.
% 
% Output:
% dataFF01Fruc_redefined = redefined dataFF01Fruc

function [dataFF01Fruc_redefined] = redefine_dataFF01Fruc(dataFF01Fruc)
    
    % Loading the old dataFF01Fruc
    dataFF01Fruc_redefined = dataFF01Fruc;
    
    % Replacing the structure in the "metabolites" field of the old
    % dataFF01Fruc with a cell array
    dataFF01Fruc_redefined.metabolites = cell(numel(fieldnames(dataFF01Fruc.metabolites)),1);
    
    % Filling the created cell array with the metabolite concentrations
    dataFF01Fruc_redefined.metabolites{1} = dataFF01Fruc.metabolites.Glc_ec;
    dataFF01Fruc_redefined.metabolites{2} = dataFF01Fruc.metabolites.Fruc_ec;
    dataFF01Fruc_redefined.metabolites{3} = dataFF01Fruc.metabolites.Sucr_ec;
    dataFF01Fruc_redefined.metabolites{4} = dataFF01Fruc.metabolites.Malt_ec;
    dataFF01Fruc_redefined.metabolites{5} = dataFF01Fruc.metabolites.Tre_ec;
    dataFF01Fruc_redefined.metabolites{6} = dataFF01Fruc.metabolites.Glc_ic;
    dataFF01Fruc_redefined.metabolites{7} = dataFF01Fruc.metabolites.Fruc_ic;
    dataFF01Fruc_redefined.metabolites{8} = dataFF01Fruc.metabolites.Malt_ic;
    dataFF01Fruc_redefined.metabolites{9} = dataFF01Fruc.metabolites.Tre_cyt;
    dataFF01Fruc_redefined.metabolites{10} = dataFF01Fruc.metabolites.Tre_vac;
    dataFF01Fruc_redefined.metabolites{11} = dataFF01Fruc.metabolites.Tre_ic;
    dataFF01Fruc_redefined.metabolites{12} = dataFF01Fruc.metabolites.T6P;
    dataFF01Fruc_redefined.metabolites{13} = dataFF01Fruc.metabolites.Glyc;
    dataFF01Fruc_redefined.metabolites{14} = dataFF01Fruc.metabolites.G1P;
    dataFF01Fruc_redefined.metabolites{15} = dataFF01Fruc.metabolites.UDPGlc;
    dataFF01Fruc_redefined.metabolites{16} = dataFF01Fruc.metabolites.G6P;
    dataFF01Fruc_redefined.metabolites{17} = dataFF01Fruc.metabolites.F6P;
    dataFF01Fruc_redefined.metabolites{18} = dataFF01Fruc.metabolites.FBP;
    dataFF01Fruc_redefined.metabolites{19} = dataFF01Fruc.metabolites.DHAP;
    dataFF01Fruc_redefined.metabolites{20} = dataFF01Fruc.metabolites.GAP;
    dataFF01Fruc_redefined.metabolites{21} = dataFF01Fruc.metabolites.threePG;
    dataFF01Fruc_redefined.metabolites{22} = dataFF01Fruc.metabolites.twoPG;
    dataFF01Fruc_redefined.metabolites{23} = dataFF01Fruc.metabolites.PEP;
    dataFF01Fruc_redefined.metabolites{24} = dataFF01Fruc.metabolites.Pyr;
    dataFF01Fruc_redefined.metabolites{25} = dataFF01Fruc.metabolites.G3P;
    dataFF01Fruc_redefined.metabolites{26} = dataFF01Fruc.metabolites.NADH;
    dataFF01Fruc_redefined.metabolites{27} = dataFF01Fruc.metabolites.NAD;
    dataFF01Fruc_redefined.metabolites{28} = dataFF01Fruc.metabolites.ATP;
    dataFF01Fruc_redefined.metabolites{29} = dataFF01Fruc.metabolites.ADP;
    dataFF01Fruc_redefined.metabolites{30} = dataFF01Fruc.metabolites.AMP;
    dataFF01Fruc_redefined.metabolites{31} = dataFF01Fruc.metabolites.UTP;
    dataFF01Fruc_redefined.metabolites{32} = dataFF01Fruc.metabolites.UDP;
    
    % Replacing the structure in the "metabolites_ss" field of the old
    % dataFF01Fruc with a cell array
    dataFF01Fruc_redefined.metabolites_ss = cell(numel(fieldnames(dataFF01Fruc.metabolites_ss)),1);
    
    % Filling the created cell array with the metabolite concentrations
    dataFF01Fruc_redefined.metabolites_ss{1} = dataFF01Fruc.metabolites_ss.Glc_ec;
    dataFF01Fruc_redefined.metabolites_ss{2} = dataFF01Fruc.metabolites_ss.Fruc_ec;
    dataFF01Fruc_redefined.metabolites_ss{3} = dataFF01Fruc.metabolites_ss.Sucr_ec;
    dataFF01Fruc_redefined.metabolites_ss{4} = dataFF01Fruc.metabolites_ss.Malt_ec;
    dataFF01Fruc_redefined.metabolites_ss{5} = dataFF01Fruc.metabolites_ss.Tre_ec;
    dataFF01Fruc_redefined.metabolites_ss{6} = dataFF01Fruc.metabolites_ss.Glc_ic;
    dataFF01Fruc_redefined.metabolites_ss{7} = dataFF01Fruc.metabolites_ss.Fruc_ic;
    dataFF01Fruc_redefined.metabolites_ss{8} = dataFF01Fruc.metabolites_ss.Malt_ic;
    dataFF01Fruc_redefined.metabolites_ss{9} = dataFF01Fruc.metabolites_ss.Tre_cyt;
    dataFF01Fruc_redefined.metabolites_ss{10} = dataFF01Fruc.metabolites_ss.Tre_vac;
    dataFF01Fruc_redefined.metabolites_ss{11} = dataFF01Fruc.metabolites_ss.Tre_ic;
    dataFF01Fruc_redefined.metabolites_ss{12} = dataFF01Fruc.metabolites_ss.T6P;
    dataFF01Fruc_redefined.metabolites_ss{13} = dataFF01Fruc.metabolites_ss.Glyc;
    dataFF01Fruc_redefined.metabolites_ss{14} = dataFF01Fruc.metabolites_ss.G1P;
    dataFF01Fruc_redefined.metabolites_ss{15} = dataFF01Fruc.metabolites_ss.UDPGlc;
    dataFF01Fruc_redefined.metabolites_ss{16} = dataFF01Fruc.metabolites_ss.G6P;
    dataFF01Fruc_redefined.metabolites_ss{17} = dataFF01Fruc.metabolites_ss.F6P;
    dataFF01Fruc_redefined.metabolites_ss{18} = dataFF01Fruc.metabolites_ss.FBP;
    dataFF01Fruc_redefined.metabolites_ss{19} = dataFF01Fruc.metabolites_ss.DHAP;
    dataFF01Fruc_redefined.metabolites_ss{20} = dataFF01Fruc.metabolites_ss.GAP;
    dataFF01Fruc_redefined.metabolites_ss{21} = dataFF01Fruc.metabolites_ss.threePG;
    dataFF01Fruc_redefined.metabolites_ss{22} = dataFF01Fruc.metabolites_ss.twoPG;
    dataFF01Fruc_redefined.metabolites_ss{23} = dataFF01Fruc.metabolites_ss.PEP;
    dataFF01Fruc_redefined.metabolites_ss{24} = dataFF01Fruc.metabolites_ss.Pyr;
    dataFF01Fruc_redefined.metabolites_ss{25} = dataFF01Fruc.metabolites_ss.G3P;
    dataFF01Fruc_redefined.metabolites_ss{26} = dataFF01Fruc.metabolites_ss.NADH;
    dataFF01Fruc_redefined.metabolites_ss{27} = dataFF01Fruc.metabolites_ss.NAD;
    dataFF01Fruc_redefined.metabolites_ss{28} = dataFF01Fruc.metabolites_ss.ATP;
    dataFF01Fruc_redefined.metabolites_ss{29} = dataFF01Fruc.metabolites_ss.ADP;
    dataFF01Fruc_redefined.metabolites_ss{30} = dataFF01Fruc.metabolites_ss.AMP;
    dataFF01Fruc_redefined.metabolites_ss{31} = dataFF01Fruc.metabolites_ss.UTP;
    dataFF01Fruc_redefined.metabolites_ss{32} = dataFF01Fruc.metabolites_ss.UDP;
    
end