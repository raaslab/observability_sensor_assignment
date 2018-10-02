%compare the perfect pair assignment and unique pair assignment(bf+greedy) with invcond
% this function describe how to make perfect matching and unique pair assignment
function [perfect_value, bf_uni_value, gre_uni_value] = compare_relax_uni_invcond_fun(M,pr,pt)

    pr_store = pr; % store the original sensor
    pt_store = pt; % store the original target

    %using low_invcond
    invcond_nn_m=invcond_calcu_nn_m(pr,pt,length(pr(:,1)),length(pt(:,1)));

    %%%three assignment algorithms
    % 1 perfect assignment
    [perfect_value, ~, ~]=bipartite_matching(invcond_nn_m);

    % 2 brute-force unique pair assignment
    [bf_uni_value, ~] = assign_bf_unipair_invcond_fun(2*M, M, pr, pt); 

    % 3 greedy unique pair  assignment
    unique_eachstep=zeros(M,1);
    s_selected=zeros(M,2);
    r_pair_t_index = zeros(M,3);
    for t=1:M
        unique_eachstep(t)=max(max(invcond_nn_m));
        [row_max,col_max]=find(invcond_nn_m==unique_eachstep(t)); % how to make it unique??

        % find the index of the target
        t_index = find(ismember(pt_store,pt(col_max(1),:),'rows'));

        pt(col_max(1),:)=[]; % delete the target has been tracked

        s_selected(t,1)=fix((row_max(1)-1)/length(pr(:,1)))+1;
        s_selected(t,2)=mod(row_max(1)-1,length(pr(:,1)))+1;% find the sensor index
        % find the index of the sensor
        s1_index = find(ismember(pr_store,pr(s_selected(t,1),:),'rows'));
        s2_index = find(ismember(pr_store,pr(s_selected(t,2),:),'rows'));

        pr([s_selected(t,1); s_selected(t,2)],:)=[];
        %pr(s_selected(t,2),:)=[]; %delete the sensor pair has been used. 
        r_pair_t_index(t,:) = [s1_index,s2_index,t_index]; %%% find which row in previosus not reduced!

        invcond_nn_m=invcond_calcu_nn_m(pr,pt, length(pr(:,1)),length(pt(:,1)));
        %low_bound=invercond(pr,pt,uo_max,length(pr(:,1)),length(pt(:,1)));

    end
    gre_uni_value=sum(unique_eachstep);
    %appro_ratio=unique_value/perfectvalue; 
end