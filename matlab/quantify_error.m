function [ err ] = quantify_error( actual, predicted )
    N = length(actual);
    err = zeros(N,1);
    for i = 1:length(actual)
       err(i) = (predicted(i) - actual(i));
    end
end




