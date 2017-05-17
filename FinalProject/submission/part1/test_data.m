function [ranked] = test_data(X_test, ids, model, nr_images)
    classes = {'airplanes','motorbikes','faces','cars'};    
    
    % Initialise scores matrices for every class
    scores = zeros(nr_images*length(classes),3);
    
    % First column containing the image indices, used later for mapping
    % back to the original image.
    scores(:,1) = 1:nr_images*4;
    
    % Second column containing the true class ids, used later for
    % evaluating performance.
    scores(:,2) = ids; 
    
    % Third column containing the scores of the image being of that class,
    % Also, images are ranked in descending order based on this column
    [~, S] = predict(model, X_test);
    scores(:,3) = S(:,2);
    ranked = flipud(sortrows(scores,3));

end

