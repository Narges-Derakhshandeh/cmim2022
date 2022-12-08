function sys = add_body_ND(sys,name, location, orientation)
%ADD_BODY_ND add single body to our multibody system

% if nargin<4
%     orientation=0;
% end

arguments 
    sys struct
    name (1,1) string 
    location (2,1)double=[0;0]
    orientation (1,1)double=0
end 
   body=struct("name",name);
    body.location=location;
    body.orientation=orientation;
    
    sys.bodies=[sys.bodies,body];


end

