if setup.GPdataset.GP400WT == 1
    ExpData = dataFF01;
elseif setup.GPdataset.GP1800WT == 1
    ExpData = dataFF03;
elseif setup.GPdataset.GP400M == 1
    ExpData = dataFF04;
elseif setup.GPdataset.Fruc == 1
    ExpData = dataFF01Fruc;
elseif setup.GPdataset.Sucr == 1
    ExpData = dataFF01Sucr;
elseif setup.GPdataset.Malt == 1
    ExpData = dataFF01Malt;
end