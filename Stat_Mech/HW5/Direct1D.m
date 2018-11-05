% Direct1D -- 1D Direct Sampling: October 2017
clear all; close all;    
tic;
N = 5;
L = 10.0;
sigma = 0.75; 
n_configs = 10^3;
attempts =0;
xs=[];
for i = 1:n_configs
    config = true;
    if mod(i,int32(n_configs/10)) == 0
        fprintf(['Number of configs = ', num2str(i),' of ',num2str(n_configs),'\n']);
    end
    while config == true
        x = (L - 2* sigma) * rand(N,1) + sigma;
        x = sort(x);
        min_xdist = min(diff(x));
        attempts = attempts +1;
        if min_xdist > 2.0 * sigma
            config = false;
        end
    end
    xs=[xs,x];
end
toc;
histogram(xs,20,'Normalization','pdf');
            
            
            
            
            