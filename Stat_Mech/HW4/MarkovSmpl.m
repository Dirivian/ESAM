% October 2017 -- MarkovSmpl
clear all; close all;
L = [0.25, 0.25; 0.75, 0.25; 0.25, 0.75; 0.75, 0.750];
Ls = [L];
sigma = 0.12;
s_attempt_list= [];
for sigma = 0.10:0.01:0.4
sigma_sq = sigma^2;
delta = 0.1;
n_steps = 10^3;
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
s_attempt_list = [s_attempt_list,succesful_attempt];
end

plot(0.10:0.01:0.4,s_attempt_list)
ylabel('Succesful attempts')
xlabel('\sigma')
% r = sigma;
% ang = 0:0.01:2*pi;
% xp = r*cos(ang); yp = r*sin(ang);
% figure(1);
% for i = 1:2:2*(n_steps+1)
%     hold off;
%    plot(zeros(1,100), linspace(0,1), 'k-'); hold on;
%    plot(ones(1,100), linspace(0,1), 'k-'); hold on;
%     axis([0, 1, 0, 1]); axis equal;
% plot(Ls(1, i)+xp, Ls(1, i+1)+yp, 'r')
% hold on;
%     axis([0, 1, 0, 1]); axis equal;
% plot(Ls(2,i)+xp, Ls(2,i+1)+yp, 'b')
% hold on;
%     axis([0, 1, 0, 1]); axis equal;
% plot(Ls(3,i)+xp, Ls(3,i+1)+yp, 'g')
% hold on;
%     axis([0, 1, 0, 1]); axis equal;
% plot(Ls(4,i)+xp, Ls(4,i+1)+yp, 'k')
% title(['Time = ', num2str(round(i/2))], 'FontSize', 20)
% pause
% end

