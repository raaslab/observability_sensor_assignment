%log_det for single target and its assigned sensors
function [ob_trace] =trace_nsen_1tar(pr,pt)
   
        obs = zeros(length(pr(:,1)), 2); 
        if isempty(pr) ~= 1
            for i = 1: length(pr(:,1)) % we want to know how many sensors
                        obs(i,:) = [pr(i,1) - pt(1,1), pr(i,2)-pt(1,2)];
            end
            aug_obs = obs'*obs;
            ob_trace = trace(aug_obs);               
        else 
             ob_trace = 0; 
        end
        
end