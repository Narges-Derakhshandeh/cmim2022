function c_id = coordinate_name_to_id(coord_name)
%COORDINATE_NAME TO_ Summary of this function goes here
%   Detailed explanation goes here
 if coord_name=="x"
      c_id=1;
  elseif coord_name=="y"
      c_id=2;
  elseif coord_name=="fi"
      c_id=3;
  else
      error("Unknown coordinate name %s!", coord_name);
  end
  
end

