function [dist] = Euclidean_Distance(mat_a, mat_b)
    % cal the euclidean distance of mat_a and mat_b
    % mat_a : sam_a * fea_num
    % mat_b : sam_b * fea_num
    % ---------------------------------------------------------------------
    
    [sam_a, fea_num] = size(mat_a) ;
    [sam_b, fea_num] = size(mat_b) ;
    xx = sum(mat_a .* mat_a, 2) ; % x.*x
    yy = sum(mat_b .* mat_b, 2) ; % y.*y
    xy = mat_a * mat_b' ; % x*y'
    dist = sqrt(repmat(xx, 1, sam_b) + repmat(yy', sam_a, 1) - 2*xy) ;
end