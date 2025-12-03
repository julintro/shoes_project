function [blocks, blockLength, totalUsed] = splitSignalIntoBlocks(signal, numBlocks)
% splitSignalIntoBlocks - Découpe un signal en sous-fenêtres de longueurs égales
%
% INPUTS :
%   signal     : vecteur contenant le signal (ligne ou colonne)
%   numBlocks  : nombre de sous-fenêtres désirées
%
% OUTPUTS :
%   blocks      : matrice (numBlocks x blockLength) contenant les sous-fenêtres
%   blockLength : longueur de chaque sous-fenêtre
%   totalUsed   : nombre total d'échantillons réellement utilisés
%
% EXEMPLE :
%   [B, L] = splitSignalIntoBlocks(x, 4);

    % Assurer que le signal est colonne
    signal = signal(:);
    N = length(signal);

    % Longueur maximale possible par bloc
    blockLength = floor(N / numBlocks);

    % Nombre total d'échantillons utilisés
    totalUsed = blockLength * numBlocks;

    % Tronquer le signal à la plus grande longueur divisible
    signalUsed = signal(1:totalUsed);

    % Reshape en blocs
    blocks = reshape(signalUsed, blockLength, numBlocks);

end
