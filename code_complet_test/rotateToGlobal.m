function [aLx, aLy, aLz, aM, aLxy] = rotateToGlobal(aS, roll, pitch, yaw)
% ROTATETOGLOBAL Rotate sensor-frame accelerations into global (ENU) frame
% Uses Z-Y-X (yaw-pitch-roll) intrinsic rotation sequence


N = size(aS,1);
aL = zeros(N,3);


for k = 1:N
phi = roll(k);
theta = pitch(k);
psi = yaw(k);


Rz = [cos(psi) -sin(psi) 0;
sin(psi) cos(psi) 0;
0 0 1];
Ry = [ cos(theta) 0 sin(theta);
0 1 0;
-sin(theta) 0 cos(theta)];
Rx = [1 0 0;
0 cos(phi) -sin(phi);
0 sin(phi) cos(phi)];


R = Rz * Ry * Rx;
aL(k,:) = (R * aS(k,:).').';
end


aLx = aL(:,1);
aLy = aL(:,2);
aLz = aL(:,3);
aLxy = sqrt(aLx.^2 + aLy.^2);
aM = sqrt(aLx.^2 + aLy.^2 + aLz.^2);
end