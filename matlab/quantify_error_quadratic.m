function [ err ] = quantify_error( actual, predicted )
    N = length(actual);
    err = zeros(N,1);
    for i = 1:length(actual)
        if ( predicted(i) >= actual(i) )
            err(i) = (predicted(i) - actual(i))^2;
        else
            err(i) = - (predicted(i) - actual(i))^2;
        end
    end
end




