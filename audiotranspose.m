% This function takes audio  as input transposes it to a new frequency.
%
% function y = audiotranspose(x,p,F)
%
% x= input audio
% p= pitch factor (0.5 = 1/2 the ferquency or one octave below;
%                   1.0 = no change;
%                   2.0 = twice the frequency or one octave above;)
% F= sampling frequency
%     W > 1.0
%

function y = audiotranspose(x,p,F)

if F <= 1.0
  error('bad sampling frequency parameter. make sure that F > 1.0');
end
if p <= 0.2 | p >=5.0
  error('bad pitch factor parameter. make sure that 0.2 < p < 5.0');
end

sizex = size(x);

if sizex(1) ~= 1
  if sizex(2) == 1
     x=x';
  else
     error(['x must be a vector'])
  end
end

%size of input audio signal
N=length(x);

%use a window size of  50msecs
% this sounds good for most speech
windowsecs=70e-3;

%calculate number of samples in window
window=round(F*windowsecs);

if p < 1.0
  maxdelay=window*(1-p);
  sign=1.0;
else
  maxdelay=window*(p-1);
  sign=-1.0;
end

%make a sawtooth function
%sawtooth produces a wave from -1 to 1
delay=(maxdelay*sign/2)*sawtooth(2*pi/window*[1:N]);

% adjust DC of waveform so that it goes between 0 and maxdelay
delay= delay - min(delay);

index=[maxdelay+1:N+maxdelay]-delay;

xdelayed=[zeros(1,maxdelay),x];

rawindex=1:length(xdelayed);

%1st order linear interpolation since indicies are not integers
index1=floor(index);
index2=ceil(index);
fract=index-index1;

y = fract .* xdelayed(index1)  +  (1-fract) .* xdelayed(index2);

