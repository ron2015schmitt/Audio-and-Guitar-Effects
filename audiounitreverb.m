%This function is a unit all-pass audio reverb filter
%
%function y = audiounitreverb(x,d,G)
% x = input audio vestor
% d= delay is samples
% G = delay gain factor
function y = audiounitreverb(x,d,G)

sizex = size(x);

if sizex(1) ~= 1
  if sizex(2) == 1
     x=x';
  else
     error(['x must be a vector'])
  end
end

N=length(x);

x=[zeros(1,d),x];

y=zeros(1,N+d);
ya=y;

for i = 1+d:N+d
 ya(i)=x(i) + G*ya(i-d);
 y(i)=-G*ya(i) + ya(i-d);
end
