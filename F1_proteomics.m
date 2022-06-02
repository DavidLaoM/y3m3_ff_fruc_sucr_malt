
%% recall data
[~,~,full_cell] = xlsread('Proteomics data different substrates.xlsx');
prot.names = full_cell(3:end,1);
prot.gluc.chem = xlsread('Proteomics data different substrates.xlsx', 'Original data', 'B3:B25');
prot.gluc.ff = xlsread('Proteomics data different substrates.xlsx', 'Original data', 'C3:C25');
prot.fruc.chem = xlsread('Proteomics data different substrates.xlsx', 'Original data', 'E3:E25');
prot.fruc.ff = xlsread('Proteomics data different substrates.xlsx', 'Original data', 'F3:F25');
prot.sucr.chem = xlsread('Proteomics data different substrates.xlsx', 'Original data', 'H3:H25');
prot.sucr.ff = xlsread('Proteomics data different substrates.xlsx', 'Original data', 'I3:I25');
prot.malt.chem = xlsread('Proteomics data different substrates.xlsx', 'Original data', 'K3:K25');
prot.malt.ff = xlsread('Proteomics data different substrates.xlsx', 'Original data', 'L3:L25');

%% adding glk
prot.names{24} = 'GLK';
prot.names{9} = 'GAPDH';
prot.gluc.chem(24) = prot.gluc.chem(2) - prot.gluc.chem(3);
prot.gluc.ff(24) = prot.gluc.ff(2) - prot.gluc.ff(3);
prot.fruc.chem(24) = prot.fruc.chem(2) - prot.fruc.chem(3);
prot.fruc.ff(24) = prot.fruc.ff(2) - prot.fruc.ff(3);
prot.sucr.chem(24) = prot.sucr.chem(2) - prot.sucr.chem(3);
prot.sucr.ff(24) = prot.sucr.ff(2) - prot.sucr.ff(3);
prot.malt.chem(24) = prot.malt.chem(2) - prot.malt.chem(3);
prot.malt.ff(24) = prot.malt.ff(2) - prot.malt.ff(3);

%% visual abundance
% 
colGluc = [0 0.4470 0.7410];
colFruc = [0.8500 0.3250 0.0980];
colSucr = [0.9290 0.6940 0.1250];
colMalt = [0.4940 0.1840 0.5560];
colGluc_soft = colGluc + ([1 1 1] - colGluc)/2;
colFruc_soft = colFruc + ([1 1 1] - colFruc)/2;
colSucr_soft = colSucr + ([1 1 1] - colSucr)/2;
colMalt_soft = colMalt + ([1 1 1] - colMalt)/2;
% 
mets2plot = [1,3:15,17:20];
selnames = prot.names(mets2plot);
% 
% y_gluc = [prot.gluc.chem(1:22), prot.gluc.ff(1:22)];
y_gluc = [prot.gluc.chem(mets2plot), prot.gluc.ff(mets2plot)];
% y_fruc = [prot.fruc.chem, prot.fruc.ff];
y_fruc = [prot.fruc.chem(mets2plot), prot.fruc.ff(mets2plot)];
% y_sucr = [prot.sucr.chem, prot.sucr.ff];
y_sucr = [prot.sucr.chem(mets2plot), prot.sucr.ff(mets2plot)];
% y_malt = [prot.malt.chem, prot.malt.ff];
y_malt = [prot.malt.chem(mets2plot), prot.malt.ff(mets2plot)];
y_chem = [prot.gluc.chem(mets2plot), prot.fruc.chem(mets2plot), prot.sucr.chem(mets2plot), prot.malt.chem(mets2plot)];
y_ff = [prot.gluc.ff(mets2plot), prot.fruc.ff(mets2plot), prot.sucr.ff(mets2plot), prot.malt.ff(mets2plot)];
% 
fh_3001 = figure(3001);
fh_3001.Position =  [1921 257 1536 747];
subplot(2,4,1), bar(y_gluc), title('glucose')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90)
subplot(2,4,2), bar(y_fruc), title('fructose')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90)
subplot(2,4,5), bar(y_sucr), title('sucrose')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90)
subplot(2,4,6), bar(y_malt), title('maltose')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90)
subplot(2,4,[3 4]), bar(y_chem), title('Chem')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90)
subplot(2,4,[7 8]), bar(y_ff), title('FF')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90)
% color
fh_3001.Children(6).Children(2).FaceColor = colGluc;
fh_3001.Children(6).Children(1).FaceColor = colGluc_soft;
fh_3001.Children(5).Children(2).FaceColor = colFruc;
fh_3001.Children(5).Children(1).FaceColor = colFruc_soft;
fh_3001.Children(4).Children(2).FaceColor = colSucr;
fh_3001.Children(4).Children(1).FaceColor = colSucr_soft;
fh_3001.Children(3).Children(2).FaceColor = colMalt;
fh_3001.Children(3).Children(1).FaceColor = colMalt_soft;
fh_3001.Children(2).Children(4).FaceColor = colGluc;
fh_3001.Children(2).Children(3).FaceColor = colFruc;
fh_3001.Children(2).Children(2).FaceColor = colSucr;
fh_3001.Children(2).Children(1).FaceColor = colMalt;
fh_3001.Children(1).Children(4).FaceColor = colGluc_soft;
fh_3001.Children(1).Children(3).FaceColor = colFruc_soft;
fh_3001.Children(1).Children(2).FaceColor = colSucr_soft;
fh_3001.Children(1).Children(1).FaceColor = colMalt_soft;


