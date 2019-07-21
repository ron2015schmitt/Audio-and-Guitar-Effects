function y = audiochorus(x,W,R,A,Fs)
%function y = audiochorus(x,W,R,A,Fs)
% This function takes audio  as input and creates new version with an a
% chorus effect.
%
% CHORUS is an audio effect where the input is delayed, but not by a constant
% amount. The amount of delay is varied sinusoidally.
%
% x= input audio
% W = "width" of chorus (average delay in secs)
%     W > 1/Fs
% R = "rate" of chorus (how fast the delay is altered in Hz)
%     0.0 < R < Fs/2
% A = mix (0.0 -> 100% "dry"; 0.5 -> 50% dry, 50% chorus; 1.0 -> 100% chorus)
%     0.0 <= A <= 1.0
% Fs = sample rate in Hz

W=round(W*Fs)
if W <= 1.0
  error('bad width parameter. make sure that W > 1/Fs');
end
R=R/Fs;
if R <= 0.0 | R >=0.5
  error('bad rate parameter. make sure that 0.0 < R < Fs/2');
end
if A < 0.0 | A > 1.0
  error('bad mix parameter. make sure that 0.0 <= A <= 1.0');
end

sizex = size(x);

if sizex(1) ~= 1
  if sizex(2) == 1
     x=x';
  else
     error(['x must be a vector'])
  end
end


N=length(x);

%add a DC value so that the delay is always greater than zero
% Notice that we use sawtooth( , 0.5), which produces a standard, symmetrical
% triangle wave. This actually produces a smoother sounding effect than using
% a sine wave.
delay=round(W*sawtooth(2*pi*R*[1:N],0.5)) + W + 1;
plot(delay)
T=max(delay);
chorusindex=[T+1:N+T]-delay;

xdelayed=[zeros(1,T),x];

xchorus = xdelayed(chorusindex);

y=(1 - A)*x + A*xchorus;
