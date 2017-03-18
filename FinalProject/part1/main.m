% Tushar Nimbhorkar & Diede Rusticus
% Computer Vision '17
% Artificial Intelligence Master
% University of Amsterdam

clear 
close all

%%%%%%%%% Select assignment and image by uncommenting the line %%%%%%%%%

test = 'feature_extraction';
% test = 'image_stitching';

%%%%%%%%% 2.1 Feature Extraction and Description %%%%%%%%%

if (strcmp(test,'feature_extraction'))
    
    D = feature_extraction();
    
    % Doing Kmeans
    % Change the VOcabulary size and Number of iteration as needed
    Vocab_size=400;
    N_iter = 1000;
    
    % Get the cluster centres
    [Centre] = Kmeans_cluster(single(D),Vocab_size,N_iter);
    
    % TODO: 2.3 Map sift with kmeans clusters
    
    
end

if (strcmp(test,'image_stitching'))

end
