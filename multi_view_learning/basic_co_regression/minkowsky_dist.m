function dist = minkowsky_dist(xr, xs, p)
    % function to cal minkowsky distance between xr and xs
    % p - distance order
    % ---------------------------------------------------------------------
    
    dist = sum(abs(xr-xs).^p).^(1/p) ;
end