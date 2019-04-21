
 function Jnew = reorder_jac(J);
%
% function Jnew = reorder_jac(J);
%
% reorders tridiagonal (Jacobi) matrix + corner entries
% to a pentadiagonal form (no corner entries.
% 
% Note: Jnew is stored as a sparse matrix

 [n,n] = size(J);

 p = zeros(n,1);
 if rem(n,2)==0
    p(1:2:end) = [1:round(n/2)]';
    p(2:2:end) = [n:-1:round(n/2)+1]';
 else
    p(1:2:end) = [n:-1:ceil(n/2)]';
    p(2:2:end) = [1:floor(n/2)]';
 end

 Jnew = sparse(J(p,p)); 
  
