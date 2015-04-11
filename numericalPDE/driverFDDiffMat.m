% driverFDDiffMat.m

domain = [-1 1];
N = 10;
stencilSize = 2;
direction = 'FD';
option = 'non-periodic';

[x,h,D1,D2] = FDDiffMat( domain,N,stencilSize,direction,option);
