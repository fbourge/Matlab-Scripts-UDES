function [ reduced_profile ] = reduce_dimension( input_profile, dim_in, dim_out )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

c=(dim_out/dim_in)

if(rem(c,1)~=0) %  if not integer
error('bad dimension : c is not integer');
end


rest= mod(size(input_profile,1),c); % compute remainder after division

if( rest ~=0) % arrange the vector size to produce integer division
input_profile=vertcat(input_profile,zeros(c-rest,1));
end 

m_size=size(input_profile,1);

reduced_profile = zeros(m_size/c,1);

for i=1:size(reduced_profile,1)
    reduced_profile(i) = mean(input_profile((i-1)*c+1:i*c));
end

end

