function [ err ] = quantify_error( actual, predicted )
    N = length(actual);
    err = zeros(N,1);
    
    err(1) =  1 / actual(1);
    
    for i = 2:length(actual)
        rel = 1 / actual(i);
        err(i) = rel / log2(i);
    end
end




