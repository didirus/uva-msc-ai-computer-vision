classes = {'airplanes', 'cars', 'faces', 'motorbikes'};
splits = {'train', 'test'};

n = 0;
for s = 1:length(splits)
    for i = 1:length(classes)
        filename = char(strcat('../Caltech4/ImageData/', classes(i),'_', splits(s), '/'));
        for j = 1:5
            imagename = strcat(filename,'img',num2str(j,'%.3d'),'.jpg');
            I = imread(imagename);
            if size(I,3) > 1
                n = n + 1;
            end
        end
    end
end

data = zeros(32,32,3,n);
labels = zeros(1,n);
sets = zeros(1,n);
ind = 1;

for s = 1:length(splits)
    for i = 1:length(classes)
        filename = char(strcat('../Caltech4/ImageData/', classes(i),'_', splits(s), '/'));
        for j = 1:5
            imagename = strcat(filename,'img',num2str(j,'%.3d'),'.jpg');
            I = imread(imagename);
            if size(I,3) > 1
                I = single(I);
                I = imresize(I, [32 32]);
                data(:,:,:,ind) = I;
                
                if strcmp(splits(s),splits(1))
                    sets(ind) = 1;
                else
                    sets(ind) = 2;
                end
                
                if strcmp(classes(i),classes(1))
                    labels(ind) = 1;
                elseif strcmp(classes(i),classes(2))
                    labels(ind) = 2;
                elseif strcmp(classes(i),classes(3))
                    labels(ind) = 3;
                elseif strcmp(classes(i),classes(4))
                    labels(ind) = 4;
                end
                
                ind = ind + 1;
            end
        end
    end
end