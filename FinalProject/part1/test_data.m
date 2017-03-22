function [ranked] = test_data(X_test, ids, model, nr_images)
    classes = {'airplanes','motorbikes','faces','cars'};    
    
    % Initialise scores matrices for every class
    scores = zeros(nr_images*length(classes),3);
    scores(:,1) = 1:nr_images*4;
%     ind = 1;
%     for j = 1:4
%         for i = 1:nr_images
%             name = strcat(char(classes(j)), '_test/img',num2str(i,'%.3d'),'.jpg');
%             disp(name)
%             scores(ind,1) = name;
%             ind = ind + 1;
%         end
%     end
    
    scores(:,2) = ids; 
    [~, S] = predict(model, X_test);
    scores(:,3) = S(:,2);
    ranked = flipud(sortrows(scores,3));

end

