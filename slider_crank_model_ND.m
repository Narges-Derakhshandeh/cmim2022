clear all
clc
close all

%globally we have a complete multibody system including bodies, joints,
%analysis settings
%To store the information of the system we need to use data sturcure which named stuct in MATLAB
  %so we have a global structure which include all information for our system and it is kind of tree which contain the body data(body struct)

%what is the drawback of keeping it? it decrease the effeciency because it adds extra cordinates which they must be solved
%but because we are not concern about the effecienty in this problem, we can keep ground as the body it makes the process more easy for us because it is fully constrained


%sys=struct();
sys=make_system_ND(); 
  
% Bodies

%What do we need to decribe our body? 
%to decribe the system we need: name of body, its location and orientation

sys=add_body_ND(sys,"ground");
sys=add_body_ND(sys,"cranck", [-0.1, 0.05], -deg2rad(30));
sys=add_body_ND(sys,"link", [-0.5, 0.05], deg2rad(15));
sys=add_body_ND(sys,"slider", [-0.7, 0]);



%How to account the change? it is necessary to define a function
%as(make_system) to add the changes like adding gravity


%we also need a fuction to generate the body which is named "add_body".
 %output of the function is sys because we want to generate and add the
 %body to preivous system so the output is sys in this function.
%In this function we want to define that as a default the orienttation is zero but if we want toc ahnge it we can do it here
%it means that in this function we provide orientation=0 for the argumants which are lower 4 (arguments=sys,name, location, orientation) and it means we can not provide the rotation.


%then we can add the body in the slider by define the body to the system by
%its name, location and orientation
%adding the bodies in order(1.ground 2.cranck 3.link 4.slider)
%for the cranck,link  we can add the location in meter and the orientation in rad
%% joints-kinematic(revolute and simple)


% then we want to define the data struct rleted to each joints( we have 2 revolute
% joint and a simple joint) as function of 2 bodies which the joint is
% connecting them together. ( named ad body_i and body_j)
%For body_i and body_j we need a coordinate
%for the first revolute joint the body i is ground and the body j is cranck

sys=add_joint_revolute_ND(sys,"ground","cranck",[0;0], [0.1;0]);


%% SECTION TITLE
%then we write a function for the checking body exists or not. we can use
%this function in the add_joint_revolute function to assert if the body_i
%or body_j exist or not.
%% continue by adding the other revolute joint between cranck and link. remember for the new revolute joint we msut follow exactly the privous steps.
sys=add_joint_revolute_ND(sys,"cranck","link",[-0.1;0], [0.3;0]);
%continue by adding the other revolute joint between  link and slider. remember for the new revolute joint we msut follow exactly the privous steps
sys=add_joint_revolute_ND(sys,"link","slider",[-0.2;0]);
%% now we need to add the simple joint which is related to the slider and the ground. we needs to provide two more information here
% the value(scaler) which make the constraints and secondly in whcih coordinate the simple joint works
%what we need to constraint is y axis and angle to be zero
sys=add_joint_simple_ND(sys ,"slider","y");
sys=add_joint_simple_ND(sys ,"slider","fi");
%then we creat the add_joint_simple function for them. then in this
%function we can add the check_body_exists for asserting the name of the
%bodies
%then we need to change the coordinate name from string to the value, by
%defining  if_end this puporse is provided and the coordinate name can
%cahnge to the value.





sys=add_joint_simple_ND(sys ,"ground","x");
sys=add_joint_simple_ND(sys ,"ground","y");
sys=add_joint_simple_ND(sys ,"ground","fi");


%% Driving

%then we need to add the simple joint which is related to the driving.it is
%applied on the cranck and we define the angle for as the initial value for
%this driving joint. The last argument for driving constraint (time
%function) is 1.2*t -deg2rad(30)
sys=add_joint_simple_driving_ND(sys ,"cranck","fi", @(t) 1.2*t -deg2rad(30));

%then we creat the add_joint_simple_driving  function for driving cranck. then in this
%function we can add the check_body_exists for asserting the name of the
%bodies
%% slover part
% then we want to solve the system for the position level, so we need 3 thing: firstly we need
% the constrain equations ( C) and the q as the initial coordinates (the general postion to gather bodies) and the value of the equation which equals to
% zero
%we define a function file for the q as the initial_coordinates

 q0 = initial_coordinates(sys);

q=fsolve(@(q)constraints(sys,q,0),q0)
 %it looks correct for example the q for the ground is [0,0,0] 

%then we need to get constraints vector and because we have 3 types of joints so we have 3 types of constraints
%so the first function is all constrains for revolute joints
%we need qi for body i and qj for the body j
%we also need to define the rotational matrix for computing S_i and S_j
% we need to slove  first constrant equation (qi(1:2)+Ai*s_i - qj(1:2)-Aj*j.s_j) to find the zeros.
% then we add the constraint funtion related to the revolute joints to the main file
%Cr = constraints_revolute(sys,q)

%The next constraint equation is for the simple joint which needs the body coordinate and values
%Cs = constraints_simple(sys,q)

%the last constraint equation is for the simple driving joint which is
%function of time and body coordinate function(t)
%we add this fuctions to the main file (slider_cranck_model) and the initial value for the time is zero
%Csd = constraints_simple_driving(sys,q,0)

%before solving the problem we need to define the function for all constraints 


% C=constraints(sys,q,0)


%then we can check the length of C and q that they must be equal and we
%understad thet we need to add 3 more constraints for the ground( x, y,
%angle) line80
% sys=add_joint_simple_ND(sys ,"ground","x");
% sys=add_joint_simple_ND(sys ,"ground","y");
% sys=add_joint_simple_ND(sys ,"ground","fi");

%and now the length of both C and q are equal and we can solve the problem
%(constraints(sys,q,0)) by the fsolve and initial coordinates are q0 and
%time=0
%q=fsolve(@(q)constraints(sys,q,t),q0)