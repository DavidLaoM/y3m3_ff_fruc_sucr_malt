%% recall data combinatorial estimation

% % parameters changed
% parSet1 = [parHXT, parHXK, parINV,parMALX];
% parSet2 = [parHXT, parHXK, parINV,parMALX, parTRE];
% parSet3 = [parHXT, parHXK, parINV,parMALX, parUG];
% parSet4 = [parHXT, parHXK, parINV,parMALX, parPGI];
% parSet5 = [parHXT, parHXK, parINV,parMALX, parPFK];
% parSet6 = [parHXT, parHXK, parINV,parMALX, parALD];
% parSet7 = [parHXT, parHXK, parINV,parMALX, parTRE, parUG];
% % estimation case
% parCombs{6} = parSet1; %'pE1_par1new_cf6all.mat';
% parCombs{11} = parSet2; %'pE1_par2new_tre_cf6all.mat';
% parCombs{16} = parSet3; %'pE1_par3new_ugall_cf6all.mat';
% parCombs{21} = parSet4; %'pE1_par4new_ugsingle_pgi_cf6all.mat';
% parCombs{26} = parSet5; %'pE1_par4new_ugsingle_pfk_cf6all.mat';
% parCombs{31} = parSet6; %'pE1_par4new_ugsingle_ald_cf6all.mat';
% parCombs{32} = parSet7; % 

% error arrays
load('pE1_sims_safecopy.mat',"sim_ref_gluc","sim_ref_fruc","sim_ref_sucr","sim_ref_malt",...
    "error_ref","error_gluc_ref","error_fruc_ref","error_sucr_ref","error_malt_ref",...
    "error_cell","error_gluc_cell","error_fruc_cell","error_sucr_cell","error_malt_cell")

% %% 
selError_fructose = zeros(10,6);
selError_sucrose = zeros(10,6);
selError_maltose = zeros(10,6);
    % up to down: 
    %   pset    pstart  1
    %   pset1   pmain   2
    %   pset2   ptre    3
    %   pset3   pug     4
    %   pset4   ppgi    5
    %   pset5   ppfk    6
    %   pset6   pald    7
    %   pset7   ptre_ug 8
    %   pset    pgapdh  9
    %   pset    pgapdh_Cspec  10
    % left to right: 
    %   fbp
    %   gap
    %   dhap
    %   3pg
    %   2pg
    %   pep
    % 
    selError_fructose(1,1) = sum(abs(error_fruc_ref.FBP));
    selError_fructose(1,2) = sum(abs(error_fruc_ref.GAP));
    selError_fructose(1,3) = sum(abs(error_fruc_ref.DHAP));
    selError_fructose(1,4) = sum(abs(error_fruc_ref.threePG));
    selError_fructose(1,5) = sum(abs(error_fruc_ref.twoPG));
%     selError_fructose(1,6) = sum(abs(error_fruc_ref.PEP));
    for i = 2:8
        if i == 2, i2 = 6; 
        elseif i == 3, i2 = 11; 
        elseif i == 4, i2 = 16; 
        elseif i == 5, i2 = 21; 
        elseif i == 6, i2 = 26; 
        elseif i == 7, i2 = 31; 
        elseif i == 8, i2 = 32; 
        end
        selError_fructose(i,1) = sum(abs(error_fruc_cell{i2}.FBP));
        selError_fructose(i,2) = sum(abs(error_fruc_cell{i2}.GAP));
        selError_fructose(i,3) = sum(abs(error_fruc_cell{i2}.DHAP));
        selError_fructose(i,4) = sum(abs(error_fruc_cell{i2}.threePG));
        selError_fructose(i,5) = sum(abs(error_fruc_cell{i2}.twoPG));
    %     selError_fructose(i,6) = sum(abs(error_fruc_cell{i2}.PEP));
    end
    % 
    selError_sucrose(1,1) = sum(abs(error_sucr_ref.FBP));
    selError_sucrose(1,2) = sum(abs(error_sucr_ref.GAP));
    selError_sucrose(1,3) = sum(abs(error_sucr_ref.DHAP));
    selError_sucrose(1,4) = sum(abs(error_sucr_ref.threePG));
    selError_sucrose(1,5) = sum(abs(error_sucr_ref.twoPG));
    selError_sucrose(1,6) = sum(abs(error_sucr_ref.PEP));
    for i = 2:8
        if i == 2, i2 = 6; 
        elseif i == 3, i2 = 11; 
        elseif i == 4, i2 = 16; 
        elseif i == 5, i2 = 21; 
        elseif i == 6, i2 = 26; 
        elseif i == 7, i2 = 31; 
        elseif i == 8, i2 = 32; 
        end
        selError_sucrose(i,1) = sum(abs(error_sucr_cell{i2}.FBP));
        selError_sucrose(i,2) = sum(abs(error_sucr_cell{i2}.GAP));
        selError_sucrose(i,3) = sum(abs(error_sucr_cell{i2}.DHAP));
        selError_sucrose(i,4) = sum(abs(error_sucr_cell{i2}.threePG));
        selError_sucrose(i,5) = sum(abs(error_sucr_cell{i2}.twoPG));
        selError_sucrose(i,6) = sum(abs(error_sucr_cell{i2}.PEP));
    end
    % 
    selError_maltose(1,1) = sum(abs(error_malt_ref.FBP));
    selError_maltose(1,2) = sum(abs(error_malt_ref.GAP));
    selError_maltose(1,3) = sum(abs(error_malt_ref.DHAP));
    selError_maltose(1,4) = sum(abs(error_malt_ref.threePG));
    selError_maltose(1,5) = sum(abs(error_malt_ref.twoPG));
    selError_maltose(1,6) = sum(abs(error_malt_ref.PEP));
    for i = 2:8
        if i == 2, i2 = 6; 
        elseif i == 3, i2 = 11; 
        elseif i == 4, i2 = 16; 
        elseif i == 5, i2 = 21; 
        elseif i == 6, i2 = 26; 
        elseif i == 7, i2 = 31; 
        elseif i == 8, i2 = 32; 
        end
        selError_maltose(i,1) = sum(abs(error_malt_cell{i2}.FBP));
        selError_maltose(i,2) = sum(abs(error_malt_cell{i2}.GAP));
        selError_maltose(i,3) = sum(abs(error_malt_cell{i2}.DHAP));
        selError_maltose(i,4) = sum(abs(error_malt_cell{i2}.threePG));
        selError_maltose(i,5) = sum(abs(error_malt_cell{i2}.twoPG));
        selError_maltose(i,6) = sum(abs(error_malt_cell{i2}.PEP));
    end

