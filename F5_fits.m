% % PEST5_
% simplify almost all inside the cost function. Outside just the initial
% parameter set, estimation setup and later visualization

%% Initial recall
clear; close all; clc;
set_paths;
dbstop if error

% initial setup
setup.clamp10.FBP = 0;
setup.sameKm = 1;
plotflag = 0; 


% %  selecting parameter
% x_literature
load('pset_pE10_xres.mat','x_pE10_end'); 
x_literature = zeros(1,184); x_literature(1:165) = x_pE10_end;
% x_ug
load('x1_initial.mat','x1BSucr','x1AFruct')
x_ug = x1BSucr;
% x_gapdh
load('x_Y3M3_3.mat','x_Y3M3_3')
x_gapdh = x_Y3M3_3;
% x_tre
load('x_Y3M3_4.mat','x_fit_all','x_fit_fructose','x_fit_sucrose','x_fit_maltose')
x_tre_fructose = x_fit_fructose;
x_tre_sucrose = x_fit_sucrose;
x_tre_maltose = x_fit_maltose; 

% % % simulation and recall data
% % for k = 1:6
% %     % select parameter
% %     if k == 1, x = x_literature; 
% %     elseif k == 2, x = x_ug; 
% %     elseif k == 3, x = x_gapdh; 
% %     elseif k == 4, x = x_tre_fructose; 
% %     elseif k == 5, x = x_tre_sucrose; 
% %     elseif k == 6, x = x_tre_maltose; 
% %     end
% %     % simulation 
% %     plotflag = 11; 
% %     simulate_all
% %     plotflag = 0;
% %     % 
% %     fh_1 = figure(1);
% %     fh_3 = figure(3);
% %     fh_5 = figure(5);
% %     fh_7 = figure(7);
% %     % recall data
% %     names = {'Glc_{ec} [mM]',... % 1 % 1
% %             'Fruc_{ec} [mM]',... % 2 % 1
% %             'Malt_{ec} [mM]',... % 3 % 1
% %             'Tre_{ic} [mM]',... % 4 % 1
% %             'T6P [mM]',... % 5 % 1
% %             'G6P [mM]',... % 6 % 1
% %             'F6P [mM]',... % 7 % 1
% %             'FBP [mM]',... % 8 % 1
% %             'DHAP [mM]',... % 9 % 1
% %             'GAP [mM]',... % 10 % 1
% %             '3PG [mM]',... % 11 % 1
% %             '2PG [mM]',... % 12 % 1
% %             'PEP [mM]',... % 13 % 1
% %             'ATP [mM]',... % 14 % 1
% %             'ADP [mM]',... % 15 % 1
% %             'AMP [mM]',... % 16 % 1
% %             'NADH [mM]',... % 17 % 1
% %             'NAD [mM]',... % 18 % 1
% %             };
% %     nt = length(names);
% %     exp_data2plot = cell(4,nt);
% %     sim_data2plot = cell(4,nt);
% %     no = length(fh_1.Children);
% %     % loop to import each metabolite in the previous list
% %     for i = 1:nt
% %         % 
% %         for j = 2:no % 1 was the title
% %             if strcmp(fh_1.Children(j).Title.String,names{i}) % if it matches
% %                 % expData: extract time and concentration for each metabolite
% %                 exp_data2plot{1,i} = [fh_1.Children(j).Children(2).XData',...
% %                                       fh_1.Children(j).Children(2).YData'];
% %                 exp_data2plot{2,i} = [fh_3.Children(j).Children(2).XData',...
% %                                       fh_3.Children(j).Children(2).YData'];
% %                 exp_data2plot{3,i} = [fh_5.Children(j).Children(2).XData',...
% %                                       fh_5.Children(j).Children(2).YData'];
% %                 exp_data2plot{4,i} = [fh_7.Children(j).Children(2).XData',...
% %                                       fh_7.Children(j).Children(2).YData'];
% %                 % simData: extract time and concentration for each metabolite
% %                 if length(fh_1.Children(j).Children) == 3
% %                     sim_data2plot{1,i} = [fh_1.Children(j).Children(3).XData',...
% %                                           fh_1.Children(j).Children(3).YData'];
% %                 end
% %                 if length(fh_3.Children(j).Children) == 3
% %                     sim_data2plot{2,i} = [fh_3.Children(j).Children(3).XData',...
% %                                           fh_3.Children(j).Children(3).YData'];
% %                 end
% %                 if length(fh_5.Children(j).Children) == 3
% %                     sim_data2plot{3,i} = [fh_5.Children(j).Children(3).XData',...
% %                                           fh_5.Children(j).Children(3).YData'];
% %                 end
% %                 if length(fh_7.Children(j).Children) == 3
% %                     sim_data2plot{4,i} = [fh_7.Children(j).Children(3).XData',...
% %                                           fh_7.Children(j).Children(3).YData'];
% %                 end
% %             end
% %         end
% %     end
% %     close all
% %     % save it in appropriate location
% %     if k == 1, exp_data_x_literature = exp_data2plot; sim_data_x_literature = sim_data2plot; 
% %     elseif k == 2, exp_data_x_ug = exp_data2plot; sim_data_x_ug = sim_data2plot; 
% %     elseif k == 3, exp_data_x_gapdh = exp_data2plot; sim_data_x_gapdh = sim_data2plot; 
% %     elseif k == 4, exp_data_x_tre_fructose = exp_data2plot; sim_data_x_tre_fructose = sim_data2plot; 
% %     elseif k == 5, exp_data_x_tre_sucrose = exp_data2plot; sim_data_x_tre_sucrose = sim_data2plot; 
% %     elseif k == 6, exp_data_x_tre_maltose = exp_data2plot; sim_data_x_tre_maltose = sim_data2plot; 
% %     end
% % 
% % end
% % % save that data not to have to re-run
% % save('E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F4simData.mat',...
% %     'exp_data_x_literature','exp_data_x_ug','exp_data_x_gapdh','exp_data_x_tre_fructose','exp_data_x_tre_sucrose','exp_data_x_tre_maltose',...
% %     'sim_data_x_literature','sim_data_x_ug','sim_data_x_gapdh','sim_data_x_tre_fructose','sim_data_x_tre_sucrose','sim_data_x_tre_maltose');


%% fast path, just load the data
load('F4simData.mat',...
    'exp_data_x_literature','exp_data_x_ug','exp_data_x_gapdh','exp_data_x_tre_fructose','exp_data_x_tre_sucrose','exp_data_x_tre_maltose',...
    'sim_data_x_literature','sim_data_x_ug','sim_data_x_gapdh','sim_data_x_tre_fructose','sim_data_x_tre_sucrose','sim_data_x_tre_maltose');


%% figure color and style
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
% style
fh_linewidth = 1.5;
fh_markersize = 5;
% xlim
% ylim

% pretreatment to get out irrelavant data
sim_data_x_literature{1,2} = zeros(1,2);
sim_data_x_literature{4,2} = zeros(1,2);
sim_data_x_ug{1,2} = zeros(1,2);
sim_data_x_ug{4,2} = zeros(1,2);
sim_data_x_gapdh{1,2} = zeros(1,2);
sim_data_x_gapdh{4,2} = zeros(1,2);
sim_data_x_tre_fructose{1,2} = zeros(1,2);
sim_data_x_tre_fructose{4,2} = zeros(1,2);
sim_data_x_tre_sucrose{1,2} = zeros(1,2);
sim_data_x_tre_sucrose{4,2} = zeros(1,2);
sim_data_x_tre_maltose{1,2} = zeros(1,2);
sim_data_x_tre_maltose{4,2} = zeros(1,2);

%% figure 4 (part A)
% figures
if exist('fh_600041','var')
    clf(fh_600041)
end
fh_600041 = figure(600041);
fh_600041.Position = [1921 257 1536 747];
% 
id_plot1 = [1 2 6 7 8 10 9 3];
id_plot1_loc = [1 2 3 4 5 6 7 1];
names_plot1 = {'Glc_{ec}',... % 1 % 1
            'Fruc_{ec}',... % 2 % 1
            'G6P',... % 6 % 1
            'F6P',... % 7 % 1
            'FBP',... % 8 % 1
            'GAP',... % 10 % 1
            'DHAP',... % 9 % 1
            'Malt_{ec}',... % 3 % 1
            };
ylim1 = [zeros(8,1) ones(8,1)];
    ylim1(3,:) = [0 8];
    ylim1(4,:) = [0 2];
    ylim1(5,:) = [0 0.8];
    ylim1(6,:) = [0 0.035];
    ylim1(7,:) = [0 0.6];
% % % % for i = 1:length(id_plot1)
for i = [1,2,3:7]
    % exp data
    exp_gluc_data_t = exp_data_x_literature{1,id_plot1(i)}(:,1);
    exp_gluc_data_conc = exp_data_x_literature{1,id_plot1(i)}(:,2);
    exp_fruc_data_t = exp_data_x_literature{2,id_plot1(i)}(:,1);
    exp_fruc_data_conc = exp_data_x_literature{2,id_plot1(i)}(:,2);
    exp_sucr_data_t = exp_data_x_literature{3,id_plot1(i)}(:,1);
    exp_sucr_data_conc = exp_data_x_literature{3,id_plot1(i)}(:,2);
    exp_malt_data_t = exp_data_x_literature{4,id_plot1(i)}(:,1);
    exp_malt_data_conc = exp_data_x_literature{4,id_plot1(i)}(:,2);
    % sim data
    % x_lit
    xlit_gluc_sim_data_t = sim_data_x_literature{1,id_plot1(i)}(:,1);
    xlit_gluc_sim_data_conc = sim_data_x_literature{1,id_plot1(i)}(:,2);
    xlit_fruc_sim_data_t = sim_data_x_literature{2,id_plot1(i)}(:,1);
    xlit_fruc_sim_data_conc = sim_data_x_literature{2,id_plot1(i)}(:,2);
    xlit_sucr_sim_data_t = sim_data_x_literature{3,id_plot1(i)}(:,1);
    xlit_sucr_sim_data_conc = sim_data_x_literature{3,id_plot1(i)}(:,2);
    xlit_malt_sim_data_t = sim_data_x_literature{4,id_plot1(i)}(:,1);
    xlit_malt_sim_data_conc = sim_data_x_literature{4,id_plot1(i)}(:,2);
    % x_ug
    xug_gluc_sim_data_t = sim_data_x_ug{1,id_plot1(i)}(:,1);
    xug_gluc_sim_data_conc = sim_data_x_ug{1,id_plot1(i)}(:,2);
    xug_fruc_sim_data_t = sim_data_x_ug{2,id_plot1(i)}(:,1);
    xug_fruc_sim_data_conc = sim_data_x_ug{2,id_plot1(i)}(:,2);
    xug_sucr_sim_data_t = sim_data_x_ug{3,id_plot1(i)}(:,1);
    xug_sucr_sim_data_conc = sim_data_x_ug{3,id_plot1(i)}(:,2);
    xug_malt_sim_data_t = sim_data_x_ug{4,id_plot1(i)}(:,1);
    xug_malt_sim_data_conc = sim_data_x_ug{4,id_plot1(i)}(:,2);
    % x_gapdh
    xgapdh_gluc_sim_data_t = sim_data_x_gapdh{1,id_plot1(i)}(:,1);
    xgapdh_gluc_sim_data_conc = sim_data_x_gapdh{1,id_plot1(i)}(:,2);
    xgapdh_fruc_sim_data_t = sim_data_x_gapdh{2,id_plot1(i)}(:,1);
    xgapdh_fruc_sim_data_conc = sim_data_x_gapdh{2,id_plot1(i)}(:,2);
    xgapdh_sucr_sim_data_t = sim_data_x_gapdh{3,id_plot1(i)}(:,1);
    xgapdh_sucr_sim_data_conc = sim_data_x_gapdh{3,id_plot1(i)}(:,2);
    xgapdh_malt_sim_data_t = sim_data_x_gapdh{4,id_plot1(i)}(:,1);
    xgapdh_malt_sim_data_conc = sim_data_x_gapdh{4,id_plot1(i)}(:,2);
    % x_tre
    xtre_gluc_sim_data_t = sim_data_x_tre_fructose{1,id_plot1(i)}(:,1);
    xtre_gluc_sim_data_conc = sim_data_x_tre_fructose{1,id_plot1(i)}(:,2);
    xtre_fruc_sim_data_t = sim_data_x_tre_fructose{2,id_plot1(i)}(:,1);
    xtre_fruc_sim_data_conc = sim_data_x_tre_fructose{2,id_plot1(i)}(:,2);
    xtre_sucr_sim_data_t = sim_data_x_tre_sucrose{3,id_plot1(i)}(:,1);
    xtre_sucr_sim_data_conc = sim_data_x_tre_sucrose{3,id_plot1(i)}(:,2);
    xtre_malt_sim_data_t = sim_data_x_tre_maltose{4,id_plot1(i)}(:,1);
    xtre_malt_sim_data_conc = sim_data_x_tre_maltose{4,id_plot1(i)}(:,2);

    % plotting

    % % % % iloc1 % % % % 
    iloc1 = id_plot1_loc(i) + 0;
    % 
    sp = subplot(4,7,iloc1);
    plot(xlit_gluc_sim_data_t,xlit_gluc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colGluc_soft,...
        'LineStyle',':')
    hold on
    plot(xug_gluc_sim_data_t,xug_gluc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colGluc_soft,...
        'LineStyle','-.')
    plot(xgapdh_gluc_sim_data_t,xgapdh_gluc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colGluc_soft,...
        'LineStyle','--')
    plot(xtre_gluc_sim_data_t,xtre_gluc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colGluc_soft,...
        'LineStyle','-')
    plot(exp_gluc_data_t,exp_gluc_data_conc,'o',...
        'MarkerSize',fh_markersize,...
        'MarkerEdgeColor',colGluc_dark,...
        'MarkerFaceColor',colGluc)
    ylim(ylim1(id_plot1_loc(i),:))

    % add name metabolite
    xval = sp.XLim(1) + 0.8 * (sp.XLim(2) - sp.XLim(1));
    yval = sp.YLim(1) + 0.9 * (sp.YLim(2) - sp.YLim(1));
    text(xval,yval,names_plot1{i},...
        'HorizontalAlignment','Center','FontSize',12)
    tempYtick = sp.YTick([1 end]);
    tempYticklabel = cell(2,1); 
        tempYticklabel{1} = sp.YTickLabel{1};
        tempYticklabel{2} = sp.YTickLabel{end};
    sp.YTick = tempYtick;
    sp.YTickLabel = tempYticklabel;
    sp.XTick = [0 400];
    sp.FontSize = 12;

    % % % % iloc2 % % % % 
    iloc2 = id_plot1_loc(i) + 7;
    % 
    sp = subplot(4,7,iloc2);
    plot(xlit_fruc_sim_data_t,xlit_fruc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colFruc_soft,...
        'LineStyle',':')
    hold on
    plot(xug_fruc_sim_data_t,xug_fruc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colFruc_soft,...
        'LineStyle','-.')
    plot(xgapdh_fruc_sim_data_t,xgapdh_fruc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colFruc_soft,...
        'LineStyle','--')
    plot(xtre_fruc_sim_data_t,xtre_fruc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colFruc_soft,...
        'LineStyle','-')
    plot(exp_fruc_data_t,exp_fruc_data_conc,'o',...
        'MarkerSize',fh_markersize,...
        'MarkerEdgeColor',colFruc_dark,...
        'MarkerFaceColor',colFruc)
    ylim(ylim1(id_plot1_loc(i),:))

    % add name metabolite
    xval = sp.XLim(1) + 0.8 * (sp.XLim(2) - sp.XLim(1));
    yval = sp.YLim(1) + 0.9 * (sp.YLim(2) - sp.YLim(1));
    text(xval,yval,names_plot1{i},...
        'HorizontalAlignment','Center','FontSize',12)
    tempYtick = sp.YTick([1 end]);
    tempYticklabel = cell(2,1); 
        tempYticklabel{1} = sp.YTickLabel{1};
        tempYticklabel{2} = sp.YTickLabel{end};
    sp.YTick = tempYtick;
    sp.YTickLabel = tempYticklabel;
    sp.XTick = [0 400];
    sp.FontSize = 12;

    % % % % iloc3 % % % % 
    iloc3 = id_plot1_loc(i) + 14;
    % 
    sp = subplot(4,7,iloc3);
    plot(xlit_sucr_sim_data_t,xlit_sucr_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colSucr_soft,...
        'LineStyle',':')
    hold on
    plot(xug_sucr_sim_data_t,xug_sucr_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colSucr_soft,...
        'LineStyle','-.')
    plot(xgapdh_sucr_sim_data_t,xgapdh_sucr_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colSucr_soft,...
        'LineStyle','--')
    plot(xtre_sucr_sim_data_t,xtre_sucr_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colSucr_soft,...
        'LineStyle','-')
    plot(exp_sucr_data_t,exp_sucr_data_conc,'o',...
        'MarkerSize',fh_markersize,...
        'MarkerEdgeColor',colSucr_dark,...
        'MarkerFaceColor',colSucr)
    ylim(ylim1(id_plot1_loc(i),:))

    % add name metabolite
    xval = sp.XLim(1) + 0.8 * (sp.XLim(2) - sp.XLim(1));
    yval = sp.YLim(1) + 0.9 * (sp.YLim(2) - sp.YLim(1));
    text(xval,yval,names_plot1{i},...
        'HorizontalAlignment','Center','FontSize',12)
    tempYtick = sp.YTick([1 end]);
    tempYticklabel = cell(2,1); 
        tempYticklabel{1} = sp.YTickLabel{1};
        tempYticklabel{2} = sp.YTickLabel{end};
    sp.YTick = tempYtick;
    sp.YTickLabel = tempYticklabel;
    sp.XTick = [0 400];
    sp.FontSize = 12;

    % % % % iloc4 % % % % 
    iloc4 = id_plot1_loc(i) + 21;
    if i ~= 1
        % 
        sp = subplot(4,7,iloc4);
        plot(xlit_malt_sim_data_t,xlit_malt_sim_data_conc,...
            'LineWidth',fh_linewidth,'Color',colMalt_soft,...
            'LineStyle',':')
        hold on
        plot(xug_malt_sim_data_t,xug_malt_sim_data_conc,...
            'LineWidth',fh_linewidth,'Color',colMalt_soft,...
            'LineStyle','-.')
        plot(xgapdh_malt_sim_data_t,xgapdh_malt_sim_data_conc,...
            'LineWidth',fh_linewidth,'Color',colMalt_soft,...
            'LineStyle','--')
        plot(xtre_malt_sim_data_t,xtre_malt_sim_data_conc,...
            'LineWidth',fh_linewidth,'Color',colMalt_soft,...
            'LineStyle','-')
        plot(exp_malt_data_t,exp_malt_data_conc,'o',...
            'MarkerSize',fh_markersize,...
            'MarkerEdgeColor',colMalt_dark,...
            'MarkerFaceColor',colMalt)
        ylim(ylim1(id_plot1_loc(i),:))
    
        % add name metabolite
        xval = sp.XLim(1) + 0.8 * (sp.XLim(2) - sp.XLim(1));
        yval = sp.YLim(1) + 0.9 * (sp.YLim(2) - sp.YLim(1));
        text(xval,yval,names_plot1{i},...
            'HorizontalAlignment','Center','FontSize',12)
    else
        % 
        sp = subplot(4,7,iloc4);
% %         plot(sim_data_x_literature{4,id_plot1(end)}(:,1),sim_data_x_literature{4,id_plot1(end)}(:,2),...
% %             'LineWidth',fh_linewidth,'Color',colMalt_soft,...
% %             'LineStyle',':')
% %         hold on
% %         plot(sim_data_x_ug{4,id_plot1(end)}(:,1),sim_data_x_ug{4,id_plot1(end)}(:,2),...
% %             'LineWidth',fh_linewidth,'Color',colMalt_soft,...
% %             'LineStyle','-.')
% %         plot(sim_data_x_gapdh{4,id_plot1(end)}(:,1),sim_data_x_gapdh{4,id_plot1(end)}(:,2),...
% %             'LineWidth',fh_linewidth,'Color',colMalt_soft,...
% %             'LineStyle','--')
% %         plot(sim_data_x_tre_maltose{4,id_plot1(end)}(:,1),sim_data_x_tre_maltose{4,id_plot1(i)}(:,2),...
% %             'LineWidth',fh_linewidth,'Color',colMalt_soft,...
% %             'LineStyle','-')
        p1 = plot(sim_data_x_literature{4,3}(:,1),sim_data_x_literature{4,3}(:,2),...
            'LineWidth',fh_linewidth,'Color',colMalt_soft,...
            'LineStyle',':');
        hold on
        p2 = plot(sim_data_x_ug{4,3}(:,1),sim_data_x_ug{4,3}(:,2),...
            'LineWidth',fh_linewidth,'Color',colMalt_soft,...
            'LineStyle','-.');
        p3 = plot(sim_data_x_gapdh{4,3}(:,1),sim_data_x_gapdh{4,3}(:,2),...
            'LineWidth',fh_linewidth,'Color',colMalt_soft,...
            'LineStyle','--');
        p4 = plot(sim_data_x_tre_maltose{4,3}(:,1),sim_data_x_tre_maltose{4,3}(:,2),...
            'LineWidth',fh_linewidth,'Color',colMalt_soft,...
            'LineStyle','-');
        p5 = plot(exp_data_x_literature{4,id_plot1(end)}(:,1),exp_data_x_literature{4,id_plot1(end)}(:,2),'o',...
            'MarkerSize',fh_markersize,...
            'MarkerEdgeColor',colMalt_dark,...
            'MarkerFaceColor',colMalt);
        ylim(ylim1(id_plot1_loc(i),:))
        % labels
        ylabel('Concentration (mM)')
        xlabel('Time (s)')
        legend([p1 p2 p3 p4 p5],'Literature','transport + hydrolysis','GAPDH','PGM1 + TPS1','Experimental')
    
        % add name metabolite
        xval = sp.XLim(1) + 0.8 * (sp.XLim(2) - sp.XLim(1));
        yval = sp.YLim(1) + 0.9 * (sp.YLim(2) - sp.YLim(1));
        text(xval,yval,'Malt_{ec}',...
            'HorizontalAlignment','Center','FontSize',12)
    end
    tempYtick = sp.YTick([1 end]);
    tempYticklabel = cell(2,1); 
    tempYticklabel{1} = sp.YTickLabel{1};
    tempYticklabel{2} = sp.YTickLabel{end};
    sp.YTick = tempYtick;
    sp.YTickLabel = tempYticklabel;
    sp.XTick = [0 400];
    sp.FontSize = 12;
end

% %% deleting extra plots
delete(fh_600041.Children(28)) % gluc_ec in fructose
delete(fh_600041.Children(24)) % fruc_ec in glucose
delete(fh_600041.Children(21)) % fruc_ec in maltose
% %%
fh_600041.Children(23).Position = [(0.2464+0.1317)/2 0.1100 0.0812 0.1577];


% %% annotations and lines
% 
% delete(temp_txt)
temp_txt = annotation('textbox',[0.06 0.05 0.1 0.1],'String','Maltose','FitBoxToText','on');
temp_txt.EdgeColor = 'none';
temp_txt.FontSize = 20;
temp_txt.Color = colMalt;
temp_txt.HorizontalAlignment = 'center';
temp_txt.Rotation = 90;
% %%
% delete(temp_txt)
temp_txt = annotation('textbox',[0.06 0.05+0.2191 0.1 0.1],'String','Sucrose','FitBoxToText','on');
temp_txt.EdgeColor = 'none';
temp_txt.FontSize = 20;
temp_txt.Color = colSucr;
temp_txt.HorizontalAlignment = 'center';
temp_txt.Rotation = 90;
% %%
% delete(temp_txt)
temp_txt = annotation('textbox',[0.06 0.05+2*0.2191 0.1 0.1],'String','Fructose','FitBoxToText','on');
temp_txt.EdgeColor = 'none';
temp_txt.FontSize = 20;
temp_txt.Color = colFruc;
temp_txt.HorizontalAlignment = 'center';
temp_txt.Rotation = 90;
% %%
% delete(temp_txt)
temp_txt = annotation('textbox',[0.06 0.05+3*0.2191 0.1 0.1],'String','Glucose','FitBoxToText','on');
temp_txt.EdgeColor = 'none';
temp_txt.FontSize = 20;
temp_txt.Color = colGluc;
temp_txt.HorizontalAlignment = 'center';
temp_txt.Rotation = 90;


% %% 
% delete(temp_txt)
temp_txt = annotation('textbox',[0.175 0.9 0.1 0.1],'String','Extracelular','FitBoxToText','on');
temp_txt.EdgeColor = 'none';
temp_txt.FontSize = 20;
temp_txt.HorizontalAlignment = 'center';
% %% 
% delete(temp_txt)
temp_txt = annotation('textbox',[0.575 0.9 0.1 0.1],'String','Upper glycolysis','FitBoxToText','on');
temp_txt.EdgeColor = 'none';
temp_txt.FontSize = 20;
temp_txt.HorizontalAlignment = 'center';




%% figure 4 (part B)
% figures
if exist('fh_600042','var')
    clf(fh_600042)
end
fh_600042 = figure(600042);
fh_600042.Position = [1921 257 1536 747];
% 
id_plot2 = [11 12 13 14 15 16 5];
id_plot2_loc = [1 2 3 4 5 6 7];
names_plot2 = {'3PG',... % 11 % 1
            '2PG',... % 12 % 1
            'PEP',... % 13 % 1
            'ATP',... % 14 % 1
            'ADP',... % 15 % 1
            'AMP',... % 16 % 1
            'T6P',... % 5 % 1
            };
ylim2 = [zeros(8,1) ones(8,1)];
    ylim2(1,:) = [0 6];
    ylim2(2,:) = [0 0.6];
    ylim2(3,:) = [0 2.75];
    ylim2(4,:) = [2 6];
    ylim2(5,:) = [0 2.5];
    ylim2(6,:) = [0 0.6];
    ylim2(7,:) = [0 1.25];
% plot sims literature
% plot sims ug
% plot sims gapdh
% plot sims tre
% plot exp data
for i = 1:length(id_plot2)
% for i = [1,2,3:7]
    % exp data
    exp_gluc_data_t = exp_data_x_literature{1,id_plot2(i)}(:,1);
    exp_gluc_data_conc = exp_data_x_literature{1,id_plot2(i)}(:,2);
    exp_fruc_data_t = exp_data_x_literature{2,id_plot2(i)}(:,1);
    exp_fruc_data_conc = exp_data_x_literature{2,id_plot2(i)}(:,2);
    exp_sucr_data_t = exp_data_x_literature{3,id_plot2(i)}(:,1);
    exp_sucr_data_conc = exp_data_x_literature{3,id_plot2(i)}(:,2);
    exp_malt_data_t = exp_data_x_literature{4,id_plot2(i)}(:,1);
    exp_malt_data_conc = exp_data_x_literature{4,id_plot2(i)}(:,2);
    % sim data
    % x_lit
    xlit_gluc_sim_data_t = sim_data_x_literature{1,id_plot2(i)}(:,1);
    xlit_gluc_sim_data_conc = sim_data_x_literature{1,id_plot2(i)}(:,2);
    xlit_fruc_sim_data_t = sim_data_x_literature{2,id_plot2(i)}(:,1);
    xlit_fruc_sim_data_conc = sim_data_x_literature{2,id_plot2(i)}(:,2);
    xlit_sucr_sim_data_t = sim_data_x_literature{3,id_plot2(i)}(:,1);
    xlit_sucr_sim_data_conc = sim_data_x_literature{3,id_plot2(i)}(:,2);
    xlit_malt_sim_data_t = sim_data_x_literature{4,id_plot2(i)}(:,1);
    xlit_malt_sim_data_conc = sim_data_x_literature{4,id_plot2(i)}(:,2);
    % x_ug
    xug_gluc_sim_data_t = sim_data_x_ug{1,id_plot2(i)}(:,1);
    xug_gluc_sim_data_conc = sim_data_x_ug{1,id_plot2(i)}(:,2);
    xug_fruc_sim_data_t = sim_data_x_ug{2,id_plot2(i)}(:,1);
    xug_fruc_sim_data_conc = sim_data_x_ug{2,id_plot2(i)}(:,2);
    xug_sucr_sim_data_t = sim_data_x_ug{3,id_plot2(i)}(:,1);
    xug_sucr_sim_data_conc = sim_data_x_ug{3,id_plot2(i)}(:,2);
    xug_malt_sim_data_t = sim_data_x_ug{4,id_plot2(i)}(:,1);
    xug_malt_sim_data_conc = sim_data_x_ug{4,id_plot2(i)}(:,2);
    % x_gapdh
    xgapdh_gluc_sim_data_t = sim_data_x_gapdh{1,id_plot2(i)}(:,1);
    xgapdh_gluc_sim_data_conc = sim_data_x_gapdh{1,id_plot2(i)}(:,2);
    xgapdh_fruc_sim_data_t = sim_data_x_gapdh{2,id_plot2(i)}(:,1);
    xgapdh_fruc_sim_data_conc = sim_data_x_gapdh{2,id_plot2(i)}(:,2);
    xgapdh_sucr_sim_data_t = sim_data_x_gapdh{3,id_plot2(i)}(:,1);
    xgapdh_sucr_sim_data_conc = sim_data_x_gapdh{3,id_plot2(i)}(:,2);
    xgapdh_malt_sim_data_t = sim_data_x_gapdh{4,id_plot2(i)}(:,1);
    xgapdh_malt_sim_data_conc = sim_data_x_gapdh{4,id_plot2(i)}(:,2);
    % x_tre
    xtre_gluc_sim_data_t = sim_data_x_tre_fructose{1,id_plot2(i)}(:,1);
    xtre_gluc_sim_data_conc = sim_data_x_tre_fructose{1,id_plot2(i)}(:,2);
    xtre_fruc_sim_data_t = sim_data_x_tre_fructose{2,id_plot2(i)}(:,1);
    xtre_fruc_sim_data_conc = sim_data_x_tre_fructose{2,id_plot2(i)}(:,2);
    xtre_sucr_sim_data_t = sim_data_x_tre_sucrose{3,id_plot2(i)}(:,1);
    xtre_sucr_sim_data_conc = sim_data_x_tre_sucrose{3,id_plot2(i)}(:,2);
    xtre_malt_sim_data_t = sim_data_x_tre_maltose{4,id_plot2(i)}(:,1);
    xtre_malt_sim_data_conc = sim_data_x_tre_maltose{4,id_plot2(i)}(:,2);

    % plotting

    % % % % iloc1 % % % % 
    iloc1 = id_plot2_loc(i) + 0;
    % 
    sp = subplot(4,7,iloc1);
    plot(xlit_gluc_sim_data_t,xlit_gluc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colGluc_soft,...
        'LineStyle',':')
    hold on
    plot(xug_gluc_sim_data_t,xug_gluc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colGluc_soft,...
        'LineStyle','-.')
    plot(xgapdh_gluc_sim_data_t,xgapdh_gluc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colGluc_soft,...
        'LineStyle','--')
    plot(xtre_gluc_sim_data_t,xtre_gluc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colGluc_soft,...
        'LineStyle','-')
    plot(exp_gluc_data_t,exp_gluc_data_conc,'o',...
        'MarkerSize',fh_markersize,...
        'MarkerEdgeColor',colGluc_dark,...
        'MarkerFaceColor',colGluc)
    ylim(ylim2(id_plot2_loc(i),:))

    % add name metabolite
    xval = sp.XLim(1) + 0.8 * (sp.XLim(2) - sp.XLim(1));
    yval = sp.YLim(1) + 0.9 * (sp.YLim(2) - sp.YLim(1));
    text(xval,yval,names_plot2{i},...
        'HorizontalAlignment','Center','FontSize',12)
    tempYtick = sp.YTick([1 end]);
    tempYticklabel = cell(2,1); 
        tempYticklabel{1} = sp.YTickLabel{1};
        tempYticklabel{2} = sp.YTickLabel{end};
    sp.YTick = tempYtick;
    sp.YTickLabel = tempYticklabel;
    sp.XTick = [0 400];
    sp.FontSize = 12;

    % % % % iloc2 % % % % 
    iloc2 = id_plot2_loc(i) + 7;
    % 
    sp = subplot(4,7,iloc2);
    plot(xlit_fruc_sim_data_t,xlit_fruc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colFruc_soft,...
        'LineStyle',':')
    hold on
    plot(xug_fruc_sim_data_t,xug_fruc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colFruc_soft,...
        'LineStyle','-.')
    plot(xgapdh_fruc_sim_data_t,xgapdh_fruc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colFruc_soft,...
        'LineStyle','--')
    plot(xtre_fruc_sim_data_t,xtre_fruc_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colFruc_soft,...
        'LineStyle','-')
    plot(exp_fruc_data_t,exp_fruc_data_conc,'o',...
        'MarkerSize',fh_markersize,...
        'MarkerEdgeColor',colFruc_dark,...
        'MarkerFaceColor',colFruc)
    ylim(ylim2(id_plot2_loc(i),:))

    % add name metabolite
    xval = sp.XLim(1) + 0.8 * (sp.XLim(2) - sp.XLim(1));
    yval = sp.YLim(1) + 0.9 * (sp.YLim(2) - sp.YLim(1));
    text(xval,yval,names_plot2{i},...
        'HorizontalAlignment','Center','FontSize',12)
    tempYtick = sp.YTick([1 end]);
    tempYticklabel = cell(2,1); 
        tempYticklabel{1} = sp.YTickLabel{1};
        tempYticklabel{2} = sp.YTickLabel{end};
    sp.YTick = tempYtick;
    sp.YTickLabel = tempYticklabel;
    sp.XTick = [0 400];
    sp.FontSize = 12;

    % % % % iloc3 % % % % 
    iloc3 = id_plot2_loc(i) + 14;
    % 
    sp = subplot(4,7,iloc3);
    plot(xlit_sucr_sim_data_t,xlit_sucr_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colSucr_soft,...
        'LineStyle',':')
    hold on
    plot(xug_sucr_sim_data_t,xug_sucr_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colSucr_soft,...
        'LineStyle','-.')
    plot(xgapdh_sucr_sim_data_t,xgapdh_sucr_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colSucr_soft,...
        'LineStyle','--')
    plot(xtre_sucr_sim_data_t,xtre_sucr_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colSucr_soft,...
        'LineStyle','-')
    plot(exp_sucr_data_t,exp_sucr_data_conc,'o',...
        'MarkerSize',fh_markersize,...
        'MarkerEdgeColor',colSucr_dark,...
        'MarkerFaceColor',colSucr)
    ylim(ylim2(id_plot2_loc(i),:))

    % add name metabolite
    xval = sp.XLim(1) + 0.8 * (sp.XLim(2) - sp.XLim(1));
    yval = sp.YLim(1) + 0.9 * (sp.YLim(2) - sp.YLim(1));
    text(xval,yval,names_plot2{i},...
        'HorizontalAlignment','Center','FontSize',12)
    tempYtick = sp.YTick([1 end]);
    tempYticklabel = cell(2,1); 
        tempYticklabel{1} = sp.YTickLabel{1};
        tempYticklabel{2} = sp.YTickLabel{end};
    sp.YTick = tempYtick;
    sp.YTickLabel = tempYticklabel;
    sp.XTick = [0 400];
    sp.FontSize = 12;

    % % % % iloc4 % % % % 
    iloc4 = id_plot1_loc(i) + 21;

    % 
    sp = subplot(4,7,iloc4);
    p1 = plot(xlit_malt_sim_data_t,xlit_malt_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colMalt_soft,...
        'LineStyle',':');
    hold on
    p2 = plot(xug_malt_sim_data_t,xug_malt_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colMalt_soft,...
        'LineStyle','-.');
    p3 = plot(xgapdh_malt_sim_data_t,xgapdh_malt_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colMalt_soft,...
        'LineStyle','--');
    p4 = plot(xtre_malt_sim_data_t,xtre_malt_sim_data_conc,...
        'LineWidth',fh_linewidth,'Color',colMalt_soft,...
        'LineStyle','-');
    p5 = plot(exp_malt_data_t,exp_malt_data_conc,'o',...
        'MarkerSize',fh_markersize,...
        'MarkerEdgeColor',colMalt_dark,...
        'MarkerFaceColor',colMalt);
    ylim(ylim2(id_plot1_loc(i),:))

    if i == 1
        % labels
        ylabel('Concentration (mM)')
        xlabel('Time (s)')
        legend([p1 p2 p3 p4 p5],'Literature','transport + hydrolysis','GAPDH','PGM1 + TPS1','Experimental')
    end

    % add name metabolite
    xval = sp.XLim(1) + 0.8 * (sp.XLim(2) - sp.XLim(1));
    yval = sp.YLim(1) + 0.9 * (sp.YLim(2) - sp.YLim(1));
    text(xval,yval,names_plot2{i},...
        'HorizontalAlignment','Center','FontSize',12)

    tempYtick = sp.YTick([1 end]);
    tempYticklabel = cell(2,1); 
    tempYticklabel{1} = sp.YTickLabel{1};
    tempYticklabel{2} = sp.YTickLabel{end};
    sp.YTick = tempYtick;
    sp.YTickLabel = tempYticklabel;
    sp.XTick = [0 400];
    sp.FontSize = 12;

end



% %% annotations and lines
% 
% delete(temp_txt)
temp_txt = annotation('textbox',[0.06 0.05 0.1 0.1],'String','Maltose','FitBoxToText','on');
temp_txt.EdgeColor = 'none';
temp_txt.FontSize = 20;
temp_txt.Color = colMalt;
temp_txt.HorizontalAlignment = 'center';
temp_txt.Rotation = 90;
% %%
% delete(temp_txt)
temp_txt = annotation('textbox',[0.06 0.05+0.2191 0.1 0.1],'String','Sucrose','FitBoxToText','on');
temp_txt.EdgeColor = 'none';
temp_txt.FontSize = 20;
temp_txt.Color = colSucr;
temp_txt.HorizontalAlignment = 'center';
temp_txt.Rotation = 90;
% %%
% delete(temp_txt)
temp_txt = annotation('textbox',[0.06 0.05+2*0.2191 0.1 0.1],'String','Fructose','FitBoxToText','on');
temp_txt.EdgeColor = 'none';
temp_txt.FontSize = 20;
temp_txt.Color = colFruc;
temp_txt.HorizontalAlignment = 'center';
temp_txt.Rotation = 90;
% %%
% delete(temp_txt)
temp_txt = annotation('textbox',[0.06 0.05+3*0.2191 0.1 0.1],'String','Glucose','FitBoxToText','on');
temp_txt.EdgeColor = 'none';
temp_txt.FontSize = 20;
temp_txt.Color = colGluc;
temp_txt.HorizontalAlignment = 'center';
temp_txt.Rotation = 90;


% %% 
% delete(temp_txt)
temp_txt = annotation('textbox',[0.235 0.9 0.1 0.1],'String','Lower Glycolysis','FitBoxToText','on');
temp_txt.EdgeColor = 'none';
temp_txt.FontSize = 20;
temp_txt.HorizontalAlignment = 'center';
% %% 
% delete(temp_txt)
temp_txt = annotation('textbox',[0.580 0.9 0.1 0.1],'String','Cofactors','FitBoxToText','on');
temp_txt.EdgeColor = 'none';
temp_txt.FontSize = 20;
temp_txt.HorizontalAlignment = 'center';
% %% 
% delete(temp_txt)
temp_txt = annotation('textbox',[0.81 0.9 0.1 0.1],'String','Trehalose','FitBoxToText','on');
temp_txt.EdgeColor = 'none';
temp_txt.FontSize = 20;
temp_txt.HorizontalAlignment = 'center';

