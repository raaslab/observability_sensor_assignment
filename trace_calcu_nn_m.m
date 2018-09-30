function [trace_redo] = trace_calcu_nn_m(pr,pt,N,M)

    trace_redo=zeros(N*N,M);
    for i=1:N
        for j=1:N 
                 for k=1:M
                     if i~=j
                         obs=[pr(i,1)-pt(k,1), pr(i,2)-pt(k,2); pr(j,1)-pt(k,1), pr(j,2)-pt(k,2)];                      
                     else
                        obs=[pr(i,1)-pt(k,1), pr(i,2)-pt(k,2)];
                     end                     
                     aug_obs = obs'*obs;
                     %robot pair i, j and target k
                     trace_redo(N*(i-1)+j,k)=trace(aug_obs);

                 end     
        end
    end
end