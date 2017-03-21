function [v_frequency] = quantize(visual_dictionary, descriptors, vocabulary_size)
    
    %%%%%%% 2.3 %%%%%%%
    
    % Init frequency with zeros
    v_frequency = zeros(vocabulary_size, 1);
    
    % Pairwise distance between two sets of observations
    % visual_dict and descriptors must have same nr of columns
    min_dist = pdist2(double(visual_dictionary), double(descriptors'));
    
    % Find Index for min distance
    [~ , index] = min(min_dist);
    
    %%%%%%% 2.4 %%%%%%%
    
    % Loop over the vocabulary size
    % and put the sum at that index into frequency (position)
    for i=1:vocabulary_size
        v_frequency(i) = sum(index == i);
    end

    v_frequency = double(v_frequency);
    
    % Normalize frequencies
    v_frequency = v_frequency ./ max(v_frequency); %changing to max here
end
