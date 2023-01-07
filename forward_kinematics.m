function [A,Links] = forward_kinematics(Links)
    % Calculate DH matrix of forward kinematics
    A = eye(4);
    n = length(Links);
    
    % Multiply a_matrices (Loop Closure Eqn)
    for i = 1:n
        Links(i) = Links(i).calculate_a_matrix;
        A = A*Links(i).a_matrix;
    end
    A = simplify(A);
end