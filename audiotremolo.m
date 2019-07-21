%function y = audiotremelo(x,R,A)
% This function takes audio  as input and creates new version with an a
% tremolo effect.
%
% TREMOLO is an effect where the volume (amplitude) of the audio
% signal is varied sinusoidally at a slow rate: 
%    y[n] = (1-A) * x[n] + A * x[n] * sin(2*pi*R*n), 
%        where R is the rate of the tremolo.
%
%
% x= input audio
% R = "rate" of tremelo  (how fast the amplitude is altered in cycles per sample)
%     0.0 < R < 1.0
% A = mix (0.0 -> 100% "dry"; 0.5 -> 50% dry, 50% chorus; 1.0 -> 100% chorus)
%     0.0 <= A <= 1.0
function y = audiotremelo(x,R,A)

if R <= 0.0 | R >=1.0
  error('bad rate parameter. make sure that 0.0 < R < 1.0');
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

sinewave=sin(2*pi*R*[1:N]);

y=(1 - A)*x + A*x.*sinewave;