%% visual percentage change
% 
colGluc = [0 0.4470 0.7410];
colFruc = [0.8500 0.3250 0.0980];
colSucr = [0.9290 0.6940 0.1250];
colMalt = [0.4940 0.1840 0.5560];
colGluc_soft = colGluc + ([1 1 1] - colGluc)/2;
colFruc_soft = colFruc + ([1 1 1] - colFruc)/2;
colSucr_soft = colSucr + ([1 1 1] - colSucr)/2;
colMalt_soft = colMalt + ([1 1 1] - colMalt)/2;
% 
% y_gluc = [prot.gluc.chem(1:22), prot.gluc.ff(1:22)];
    y_gluc_perc = (y_gluc(:,2) - y_gluc(:,1)) ./ y_gluc(:,1) * 100;
% y_fruc = [prot.fruc.chem, prot.fruc.ff];
    y_fruc_perc = (y_fruc(:,2) - y_fruc(:,1)) ./ y_fruc(:,1) * 100;
% y_sucr = [prot.sucr.chem, prot.sucr.ff];
    y_sucr_perc = (y_sucr(:,2) - y_sucr(:,1)) ./ y_sucr(:,1) * 100;
% y_malt = [prot.malt.chem, prot.malt.ff];
    y_malt_perc = (y_malt(:,2) - y_malt(:,1)) ./ y_malt(:,1) * 100;
% y_chem = [prot.gluc.chem(1:22), prot.fruc.chem, prot.sucr.chem, prot.malt.chem];
    y_chem_perc = [(y_chem(:,2) - y_chem(:,1)) ./ y_chem(:,1), ...
                   (y_chem(:,3) - y_chem(:,1)) ./ y_chem(:,1), ...
                   (y_chem(:,4) - y_chem(:,1)) ./ y_chem(:,1)] * 100;
% y_ff = [prot.gluc.ff(1:22), prot.fruc.ff, prot.sucr.ff, prot.malt.ff];
    y_ff_perc = [(y_ff(:,2) - y_ff(:,1)) ./ y_ff(:,1), ...
                 (y_ff(:,3) - y_ff(:,1)) ./ y_ff(:,1), ...
                 (y_ff(:,4) - y_ff(:,1)) ./ y_ff(:,1)] * 100;
