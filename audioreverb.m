%This function takes audio  as input and creates new version with reverb
%
% A five stage reverb filter is used
% 
%function y = audioreverb(x,Fs)
% x = input audio vestor
% Fs = sampling frequency
function y = audioreverb(x,Fs)

sizex = size(x);

if sizex(1) ~= 1
  if sizex(2) == 1
     x=x';
  else
     error(['x must be a vector'])
  end
end

G=[.75 .72 .69 .66 .63];
T=[50.1e-3 35.1e-3 24.6e-3 17.1e-3 12.1e-3];
d=round(T*Fs);

N=length(x);

y1=audiounitreverb(x ,d(1),G(1));
y2=audiounitreverb(y1,d(2),G(2));
y3=audiounitreverb(y2,d(3),G(3));
y4=audiounitreverb(y3,d(4),G(4));
y5=audiounitreverb(y4,d(5),G(5));

y=y5;
