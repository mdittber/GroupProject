function [BGap, Radius, Volt, Mat] = getBandGap(QdotObj,SimDir)
%[BGap, Radius, Volt, Info] = getBandGap(QdotObj,SimDir)
%   Input:  QdotObj     - Object that shall give the Band Gap
%           SimDir      - Path where to find the object
%   Output: BGap        - Band Gap in eV
%           Radius      - Inner and Outer Radius of the Qdot
%           Volt        - Applied Voltage
%           Mat         - Material name

    [n,m] = size(QdotObj.geometry);
    Radius = zeros(max(n,m),1);
    for i=1:max(n,m)
        Radius(i) = QdotObj.geometry(i).radius;
    end
    Volt = QdotObj.Vdmin;
    
    if strcmp(QdotObj.mat_name, 'PbSe_allan')
        Mat = 1;
    elseif strcmp(QdotObj.mat_name, 'PbSe_lent')
        Mat = 2;
    elseif strcmp(QdotObj.mat_name, 'CdSe_CdS')
        Mat = 3;
    elseif strcmp(QdotObj.mat_name, 'InGaAs')
        Mat = 4;
    else
        Mat = 0.1;
    end
    
    global config;
    load([config.simulations, SimDir, '/CB_E_0_0.dat']);
    load([config.simulations, SimDir, '/VB_E_0_0.dat']);
    minCB = min(CB_E_0_0);
    maxVB = max(VB_E_0_0);
    BGap  = minCB - maxVB;
end