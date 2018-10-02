%brute-force unique pair assignment by trace.
function [max_logdet, t_spair_index] = assign_bf_unipair_logdet_fun(N, M, pr, pt)
    % get sensors id
    sensors_id = zeros(1, N);
    for i = 1 : N
        sensors_id(i) = i; 
    end
    %once we have sensors_id, we get all the permutations
    % it is a [n_row, N] matrix
    sensor_perms = perms(sensors_id); 
    [n_row, ~] = size(sensor_perms); 
    %for each possible case, it will be assigned to target, 1, ..., M
    % and it has a sum of trace with respct to targets. 
    logdet_eachrow = zeros(1, n_row);
    for i = 1 : n_row
        allt_erow_logdet = zeros(1, M);
        for j = 1 : M
            allt_erow_logdet(j) = logdet_nsensor_1tar(pr(sensor_perms(i, 2*j-1:2*j), :), pt(j,:));
        end
        logdet_eachrow(i) = sum(allt_erow_logdet); 
    end
    %calculate the max_trace and its index
    [max_logdet, max_inx] = max(logdet_eachrow); 
    %calculate the tar_sensor_index, located at the max_inx, 1:2M
    t_spair_index = sensor_perms(max_inx, 1:2*M);
end
