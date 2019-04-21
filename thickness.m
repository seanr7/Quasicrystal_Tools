%% code to measure thinkness of a cantor set
function[thickness] = thickness(Sigmak)
% Sigmak == inputted collection of intervals/approx cantor set
% thickness == thickness of inputted (approx) cantor set
n = numel(Sigmak(:,1)); %no. of intervals in inputted union
U = zeros(n-1,2); %preallocate zero matrix to store gaps, n intervals --> n-1 gaps
for i = 1:n-1 %loop through sigmak to get a set of gaps
    U(i,1) = Sigmak(i,2);
    U(i,2) = Sigmak(i+1,1);
end
gapsize = zeros(n-1,1); %preallocate zero matrix to store lengths of gaps
for i = 1:n-1
    gapsize(i) = abs(U(i,2)-U(i,1)); % find lengths of gaps. ith entry corresponds to size of ith gap
end
% HOW TO ACCOUNT FOR ROUNDING ERROS IN GAPS (temp solution for now below)
tol = 10e-10; %tolerance to 'kill' gaps at, may make input var
for i = 1:n-1
    if gapsize(i) < tol %if gap sizes are smaller than accepted tolerance (due to rounding errors)
        gapsize(i) = 0; %redefine to be 0, as they effectively are
    end
end
x = find(gapsize); %find indices associated w/ nonzero gaps
[gapsize_sorted, index] = sort(gapsize(x)); %sorts gaps by dec. size/length
U1 = U(:,1); %left endpts of gaps to be sorted
U2 = U(:,2); %right endpts of gaps to be sorted
U1 = U1(x); U2 = U2(x); %get endpts of nonzero gaps
U_sorted = [U1(index), U2(index)]; %store sorted gaps 

k = 1; %counter for storing thicknesses
m = numel(U_sorted(:,1)); %no. of nonzero gaps
I = [Sigmak(1,1), Sigmak(n,2)]; %define convex hull
thicknesses = zeros(2*m,1);
for j = 1:m %loop over no. of nonzero gaps
    for i = 1:j %iterate through to remove the first j gaps from the hull 
        if i == 1
            IremUj = zeros(j+1,2); %removing j gaps in the hull so j + 1 ints in the hull
            IremUj(1,1) = I(1,1); %left most endpoint of hull remove j gaps is left most end point of the hull
            IremUj(j+1,2) = I(1,2); %right most endpt of j+1th band is right endpt of the hull
            U1 = sort(U_sorted(1:j,1)); U2 = sort(U_sorted(1:j,2)); %removing first j intervals, sorted by length. resort these by their endpoints
        end
        IremUj(i,2) = U1(i); %create left endpoint of ith gap in hull 
        IremUj(i+1,1)= U2(i); %create right endponit of ith gap in hull
    end
    %ujleft = IremUj(j,2); %find ujleft, left boundary point of last gap and last connected component (MAY BE UNNEEDED)
    %Kl = [IremUj(j,1), IremUj(j,2)]; %find int/connected component in IremUj (hull remove first j gaps) which shares ujleft as a boundary point w/ gap Uj
    %ujright = IremUj(j+1,1); %find ujright, right boundary point of last gap and last connected component (MAY BE UNNEEDED)
    %Kr = [IremUj(j+1,1), IremUj(j+1,2)]; %find int/connected component in IremUj, hull remove first j gaps, which shares ujright as a boundary point w/ gap Uj
    
    ujleft = U_sorted(j,1) ; ujright = U_sorted(j,2); %find left and right boundary points of jth gap in IremUj, last removed gap in the hull
    [ujleft_index, ~] = find(IremUj == ujleft); [ujright_index, ~] = find(IremUj == ujright); % find index of connected components of IremUj which contain boundary points
    Kl = [IremUj(ujleft_index,1), IremUj(ujleft_index,2)]; %find int/connected component in IremUj (hull remove first j gaps) which shares ujleft as a boundary point w/ gap Uj
    Kr = [IremUj(ujright_index,1), IremUj(ujright_index,2)]; %find int/connected component in IremUj, hull remove first j gaps, which shares ujright as a boundary point w/ gap Uj
    thicknesses(k) = abs(Kl(1,2) - Kl(1,1))/gapsize_sorted(j);
    thicknesses(k+1) = abs(Kr(1,2) - Kr(1,1))/gapsize_sorted(j);
    k = k+2;
end
thicknesses = sort(thicknesses);
thickness = thicknesses(1); 
end