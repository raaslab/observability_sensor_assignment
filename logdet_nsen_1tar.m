%log_det for single target and its assigned sensors
function [ob_log_determ] = logdet_nsen_1tar(pr,pt)
  n = length(pr(:,1)); 
  if n > 1
        obs = zeros(length(pr(:,1)), 2); 
        for i = 1: length(pr(:,1)) % we want to know how many sensors
                    obs(i,:) = [pr(i,1) - pt(1,1), pr(i,2)-pt(1,2)];
        end
        aug_obs = obs'*obs;
        ob_log_determ = log(det(aug_obs)); 
    
  else 
        ob_log_determ = 0; 
  end
end