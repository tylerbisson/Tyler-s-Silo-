function [ output ] = tylerssilo(input_sig, grain_len, platter_width,...
    start_time, num_streams, outlength)

% Tyler's Silo is a granular synthesis engine 


%        Input_sig: read in input signal using audioread 
%        grain_len: grain size in milliseconds
%    platter_width: platter width is a multiplier of the window that 
%                   tylers silo selects grains from. A platter_width of
%                   one results results in no varience in grain
%                   selection, while a platter_width of two results in 
%                   a window two size that of the grain length from
%                   which tylers silo will randomly select a grain. 
%       start_time: this sets the postion where the grain selection platter
%                   begins. 
%      num_streams: the amount of iterations of this process that will be 
%                   summed together and scaled 
%        outlength: length of output in seconds

fs = 44100; 
input_sig = input_sig(:,1);
grain_len = floor(grain_len * (44100/1000)); % convert time to samples
sig_len = length(input_sig);
platter_width = ceil(platter_width * grain_len);
outlength = outlength * fs;
start_samp = ceil(start_time * fs);
y = zeros(1,outlength);
y = y';
num_out_grains = floor(outlength/grain_len);
shuffle_points = platter_width - grain_len;
hop = floor(grain_len/2);
num_out_grains = num_out_grains * 2;
output = zeros(1,outlength);
output = output';

if (start_samp + platter_width) > sig_len
     error('start_samp is too close to end of input file') 
end

if shuffle_points == 0 
    shuffle_points = 1;
end 

    for loop_count = 1:1:num_streams
            for currentgrain = 1:1:num_out_grains
                    in_sti = (start_samp - 1) + randi(shuffle_points);
%                     in_sti = (start_samp + ceil(rand(1,50000)) - 1) + randi(shuffle_points);
                    in_endi = in_sti + grain_len;
                    out_sti = (hop * (currentgrain -1)) + 1;
                    out_endi = out_sti + grain_len;
                            if out_endi > outlength
                                    out_endi = outlength;
                                    in_endi = in_sti + (out_endi-out_sti);
                            end
                     y(out_sti:out_endi) = y(out_sti:out_endi) +...
                     (input_sig(in_sti:in_endi).*...
                     hann(length(input_sig(in_sti:in_endi))));
            end
        output = output + y;
    end
end

