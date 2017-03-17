function [ D ] = feature_extraction()

    Classes = {'airplanes_train','motorbikes_train','faces_train','cars_train'};
    
    D = [];
    for i=1:length(Classes)
        filename = char(strcat('../Caltech4/subdata/', Classes(i), '/' ));
        for j =1:5
            imagename = strcat(filename,'img',num2str(j,'%.3d'),'.jpg');
            I = imread(imagename);
            [~, d] = descriptors(I, 'normal');
            D = vertcat(D,d');
        end
    end
end

