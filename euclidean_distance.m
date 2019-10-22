function [ output ] = euclidean_distance(data, center)

data_num = size(data, 1);
center_num = size(center, 1);
output = zeros(data_num, center_num);
for i = 1:center_num
    difference = data - repmat(center(i,:), data_num, 1);    
    sum_of_squares = sum(difference .* difference, 2);        
    output(:, i) = sum_of_squares;             
end

end