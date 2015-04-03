function [result] = Calculate_Kernel(mat_a, mat_b, options)
    % cal the kernel of vec_a and vec_b with options
    % mat_a : sam_a * fea_num
    % mat_b : sam_b * fea_num
    % options : KernelType - differnt choices :
    %                        'Gaussian' - exp( -|x-y|.^2 / (2*sigma.^2) )
    %                        'Polynomial' - (x*y).^d
    %           sigma - sigma of Guassian kernel           
    %           d - d of other kernels
    % ---------------------------------------------------------------------
   
    % switch differnt KernelType
    switch lower(options.KernelType)
        case lower('Gaussian')
            dist = Euclidean_Distance(mat_a, mat_b) ;
            result = exp( -dist / (2*options.sigma.^2)) ;
        case lower('Polynomial')
            dist = Euclidean_Distance(mat_a, mat_b) ;
            result =  dist ;
    end
end