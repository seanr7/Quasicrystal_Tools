%% Calculate spectra of Hamiltionian op for 2D quasicrystals with Thue-Moorse potential
function [I] = thuemorse_twod(k,lambda1,lambda2)
    if lambda1 == lambda2
        I1 = thuemorse(k,lambda1);
        I2 = I1;
        I = sumintervals(I1,I2);
    else
        I1 = thuemorse(k,lambda1);
        I2 = thuemorse(k,lambda2);
        I = sumintervals(I1,I2);
    end
end