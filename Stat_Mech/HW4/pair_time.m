function [del_t] = pair_time(pos_a, vel_a, pos_b, vel_b, sigma)
% EventMD
% October 2016
    del_x = [pos_b(1,1) - pos_a(1,1), pos_b(1,2) - pos_a(1,2)];
    del_x_sq = del_x(1,1)^2 + del_x(1,2)^2;
    del_v = [vel_b(1,1) - vel_a(1,1), vel_b(1,2) - vel_a(1,2)];
    del_v_sq = del_v(1,1)^2 + del_v(1,2)^2;
    scal = del_v(1,1) * del_x(1,1) + del_v(1,2) * del_x(1,2);
    Upsilon = scal^2 - del_v_sq * ( del_x_sq - 4.0 * sigma^2);
    if Upsilon > 0.0 & scal < 0.0
        del_t = - (scal + sqrt(Upsilon)) / del_v_sq;
    else
        del_t = 100; %NaN
    end