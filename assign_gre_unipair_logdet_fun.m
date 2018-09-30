%greedy unique pair assignment by trace.
function [r_pair_t_index] = assign_gre_unipair_logdet_fun(M,pr,pt)

    pr_store = pr; % store the original sensor
    pt_store = pt; % store the original target

    %calculate the logdet for N sensors and M targets to a matrix [N*N, M]
    logdet_nn_m=logdet_calcu_nn_m(pr,pt,length(pr(:,1)),length(pt(:,1)));

    % unique pair assignment
    unique_eachstep=zeros(M,1);
    s_selected=zeros(M,2);
    r_pair_t_index = zeros(M,3);
    for t=1:M
        unique_eachstep(t)=max(max(logdet_nn_m));
        [row_max,col_max]=find(logdet_nn_m==unique_eachstep(t)); % how to make it unique??

        % find the index of the target
        t_index = find(ismember(pt_store,pt(col_max(1),:),'rows'));

        pt(col_max(1),:)=[]; % delete the target has been tracked

        s_selected(t,1)=fix((row_max(1)-1)/length(pr(:,1)))+1;
        s_selected(t,2)=mod(row_max(1)-1,length(pr(:,1)))+1;% find the sensor index
        % find the index of the sensor
        s1_index = find(ismember(pr_store,pr(s_selected(t,1),:),'rows'));
        s2_index = find(ismember(pr_store,pr(s_selected(t,2),:),'rows'));

        %delete the sensor pair has been used. 
        pr([s_selected(t,1); s_selected(t,2)],:)=[];

        r_pair_t_index(t,:) = [s1_index,s2_index,t_index]; %%% find which row in previosus not reduced!

        %calculate the new logdet table [(n-2)(n-2), m-1]. 
        logdet_nn_m=logdet_calcu_nn_m(pr,pt,length(pr(:,1)),length(pt(:,1))); 

    end
end