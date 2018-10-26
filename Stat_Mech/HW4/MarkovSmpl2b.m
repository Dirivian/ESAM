% October 2017 -- MarkovSmpl
clear all; close all;
L = [0.25, 0.25; 0.75, 0.25; 0.25, 0.75; 0.75, 0.750];
Ls = [L];
sigma = 0.12;
s_attempt_list= [];

sigma_sq = sigma^2;
delta = 0.1;
n_steps = 10^5;
succesful_attempt = 0;
for i = 1:n_steps
    a_rand = randi([1,4]);
    a = L(a_rand,1:2);
    b = [a(1) + 2*delta*rand - delta, a(2) + 2*delta*rand - delta];
    L_tmp = L;
    L_tmp(a_rand, :) = [];
    min_dist = min(sum((b - L_tmp).^2,2));
    if b(1,1) > sigma & b(1,2) > sigma & b(1,1) < 1-sigma & b(1,2) < 1 - sigma...
                & min_dist > 4.0 * sigma^2
            L(a_rand,:) = b;
            succesful_attempt =succesful_attempt+1;
    end
    Ls = [Ls,L];
end

% Observable
Y_positions = Ls(:,2:2:2*n_steps);
histogram(Y_positions,20,'Normalization','pdf');
xlabel('Y position', 'FontSize', 24);
ylabel('pdf', 'FontSize', 24);
set(gca, 'FontSize', 24);
title(['\sigma = ', num2str(sigma), '    n_{steps} = ', num2str(n_steps)], 'FontSize', 20);

