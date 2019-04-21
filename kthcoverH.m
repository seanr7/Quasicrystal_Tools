%% Calculate the kth cover of the spectrum of H by unioning sigmak and sigmak+1
function [SIGMAk] = kthcoverH(k,lambda)
% take SIGMAk = sigmak U sigmak+1, kth cover for the spectrum of H w/ 
% aperiodic TM potential
sigmak = thuemorse(k,lambda); %calculate sigmak, spectra of kth periodic approx
sigmak_next = thuemorse(k+1,lambda); %calculate sigmak+1, spectra of k+1th periodic approx
SIGMAk = unionintervals(sigmak, sigmak_next, 10e-8); %take sigmak U sigmak+1 to give SIGMAk, kth cover
end