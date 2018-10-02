clear all;      % clears all variables in your workspace
min_num_targets  = 1;
max_num_targets = 5; %set the target from 
num_trials = 10;
uo_max=1; % maximum motion ability for the target
for M = min_num_targets : max_num_targets % start from 1 target to 30 targets
     for i = 1  : num_trials % 100 trials
            pr=zeros(2*M,2); % the position of sensor
            pt=zeros(M,2); % position of  target
            pr(:,1)=100.*rand(2*M,1);
            pr(:,2)=100.*rand(2*M,1);
            pt(:,1)=100.*rand(M,1);
            pt(:,2)=100.*rand(M,1);
            cla;
            [perfect_value(i,M),bf_uni_value(i,M), gre_uni_value(i,M)] = compare_relax_uni_logdet_fun(M,pr,pt);
     end
end
for M = min_num_targets : max_num_targets
avg_perfect(M) = mean(perfect_value(:,M));
std_perfect(M) = std(perfect_value(:,M));

avg_bf_uni(M) = mean(bf_uni_value(:,M));
std_bf_uni(M) = std(bf_uni_value(:,M));

avg_gre_uni(M) = mean(gre_uni_value(:,M));
std_gre_uni(M) = std(gre_uni_value(:,M));
end

figure; hold on;
errorbar(min_num_targets:max_num_targets,avg_perfect(min_num_targets:max_num_targets),...
    std_perfect(min_num_targets:max_num_targets), 'r');
errorbar(min_num_targets:max_num_targets,avg_bf_uni(min_num_targets:max_num_targets),...
    std_bf_uni(min_num_targets:max_num_targets), 'm');
errorbar(min_num_targets:max_num_targets,avg_gre_uni(min_num_targets:max_num_targets),...
    std_gre_uni(min_num_targets:max_num_targets),'b');
errorbar(min_num_targets:max_num_targets,1/3*avg_bf_uni(min_num_targets:max_num_targets),...
    std_bf_uni(min_num_targets:max_num_targets), 'm');
title('Comparison of Perfect Pair and Unique Pair Assignment')
legend('Perfect Pair Assignment','Brute-force Unique Pair Assignment', 'Greedy Unique Pair Assignment', ...
    '1/3 Brute-force Unique Pair Assignment');
xlabel('Number of targets');
ylabel('Total Reward');