function [ err ] = quantify_error_rmse( actual, predicted )

    diff = actual - predicted;
    err = sqrt( mean( diff .^ 2 ) );

end




