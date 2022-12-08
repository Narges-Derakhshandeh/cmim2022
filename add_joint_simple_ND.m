function sys = add_joint_simple_ND(sys,body_name,coord_name, value)
%ADD_JOINT  :add revolute joint definition to the system
arguments 
    sys struct
   body_name(1,1) string 
   coord_name (1,1) string 
   value(1,1)double=0
    
end 
%checking of bodies name manually
  check_body_exists(sys,body_name)
  
c_id = coordinate_name_to_id(coord_name);
%   if coord_name=="x"
%       c_id=1;
%   elseif coord_name=="y"
%       c_id=2;
%   elseif coord_name=="fi"
%       c_id=3;
%   else
%       error("Unknown coordinate name %s!", coord_name);
%   end
  
  j=struct();
  j.body_qidx=body_name_to_qidx(sys,body_name);
  j.coord_id=c_id;
  j.coord_value=value;

  sys.joints.simple=[sys.joints.simple, j];
end
