%log_det for single target and its assigned sensors
function [ob_trace] =trace_nsensor_1tar(pr,pt)
   
        obs = zeros(length(pr(:,1)), 2); 
        if length(pr(:,1)) >0
            for i = 1: length(pr(:,1)) % we want to know how many sensors
                        obs(i,:) = [pr(i,1) - pt(1,1), pr(i,2)-pt(1,2)];
            end
            aug_obs = obs'*obs;
            ob_trace = trace(aug_obs);    
            
        else 
             ob_trace = 0; 
        end
        
end