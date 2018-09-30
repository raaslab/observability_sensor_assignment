%to see general assign equally to each target.
clear all;      % clears all variables in your workspace
M = 5; % the number of target is fixed.
min_num_robots  = 20;
max_num_robots = 50; %set the target from 
num_trials = 30;
for N = min_num_robots : max_num_robots % start from 1 target to 30 targets
     for i = 1  : num_trials % 100 trials
            pr=zeros(N,2); % the position of sensor
            pt=zeros(M,2); % position of  target
            pr(:,1)=100.*rand(N,1);
            pr(:,2)=100.*rand(N,1);
            pt(:,1)=100.*rand(M,1);
            pt(:,2)=100.*rand(M,1);
            cla;
            [num_sensor_targeti(i,N)] = submodular_obs_fun(N,M,pr,pt);
     end
end
for N = min_num_robots : max_num_robots
avgnum_sensor_targeti(N) = mean(num_sensor_targeti(:,N));
stdnum_sensor_targeti(N) = std(num_sensor_targeti(:,N));
avgnum_sensor_pertarget(N)=N/M;
stdnum_sensor_pertargeti(N)=0;
end

figure; hold on;
errorbar(min_num_robots:max_num_robots,avgnum_sensor_targeti(min_num_robots:max_num_robots),...
    stdnum_sensor_targeti(min_num_robots:max_num_robots), 'r');
errorbar(min_num_robots:max_num_robots,avgnum_sensor_pertarget(min_num_robots:max_num_robots),...
    stdnum_sensor_pertargeti(min_num_robots:max_num_robots), 'b');

title('The number of sensors assigned to one target')
legend('Number of sensors assigned to one specific target','Number of sensors / numebr of targets');
xlabel('Number of sensors');
ylabel('Number of sensors assigned to specific target');