function [ D ] = feature_extraction(descr_type)

    % Define the 4 classes
    Classes = {'airplanes_train','motorbikes_train','faces_train','cars_train'};
    
    % For every image, get the descriptors with keypoint sampling
    D = [];
    for i=1:length(Classes)
        filename = char(strcat('../Caltech4/ImageData/', Classes(i), '/' ));
        for j = 1:100
            imagename = strcat(filename,'img',num2str(j,'%.3d'),'.jpg');
            I = imread(imagename);
            [~, d] = descriptors(I, descr_type);
            D = vertcat(D,d');
        end
    end
end

