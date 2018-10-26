function [del_t] = wall_time(pos_a, vel_a, sigma)
% EventMD
% September 2016
if vel_a > 0.0
    del_t = (1.0 - sigma - pos_a) / vel_a;
elseif vel_a < 0.0
    del_t = (pos_a - sigma) / abs(vel_a);
else
    del_t = 100; %NaN;
end
