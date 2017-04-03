function [v_frequency] = quantize(visual_dictionary, descriptors, vocabulary_size)
        
    % Init cluster frequencies with zeros
    v_frequency = zeros(vocabulary_size, 1);
    
    % Pairwise distance between two sets of observations
    % First observation are all the visual words, second observations the
    % image descriptors
    min_dist = pdist2(double(visual_dictionary), double(descriptors'));
    
    % Find index of minimum distances
    [~ , index] = min(min_dist);
        
    % Loop over the vocabulary size and put the sum of that index into 
    % the frequency vector
    for i=1:vocabulary_size
        v_frequency(i) = sum(index == i);
    end

    v_frequency = double(v_frequency);
    
    % Normalize frequencies because images could have fewer of more
    % descriptors. 
    v_frequency = v_frequency ./ max(v_frequency);
end
