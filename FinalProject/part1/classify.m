function [label,score] = classify(models, test_data)
    % To classify a new image, you should calculate its visual 
    % words histogram as described in Section 2.4 and use the 
    % trained support vector machine classifier to assign it to 
    % the most probable object class.
        
    for i=1:length(models)
        [label,score] = predict(models(i),test_data);
    end
end

