function [J,Links] = solve_jacobian(Links)
    % Calculate the robot jacobian
    n = length(Links);
    
    % Calculate Riminus1_0 matrix
    Riminus1_0 = eye(3);
    Riminus1_0_matrix = sym(zeros(3,3,n));
    for i = 2:n
        Riminus1_0 = Riminus1_0 * Links(i-1).a_matrix(1:3,1:3);
        Riminus1_0_matrix(:,:,i) = Riminus1_0;
    end
    Riminus1_0_matrix(:,:,1) = eye(3);
    Riminus1_0_matrix = simplify(Riminus1_0_matrix);
    
    % Calculate Pn_iminus1 matrix
    Pn_iminus1 = zeros(3,1);
    Pn_iminus1_matrix = sym(zeros(3,n));
    for i = n:-1:1
        ri_iminus1 = Links(i).a_matrix(1:3,4);
        Pn_iminus1 = Riminus1_0_matrix(:,:,i) * ri_iminus1 + Pn_iminus1;
        Pn_iminus1_matrix(:,i) = Pn_iminus1;
    end
    Pn_iminus1_matrix = simplify(Pn_iminus1_matrix);
    
    % Calculate z_iminus1 and jacobian_vector
    J = sym(zeros(6,n));
    for i = 1:n
        Links(i) = Links(i).calculate_jacobian(Riminus1_0_matrix(:,:,i),Pn_iminus1_matrix(:,i));
        J(:,i) = Links(i).jacobian_vector;
    end
end