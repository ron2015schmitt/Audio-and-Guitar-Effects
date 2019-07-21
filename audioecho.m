function y = audioecho(x,T,A)
%function y = audioecho(x,T,A)
%This function takes audio  as input and creates new version with an echo
%
% x = input audio vestor
% T = length of delay, in samples
%     T > 0
% A = mix (0.0 -> 100% "dry"; 0.5 -> 50% dry, 50% echo; 1.0 -> 100% echo)
%     0.0 <= A <= 1.0

T=round(T);
if T <= 0
  error('bad rate parameter. make sure that T > 0');
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

xdelayed=[zeros(1,T),x];
x=[x,zeros(1,T)];

y=(1-A)*x + A*xdelayed;
