% Legend for plotting by Hugo Cloudt
if ~isa(plotMode,'numeric')
    
    if plotMode == "2_HugoCloudt"
        
        [legend_HugoCloudt] = legendHugoCloudt;
        metNames_HugoCloudt = legend_HugoCloudt.metabolites;
        reactNames_HugoCloudt = legend_HugoCloudt.fluxes;
        
    end
    
% Legend in original code
else
    [legenda] = legendaFull; %legenda for the names needed
    metNames = legenda.metabolites;
    reactNames = legenda.fluxes;
end