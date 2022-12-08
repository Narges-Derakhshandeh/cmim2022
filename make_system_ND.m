function sys = make_system_ND()
%MAKE_SYSTEM_ND CREATE a data structure to store complete multibody system
sys=struct();
sys.bodies=struct([]);
sys.joints=struct('revolute', struct([]),'simple',struct([]), ...
    'simple_driving', struct([]));


end

