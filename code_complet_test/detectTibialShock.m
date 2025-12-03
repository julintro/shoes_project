function [peakVals, peakTimes, tibialShock_ms2, tibialShock_g, TibialShockTable, stepStats] = ...
detectTibialShock(ye, te, fs, params)
% DETECTTIBIALSHOCK Detect impact peaks (tibial shock) from vertical accel
% params fields expected:
% .minStepTime (s)
% .minPeakProm (m/s^2)
% .searchWinSec (s) window before candidate to find true peak


if ~isfield(params,'minStepTime'); params.minStepTime = 0.55; end
if ~isfield(params,'minPeakProm'); params.minPeakProm = 20; end
if ~isfield(params,'searchWinSec'); params.searchWinSec = 0.08; end


minPeakDistance = round(params.minStepTime * fs);
minPeakProm = params.minPeakProm;
searchWin = round(params.searchWinSec * fs);


fprintf('\nPeak detection parameters:\n');
fprintf(' MinPeakDistance = %d samples (%.3f s)\n', minPeakDistance, params.minStepTime);
fprintf(' MinPeakProminence = %.2f m/s^2\n', minPeakProm);


[pk_cand, loc_cand] = findpeaks(ye, 'MinPeakDistance', minPeakDistance, 'MinPeakProminence', minPeakProm);
if isempty(pk_cand)
warning('No candidate impact peaks found.');
peakVals = []; peakTimes = []; TibialShockTable = table(); tibialShock_ms2 = []; tibialShock_g = [];
stepStats = struct('mean',NaN,'std',NaN,'max',NaN,'min',NaN);
return
end

peakVals = zeros(size(pk_cand));
peakLocs = zeros(size(pk_cand));


for i = 1:length(loc_cand)
idxEnd = loc_cand(i);
idxStart = max(idxEnd - searchWin, 1);
[valMax, idxRel] = max(ye(idxStart:idxEnd));
peakVals(i) = valMax;
peakLocs(i) = idxStart + idxRel - 1;
end


[peakLocs, uniqIdx] = unique(peakLocs, 'stable');
peakVals = peakVals(uniqIdx);


% convert to times and stats
peakTimes = te(peakLocs);
nSteps = length(peakVals);
fprintf('Detected %d refined impact peaks (steps) in the selected window.\n', nSteps);


tibialShock_ms2 = peakVals;
tibialShock_g = peakVals / 9.81;


% meanShock_ms2 = mean(tibialShock_ms2);
% stdShock_ms2 = std(tibialShock_ms2);
% maxShock_ms2 = max(tibialShock_ms2);
% minShock_ms2 = min(tibialShock_ms2);
% 
% meanShock_g = mean(tibialShock_g);

% Summary table
StepIndex = (1:nSteps).';
PeakTime_s = peakTimes(:);
Shock_ms2 = tibialShock_ms2(:);
Shock_g = tibialShock_g(:);
TibialShockTable = table(StepIndex, PeakTime_s, Shock_ms2, Shock_g);


% Plot
figure('Name','Detected impact peaks'); clf;
plot(te, ye, 'r-'); hold on;
plot(peakTimes, peakVals, 'ko','MarkerFaceColor','k');
xlabel('Time [s]'); ylabel('Vertical acceleration [m/s^2]');
title('Extracted vertical acceleration with detected impact peaks (refined)');
grid on; legend('ye','Impact peaks','Location','best'); hold off;
end


    