%% function to generate thue-morse words after k iterations, then calculate spectra of the kth periodic approximations to H w/ aperiodic TM potential
function [I, V, p] = thuemorse(k,lambda)
% k = no. of substitutions according to primitive substitution rules
% V = potential after k substitutions according to thue-moorse
% I = sorted eigenvalues of resulting periodic schrodinger operator, stored as intervals  
% lambda = 'coupling'

V = lambda; %define coupling
for j = 1:k %initiate loop to generate periodic thue-morse potential
    V = [V, lambda - V]; 
end
V = V';
p = numel(V); %define period of potential
off = ones(p,1);
J = spdiags([off V off],-1:1,p,p); %store J as a sparse tridiagonal matrix 

%store exponential values for corner matrices
e(1,1) = 1; %exp(0)
e(2,1) = -1; %e^+-ipi
e(3,1) = -1; %e^+-ipi

%% calculate spectra of matrix eval @ theta = 0
J(1,p) = J(1,p) + e(1,1);
J(p,1) = J(p,1) + e(1,1);
Jnew = reorder_jac(J); %for computational cost
E_0 = eig(Jnew); %store eigenvalues of matrix eval @ theta = 0
J(1,p) = 0; %reset corner entries
J(p,1) = 0;

%% calculate spectra of matrix eval @ theta = pi
J(1,p) = J(1,p) + e(3,1);
J(p,1) = J(p,1) + e(2,1);
Jnew = reorder_jac(J);
E_pi = eig(Jnew); %store eigenvalues of matrix eval @ theta = pi

%these computations produce 2*p eigenvalues, and we can generate the
%spectra of the Jacobi matrix as k intervals with end points as these
%eigenvalues. note, that the internal part of the intervals stems from
%0<theta<pi, but theta = 0 and theta = pi give the endpoints, thus we only
%need to explicitly calculate those.

%% sort eigenvalues of kth periodic approx as intervals
E = [E_0' E_pi'];
E = sort(E, 'ascend');

I = zeros(p,2);
for i = 2:2:2*p %store eigenvalue spectra as intervals, these are sorted
    I(i/2,1) = E(1,i-1) ;
    I(i/2,2) = E(1,i);
end   
end