function [Avg_s, RMS_s, blockLength, totalSamplesUsed] = computeBlockStats(ye, numBlocks)
% COMPUTEBLOCKSTATS Compute average and RMS for equally-sized sub-windows
Ne = length(ye);
blockLength = floor(Ne / numBlocks);
totalSamplesUsed = blockLength * numBlocks;
Avg_s = zeros(1,numBlocks);
RMS_s = zeros(1,numBlocks);


for j = 1:numBlocks
idxStart = 1 + (j-1)*blockLength;
idxEnd = j * blockLength;
segment = ye(idxStart:idxEnd);
Avg_s(j) = mean(segment);
RMS_s(j) = sqrt(mean(segment.^2));
end
end