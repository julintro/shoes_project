function [te, ye, ind_in, ind_fi] = selectTimeWindow(t, y)
% SELECTTIMEWINDOW Interactive/manual selection of a time window
% Modes:
% 1 = mouse selection (ginput)
% 2 = start and end times manually
% 3 = start time + number of points


disp('--- Signal selection ---');
disp('1 = select with mouse');
disp('2 = enter start and end times manually');
disp('3 = enter start time and number of points manually');
modeSel = input('Select mode (1/2/3): ');


switch modeSel
case 1
figure(gcf);
[px,~] = ginput(2);
pin = px(1); pfi = px(2);
ind_in = find(t >= pin, 1, 'first');
ind_fi = find(t <= pfi, 1, 'last');
te = t(ind_in:ind_fi);
ye = y(ind_in:ind_fi);
case 2
pin = input('Enter start time [s]: ');
pfi = input('Enter end time [s]: ');
ind_in = find(t >= pin, 1, 'first');
ind_fi = find(t <= pfi, 1, 'last');
te = t(ind_in:ind_fi);
ye = y(ind_in:ind_fi);
case 3
pin = input('Enter start time [s]: ');
Np = input('Enter number of points: ');
[~,indStart] = min(abs(t-pin));
indEnd = indStart + Np - 1;
% bounds check
if indEnd > length(t)
indEnd = length(t);
end
ind_in = indStart; ind_fi = indEnd;
te = t(indStart:indEnd);
ye = y(indStart:indEnd);
otherwise
error('Invalid selection mode');
end
end