%% recall data gapdh estimation
for recalling_gapdh_loop = 1
    % fructose
    openfig('pE6_fructose.fig');
    fh1 = figure(1);
    fh1.Position = [1 0.2370 0.8000 0.6917];
    % fh1.Children(9).Title.String % PEP
    % fh1.Children(10).Title.String % 2PG
    % fh1.Children(11).Title.String % 3PG
    % fh1.Children(12).Title.String % GAP
    % fh1.Children(13).Title.String % DHAP
    % fh1.Children(14).Title.String % FBP
    % 
    % data.fruc.exp.PEP = fh1.Children(9).Children(2).YData;
    data.fruc.exp.twoPG = fh1.Children(10).Children(2).YData;
    data.fruc.exp.threePG = fh1.Children(11).Children(2).YData;
    data.fruc.exp.GAP = fh1.Children(12).Children(2).YData;
    data.fruc.exp.DHAP = fh1.Children(13).Children(2).YData;
    data.fruc.exp.FBP = fh1.Children(14).Children(2).YData;
    data.fruc.exp.time = fh1.Children(14).Children(2).XData;
    % 
    % data.fruc.sim.PEP = interp1(fh1.Children(9).Children(3).XData, fh1.Children(9).Children(3).YData, data.fruc.exp.time, 'spline');
    data.fruc.sim.twoPG = interp1(fh1.Children(10).Children(3).XData, fh1.Children(10).Children(3).YData, data.fruc.exp.time, 'spline');
    data.fruc.sim.threePG = interp1(fh1.Children(11).Children(3).XData, fh1.Children(11).Children(3).YData, data.fruc.exp.time, 'spline');
    data.fruc.sim.GAP = interp1(fh1.Children(12).Children(3).XData, fh1.Children(12).Children(3).YData, data.fruc.exp.time, 'spline');
    data.fruc.sim.DHAP = interp1(fh1.Children(13).Children(3).XData, fh1.Children(13).Children(3).YData, data.fruc.exp.time, 'spline');
    data.fruc.sim.FBP = interp1(fh1.Children(14).Children(3).XData, fh1.Children(14).Children(3).YData, data.fruc.exp.time, 'spline');
    %
    % tempError.fruc.PEP = (data.fruc.sim.PEP - data.fruc.exp.PEP) ./ data.fruc.exp.PEP;
    tempError.fruc.twoPG = (data.fruc.sim.twoPG - data.fruc.exp.twoPG) ./ data.fruc.exp.twoPG;
    tempError.fruc.threePG = (data.fruc.sim.threePG - data.fruc.exp.threePG) ./ data.fruc.exp.threePG;
    tempError.fruc.GAP = (data.fruc.sim.GAP - data.fruc.exp.GAP) ./ data.fruc.exp.GAP;
    tempError.fruc.DHAP = (data.fruc.sim.DHAP - data.fruc.exp.DHAP) ./ data.fruc.exp.DHAP;
    tempError.fruc.FBP = (data.fruc.sim.FBP - data.fruc.exp.FBP) ./ data.fruc.exp.FBP;
    
% %         disp('gapdh frcutose')
% %         disp(data.fruc.exp.FBP)
% %         disp(data.fruc.sim.FBP)
% %         disp(tempError.fruc.FBP)
% %         disp(sum(abs(tempError.fruc.FBP(1:15))))

    %
    close(1)
    
    % sucrose
    openfig('pE6_sucrose.fig');
    fh1 = figure(1);
    fh1.Position = [1 0.2370 0.8000 0.6917];
    % 
    data.sucr.exp.PEP = fh1.Children(9).Children(2).YData;
    data.sucr.exp.twoPG = fh1.Children(10).Children(2).YData;
    data.sucr.exp.threePG = fh1.Children(11).Children(2).YData;
    data.sucr.exp.GAP = fh1.Children(12).Children(2).YData;
    data.sucr.exp.DHAP = fh1.Children(13).Children(2).YData;
    data.sucr.exp.FBP = fh1.Children(14).Children(2).YData;
    data.sucr.exp.time = fh1.Children(14).Children(2).XData;
    % 
    data.sucr.sim.PEP = interp1(fh1.Children(9).Children(3).XData, fh1.Children(9).Children(3).YData, data.sucr.exp.time, 'spline');
    data.sucr.sim.twoPG = interp1(fh1.Children(10).Children(3).XData, fh1.Children(10).Children(3).YData, data.sucr.exp.time, 'spline');
    data.sucr.sim.threePG = interp1(fh1.Children(11).Children(3).XData, fh1.Children(11).Children(3).YData, data.sucr.exp.time, 'spline');
    data.sucr.sim.GAP = interp1(fh1.Children(12).Children(3).XData, fh1.Children(12).Children(3).YData, data.sucr.exp.time, 'spline');
    data.sucr.sim.DHAP = interp1(fh1.Children(13).Children(3).XData, fh1.Children(13).Children(3).YData, data.sucr.exp.time, 'spline');
    data.sucr.sim.FBP = interp1(fh1.Children(14).Children(3).XData, fh1.Children(14).Children(3).YData, data.sucr.exp.time, 'spline');
    %
    tempError.sucr.PEP = (data.sucr.sim.PEP - data.sucr.exp.PEP) ./ data.sucr.exp.PEP;
    tempError.sucr.twoPG = (data.sucr.sim.twoPG - data.sucr.exp.twoPG) ./ data.sucr.exp.twoPG;
    tempError.sucr.threePG = (data.sucr.sim.threePG - data.sucr.exp.threePG) ./ data.sucr.exp.threePG;
    tempError.sucr.GAP = (data.sucr.sim.GAP - data.sucr.exp.GAP) ./ data.sucr.exp.GAP;
    tempError.sucr.DHAP = (data.sucr.sim.DHAP - data.sucr.exp.DHAP) ./ data.sucr.exp.DHAP;
    tempError.sucr.FBP = (data.sucr.sim.FBP - data.sucr.exp.FBP) ./ data.sucr.exp.FBP;
    %
    close(1)
    
    % maltsoe
    openfig('pE6_maltose.fig');
    fh1 = figure(1);
    fh1.Position = [1 0.2370 0.8000 0.6917];
    % 
    data.malt.exp.PEP = fh1.Children(9).Children(2).YData;
    data.malt.exp.twoPG = fh1.Children(10).Children(2).YData;
    data.malt.exp.threePG = fh1.Children(11).Children(2).YData;
    data.malt.exp.GAP = fh1.Children(12).Children(2).YData;
    data.malt.exp.DHAP = fh1.Children(13).Children(2).YData;
    data.malt.exp.FBP = fh1.Children(14).Children(2).YData;
    data.malt.exp.time = fh1.Children(14).Children(2).XData;
    % 
    data.malt.sim.PEP = interp1(fh1.Children(9).Children(3).XData, fh1.Children(9).Children(3).YData, data.malt.exp.time, 'spline');
    data.malt.sim.twoPG = interp1(fh1.Children(10).Children(3).XData, fh1.Children(10).Children(3).YData, data.malt.exp.time, 'spline');
    data.malt.sim.threePG = interp1(fh1.Children(11).Children(3).XData, fh1.Children(11).Children(3).YData, data.malt.exp.time, 'spline');
    data.malt.sim.GAP = interp1(fh1.Children(12).Children(3).XData, fh1.Children(12).Children(3).YData, data.malt.exp.time, 'spline');
    data.malt.sim.DHAP = interp1(fh1.Children(13).Children(3).XData, fh1.Children(13).Children(3).YData, data.malt.exp.time, 'spline');
    data.malt.sim.FBP = interp1(fh1.Children(14).Children(3).XData, fh1.Children(14).Children(3).YData, data.malt.exp.time, 'spline');
    %
    tempError.malt.PEP = (data.malt.sim.PEP - data.malt.exp.PEP) ./ data.malt.exp.PEP;
    tempError.malt.twoPG = (data.malt.sim.twoPG - data.malt.exp.twoPG) ./ data.malt.exp.twoPG;
    tempError.malt.threePG = (data.malt.sim.threePG - data.malt.exp.threePG) ./ data.malt.exp.threePG;
    tempError.malt.GAP = (data.malt.sim.GAP - data.malt.exp.GAP) ./ data.malt.exp.GAP;
    tempError.malt.DHAP = (data.malt.sim.DHAP - data.malt.exp.DHAP) ./ data.malt.exp.DHAP;
    tempError.malt.FBP = (data.malt.sim.FBP - data.malt.exp.FBP) ./ data.malt.exp.FBP;
    %
    close(1)
