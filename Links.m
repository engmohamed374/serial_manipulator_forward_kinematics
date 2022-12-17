classdef Links
    properties
        % DH parameters
        theta
        alpha
        d
        a
        type_of_joint
        a_matrix
        % dynamic parameters
        m
        I
    end
    methods
        function obj = symbolic_theta(obj, i)
            syms theta0 theta1 theta2 theta3 theta4 theta5
            Theta = [theta0 theta1 theta2 theta3 theta4 theta5];
            obj.theta = Theta(i);
            clear Theta theta0 theta1 theta2 theta3 theta4 theta5
        end
        function obj = symbolic_d(obj, i)
            syms d0 d1 d2 d3 d4 d5
            D = [d0 d1 d2 d3 d4 d5];
            obj.d = D(i);
            clear D d0 d1 d2 d3 d4 d5
        end
        function obj = calculate_a_matrix(obj)
           obj.a_matrix = [cos(obj.theta)  -sin(obj.theta)*round(cos(obj.alpha), 15)    sin(obj.theta)*round(sin(obj.alpha), 15)     obj.a*cos(obj.theta);
                           sin(obj.theta)  cos(obj.theta)*round(cos(obj.alpha), 15)     -cos(obj.theta)*round(sin(obj.alpha), 15)    obj.a*sin(obj.theta);
                           0               round(sin(obj.alpha), 15)                    round(cos(obj.alpha), 15)                    obj.d;
                           0               0                                            0                                            1              ]; 
        end
    end
end