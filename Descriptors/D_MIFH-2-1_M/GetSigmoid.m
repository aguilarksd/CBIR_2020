function [val] = GetSigmoid(Z,b)

val=1/(1+exp(-Z+b));

end