end
% *3
% 
selError_fructose(9,1) = sum(abs(tempError.fruc.FBP(1:15)));
selError_fructose(9,2) = sum(abs(tempError.fruc.GAP(1:15)));
selError_fructose(9,3) = sum(abs(tempError.fruc.DHAP(1:15)));
selError_fructose(9,4) = sum(abs(tempError.fruc.threePG(1:15)));
selError_fructose(9,5) = sum(abs(tempError.fruc.twoPG(1:15)));
% selError_fructose(9,6) = sum(abs(tempError.fruc.PEP));
% 
selError_sucrose(9,1) = sum(abs(tempError.sucr.FBP));
selError_sucrose(9,2) = sum(abs(tempError.sucr.GAP));
selError_sucrose(9,3) = sum(abs(tempError.sucr.DHAP));
selError_sucrose(9,4) = sum(abs(tempError.sucr.threePG));
selError_sucrose(9,5) = sum(abs(tempError.sucr.twoPG));
selError_sucrose(9,6) = sum(abs(tempError.sucr.PEP));
% 
selError_maltose(9,1) = sum(abs(tempError.malt.FBP));
selError_maltose(9,2) = sum(abs(tempError.malt.GAP));
selError_maltose(9,3) = sum(abs(tempError.malt.DHAP));
selError_maltose(9,4) = sum(abs(tempError.malt.threePG));
selError_maltose(9,5) = sum(abs(tempError.malt.twoPG));
selError_maltose(9,6) = sum(abs(tempError.malt.PEP));
% % % % for i = 2:8
% % % %     if i == 2, i2 = 6; 
% % % %     elseif i == 3, i2 = 11; 
% % % %     elseif i == 4, i2 = 16; 
% % % %     elseif i == 5, i2 = 21; 
% % % %     elseif i == 6, i2 = 26; 
% % % %     elseif i == 7, i2 = 31; 
% % % %     elseif i == 8, i2 = 32; 
% % % %     end
% % % %     selError_maltose(i,1) = sum(abs(error_malt_cell{i2}.FBP));
% % % %     selError_maltose(i,2) = sum(abs(error_malt_cell{i2}.GAP));
% % % %     selError_maltose(i,3) = sum(abs(error_malt_cell{i2}.DHAP));
% % % %     selError_maltose(i,4) = sum(abs(error_malt_cell{i2}.threePG));
% % % %     selError_maltose(i,5) = sum(abs(error_malt_cell{i2}.twoPG));
% % % %     selError_maltose(i,6) = sum(abs(error_malt_cell{i2}.PEP));
% % % % end

%% recall data gapdh, carbon-specific estimation
clear tempError

for recalling_gapdh_Cspecific_loop = 1
    % fructose
    openfig('pE2_fructose.fig');
    fh1 = figure(1);
    fh1.Position = [1 0.2370 0.8000 0.6917];
    % fh1.Children(9).Title.String % PEP
    % fh1.Children(10).Title.String % 2PG
    % fh1.Children(11).Title.String % 3PG
    % fh1.Children(12).Title.String % GAP
    % fh1.Children(13).Title.String % DHAP
    % fh1.Children(14).Title.String % FBP
    % 
    % data.fruc.exp.PEP = fh1.Children(9).Children(2).YData;
    data.fruc.exp.twoPG = fh1.Children(10).Children(2).YData;
    data.fruc.exp.threePG = fh1.Children(11).Children(2).YData;
    data.fruc.exp.GAP = fh1.Children(12).Children(2).YData;
    data.fruc.exp.DHAP = fh1.Children(13).Children(2).YData;
    data.fruc.exp.FBP = fh1.Children(14).Children(2).YData;
    data.fruc.exp.time = fh1.Children(14).Children(2).XData;
    % 
    % data.fruc.sim.PEP = interp1(fh1.Children(9).Children(4).XData, fh1.Children(9).Children(4).YData, data.fruc.exp.time, 'spline');
    data.fruc.sim.twoPG = interp1(fh1.Children(10).Children(4).XData, fh1.Children(10).Children(4).YData, data.fruc.exp.time, 'spline');
    data.fruc.sim.threePG = interp1(fh1.Children(11).Children(4).XData, fh1.Children(11).Children(4).YData, data.fruc.exp.time, 'spline');
    data.fruc.sim.GAP = interp1(fh1.Children(12).Children(4).XData, fh1.Children(12).Children(4).YData, data.fruc.exp.time, 'spline');
    data.fruc.sim.DHAP = interp1(fh1.Children(13).Children(4).XData, fh1.Children(13).Children(4).YData, data.fruc.exp.time, 'spline');
    data.fruc.sim.FBP = interp1(fh1.Children(14).Children(4).XData, fh1.Children(14).Children(4).YData, data.fruc.exp.time, 'spline');
    %
    % tempError.fruc.PEP = (data.fruc.sim.PEP - data.fruc.exp.PEP) ./ data.fruc.exp.PEP;
    tempError.fruc.twoPG = (data.fruc.sim.twoPG - data.fruc.exp.twoPG) ./ data.fruc.exp.twoPG;
    tempError.fruc.threePG = (data.fruc.sim.threePG - data.fruc.exp.threePG) ./ data.fruc.exp.threePG;
    tempError.fruc.GAP = (data.fruc.sim.GAP - data.fruc.exp.GAP) ./ data.fruc.exp.GAP;
    tempError.fruc.DHAP = (data.fruc.sim.DHAP - data.fruc.exp.DHAP) ./ data.fruc.exp.DHAP;
    tempError.fruc.FBP = (data.fruc.sim.FBP - data.fruc.exp.FBP) ./ data.fruc.exp.FBP;

        disp('gapdh frcutose-specific')
        disp(data.fruc.exp.FBP)
        disp(data.fruc.sim.FBP)
        disp(tempError.fruc.FBP)
        disp(sum(abs(tempError.fruc.FBP(1:15))))
    %
    close(1)
    
    % sucrose
    openfig('pE2_sucrose.fig');
    fh1 = figure(1);
    fh1.Position = [1 0.2370 0.8000 0.6917];
    % 
    data.sucr.exp.PEP = fh1.Children(9).Children(2).YData;
    data.sucr.exp.twoPG = fh1.Children(10).Children(2).YData;
    data.sucr.exp.threePG = fh1.Children(11).Children(2).YData;
    data.sucr.exp.GAP = fh1.Children(12).Children(2).YData;
    data.sucr.exp.DHAP = fh1.Children(13).Children(2).YData;
    data.sucr.exp.FBP = fh1.Children(14).Children(2).YData;
    data.sucr.exp.time = fh1.Children(14).Children(2).XData;
    % 
    data.sucr.sim.PEP = interp1(fh1.Children(9).Children(4).XData, fh1.Children(9).Children(4).YData, data.sucr.exp.time, 'spline');
    data.sucr.sim.twoPG = interp1(fh1.Children(10).Children(4).XData, fh1.Children(10).Children(4).YData, data.sucr.exp.time, 'spline');
    data.sucr.sim.threePG = interp1(fh1.Children(11).Children(4).XData, fh1.Children(11).Children(4).YData, data.sucr.exp.time, 'spline');
    data.sucr.sim.GAP = interp1(fh1.Children(12).Children(4).XData, fh1.Children(12).Children(4).YData, data.sucr.exp.time, 'spline');
    data.sucr.sim.DHAP = interp1(fh1.Children(13).Children(4).XData, fh1.Children(13).Children(4).YData, data.sucr.exp.time, 'spline');
    data.sucr.sim.FBP = interp1(fh1.Children(14).Children(4).XData, fh1.Children(14).Children(4).YData, data.sucr.exp.time, 'spline');
    %
    tempError.sucr.PEP = (data.sucr.sim.PEP - data.sucr.exp.PEP) ./ data.sucr.exp.PEP;
    tempError.sucr.twoPG = (data.sucr.sim.twoPG - data.sucr.exp.twoPG) ./ data.sucr.exp.twoPG;
    tempError.sucr.threePG = (data.sucr.sim.threePG - data.sucr.exp.threePG) ./ data.sucr.exp.threePG;
    tempError.sucr.GAP = (data.sucr.sim.GAP - data.sucr.exp.GAP) ./ data.sucr.exp.GAP;
    tempError.sucr.DHAP = (data.sucr.sim.DHAP - data.sucr.exp.DHAP) ./ data.sucr.exp.DHAP;
    tempError.sucr.FBP = (data.sucr.sim.FBP - data.sucr.exp.FBP) ./ data.sucr.exp.FBP;
    %
    close(1)
    
    % maltsoe
    openfig('pE2_maltose.fig');
    fh1 = figure(1);
    fh1.Position = [1 0.2370 0.8000 0.6917];
    % 
    data.malt.exp.PEP = fh1.Children(9).Children(2).YData;
    data.malt.exp.twoPG = fh1.Children(10).Children(2).YData;
    data.malt.exp.threePG = fh1.Children(11).Children(2).YData;
    data.malt.exp.GAP = fh1.Children(12).Children(2).YData;
    data.malt.exp.DHAP = fh1.Children(13).Children(2).YData;
    data.malt.exp.FBP = fh1.Children(14).Children(2).YData;
    data.malt.exp.time = fh1.Children(14).Children(2).XData;
    % 
    data.malt.sim.PEP = interp1(fh1.Children(9).Children(4).XData, fh1.Children(9).Children(4).YData, data.malt.exp.time, 'spline');
    data.malt.sim.twoPG = interp1(fh1.Children(10).Children(4).XData, fh1.Children(10).Children(4).YData, data.malt.exp.time, 'spline');
    data.malt.sim.threePG = interp1(fh1.Children(11).Children(4).XData, fh1.Children(11).Children(4).YData, data.malt.exp.time, 'spline');
    data.malt.sim.GAP = interp1(fh1.Children(12).Children(4).XData, fh1.Children(12).Children(4).YData, data.malt.exp.time, 'spline');
    data.malt.sim.DHAP = interp1(fh1.Children(13).Children(4).XData, fh1.Children(13).Children(4).YData, data.malt.exp.time, 'spline');
    data.malt.sim.FBP = interp1(fh1.Children(14).Children(4).XData, fh1.Children(14).Children(4).YData, data.malt.exp.time, 'spline');
    %
    tempError.malt.PEP = (data.malt.sim.PEP - data.malt.exp.PEP) ./ data.malt.exp.PEP;
    tempError.malt.twoPG = (data.malt.sim.twoPG - data.malt.exp.twoPG) ./ data.malt.exp.twoPG;
    tempError.malt.threePG = (data.malt.sim.threePG - data.malt.exp.threePG) ./ data.malt.exp.threePG;
    tempError.malt.GAP = (data.malt.sim.GAP - data.malt.exp.GAP) ./ data.malt.exp.GAP;
    tempError.malt.DHAP = (data.malt.sim.DHAP - data.malt.exp.DHAP) ./ data.malt.exp.DHAP;
    tempError.malt.FBP = (data.malt.sim.FBP - data.malt.exp.FBP) ./ data.malt.exp.FBP;
    %
    close(1)
