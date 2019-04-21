%% Function to sum unions of closed intervals (checked: 3-21-2019) (sum unions by taking all possible sums right? as in, add int in first union to EVERY int in the second union. repeat for all ints in first union)
function [I] = sumintervals(I1,I2)
% I1 = first union of ordered intervals to sum
% I2 = second union of ordered intervals to sum
L1 = I1(:,1); %left endpoints of I1
R1 = I1(:,2); %right endpoints of I1

L2 = I2(:,1); %left endpoints of I2
R2 = I2(:,2); %right endpoints of I2

%% tool to sum intervals
I = zeros(numel(L1)*numel(L2),2); %preallocate space for sums of every interval with every other
for i = 1:numel(L1)  %running slow through ints in I1
    for j = 1:numel(L2) %running fast through ints in I2
        I((i - 1)*numel(L1) + j,1) = L1(i) + L2(j); %add ith distinct interval in I1 to jth distinct interval in I2
        I((i - 1)*numel(L1) + j,2) = R1(i) + R2(j); 
    end
end
I = unionintervals(I,[],10e-8); %after taking all possible sums of intervals, take union to remove redundancies 
end
