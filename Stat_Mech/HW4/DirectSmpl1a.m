% October 2017 -- DirectSmpl
clear all; close all;
sigma = 0.12;
N = 4;
n_runs = 10^5; % 10^6
box_size = 1.0 - 2 * sigma;

attempts = 0;
Ls = [];
for i = 1:n_runs
    overlap = true;
    while overlap == true
        L = [box_size * rand + sigma, box_size * rand + sigma] ;
        attempts = attempts + 1;
        for k = 1:N-1
            a = [box_size * rand + sigma, box_size * rand + sigma] ;
            dist_sqs = [];
            for j = 1:k
                dist_sqs(j) = sum((a-L(j,1:2)).^2);
            end
            min_dist_sq = min(dist_sqs);
            if min_dist_sq < 4.0 * sigma^2
                overlap = true;
                break;
            else
                overlap = false;            
                L = [L;a];
            end
        end
    end
        Ls = [Ls,L];
end
% Observable
Y_positions = Ls(:,2:2:2*n_runs);
histogram(Y_positions,20,'Normalization','pdf');
xlabel('Y position', 'FontSize', 24);
ylabel('pdf', 'FontSize', 24);
set(gca, 'FontSize', 24);
title(['\sigma = ', num2str(sigma), ',     n_{runs} = ', num2str(n_runs)], 'FontSize', 20);