end
% *3
% 
selError_fructose(10,1) = sum(abs(tempError.fruc.FBP(1:15)));
selError_fructose(10,2) = sum(abs(tempError.fruc.GAP(1:15)));
selError_fructose(10,3) = sum(abs(tempError.fruc.DHAP(1:15)));
selError_fructose(10,4) = sum(abs(tempError.fruc.threePG(1:15)));
selError_fructose(10,5) = sum(abs(tempError.fruc.twoPG(1:15)));
% selError_fructose(10,6) = sum(abs(tempError.fruc.PEP(1:15)));
% 
selError_sucrose(10,1) = sum(abs(tempError.sucr.FBP));
selError_sucrose(10,2) = sum(abs(tempError.sucr.GAP));
selError_sucrose(10,3) = sum(abs(tempError.sucr.DHAP));
selError_sucrose(10,4) = sum(abs(tempError.sucr.threePG));
selError_sucrose(10,5) = sum(abs(tempError.sucr.twoPG));
selError_sucrose(10,6) = sum(abs(tempError.sucr.PEP));
% 
selError_maltose(10,1) = sum(abs(tempError.malt.FBP));
selError_maltose(10,2) = sum(abs(tempError.malt.GAP));
selError_maltose(10,3) = sum(abs(tempError.malt.DHAP));
selError_maltose(10,4) = sum(abs(tempError.malt.threePG));
selError_maltose(10,5) = sum(abs(tempError.malt.twoPG));
selError_maltose(10,6) = sum(abs(tempError.malt.PEP));


%% (additions made later) recall data lower glucolysis enzymes
% load all data
load('pE7_sims_safecopy.mat',...
    "sims_gluc_7","sims_fruc_7","sims_sucr_7","sims_malt_7",...
    "error_gluc_cell_7","error_fruc_cell_7","error_sucr_cell_7","error_malt_cell_7")

% create the zeros
added_error_pE7 = zeros(4,6);
[s1,s2] = size(selError_fructose);
if s1 == 10
    selError_fructose = [selError_fructose; added_error_pE7];
    selError_sucrose = [selError_sucrose; added_error_pE7];
    selError_maltose = [selError_maltose; added_error_pE7];
elseif s1 == 14
    selError_fructose(11:14,1:3) = zeros(4,6);
    selError_sucrose(11:14,1:3) = zeros(4,6);
    selError_maltose(11:14,1:3) = zeros(4,6);
else
    disp('something went wrong')
end

% Recall the error
for o = 11:14
    o_2 = o - 8;
    % 
    selError_fructose(o,1) = sum(abs(error_fruc_cell_7{o_2}.FBP));
    selError_fructose(o,2) = sum(abs(error_fruc_cell_7{o_2}.GAP));
    selError_fructose(o,3) = sum(abs(error_fruc_cell_7{o_2}.DHAP));
    selError_fructose(o,4) = sum(abs(error_fruc_cell_7{o_2}.threePG));
    selError_fructose(o,5) = sum(abs(error_fruc_cell_7{o_2}.twoPG));
%     selError_fructose(o,6) = sum(abs(error_fruc_cell_7{o_2}.PEP));
    % 
    selError_sucrose(o,1) = sum(abs(error_sucr_cell_7{o_2}.FBP));
    selError_sucrose(o,2) = sum(abs(error_sucr_cell_7{o_2}.GAP));
    selError_sucrose(o,3) = sum(abs(error_sucr_cell_7{o_2}.DHAP));
    selError_sucrose(o,4) = sum(abs(error_sucr_cell_7{o_2}.threePG));
    selError_sucrose(o,5) = sum(abs(error_sucr_cell_7{o_2}.twoPG));
    selError_sucrose(o,6) = sum(abs(error_sucr_cell_7{o_2}.PEP));
    % 
    selError_maltose(o,1) = sum(abs(error_malt_cell_7{o_2}.FBP));
    selError_maltose(o,2) = sum(abs(error_malt_cell_7{o_2}.GAP));
    selError_maltose(o,3) = sum(abs(error_malt_cell_7{o_2}.DHAP));
    selError_maltose(o,4) = sum(abs(error_malt_cell_7{o_2}.threePG));
    selError_maltose(o,5) = sum(abs(error_malt_cell_7{o_2}.twoPG));
    selError_maltose(o,6) = sum(abs(error_malt_cell_7{o_2}.PEP));
end





%% plot the combinatorial
% show by sugars and (i) fbp, (ii) gap + dhap, (iii) 3pg+2pg+pep

% figures
if exist('fh_600061','var')
    clf(fh_600061)
end
fh_600061 = figure(600061);
fh_600061.Position = [1991 584 946 393];
% fh_600061.Position = [1970 573 1120 400];
% fh_600061.Position = [69 466 805 467];
% 
idxs_shift = [1,2, 5,6,7, 4,3, 8,9,10, 11,12,13,14];
selError_fructose2 = selError_fructose(idxs_shift,:);
selError_sucrose2 = selError_sucrose(idxs_shift,:);
selError_maltose2 = selError_maltose(idxs_shift,:);
%  colormap
colGluc = [0 0.4470 0.7410];
colFruc = [0.8500 0.3250 0.0980];
colSucr = [0.9290 0.6940 0.1250];
colMalt = [0.4940 0.1840 0.5560];
% 
fruc2plot = [selError_fructose2(:,1), selError_fructose2(:,2) + selError_fructose2(:,3),  selError_fructose2(:,4) +  selError_fructose2(:,5) + selError_fructose2(:,6)];
sucr2plot = [selError_sucrose2(:,1), selError_sucrose2(:,2) + selError_sucrose2(:,3),  selError_sucrose2(:,4) +  selError_sucrose2(:,5) + selError_sucrose2(:,6)];
malt2plot = [selError_maltose2(:,1), selError_maltose2(:,2) + selError_maltose2(:,3),  selError_maltose2(:,4) +  selError_maltose2(:,5) + selError_maltose2(:,6)];
xvalues = {'FBP','GAP + DHAP','3PG + 2PG + PEP'};
yvalues_f = {'Initial','NR','NR + PGI',...
           'NR + PFK','NR + ALD','NR + UG','NR + TRE','NR + TRE + UG','NR + GAPDH','NR + GAPDH_{CSD}',...
           'NR + PGK','NR + PGM','NR + ENO','NR + PYK'};
