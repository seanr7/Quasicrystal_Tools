%% Check for convergence rate of measure of spectrum of 2D H w/ 2D TM
clc
clear all
%close all
n = 12; 
figure
for lambda = [1,2^-1,2^-2,2^-3,2^-4,2^-5]
    measures = [];
    norm = [];
    for k = 1:n
        SIGMAk = kthcoverH(k,lambda);
        SIGMAk_next = kthcoverH(k+1,lambda);
    
        m = numel(SIGMAk_next(:,1));
        SIGMAk_next = reshape(SIGMAk_next', 2*m, 1);
        SIGMAk_nextCOMP = [-inf; SIGMAk_next; inf];
        SIGMAk_nextCOMP = reshape(SIGMAk_nextCOMP', 2, m+1);
        SIGMAk_nextCOMP = SIGMAk_nextCOMP';
        
        %calc what is in SIGMAk but NOT in SIGMAk_next, i.e. the 'fat'
        %trimmed when we go to the next cover. Gives in terms of intervals
        fat = intersect(SIGMAk, SIGMAk_nextCOMP);
        tot_meas = 0;
        %tot_meas_spec = 0;
        for i = 1:numel(fat(:,1))
            if fat ~= 0
                meas = abs(fat(i,1) - fat(i,2));
                tot_meas = meas + tot_meas;
            end
        end
        %for i = 1:numel(SIGMAk(:,1))
        %    if SIGMAk ~= 0
        %        specmeas = abs(SIGMAk(i,1) - SIGMAk(i,2));
        %        tot_meas_spec = specmeas + tot_meas_spec;
        %    end
        %end
        K(k) = k;
        measures = [measures; tot_meas];
        %norm_k = tot_meas/tot_meas_spec;
        %norm = [norm; norm_k];
        
    end
    plot(K,measures,'.-','markersize',22)
    %semilogy(K,measures,'.-','markersize',22)
    %semilogy(K,norm,'.-','markersize',22,'lindwidth', 1.5)
    hold on
end
xlabel('k - index of cover')
ylabel('measure of "fat"')
legend('\lambda = 1','\lambda = 2^{-1}','\lambda = 2^{-2}','\lambda = 2^{-3}','\lambda = 2^{-4}','\lambda = 2^{-5}')
%legend('lambda = 1.5','lambda = 1.25','lambda = 1', 'lambda = .75', 'lambda = .5', 'lambda = .25')
xlim([1,n])