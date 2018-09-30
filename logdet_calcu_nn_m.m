function [ob_log_determ] = logdet_calcu_nn_m(pr,pt,N,M)

    ob_log_determ=zeros(N*N,M);
    for i=1:N
        for j=1:N 
                 for k=1:M
                     if i~=j
                         obs=[pr(i,1)-pt(k,1), pr(i,2)-pt(k,2); pr(j,1)-pt(k,1), pr(j,2)-pt(k,2)];
                         aug_obs = obs'*obs;
                         %robot pair i, j and target k
                         ob_log_determ(N*(i-1)+j,k)=log(det(aug_obs));
                     else
                         ob_log_determ(N*(i-1)+j,k)=0;
                     end

                 end     
        end
    end
end