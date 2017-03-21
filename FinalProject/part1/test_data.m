function [ranked] = test_data(X_test, ids, model)
    nr_images = 200;
    
    % Initialise scores matrices for every class
    scores = zeros(nr_images,2);
    scores(:,1) = ids;
    [~, S] = predict(model, X_test);
    scores(:,2) = S(:,2);
    ranked = flipud(sortrows(scores,2));

end

