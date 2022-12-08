function sys = add_joint_revolute_ND(sys,body_i,body_j, s_i,s_j)
%ADD_JOINT  :add revolute joint definition to the system
arguments 
    sys struct
   body_i (1,1) string 
   body_j (1,1) string 
    s_i (2,1)double=[0;0]
    s_j (2,1)double=[0;0]
end 

%checking of bodies name manually
  check_body_exists(sys,body_i)
  check_body_exists(sys,body_j)

joint=struct();
    joint.body_i_qidx=body_name_to_qidx(sys,body_i);
    joint.body_j_qidx=body_name_to_qidx(sys,body_j);
    joint.s_i=s_i;
    joint.s_j=s_j;
   
    
    sys.joints.revolute=[sys.joints.revolute, joint];


end

