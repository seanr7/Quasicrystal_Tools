%% Calculate the kth cover of the spectrum of 2D H by adding Sigmak_1D to itself
function [SIGMAk_2D] = kthcoverH_twod(k,lambda)
%% NEW, written 3/22/2019
% SIGMAk_2D = SIGMAk_1D + SIGMAk_1D, sum of kth cover for the spectrum of 1D H
% w/ aperiodic TM potential w/ itself
SIGMAk_1D = kthcoverH(k, lambda); %calculate Sigmak_1D=sigmak_1D U sigmak+1_1D
SIGMAk_2D = sumintervals(SIGMAk_1D, SIGMAk_1D); %calculate cover for 2D TM H by adding 1D cover to itself

%% OLD, from Spring 2018
% SIGMAk = sigma1 U sigma2, kth cover for the spectrum of H w/ aperiodic TM
% potential
%sigmak = thuemorse_twod(k,lambda1,lambda2);
%SIGMAk_next_1D = thuemorse_twod(k+1,lambda1,lambda2);
%SIGMAk_2D = unionintervals(sigmak, SIGMAk_next_1D, 10e-8);
end