% 
fh_3002 = figure(3002);
% fh_3002.Position =  [1 41 1920 963];
fh_3002.Position =  [1921 257 1536 747];
subplot(2,4,1), bar(y_gluc_perc), title('glucose chem -> ff')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90), ylim([-100 100])
subplot(2,4,2), bar(y_fruc_perc), title('fructose chem -> ff')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90), ylim([-100 100])
subplot(2,4,5), bar(y_sucr_perc), title('sucrose chem -> ff')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90), ylim([-100 100])
subplot(2,4,6), bar(y_malt_perc), title('maltose chem -> ff')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90), ylim([-100 100])
subplot(2,4,[3 4]), bar(y_chem_perc), title('Chem gluc -> fruc, sucr, malt')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90), ylim([-100 100])
subplot(2,4,[7 8]), bar(y_ff_perc), title('FF gluc -> fruc, sucr, malt')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90), ylim([-100 100])

% color
fh_3002.Children(6).Children.FaceColor = colGluc;
fh_3002.Children(5).Children.FaceColor = colFruc;
fh_3002.Children(4).Children.FaceColor = colSucr;
fh_3002.Children(3).Children.FaceColor = colMalt;
fh_3002.Children(2).Children(3).FaceColor = colFruc;
fh_3002.Children(2).Children(2).FaceColor = colSucr;
fh_3002.Children(2).Children(1).FaceColor = colMalt;
fh_3002.Children(1).Children(3).FaceColor = colFruc_soft;
fh_3002.Children(1).Children(2).FaceColor = colSucr_soft;
fh_3002.Children(1).Children(1).FaceColor = colMalt_soft;


%% FIGURE PLOT
% 
if exist('fh_3003','var')
    clf(3003)
end
fh_3003 = figure(3003);
fh_3003.Position =  [2071 534 1151 453];
bar(y_ff_perc), %title('FF gluc -> fruc, sucr, malt')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90), ylim([-100 100])

% color
fh_3003.Children.Children(3).FaceColor = colFruc;
fh_3003.Children.Children(2).FaceColor = colSucr;
fh_3003.Children.Children(1).FaceColor = colMalt;

% ytickts
yticks([-100 -50 0 50 100])
fh_3003.Children.YGrid = 'on';
fh_3003.Children.XGrid = 'off';

% xlabel
xlabel('Intracellular protein')
% ylabel
ylabel({'Change in protein expression in FF';'condition compared to glucose (%)'})
% legend
legend('fructose','sucrose','maltose')


%% supplementary :raw data plot
% 
if exist('fh_3004','var')
    clf(3004)
end
fh_3004 = figure(3004);
fh_3004.Position =  [1961 315 925 657];
subplot(2,2,1), bar(y_gluc), set(gca,'YScale','log'), %title('glucose')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90), 
    ylim([1e4 1e8]), lgd = legend('chem','ff'); title(lgd,'glucose')
subplot(2,2,2), bar(y_fruc), set(gca,'YScale','log'), %title('fructose')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90), 
    ylim([1e4 1e8]), lgd = legend('chem','ff'); title(lgd,'fructose')
subplot(2,2,3), bar(y_sucr), set(gca,'YScale','log'), %title('sucrose')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90), 
    ylim([1e4 1e8]), lgd = legend('chem','ff'); title(lgd,'sucrose')
    ylabel('Protein expression'), xlabel('Enzyme')
subplot(2,2,4), bar(y_malt), set(gca,'YScale','log'), %title('maltose')
    xticks(1:length(selnames)), xticklabels(selnames), xtickangle(90), 
    ylim([1e4 1e8]), lgd = legend('chem','ff'); title(lgd,'maltose')
%
fh_3004.Children(8).YGrid = 'on';
fh_3004.Children(6).YGrid = 'on';
fh_3004.Children(4).YGrid = 'on';
fh_3004.Children(2).YGrid = 'on';
% color
fh_3004.Children(8).Children(2).FaceColor = colGluc_soft;
fh_3004.Children(8).Children(1).FaceColor = colGluc;
fh_3004.Children(6).Children(2).FaceColor = colFruc_soft;
fh_3004.Children(6).Children(1).FaceColor = colFruc;
fh_3004.Children(4).Children(2).FaceColor = colSucr_soft;
fh_3004.Children(4).Children(1).FaceColor = colSucr;
fh_3004.Children(2).Children(2).FaceColor = colMalt_soft;
fh_3004.Children(2).Children(1).FaceColor = colMalt;

