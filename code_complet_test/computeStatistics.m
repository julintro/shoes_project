function Stats = computeStatistics(ye)
% COMPUTESTATISTICS Compute stats for a vector signal
Avg = mean(ye);
Max = max(ye);
Min = min(ye);
RMS = sqrt(mean(ye.^2));
Std_dev = std(ye);
Pk_pk = Max - Min;
CF = max(abs(ye)) / RMS;


N = length(ye);
mu = Avg;
sigma = Std_dev;
if sigma == 0
Sk = 0; Kurt = 0;
else
Sk = (1/N) * sum(((ye - mu)/sigma).^3);
Kurt = (1/N) * sum(((ye - mu)/sigma).^4);
end


Stats = struct();
Stats.Average = Avg;
Stats.Maximum = Max;
Stats.Minimum = Min;
Stats.StandardDeviation = Std_dev;
Stats.RMS = RMS;
Stats.PeakToPeak = Pk_pk;
Stats.CrestFactor = CF;
Stats.Skewness = Sk;
Stats.Kurtosis = Kurt;
end