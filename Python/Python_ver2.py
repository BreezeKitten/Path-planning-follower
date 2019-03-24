import numpy as np
import matplotlib.pyplot as plt
import math as m

V_avg = 0.2
V_max = 0.25
W_max = 0.5
S = 0.0
A = 0
deltaT = 0.02
L = 0.4


def path_cal(P1,P2,P3,goal):
    S = 0
    X_d = []
    Y_d = []
    
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
        for j in range(0,A):
            X_d.append(np.polyval(Xs,j/A))
            Y_d.append(np.polyval(Ys,j/A))

    return X_d,Y_d


if __name__ == '__main__':
    Xd,Yd = path_cal([-15,-15],[-25,-5],[-25,5],False)
