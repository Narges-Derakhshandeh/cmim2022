function C = constraints_simple(sys,q)
%CONSTRAINTS_REVOLUTE compute constraints for the revolute joints
C = zeros(length(sys.joints.simple),1);
c_id = 0;
for j=sys.joints.simple
qi=q(j.body_qidx);
C(c_id + 1)=qi(j.coord_id) - j.coord_value;
c_id=c_id+1;
end
end