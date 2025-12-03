function PSD = calc_PSD(Yc,df)

PS = conj(Yc) .* Yc; % compute the Power Spectrum

PSD = PS / df;       % compute the Power Spectrum Density