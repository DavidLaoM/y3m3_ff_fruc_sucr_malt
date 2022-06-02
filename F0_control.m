% % Control pipeline
%  The aim of this file is to check rerunning codes from start works well
%  after simplification of the pipeline.
check_confirm = 1;
% Please, run this code in sections, as figure numbering is important for
% some plots


%% f1
clearvars -except check_confirm
close all
% tic
F0_reference_simulations
% toc % about 30 secs
if check_confirm == 1
    % 
    fh3_mets_fruc_current = figure(3);
    fh5_mets_sucr_current = figure(5);
    fh7_mets_malt_current = figure(7);
    % 
    openfig('F0_FFmets_fruc.fig');
    fh3_mets_fruc_safecopy = figure(9);
    openfig('F0_FFmets_sucr.fig');
    fh5_mets_sucr_safecopy = figure(10);
    openfig('F0_FFmets_malt.fig');
    fh7_mets_malt_safecopy = figure(11);
    % 
    if(    (sum(fh3_mets_fruc_current.Children(end).Children(end).YData) == sum(fh3_mets_fruc_safecopy.Children(end).Children(end).YData)) && (sum(fh5_mets_sucr_current.Children(end).Children(end).YData) == sum(fh5_mets_sucr_safecopy.Children(end).Children(end).YData)) && (sum(fh7_mets_malt_current.Children(end).Children(end).YData) == sum(fh7_mets_malt_safecopy.Children(end).Children(end).YData))    )
        disp('F0 reference simulations are reproduced properly.')
    else
        disp('F0 reference simulations are NOT reproduced properly.')
    end
    close(9:11)
end

