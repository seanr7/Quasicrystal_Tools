%% Tool to take unions of closed intervals (tested: 3-21-2019)
function [ints] = unionintervals(I_1, I_2, tol)
%I_1 = First set of distinct intervals
%I_2 = Second set of distinct intervals
%tol = tolerance to account for rounding errors
%ints = output, union of all intervals in two sets of distinct ints

%made for the sake of constructing covers to sigma(H), H with aperiodic 
%thue-morse potential
I = [I_1; I_2]; %stack sets of intervals to union atop eachother 
[~,index] = sort(I(:,1)); %gives vector 'index' containing place of all left endpts in ordering w.r.t. each other
I = I(index,:); %sort intervals in order of increasing left endpoints

L = I(:,1); %left endpoints, ordered
R = I(:,2); %right endpoints, not nec ordered w.r.t. each other

%% tool to union intervals
%newint = 'working interval'. used to check against 'next' interval in input for gaps
ints = []; %store union as intervals in mx2 array, where m is the no. of distinct intervals in the union once it is calculated. starts as empty
newint = I(1,:); %first working interval
n = numel(I(:,1));
for i = 2:n
    if L(i) > newint(2) + tol %create new interval if there's a gap between right endpt of current working interval and left endpt of the next interval to union w/
        ints = [ints; newint]; %create gap in union by storing next working interval as a distinct interval in the union
        newint = I(i,:); %save next working interval, last distinct interval in union
    else if R(i) > newint(2) + tol %check to extend working interval (if there's no gap)
            newint(2) = R(i); %extend right endpt of current working interval
        end
    end
end
ints = [ints; newint]; %append last working interval, accounts for case of the union having no gaps. also, if the last step was an extension, this appends the last working interval
end