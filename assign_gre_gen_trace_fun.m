% greedy general assignemnt by trace measure
function [sensor_assignto_target_index, num_sensor_targeti] = assign_gre_gen_trace_fun(N,M,pr,pt)
    sensor_selected=[]; % define a set for the sensors have been selected
    for j = 1 : M %targets
        obs_sensor_target{j} = [];
    end
    sensor_assignto_target_index=zeros(M,N);%for each target, label the sensors that has been assigned to it 

    for k=1:N % the maximum timestep to update the table
        trace_diff_table=zeros(N,M); % for each step, calculate the trace table 
        obs_temp=obs_sensor_target;
        for i=1:N  
            if ismember(i,sensor_selected)==0 % sensor i has not been selected
                for j = 1:M
                     obs_sensor_target{j}=[obs_temp{j}; (pt(j,1)-pr(i,1)),(pt(j,2)-pr(i,2))]; % calculate the relative position part of obs
                     aug_obs=obs_sensor_target{j}'*obs_sensor_target{j}; % calculate augment system O^{T}O 
                     %trace_diff_table(i,j)=log(det(aug_obs)) - log(det(obs_temp{j}'*obs_temp{j}));
                     trace_diff_table(i,j)=trace(aug_obs) - trace(obs_temp{j}'*obs_temp{j});
                end
            else % if the sensor i has been selected
                    % this raw can be set to 0;
            end
        end
            obs_sensor_target = obs_temp;
            max_trace=max(max(trace_diff_table)); % calculate the maximum value of the table
            [row_max,col_max]=find(trace_diff_table==max_trace); % find the index of maximum value
            sensor_selected=[sensor_selected; row_max(1)]; % put the selected sensor to selected sensor set
            obs_sensor_target{col_max(1)}=[obs_sensor_target{col_max(1)};...
                                                                (pt(col_max(1),1)-pr(row_max(1),1)),(pt(col_max(1),2)-pr(row_max(1),2))];
            sensor_assignto_target_index(col_max(1),k)=row_max(1); % for selected target, keep its selected sensor       
    end
          num_sensor_targeti = length(find(sensor_assignto_target_index(1,:)));
          %sensor_assignto_target_index give us 
end