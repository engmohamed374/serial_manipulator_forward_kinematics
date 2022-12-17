%%
% Written by: Mohamed Eid
% This Program calculates the forward kinematics of any serial manipulator

clc
clear

%%
% Variables
% Definition of needed variables & parameters

link1 = Links;
link2 = Links;
link3 = Links;
link4 = Links;
link5 = Links;
link6 = Links;
Link = [link1 link2 link3 link4 link5 link6];
clear link1 link2 link3 link4 link5 link6

% syms theta_0 theta_1 theta_2 theta_4 theta_4 theta_5
% syms d0 d1 d2 d3 d4 d5
% 
% Theta = [theta_0 theta_1 theta_2 theta_4 theta_4 theta_5];
% D     = [d0 d1 d2 d3 d4 d5];

%%
% Building Robot

number_of_joints = input("How many joints? ");
Link = Link(1:number_of_joints);
clc

for i = 1:number_of_joints
    Link(i).type_of_joint = input("Enter the type of the joint No " + ...
        string(i) + " ('r'/'p'): ");
    clc
end

for i = 1:number_of_joints
    disp("Enter DH Parameters of joint No " + string(i));
    Link(i).alpha = input("alpha" + string(i-1) + " = ");
    Link(i).a = input("a" + string(i-1) + "     = ");
    
    switch Link(i).type_of_joint
        case 'r'
            Link(i).d = input("d" + string(i-1) + "     = ");
            Link(i) = Link(i).symbolic_theta(i);
        case 'p'
            Link(i).theta = input("theta" + string(i-1) + " = ");
            Link(i) = Link(i).symbolic_d(i);
    end
    clc
end

clear i

%%
% Display

line = "\n+---+----------+----------+----------+----------+\n";
fprintf("DH Parameters:\n" + line);
fprintf("|" + " j |" + "     alpha|" + "     theta|" + "         d|" + "         a|");
fprintf(line);
for i = 1:number_of_joints
    fprintf("|" + " " + string(i) + "\t" + "|" + "%10s|%10s|%10s|%10s|",...
        string(Link(i).alpha),...
        string(Link(i).theta),...
        string(Link(i).d),...
        string(Link(i).a));
    fprintf(line);
end
fprintf("\n");

clear i line

%%
% Forward Kinematics

[A,Link] = forward_kinematics(number_of_joints,Link);
disp('A = ');
disp(A);
