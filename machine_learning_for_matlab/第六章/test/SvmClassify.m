function res = SvmClassify(Training,Group)
res = svmtrain(Training,Group,'showplot',true,'kernel_function','polynomial');
end