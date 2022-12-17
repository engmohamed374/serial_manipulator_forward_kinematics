function [A,links_matrix] = forward_kinematics(n,links_matrix)
    A = eye(4);
    for i = 1:n
        links_matrix(i) = links_matrix(i).calculate_a_matrix;
        A = A*links_matrix(i).a_matrix;
    end
    A = simplify(A);
end