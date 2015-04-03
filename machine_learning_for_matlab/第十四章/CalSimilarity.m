function sim = CalSimilarity(vecA, vecB, type)
% 两个向量都是列向量
if 1 == strcmp('eclud', type)
    dist = norm((vecA-vecB)) ; 
    sim = 1.0./(1.0 + dist) ;
elseif 1 == strcmp('pears', type)
    sim = corrcoef(vecA, vecB) ;
    sim = 0.5+0.5*sim(1,2) ;
elseif 1 == strcmp('cos', type)
    sim = (vecA' * vecB) / (norm(vecA) * norm(vecB)) ;
    sim = 0.5*0.5*sim ;
end
end