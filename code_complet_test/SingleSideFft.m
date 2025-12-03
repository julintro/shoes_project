function Yc = SingleSideFft(yn)

Ne = length(yn);
Yc_ds = fft(yn) / Ne;        % double-sided, normalized

% --- build single-sided spectrum length ---
if mod(Ne,2) == 1
    Lc = round(Ne/2);        % odd length: no Nyquist bin
else
    Lc = round(Ne/2) + 1;    % even length: include Nyquist
end


% --- single-sided extraction ---
Yc  = Yc_ds(1:Lc);           % single-sided complex spectrum

% --- single-sided amplitude normalization ---
Yc = 2 * Yc;                 % recover energy of negative half
Yc(1) = Yc(1) / 2;           % DC not doubled
if mod(Ne,2) == 0
    Yc(end) = Yc(end) / 2;   % Nyquist not doubled
end