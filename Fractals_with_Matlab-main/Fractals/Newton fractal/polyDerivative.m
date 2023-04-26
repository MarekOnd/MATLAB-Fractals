function [polyDerivative] = polyDerivative(pol)
% creates derivation matrix
D = fliplr(flipud( diag(1:(size(pol,2)-1)) ));

D = [D; zeros(1, size(pol,2)-1 )];
D = [zeros( size(pol,2), 1 ), D];
polyDerivative = pol*D;
end

% note: now i know there is a in-built function for it

