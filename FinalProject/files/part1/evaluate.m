function [ APs ] = evaluate( rankedlists, nr_test_images )
    
    APs = zeros(1,length(rankedlists)+1);
    
    % For every class, calculate the AP and save
    for i = 1:length(rankedlists)
        sum_AP = 0;
        count = 0;
        for j = 1:nr_test_images*length(rankedlists)
            ranking = cell2mat(rankedlists(i));
            if ranking(j,2) == i
                count = count + 1;
                sum_AP = sum_AP + (count/j);
            else
                sum_AP = sum_AP + (0/j);
            end
        end
        
        % Save the AP for this class
        APs(:,i) = (1/nr_test_images) * sum_AP;
    end
    
    % On the final index, place the MAP measure
    APs(:,length(rankedlists)+1) = mean(APs(1:length(rankedlists)));

end

