#!/usr/bin/env python
import numpy as np
import matplotlib.pyplot as plt
import math as m
import rospy
from geometry_msgs.msg import Twist
from geometry_msgs.msg import Ponit

from turtlesim.msg import Pose

V_avg = 0.2
V_max = 0.25
W_max = 0.5
S = 0.0
A = 0
deltaT = 0.02
L = 0.4
Xd = []
Yd = []
thetad = []
Vd = []
Wd = []
t = 0
Xnow = 0
Ynow = 0
yaw = 0
theta_final = 0

cmd_vel_topic = "cmd_vel"
com_pub = rospy.Publisher(cmd_vel_topic,Twist,queue_size=10)

def path_cal(P1,P2,P3,goal):
    S = 0
    X_d = []
    Y_d = []
    theta_d = []
    X_d_dot = []
    Y_d_dot = []
    V_d = []
    W_d = []
    
    X_i = P1[0]
    Y_i = P1[1]
    theta_i = m.atan2((P2[1]-P1[1]),(P2[0]-P1[0]))

    X_f = P2[0]
    Y_f = P2[1]
    if goal == True:
        theta_f = theta_final
    else:
        theta_f = m.atan2((P3[1]-P2[1]),(P3[0]-P2[0]))

    k = 10
    ax = k * m.cos(theta_f) - 3 * X_f
    
    ay = k * m.sin(theta_f) - 3 * Y_f
    bx = k * m.cos(theta_i) + 3 * X_i
    by = k * m.sin(theta_i) + 3 * Y_i
    Xs = [X_f-X_i+ax+bx,3*X_i-ax-2*bx,-3*X_i+bx,X_i]
    Ys = [Y_f-Y_i+ay+by,3*Y_i-ay-2*by,-3*Y_i+by,Y_i]
    
    for j in range(0,1000):
        S = S + m.sqrt((np.polyval(Xs,j/1000)-np.polyval(Xs,(j+1)/1000))**2 +(np.polyval(Ys,j/1000)-np.polyval(Ys,(j+1)/1000))**2)

    k = S
    ax = k * m.cos(theta_f) - 3 * X_f
    ay = k * m.sin(theta_f) - 3 * Y_f
    bx = k * m.cos(theta_i) + 3 * X_i
    by = k * m.sin(theta_i) + 3 * Y_i
    Xs = [X_f-X_i+ax+bx,3*X_i-ax-2*bx,-3*X_i+bx,X_i]
    Ys = [Y_f-Y_i+ay+by,3*Y_i-ay-2*by,-3*Y_i+by,Y_i]

    
    A = round(k/(V_avg*deltaT))
    if goal == True:
        for j in range(0,A+2):
            X_d.append(np.polyval(Xs,j/A))
            Y_d.append(np.polyval(Ys,j/A))
    else:
        for j in range(0,int(A)+2): #A+2 just test
            X_d.append(np.polyval(Xs,j/A))
            Y_d.append(np.polyval(Ys,j/A))


    for i in range(0,int(A)+1):
        X_d_dot.append((X_d[i+1] - X_d[i])/deltaT)
        Y_d_dot.append((Y_d[i+1] - Y_d[i])/deltaT)
        theta_d.append(m.atan2(Y_d_dot[i],X_d_dot[i]))
        if i > 0:
            if(theta_d[i] > theta_d[i-1] + m.pi):
                theta_d[i] = theta_d[i] - 2 * m.pi
        V_d.append(m.sqrt((X_d_dot[i])**2 + (Y_d_dot[i])**2))

    for i in range(0,int(A)):
        W_d.append((theta_d[i+1] - theta_d[i])/deltaT)

    return X_d,Y_d,theta_d,V_d,W_d


def Vel_command(X,Y,theta,X_d,Y_d,theta_d,V_d,W_d):
    a = 1
    damp = 0.7
    k1 = 2*damp*a
    k3 = k1
    k2 = (a ** 2 - W_d ** 2) / V_d
    
    e1 = (X_d - X) * m.cos(theta) + (Y_d - Y) * m.sin(theta)
    e2 = -(X_d - X) * m.sin(theta) + (Y_d - Y) * m.cos(theta)
    e3 = theta_d - theta
    u1 = -k1 * e1
    u2 = -k2 * e2 - k3 * e3

    V_com = V_d * m.cos(e3) - u1
    W_com = W_d - u2
    
    return V_com,W_com

def command_pub(Vcom,Wcom):
    global t

    
    vel_msg = Twist()
    vel_msg.linear.x = Vcom
    vel_msg.linear.y = 0
    vel_msg.linear.z = 0
    vel_msg.angular.x = 0
    vel_msg.angular.y = 0    
    vel_msg.angular.z = Wcom
    
    com_pub.publish(vel_msg)
    rospy.loginfo("command pub")	
    t = t + 1
 
    return

def posecallback(data):
    global Xnow
    global Ynow
    global yaw 
    Xnow = data.x
    Ynow = data.y
    yaw = data.theta
    print(Xnow,Ynow,yaw)
    if t < len(Vd)-1:
        Vcom,Wcom = Vel_command(Xnow,Ynow,yaw,Xd[t],Yd[t],thetad[t],Vd[t],Wd[t])
    else:
        Vcom = 0
        Wcom = 0

    command_pub(Vcom,Wcom)

    return


def subgoalCB(data):
    global Xd
    global Yd
    global thetad
    global Vd
    global Wd
    global t
    subgoal_x = data.x
    subgoal_y = data.y
    Xd,Yd,thetad,Vd,Wd = path_cal([Xnow,Ynow],[subgoal_x,subgoal_y],[7,4],True)
    t = 0
    rospy.loginfo("subgoal change")
    return



if __name__ == '__main__':
#    Xd,Yd,thetad,Vd,Wd = path_cal([5,5],[9,4],[7,4],False)
    rospy.init_node('PPF',anonymous=True)
    rate = rospy.Rate(100)
    rospy.Subscriber("/robot_pose",Pose,posecallback)
    rospy.Subscriber("/subgoal_position",Ponit,subgoalCB)
    rospy.spin()

