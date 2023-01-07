%%
% Written by: Mohamed Eid
% This Program calculates the forward kinematics of any serial manipulator

clc
clear

%%
% Variables
% Definition of needed objects

link1 = MyLink(1);
link2 = MyLink(2);
link3 = MyLink(3);
link4 = MyLink(4);
link5 = MyLink(5);
link6 = MyLink(6);
Links = [link1 link2 link3 link4 link5 link6];
clear link1 link2 link3 link4 link5 link6

%%
% Building Robot

number_of_joints = input("How many joints? ");
Links = Links(1:number_of_joints);
clc

% Determine the type of each joint by the user
for i = 1:number_of_joints
    type_of_joint = input("Enter the type of the joint No " + ...
        string(i) + " ('r'/'p'): ");
    if ~isempty(type_of_joint)
        Links(i).type_of_joint = type_of_joint;
    end
    clc
end

% Get DH parameters from the user link by link
for i = 1:number_of_joints
    disp("Enter DH Parameters of joint No " + string(i) + " (hit enter if there is no value)");
    dh_input = input("alpha" + string(i) + " = ");
    if ~isempty(dh_input)
        Links(i).alpha = dh_input;
    end
    dh_input = input("a" + string(i) + "     = ");
    if ~isempty(dh_input)
        Links(i).a = dh_input;
    end
    
    switch Links(i).type_of_joint
        case 'r'
            dh_input = input("d" + string(i) + "     = ");
            if ~isempty(dh_input)
                 Links(i).d = dh_input;
            end
        case 'p'
            dh_input = input("theta" + string(i) + " = ");
            if ~isempty(dh_input)
                Links(i).theta = dh_input;
            end
    end
    clc
end

clear i dh_input

%%
% Display of DH parameters

line = "\n+---+----------+----------+----------+----------+\n";
fprintf("DH Parameters:\n" + line);
fprintf("|" + " j |" + "     alpha|" + "         a|" + "         d|" + "     theta|");
fprintf(line);
for i = 1:number_of_joints
    fprintf("|" + " " + string(i) + "\t" + "|" + "%10s|%10s|%10s|%10s|",...
        string(Links(i).alpha),...
        string(Links(i).a),...
        string(Links(i).d),...
        string(Links(i).theta));
    fprintf(line);
end
fprintf("\n");

clear i line

%%
% Solving Forward Kinematics

[A,Links] = forward_kinematics(Links);
disp('A = ');
disp(A);

%%
% Solving Jacobian

[J,Links] = solve_jacobian(Links);
disp('J = ');
disp(J);