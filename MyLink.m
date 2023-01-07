classdef MyLink
    properties
        % DH parameters
        theta
        alpha
        d
        a
        type_of_joint = 'r'
        a_matrix
        jacobian_vector
        % dynamic parameters
        m
        I
    end
    methods
        function obj = MyLink(i)
            if ~nargin
                return
            end
            syms theta1 theta2 theta3 theta4 theta5 theta6
            syms d1 d2 d3 d4 d5 d6
            syms alpha1 alpha2 alpha3 alpha4 alpha5 alpha6
            syms a1 a2 a3 a4 a5 a6
            Theta = [theta1 theta2 theta3 theta4 theta5 theta6];
            D = [d1 d2 d3 d4 d5 d6];
            Alpha = [alpha1 alpha2 alpha3 alpha4 alpha5 alpha6];
            A = [a1 a2 a3 a4 a5 a6];
            obj.theta = Theta(i);
            obj.alpha = Alpha(i);
            obj.d = D(i);
            obj.a = A(i);
        end
        
        function obj = calculate_a_matrix(obj)
            % Calculate the DH matrix of the related joint
            switch obj.type_of_joint
                case 'r'
                    obj.a_matrix = [cos(obj.theta)  -sin(obj.theta)*round(cos(obj.alpha),4)    sin(obj.theta)*round(sin(obj.alpha),4)     obj.a*cos(obj.theta);
                                    sin(obj.theta)  cos(obj.theta)*round(cos(obj.alpha),4)     -cos(obj.theta)*round(sin(obj.alpha),4)    obj.a*sin(obj.theta);
                                    0               round(sin(obj.alpha),4)                    round(cos(obj.alpha),4)                    obj.d;
                                    0               0                                          0                                          1              ];
                case 'p'
                    obj.a_matrix = [round(cos(obj.theta),4)  round(-sin(obj.theta),4)*round(cos(obj.alpha),4)    round(sin(obj.theta),4)*round(sin(obj.alpha),4)     obj.a*round(cos(obj.theta),4);
                                    round(sin(obj.theta),4)  round(cos(obj.theta),4)*round(cos(obj.alpha),4)     round(-cos(obj.theta),4)*round(sin(obj.alpha),4)    obj.a*round(sin(obj.theta),4);
                                    0                        round(sin(obj.alpha),4)                             round(cos(obj.alpha),4)                             obj.d;
                                    0                        0                                                   0                                                   1              ];
            end
        end
        
        function obj = calculate_jacobian(obj,Riminus1_0,Pn_iminus1)
            % Calculate the jacobian of the related joint
            z_iminus1 = Riminus1_0 * [0;0;1];
            switch obj.type_of_joint
                case 'r'
                    obj.jacobian_vector = [cross(z_iminus1,Pn_iminus1);z_iminus1];
                case 'p'
                    obj.jacobian_vector = [z_iminus1;zeros(3,1)];
            end
        end
    end
end