yvalues_s = {'Initial','NR','NR + PGI',...
           'NR + PFK','NR + ALD','NR + UG','NR + TRE','NR + TRE + UG','NR + GAPDH','NR + GAPDH_{CSD}',...
           'NR + PGK','NR + PGM','NR + ENO','NR + PYK'};
yvalues_m = {'Initial','NR','NR + PGI',...
           'NR + PFK','NR + ALD','NR + UG','NR + TRE','NR + TRE + UG','NR + GAPDH','NR + GAPDH_{CSD}',...
           'NR + PGK','NR + PGM','NR + ENO','NR + PYK'};
sp1 = subplot(1,3,1); 
    hm1 = heatmap(xvalues,yvalues_f,fruc2plot,'CellLabelColor','none');
    hm1.Title = 'Fructose';
    caxis([0, 30]);
    hm1.Colormap(:,1) = linspace(0.9,0.850,256)';
    hm1.Colormap(:,2) = linspace(0.9447,0.325,256)';
    hm1.Colormap(:,3) = linspace(0.9741,0.098,256)';
sp2 = subplot(1,3,2); 
    hm2 = heatmap(xvalues,yvalues_s,sucr2plot,'CellLabelColor','none');
    hm2.Title = 'Sucrose';
    caxis([0, 30]);
    hm2.Colormap(:,1) = linspace(0.9,0.929,256)';
    hm2.Colormap(:,2) = linspace(0.9447,0.694,256)';
    hm2.Colormap(:,3) = linspace(0.9741,0.125,256)';
sp3 = subplot(1,3,3); 
    hm3 = heatmap(xvalues,yvalues_m,malt2plot,'CellLabelColor','none');
    hm3.Title = 'Maltose';
    caxis([0, 30]);
    hm3.Colormap(:,1) = linspace(0.9,0.494,256)';
    hm3.Colormap(:,2) = linspace(0.9447,0.184,256)';
    hm3.Colormap(:,3) = linspace(0.9741,0.556,256)';
%     hm3.Colormap = zeros(256,3);
%     hm3.XLabel = 'Enzymes optimized';
%     hm3.YLabel = 'Metabolite model fit';
    
% explain 'initial', 'NR, new reactions', 'CSD' in caption, grey for the
% reference

