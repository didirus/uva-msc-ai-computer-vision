function [ Centre ] = Kmeans_cluster( Descriptor,vocab_size,N )

    %Matlab function which returns Ids and cluster centres
    [~,Centre] = kmeans(single(Descriptor),vocab_size,'MaxIter',N);

end

