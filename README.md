# serial_manipulator_kinematics_dynamics
A Matlab code for generating the forward kinematics and jacobian matrices and dynamic equations of any serial manipulator up to 6DOF using the DH method.
## Purpose
This project is intended to be used to generate dynamic equations of any serial manipulator up to 6DOF. These equations will be suitable to be used in simulating the robot dynamics and developing controllers for a such robot.
## How To Use?
1. Run the file named kinematics.m
1. Answer the questions
	- First, enter the number of joints
	- Then, enter the type of each joint ('r' for revolute and 'p' for prismatic)
	"The default joint type is revolute so you can just hit enter in case of revolute"
	- Finaly, enter the DH parameters of each joint
	"In case of no values, just hit enter and parameters will be symbolic"
1. DH parameters will be displayed as well as the DH and the Jacobian matrices

## License
There is no license, you can do whatever you like with it.

## Issues
If you encountered a problem or found a bug, just open a new issue and It shall be answered soon.
## Futere Work
The next release will contain Dynamics generation using Lagrange equations.