% % % % % 
% % % % % %% save current figure
% % % % % % print(fh_600061,'-dpdf','E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F6Adata');
% % % % % print(fh_600061,'-dtiff','E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F6Adata');
% % % % % savefig(fh_600061,'E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F6Adata');
% % % % % % 
% % % % % set(fh_600061,'Units','Inches');
% % % % % pos = get(fh_600061,'Position');
% % % % % set(fh_600061,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% % % % % print(fh_600061,'E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F6Adata','-dpdf','-r0')


%% regularization + change in GAPDH
clc, close all, clear
for recalling_data = 1

    % % PEST5_
    % simplify almost all inside the cost function. Outside just the initial
    % parameter set, estimation setup and later visualization
    
    % %% Initial recall
    clear; close all; clc;
    set_paths;
    dbstop if error
    
    % initial setup
    setup.clamp10.FBP = 0;
    setup.sameKm = 1;
    plotflag = 0; 
    
    % parameter set
    % load('x1_initial.mat','x1BSucr','x1AFruct')
    % x = x1BSucr;
    load('x_Y3M3_2.mat','x_Y3M3_2')
    x = x_Y3M3_2;
    % reference parameter set
    load('pset_pE10_xres.mat','x_pE10_end'); 
    xref = zeros(1,184); xref(1:165) = x_pE10_end;
    
    % % testSimulation
    % plotflag = 11; 
    % simulate_all
    % plotflag = 0;
    
    % % test cost function
    % plotflag = 11; % 11 = simulations per dataset, 12 = cost function visual 
    % lambda = 0; 
    % w = zeros(499,1);
    % selPars = 100;
    % x_temp = x(100);
    % [error] = costfun_FF01_all(x_temp,setup,x,plotflag,selPars,lambda,w);
    % plotflag = 0;
    
    % %% Parameter estimation setup
    
    % 1 control case (some with ALD)
    % 2 ref + ALD. fructose-specific
    % 2 ref + ALD. sucrose-specific
    % 2 ref + ALD. maltose-specific
    % 3 only ALD. fructose-specific
    
    % 3 only ALD. sucrose-specific
    % 3 only ALD. maltsoe-specific
    % 4 ref + GAPDH fit all
    % 4 ref + GAPDH fit all + gap + dhap
    % 4 ref + GAPDH fit all + gap + dhap. fructose-specific
    
    % 4 ref + GAPDH fit all + gap + dhap. sucrose-specific
    % 4 ref + GAPDH fit all + gap + dhap. maltose-specific
    % 5 only GAPDH fit all + gap + dhap. fructose-specific
    % 5 only GAPDH fit all + gap + dhap. sucrose-specific
    % 5 only GAPDH fit all + gap + dhap. maltose-specific
    
    % 6 ref + ALD + TRE. fructose-specific
    % 6 ref + ALD + TRE. sucrose-specific
    % 6 ref + ALD + TRE. maltose-specific
    % 7 ref + GAPDH + TRE. fructose-specific
    % 7 ref + GAPDH + TRE. sucrose-specific
    
    % 7 ref + GAPDH + TRE. maltose-specific
    
    % optimOptions
    options = optimoptions('lsqnonlin','Display','iter',...
        'FunctionTolerance', 1e-4, 'OptimalityTolerance', 1e-4,...
        'DiffMinChange',0.1);
    
    % % 
    nS1 = 20;
    % saveNames
    saveNames = cell(nS1,1);
    % case 1. ref + gapdh
    saveNames{1} = 'pE6_ref_gapdh_lam1.mat';
    saveNames{2} = 'pE6_ref_gapdh_lam2.mat';
    saveNames{3} = 'pE6_ref_gapdh_lam3.mat';
    saveNames{4} = 'pE6_ref_gapdh_lam4.mat';
    saveNames{5} = 'pE6_ref_gapdh_lam5.mat';
    saveNames{6} = 'pE6_ref_gapdh_lam6.mat';
    saveNames{7} = 'pE6_ref_gapdh_lam7.mat';
    saveNames{8} = 'pE6_ref_gapdh_lam8.mat';
    saveNames{9} = 'pE6_ref_gapdh_lam9.mat';
    saveNames{10} = 'pE6_ref_gapdh_lam10.mat';
    % case 2. gapdh
    saveNames{11} = 'pE6_gapdh_lam1.mat';
    saveNames{12} = 'pE6_gapdh_lam2.mat';
    saveNames{13} = 'pE6_gapdh_lam3.mat';
    saveNames{14} = 'pE6_gapdh_lam4.mat';
    saveNames{15} = 'pE6_gapdh_lam5.mat';
    saveNames{16} = 'pE6_gapdh_lam6.mat';
    saveNames{17} = 'pE6_gapdh_lam7.mat';
    saveNames{18} = 'pE6_gapdh_lam8.mat';
    saveNames{19} = 'pE6_gapdh_lam9.mat';
    saveNames{20} = 'pE6_gapdh_lam10.mat';
    
    % parCombs
    parINV = [177 178];
        parHXT_glc = [36 38 166];
        parHXT_fruc = [167 169 170];
        parHXT_malt = [179 180 181 182];
    parHXT = [parHXT_glc, parHXT_fruc, parHXT_malt]; 
    parMALX = [183 184];
        parHXK_glc = [28 29 30 31 32 33 34 171];
        parHXK_fruc = [172 173 174 175 176];
    parHXK = [parHXK_glc, parHXK_fruc]; 
        parPGM1 = 83:86;
        parTPS1 = 124:128;
    parGAPDH = 21:27;
    %     parTPS2 = 119:121;
    %     parNTH1 = 122:123;
    %     parUGP = 144:148;
    %     parATH = 149:150;
    %     parAGT1 = [151:154,158];
    %     parvacT = 155:157;
    parTRE = [parPGM1, parTPS1];
    parPGI = [57:60];
    parPFK = [43:56,87];
    parALD = [11:15];
    parTPI = [79:82];
    parUG = [parPGI,parPFK,parALD,parTPI];
    % 
    par_ref = [parHXT, parHXK, parINV, parMALX]; 
    % 
    parSet1 = [par_ref, parALD]; 
    parSet2 = [par_ref, parALD]; 
    parSet3 = parALD; 
    parSet4 = [par_ref, parGAPDH]; 
    parSet5 = parGAPDH;
    parSet6 = [par_ref, parALD, parTRE]; 
    parSet7 = [par_ref, parGAPDH, parTRE]; 
    
    % % 
    parCombs = cell(nS1,1);
    % case 1. ref + gapdh
    parCombs{1} = parSet4;
    parCombs{2} = parSet4;
    parCombs{3} = parSet4;
    parCombs{4} = parSet4;
    parCombs{5} = parSet4;
    parCombs{6} = parSet4;
    parCombs{7} = parSet4;
    parCombs{8} = parSet4;
    parCombs{9} = parSet4;
    parCombs{10} = parSet4;
    % case 2. gapdh
    parCombs{11} = parSet5;
    parCombs{12} = parSet5;
    parCombs{13} = parSet5;
    parCombs{14} = parSet5;
    parCombs{15} = parSet5;
    parCombs{16} = parSet5;
    parCombs{17} = parSet5;
    parCombs{18} = parSet5;
    parCombs{19} = parSet5;
    parCombs{20} = parSet5;
    
    % warray
    wsugars = [101 201 301 302 401];
    wfbp = [109 206 307 406];
    wsugars_fbp = [wsugars, wfbp];
    wlg = [112 209 310 409];
    wsugars_fbp_lg = [wsugars_fbp, wlg];
    wtre = [104 203 304 403];
    wsugars_fbp_tre = [wsugars_fbp, wtre];
    wrates = [120 220 320 420];
    % wsugars_fbp_rates = [wsugars_fbp, wrates];
    wall = [wsugars, wfbp, wlg, wtre, wrates];
    wgap = [111 208 309 408];
    wdhap = [110 207 308 407];
    % 
    wbaseline = zeros(499,1);
    warray = cell(nS1,1);
    for i = 1:length(warray)
        warray{i} = wbaseline;
    end
    % case 1. ref + gapdh
    warray{1}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
    warray{2}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
    warray{3}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
    warray{4}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
    warray{5}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
    warray{6}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
    warray{7}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
    warray{8}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
    warray{9}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
    warray{10}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
    % case 2. gapdh
    warray{11}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
    warray{12}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
    warray{13}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
    warray{14}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
    warray{15}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
    warray{16}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
    warray{17}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
    warray{18}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
    warray{19}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
    warray{20}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
    
    % lambdalist
    lambdalist = [1E-2 2E-2 5E-2 1E-1 3E-1 2E-1 5E-1 1E0 2E0 5E0,...
                  1E-2 2E-2 5E-2 1E-1 3E-1 2E-1 5E-1 1E0 2E0 5E0];
        
%     %% visualization
    % recall info
    xAll = []; 
    nS = 20;
    for i = 1:nS
        selPars = parCombs{i};
        if i == 1
            xres = [-0.6351   -2.0515   -1.7499   -0.3833    0.2063    0.5972    1.0723,...
               -0.9987    0.5251   -0.9790   -0.4417   -0.3899   -2.2160    1.9746,...
               -1.3476   -0.4593    0.8159   -0.2272   -2.5092    2.0363    0.0167,...
                1.2723   -2.9900    0.5194   -3.1886   -2.2366   -0.9932    0.9899,...
                0.3648    2.7942   -0.5192   -0.5364    0.1949    0.1099];
        elseif i == 2
            xres = [-0.6253   -2.0460   -1.7533   -0.3848    0.2222    0.6003    1.0651,...
               -1.0013    0.5369   -0.9691   -0.4630   -0.4256   -2.2749    1.9923,...
               -1.3692   -0.4911    0.8432   -0.2491   -2.5008    2.0291    0.0060,...
                1.2572   -3.0083    0.5408   -3.2077   -2.2395   -0.9728    1.0102,...
                0.3690    2.7932   -0.5099   -0.5588    0.1945    0.1269];
        elseif i == 3
            xres = [-0.6173   -2.0422   -1.7530   -0.3880    0.2296    0.6003    1.0608,...
               -1.0046    0.5426   -0.9686   -0.4671   -0.4374   -2.3008    1.9932,...
               -1.3800   -0.5022    0.8493   -0.2498   -2.5007    2.0287    0.0053,...
                1.2566   -3.0092    0.5413   -3.2087   -2.2396   -0.9613    1.0140,...
                0.3694    2.7934   -0.5040   -0.5647    0.1940    0.1335];
        elseif i == 4
            xres = [-0.6154   -2.0415   -1.7529   -0.3886    0.2309    0.6003    1.0601,...
               -1.0052    0.5436   -0.9685   -0.4677   -0.4394   -2.3052    1.9933,...
               -1.3818   -0.5042    0.8505   -0.2499   -2.5007    2.0287    0.0052,...
                1.2566   -3.0093    0.5414   -3.2088   -2.2396   -0.9593    1.0146,...
                0.3695    2.7934   -0.5030   -0.5657    0.1940    0.1347];
        elseif i == 5
            xres = [-0.6271   -2.0478   -1.7526   -0.3861    0.2224    0.5991    1.0644,...
               -1.0024    0.5369   -0.9694   -0.4608   -0.4238   -2.2748    1.9925,...
               -1.3675   -0.4900    0.8409   -0.2494   -2.4998    2.0276    0.0080,...
                1.2590   -3.0058    0.5405   -3.2050   -2.2380   -0.9709    1.0075,...
                0.3679    2.7909   -0.5091   -0.5568    0.1966    0.1271];
        elseif i == 6
            xres = [-0.6211   -2.0440   -1.7530   -0.3869    0.2269    0.6002    1.0623,...
               -1.0034    0.5405   -0.9688   -0.4654   -0.4329   -2.2915    1.9931,...
               -1.3759   -0.4980    0.8468   -0.2498   -2.5008    2.0286    0.0057,...
                1.2571   -3.0087    0.5412   -3.2082   -2.2394   -0.9653    1.0123,...
                0.3691    2.7931   -0.5061   -0.5622    0.1945    0.1311];
        elseif i == 7
            xres = [-0.6224   -2.0448   -1.7526   -0.3868    0.2258    0.5997    1.0626,...
               -1.0029    0.5396   -0.9683   -0.4643   -0.4303   -2.2873    1.9929,...
               -1.3740   -0.4962    0.8452   -0.2497   -2.4993    2.0275    0.0059,...
                1.2565   -3.0068    0.5409   -3.2061   -2.2383   -0.9663    1.0108,...
                0.3687    2.7915   -0.5067   -0.5606    0.1946    0.1301];
        elseif i == 8
            xres = [-0.6620   -2.0712   -1.6647   -0.4277    0.1737    0.5549    1.0444,...
               -0.9868    0.5234   -0.9124   -0.4342   -0.3377   -2.0822    1.9683,...
               -1.3156   -0.4435    0.7999   -0.2311   -2.3640    1.9152    0.0184,...
                1.1938   -2.8312    0.5033   -3.0202   -2.1523   -0.9921    0.9313,...
                0.3592    2.6386   -0.5429   -0.4855    0.1895    0.0991];
        elseif i == 9
            xres = [-0.7328   -1.8603   -0.4969   -0.5928    0.0591    0.1233    0.1437,...
               -0.6392    0.3807   -0.1937   -0.1136    0.1585   -1.6952    1.6621,...
               -2.1339   -1.3797    0.9653   -0.0231   -0.4104    0.3124    0.0114,...
                0.1821   -0.4615    0.4591   -0.8551   -0.6997   -0.5416    0.3064,...
                0.4166    0.1952   -0.8857   -0.0240   -0.2469    0.0467];
        elseif i == 10
            xres = [-0.6895   -1.5166    0.0018   -0.3501    0.2948    0.0652   -0.0750,...
               -0.4697    0.4989   -0.0360   -0.1768    0.4183   -2.3413    1.6208,...
               -2.6955   -2.3144    1.0809   -0.0000   -0.0009    0.0010   -0.1850,...
                0.1838   -0.0006    0.0368   -0.0392    0.0610   -0.1053    0.0082,...
                0.3911    0.0781   -0.6469    0.2936   -0.2898    0.0616];
        elseif i == 11
            xres = [0.9229    0.5335    2.1355   -0.5430   -0.3401    0.2348    0.3240];
        elseif i == 12
            xres = [1.3047    0.4717    2.3058   -0.6424   -0.4965    0.1785    0.2524];
        elseif i == 13
            xres = [1.0209    0.5211    2.2401   -0.6472   -0.3287    0.2269    0.3077];
        elseif i == 14
            xres = [0.9535    0.5366    2.1526   -0.6299   -0.3685    0.2189    0.3224];
        elseif i == 15
            xres = [0.0967    0.8649    0.4583   -0.5971    0.2100    0.1204    0.6331];
        elseif i == 16
            xres = [0.5471    0.6505    1.7256   -0.4642   -0.1391    0.2421    0.4464];
        elseif i == 17
            xres = [-0.0183    0.9293    0.1325   -0.4040    0.2759   -0.0843    0.6749];
        elseif i == 18
            xres = [0.0163    0.7864    0.1312   -0.4150    0.2767   -0.2537    0.5164];
        elseif i == 19
            xres = [-0.0138    0.5539    0.0067   -0.3851    0.2789   -0.2653    0.2898];
        elseif i == 20
            xres = [-0.0140    0.3929    0.0082   -0.3877    0.2791   -0.2681    0.1713];
        end
        x2 = x;
        x2(selPars) = xres;
        xAll = [xAll; x2];
    end
    
end
% 
load('pE6_sims_safecopy.mat',"sim_ref_gluc","sim_ref_fruc","sim_ref_sucr","sim_ref_malt",...
    "sims_gluc","sims_fruc","sims_sucr","sims_malt")
sims_gluc = sims_gluc';
sims_fruc = sims_fruc';
sims_sucr = sims_sucr';
sims_malt = sims_malt';


%% error data
load('pE6_sims_safecopy_withErrors.mat',...
    "error_ref","error_gluc_ref","error_fruc_ref","error_sucr_ref","error_malt_ref",...
    "error_cell","error_gluc_cell","error_fruc_cell","error_sucr_cell","error_malt_cell")
% reference parameter set
load('pset_pE10_xres.mat','x_pE10_end'); 
xref = zeros(1,184); xref(1:165) = x_pE10_end;

% lambdalist
lambdalist = [1E-2 2E-2 5E-2 1E-1 3E-1 2E-1 5E-1 1E0 2E0 5E0];
% errorData % warray{11}([201 206 209 203 220 208 207])
len = length(lambdalist); %10;
errorData = zeros(1,len);
for i = 11:20
    i2 = i - 10;
    errorData(i2) = [sum(abs(error_fruc_cell{i}.FRUCec)) + ...
                    sum(abs(error_fruc_cell{i}.T6P)) + ...
                    sum(abs(error_fruc_cell{i}.FBP)) + ...
                    sum(abs(error_fruc_cell{i}.DHAP)) + ...
                    sum(abs(error_fruc_cell{i}.GAP)) + ...
                    sum(abs(error_fruc_cell{i}.threePG)) + ...
                    sum(abs(error_fruc_cell{i}.uptake))];
end
% errorParameters
parGAPDH = 21:27; % parGAPDH
errorParameters = zeros(1,len);
for i = 11:20
    i2 = i - 10;
    errorParameters(i2) = sum(abs(xAll(i,parGAPDH) - xref(parGAPDH)));
end


%% examine. Taking the 3rd case as an example
% figures
if exist('fh_600062','var')
    clf(fh_600062)
end
fh_600062 = figure(600062);
% fh_600062.Position = [111 105 1608 840];
fh_600062.Position = [1989 636 721 292];

% 
subplot(1,2,1)
correctorder = [1:4,6,5,7:10];
% area([0.1 1],[34.5 35])
% hold on
p1 = semilogx(lambdalist(correctorder),errorData(correctorder),'k--o','MarkerFaceColor','k');
% plot(lambdalist(9),errorData(9),'b--o','MarkerFaceColor','b');
xlabel('Regulatization Factor')
ylabel('Model Error')
yyaxis right
p2 = semilogx(lambdalist(correctorder),errorParameters(correctorder),'k--o','MarkerFaceColor','w');
set(gca,'YColor', 'k');
ylabel('Parameter Deviation')
legend([p1 p2], 'Model Error', 'Parameter Deviation')
% 
dim2 = [.35 .255 .025 .115];
a_temp = annotation('rectangle',dim2,'FaceColor','k','FaceAlpha',.2,'Color','none');


% 
subplot(1,2,2)
% 
names = {'K_{eq}','K_{M,GAP}','K_{M,BPG}','K_{M,NAD}','K_{M,NADH}','K_{M,PI}','K_{cat}'};
% plot(1:7,xref(parSet5),'o-',"Color",[.7 .7 .7],"MarkerFaceColor",[.7 .7 .7],"MarkerEdgeColor",[.7 .7 .7])
p0 = line([0 8], [0 0], 'Color', 'k', 'LineStyle', '--');
hold on
p1 = plot(1:7,xAll(11,parSet5)- xref(parSet5),'o-',"Color",'k',"MarkerFaceColor",'w',"MarkerEdgeColor",'k');
hold on
p2 = plot(1:7,xAll(19,parSet5)- xref(parSet5),'o-',"Color",'k',"MarkerFaceColor",'k',"MarkerEdgeColor",'k');
xticks(1:7)
xticklabels(parSet5)
xlim([0 8])
ylim([-3 3])
box on
ylabel('Reference Parameter Set Deviation (log10 scale)')
xticklabels(names)
xtickangle(60)
legend([p0 p1 p2],'reference','non regularized','regularized')



%% figure 6C, trehalose, pgm1 (alone) vs tps1 and pgm1

% % % % recall exp data
% % clear
% % close all
% % % fruc
% % openfig('pE2_fructose.fig')
% % fh1 = figure(1);
% % exp_data.fruc.time = fh1.Children(20).Children(2).XData;
% % exp_data.fruc.conc = fh1.Children(20).Children(2).YData;
% % close(1)
% % 
% % % sucr
% % openfig('pE2_sucrose.fig')
% % fh1 = figure(1);
% % exp_data.sucr.time = fh1.Children(20).Children(2).XData;
% % exp_data.sucr.conc = fh1.Children(20).Children(2).YData;
% % close(1)
% % 
% % % malt
% % openfig('pE2_maltose.fig')
% % fh1 = figure(1);
% % exp_data.malt.time = fh1.Children(20).Children(2).XData;
% % exp_data.malt.conc = fh1.Children(20).Children(2).YData;
% % close(1)
% % 
% % % % recall pgm1 case (pE4)
% % load('pE4_simData.mat')
% % % saveNames_4 = 
% % %     {'pE4_pgm1_all.mat'     }
% % %     {'pE4_pgm1_fructose.mat'}
% % %     {'pE4_pgm1_sucrose.mat' }
% % %     {'pE4_pgm1_maltose.mat' }
% % % 
% % idx_T6P = 26;
% % sim_data.pgm1.fruc.conc = interp1(sims_fruc{2}.T_1, sims_fruc{2}.Y_HugoCloudt_1(:,idx_T6P), exp_data.fruc.time,"pchip");
% % sim_data.pgm1.sucr.conc = interp1(sims_sucr{3}.T_1, sims_sucr{3}.Y_HugoCloudt_1(:,idx_T6P), exp_data.sucr.time,"pchip");
% % sim_data.pgm1.malt.conc = interp1(sims_malt{4}.T_1, sims_malt{4}.Y_HugoCloudt_1(:,idx_T6P), exp_data.malt.time,"pchip");
% % 
% % % % recall reference simualtions
% % sim_data.ref.fruc.conc = interp1(sim_ref_fruc{1}.T_1, sim_ref_fruc{1}.Y_HugoCloudt_1(:,idx_T6P), exp_data.fruc.time,"pchip");
% % sim_data.ref.sucr.conc = interp1(sim_ref_sucr{1}.T_1, sim_ref_sucr{1}.Y_HugoCloudt_1(:,idx_T6P), exp_data.sucr.time,"pchip");
% % sim_data.ref.malt.conc = interp1(sim_ref_malt{1}.T_1, sim_ref_malt{1}.Y_HugoCloudt_1(:,idx_T6P), exp_data.malt.time,"pchip");
% % 
% % % % recall pgm+tps1 case (pE3)
% % load('pE3_simData.mat')
% % % saveNames_3 = 
% % %     {'pE3_par1tre_all.mat'               }
% % %     {'pE3_par1tre_fructose.mat'          }
% % %     {'pE3_par1tre_sucrose.mat'           }
% % %     {'pE3_par1tre_maltose.mat'           }
% % %     {'pE3_par2tre_ref_all.mat'           }
% % %     {'pE3_par2tre_ref_fructose.mat'      }
% % %     {'pE3_par2tre_ref_sucrose.mat'       }
% % %     {'pE3_par2tre_ref_maltose.mat'       }
% % %     {'pE3_par3tre_ref_gapdh_all.mat'     }
% % %     {'pE3_par3tre_ref_gapdh_fructose.mat'}
% % %     {'pE3_par3tre_ref_gapdh_sucrose.mat' }
% % %     {'pE3_par3tre_ref_gapdh_maltose.mat' }
% % sim_data.pgm1_tps1.fruc.conc = interp1(sims_fruc{2}.T_1, sims_fruc{2}.Y_HugoCloudt_1(:,idx_T6P), exp_data.fruc.time,"pchip");
% % sim_data.pgm1_tps1.sucr.conc = interp1(sims_sucr{3}.T_1, sims_sucr{3}.Y_HugoCloudt_1(:,idx_T6P), exp_data.sucr.time,"pchip");
% % sim_data.pgm1_tps1.malt.conc = interp1(sims_malt{4}.T_1, sims_malt{4}.Y_HugoCloudt_1(:,idx_T6P), exp_data.malt.time,"pchip");
% % 
% % 
% % %%
% % figure
% % plot(sims_fruc{2}.T_1, sims_fruc{2}.Y_HugoCloudt_1(:,26))


% 
load('pE4_simData.mat',...
    'sims_gluc', 'sim_ref_gluc',...
    'sims_fruc', 'sim_ref_fruc',...
    'sims_sucr', 'sim_ref_sucr',...
    'sims_malt', 'sim_ref_malt',...
    'pE4_pgm1_fruc', 'pE4_pgm1_sucr', 'pE4_pgm1_malt', ...
    "saveNames_4")

% 
load('pE3_simData.mat',...
    'sims_gluc', 'sim_ref_gluc',...
    'sims_fruc', 'sim_ref_fruc',...
    'sims_sucr', 'sim_ref_sucr',...
    'sims_malt', 'sim_ref_malt',...
    'pE3_pgm1_tps1_fruc', 'pE3_pgm1_tps1_sucr', 'pE3_pgm1_tps1_malt', ...
    'pE3_exp_fruc', 'pE3_exp_sucr', 'pE3_exp_malt', ...
    'pE3_ref_fruc', 'pE3_ref_sucr', 'pE3_ref_malt', ...
    "saveNames_3")



%% calculate errors
error_data = zeros(3,3); %([ref,pgm1,pgm1+tps1],[fruc,sucr,malt])
    % fruc
    error_data(1,1) = sum(abs(pE3_ref_fruc(1:15) - pE3_exp_fruc(1:15)));
    error_data(2,1) = sum(abs(pE4_pgm1_fruc(1:15) - pE3_exp_fruc(1:15)));
    error_data(3,1) = sum(abs(pE3_pgm1_tps1_fruc(1:15) - pE3_exp_fruc(1:15)));
    % sucr
    error_data(1,2) = sum(abs(pE3_ref_sucr - pE3_exp_sucr));
    error_data(2,2) = sum(abs(pE4_pgm1_sucr - pE3_exp_sucr));
    error_data(3,2) = sum(abs(pE3_pgm1_tps1_sucr - pE3_exp_sucr));
    % malt
    error_data(1,3) = sum(abs(pE3_ref_malt - pE3_exp_malt));
    error_data(2,3) = sum(abs(pE4_pgm1_malt - pE3_exp_malt));
    error_data(3,3) = sum(abs(pE3_pgm1_tps1_malt - pE3_exp_malt));


%% plot as bar plots

% color
colGluc = [0 0.4470 0.7410];
colFruc = [0.8500 0.3250 0.0980];
colSucr = [0.9290 0.6940 0.1250];
colMalt = [0.4940 0.1840 0.5560];
colGluc_dark = colGluc/2;
colFruc_dark = colFruc/2;
colSucr_dark = colSucr/2;
colMalt_dark = colMalt/2;
colGluc_soft = colGluc + ([1 1 1] - colGluc)/3;
colFruc_soft = colFruc + ([1 1 1] - colFruc)/3;
colSucr_soft = colSucr + ([1 1 1] - colSucr)/3;
colMalt_soft = colMalt + ([1 1 1] - colMalt)/3;
%
labels = categorical({'GAPDH','PGM1','PGM1 + TPS1'});
labels = reordercats(labels,{'GAPDH','PGM1','PGM1 + TPS1'});

% figures
if exist('fh_600067','var')
    clf(fh_600067)
end
fh_600067 = figure(600067);
% fh_600067.Position = [1952 560 560 420];
fh_600067.Position = [1960 659 383 321];
% 
bh = bar(labels,error_data);
ylabel('Model error T6P (mM)')
xlabel('Enzymes parameters estimated')
% 
bh(1).FaceColor = colFruc;
bh(1).EdgeColor = colFruc_dark;
% 
bh(2).FaceColor = colSucr;
bh(2).EdgeColor = colSucr_dark;
% 
bh(3).FaceColor = colMalt;
bh(3).EdgeColor = colMalt_dark;
% 
lgd = legend('fructose','sucrose','maltose');
title(lgd,'FF dataset');


% % % % %% save current figure
% % % % % print(fh_600067,'-dpdf','E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F6Ddata');
% % % % print(fh_600067,'-dtiff','E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F6Ddata');
% % % % savefig(fh_600067,'E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F6Ddata');
% % % % % 
% % % % set(fh_600067,'Units','Inches');
% % % % pos = get(fh_600067,'Position');
% % % % set(fh_600067,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% % % % print(fh_600067,'E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F6Ddata','-dpdf','-r0')

