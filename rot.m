function A = rot(fi)
%ROT Summary 
sfi = sin(fi);
cfi = cos(fi);

A=[cfi, -sfi
    sfi, cfi];
end

