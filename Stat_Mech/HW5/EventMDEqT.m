% EventMD
% September 2017
clear all; close all;
pos = [0.25, 0.25; 0.75, 0.25; 0.25, 0.75; 0.75, 0.75];
vel = [0.21, 0.12; 0.71, 0.18; -0.23, -0.79; 0.78, 0.1177];

singles = [1, 1; 1, 2; 2, 1; 2, 2; 3, 1; 3, 2; 4, 1; 4, 2];
pairs = [1, 2; 1, 3; 1, 4; 2, 3; 2, 4; 3, 4];
sigma = 0.12;
t = 0.0;
ts = [0];
n_events = 10^5;
DFile = [0, pos(:,1)', pos(:,2)',  vel(:,1)', vel(:,2)'];
XPosFile = [];
inter_times = [];
for event = 1:n_events
    if mod(event,int32(n_events/10)) == 0
        fprintf(['event = ', num2str(event),' of ',num2str(n_events),'\n']);
    end
    for  k = 1:8
            wall_times(k) = wall_time(pos(singles(k,1),singles(k,2)), vel(singles(k,1),singles(k,2)), sigma);
    end
    for k = 1:6
            pair_times(k) = pair_time(pos(pairs(k,1),:),vel(pairs(k,1),:),pos(pairs(k,2),:),vel(pairs(k,2),:), sigma);
    end
    next_event = min(min(wall_times), min(pair_times));
    %
    t_previous = t;
    if floor(t+ 1 + next_event) - floor(t+1) == 1
        inter_time = floor(t+1);
        inter_times = [inter_times,inter_time];
        del_t = inter_time - t_previous;
        disp(t+1-t_previous)
        for k = 1:8
            pos(singles(k,1), singles(k,2)) = pos(singles(k,1), singles(k,2)) + vel(singles(k,1), singles(k,2)) * del_t;
        end
        NewXPos = [pos(1,1);pos(2,1);pos(3,1);pos(4,1)];
        XPosFile = [XPosFile,NewXPos];
        t_previous = inter_time;
    end
    %
    t = t + next_event;
    ts = [ts;t];
    del_t = t - t_previous;
    for k = 1:8
       pos(singles(k,1), singles(k,2)) = pos(singles(k,1), singles(k,2)) + vel(singles(k,1), singles(k,2)) * del_t;
    end
    if min(wall_times) < min(pair_times)
        collision_disk = singles(find(~(wall_times - min(wall_times))),1);
        direction = singles(find(~(wall_times - min(wall_times))),2);
        vel(collision_disk, direction) = - vel(collision_disk, direction); 
    else
        a = pairs(find(~(pair_times - next_event)), 1);
        b = pairs(find(~(pair_times - next_event)), 2);
        del_x = [pos(b,1) - pos(a,1), pos(b,2) - pos(a,2)];
        abs_x = sqrt(del_x(1,1)^2 + del_x(1,2)^2);
        e_perp = del_x/abs_x;
        del_v = [vel(b,1) - vel(a,1), vel(b,2) - vel(a,2)];
        scal = del_v(1,1) * e_perp(1,1) + del_v(1,2) * e_perp(1,2);
        for k = 1:2
            vel(a,k) = vel(a,k) + e_perp(1,k) * scal;
            vel(b,k) = vel(b,k) - e_perp(1,k) * scal;
        end
    end
% DFile: Column 1: Event times; 
% Columns 2,3,4,5: x-positions; Columns 6, 7, 8, 9; y-positions; 
% Columns 10, 11, 12, 13: x-velocities; Columns 14, 15, 16, 17:
% y-velocities.
    DFile = [DFile; t, pos(:,1)', pos(:,2)',  vel(:,1)', vel(:,2)'];
end

% Observable: Event Xs
figure(1);
X_positions_Events = DFile(:,2:5);
histogram(X_positions_Events,20);
xlabel('X position', 'FontSize', 24);
ylabel('Count', 'FontSize', 24);
set(gca, 'FontSize', 24);
title({['X positions from Events'];['\sigma = ', num2str(sigma), ',     n_{events} = ', num2str(n_events)]}, 'FontSize', 20);
%
% Observable: Event Ys
figure(2);
Y_positions_Events = DFile(:,6:9);
histogram(Y_positions_Events,20);
xlabel('Y position', 'FontSize', 24);
ylabel('Count', 'FontSize', 24);
set(gca, 'FontSize', 24);
title({['Y positions from Events'];['\sigma = ', num2str(sigma), ',     n_{events} = ', num2str(n_events)]}, 'FontSize', 20);
%
% Observable: X
figure(3);
X_positions = reshape(XPosFile, [size(XPosFile,1)*size(XPosFile,2),1]);
histogram(X_positions,20);
xlabel('X position', 'FontSize', 24);
ylabel('Count', 'FontSize', 24);
set(gca, 'FontSize', 24);
title({['X positions at Ts'];['\sigma = ', num2str(sigma), ',     n_{events} = ', num2str(n_events)]}, 'FontSize', 20);

                          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
