%invcond for single target and its assigned two sensors with u_max
function [pair_invcond] = invcond_2sensor_1tar(pr,pt)
  global u_max
  % calculate distance dis(p1,t) and dis(p2,t)
  d_s1t = norm(pr(1,:) - pt);
  d_s2t = norm(pr(2,:) - pt); 
  % distance ratio
  r = d_s2t/d_s1t; 
  % calculate the angle between the vector s1_t and s2_t
  theta2t1 = atan2(norm(cross([(pr(1,1)-pt(1,1)),(pr(1,2)-pt(1,2)),0],...
                     [(pr(2,1)-pt(1,1)),(pr(2,2)-pt(1,2)),0])),dot([(pr(1,1)-pt(1,1)),(pr(1,2)-pt(1,2)),0],...
                     [(pr(2,1)-pt(1,1)),(pr(2,2)-pt(1,2)),0]));
                 
  % maximum and minimum eigenvalues of observability matrix. 
  lambda_min=(1+r^2-sqrt(1+r^4+2*r^2*cos(2*theta2t1)))/2;
  lambda_max=(1+r^2+sqrt(1+r^4+2*r^2*cos(2*theta2t1)))/2;
  % calculate the inverse of the condition number for p1_p2_t system          
  pair_invcond=sqrt(lambda_min/(lambda_max + u_max^2/d_s1t^2));
end