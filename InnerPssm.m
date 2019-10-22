function [ result ] = InnerPssm( M , j)
    sum = 0;
    result = 0;

    for v=1:20

        sum = sum + M(1,v);
    end
    sum = sum / 20;
    result = M(1,j) - sum;

end

