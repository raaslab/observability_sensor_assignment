%brute-force unique pair assignment by trace.
function [max_logdet, t_spair_index] = assign_bf_unipair_logdet_fun(N, M, pr, pt)
    % get sensors id
    sensors_id = [1:N];
    %once we have sensors_id, we get all the possible cases
    % it is a [n_row, N] matrix
    %choose the first pair
    sensor_perms = nchoosek(sensors_id,2);
    %choose the following pairs
    for t = 1 : M-1
        P2 = [];
        for i = 1 : size(sensor_perms,1)
            B=nchoosek(setdiff(sensors_id,sensor_perms(i,:)),2);
            P2 = [P2; repmat(sensor_perms(i,:),size(B,1),1) B];
        end
        sensor_perms = P2;
    end
    
    [n_row, ~] = size(sensor_perms); 
    %for each possible case, it will be assigned to target, 1, ..., M
    % and it has a sum of trace with respct to targets. 
    logdet_eachrow = zeros(1, n_row);
    for i = 1 : n_row
        allt_erow_logdet = zeros(1, M);
        for j = 1 : M
            allt_erow_logdet(j) = logdet_nsen_1tar(pr(sensor_perms(i, 2*j-1:2*j), :), pt(j,:));
        end
        logdet_eachrow(i) = sum(allt_erow_logdet); 
    end
    %calculate the max_trace and its index
    [max_logdet, max_inx] = max(logdet_eachrow); 
    %calculate the tar_sensor_index, located at the max_inx, 1:2M
    t_spair_index = sensor_perms(max_inx, :);
end
