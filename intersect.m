%% Tool to take intersections of two closed intervals on the real line w/ finite endpts, by taking the compliment of the union of the compliment of these intervals
function [unioncomp] = intersect(ints1,ints2)

% ints1 = finite ordered collection of intervals (this is a 'union') 
% ints2 = finte ordered collection of intervals
unioncomp = [0,0]; % returns 'empty set' in the case of no intersect 
% MAY NEED TO CHANGE THIS CHECKING FOR FAT TRIM
% SWITCHED FROM [0] to [0,0] ON 4/20/18, JUST IN CASE THIS CREATES ERRORES
% ELSEWHERE. CHANGED FOR 2D FAT TRIM
%% take compliment of ints1
n =  numel(ints1(:,1));
I_1 = reshape(ints1', 2*n, 1); %reshape ints1 to be a 2nx1 col vector
I_1comp = [-inf; I_1; inf]; %place -inf, inf on top of reshaped col vector
I_1comp = reshape(I_1comp', 2, n+1); %reshape above comp vector
I_1comp = I_1comp'; %transpose, overall above lines has affects of complimenting ints 1

%% take compliment of ints2
m = numel(ints2(:,1)); 
I_2 = reshape(ints2', 2*m, 1); %reshape ints2 to be a 2nx1 col vector
I_2comp = [-inf; I_2; inf]; %place -inf, inf on top of reshaped col vector
I_2comp = reshape(I_2comp', 2, m+1); %reshape above comp vector
I_2comp = I_2comp';%transpose, overall above lines has affects of complimenting ints 2
%% take union of previously complimented ints, then rearrange
union = unionintervals(I_1comp, I_2comp, 10e-8); % default tol is 10e-8. take union of complimented intervals
k = numel(union(:,1));
% take compliment of the union 
for i = 1:k-1 
    unioncomp(i,1) = union(i,2);
    unioncomp(i,2) = union(i+1,1);
end
end