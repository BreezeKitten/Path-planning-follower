%% initial 
clear all;
V_avg = 0.2;
V_max = 0.25;
W_max = 0.5;
S = 0;
A = 0;
deltaT = 0.02;
L = 0.4;  %length constant
theta_int = pi*3/4;
theta_final = 0;

X_int = -20;
Y_int = -20;
theta_int = 0; % unit:rad

X(1) = X_int;
Y(1) = Y_int;
theta(1) = theta_int;
%% goal set
goal_set = {[-15 -15],[-25 -5],[-25 5],[-25 15],[-15 15],[-5 15]};
[m,n] = size(goal_set);
goal_num = n;

%% planning_via_Cartesian
for i = 1:(n-1)
    P1 = goal_set{i};
    P2 = goal_set{i+1};
        
    X_i = P1(1);
    Y_i = P1(2);
%     if( i == 1)
%         theta_i = theta_int;
%     else
        theta_i = atan2((P2(2)-P1(2)),(P2(1)-P1(1)));
%     end

    X_f = P2(1);
    Y_f = P2(2);
    if(i == (n-1))
        theta_f = theta_final;
    else
        P3 = goal_set{i+2};
        theta_f = atan2((P3(2)-P2(2)),(P3(1)-P2(1)));
    end
    
    k = 10;
    ax = k * cos(theta_f) - 3 * X_f;
    ay = k * sin(theta_f) - 3 * Y_f;
    bx = k * cos(theta_i) + 3 * X_i;
    by = k * sin(theta_i) + 3 * Y_i;
    Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];
    Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];
    
    S_bk = S;
    for j = 1:1000
        S = S + sqrt((polyval(Xs,(j-1)/1000)-polyval(Xs,(j)/1000))^2 +(polyval(Ys,(j-1)/1000)-polyval(Ys,(j)/1000))^2 );
    end
    k = S-S_bk;
    ax = k * cos(theta_f) - 3 * X_f;
    ay = k * sin(theta_f) - 3 * Y_f;
    bx = k * cos(theta_i) + 3 * X_i;
    by = k * sin(theta_i) + 3 * Y_i;
    Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];
    Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];   
    
    A_bk = A;
    A = A + round(k/(V_avg * deltaT));
    if( i == n-1)
        for j = A_bk:A+2
            X_d(j + 1) = polyval(Xs,(j-A_bk)/(A-A_bk));
            Y_d(j + 1) = polyval(Ys,(j-A_bk)/(A-A_bk));
        end
    else
        for j = A_bk:A
            X_d(j + 1) = polyval(Xs,(j-A_bk)/(A-A_bk));
            Y_d(j + 1) = polyval(Ys,(j-A_bk)/(A-A_bk));
        end
    end
    
    
end

%% sim
figure(1)
plot(X_d,Y_d)
axis([-30 10 -30 30])
hold on
plot(-15,-15,'O');
plot(-25,-5,'O');
plot(-25,5,'O');
plot(-25,15,'O');
plot(-15,15,'O');
plot(-5,15,'X');
line([-20 -20],[0 10]);
line([10 10],[0 10]);
line([-20 10],[10 10]);
line([-20 10],[0 0]);
set(gca,'xtick',[-30:10:10]);
grid on;
pause(4)
for i = 1:A+1
   
    X_d_dot(i) = (X_d(i+1) - X_d(i))/deltaT;
    Y_d_dot(i) = (Y_d(i+1) - Y_d(i))/deltaT;
    theta_d(i) = atan2(Y_d_dot(i),X_d_dot(i));
    if(i > 1)
        if(theta_d(i) > theta_d(i-1) + pi)
            theta_d(i) = theta_d(i) - 2*pi;
        end
    end
    V_d(i) = sqrt((X_d_dot(i))^2+(Y_d_dot(i))^2);
    
end

for i = 1:A
    
    W_d(i) = (theta_d(i+1) - theta_d(i))/deltaT;
       
end

% ---------kinetic model control----------------

a = 1;
damp = 0.7;
k1 = 2*damp*a;
k3 = k1;


for t = 1:A
  
  if(mod(t,5) == 1)
  e_1(t) = (X_d(t) - X(t)) * cos(theta(t)) + (Y_d(t) - Y(t)) * sin(theta(t));
  e_2(t) = -(X_d(t) - X(t)) * sin(theta(t)) + (Y_d(t) - Y(t)) * cos(theta(t));
  e_3(t) = theta_d(t) - theta(t);
  
  k2 = (a^2 - W_d(t)^2) / V_d(t);
  
  u_1(t) = -k1 * e_1(t);
  %u_2(t) = -k2 * V_d(t) * sin(e_3(t)) * e_2(t) / e_3(t) - k3 * e_3(t);
  u_2(t) = -k2 *e_2(t) - k3 * e_3(t);  
  V_com(t) = V_d(t)*cos(e_3(t)) - u_1(t);
  W_com(t) = W_d(t) - u_2(t);  
  else
        V_com(t) = V_com(t-1);
        W_com(t) = W_com(t-1); 
  end
  
  if(abs(V_com(t)) >= V_max)
      V_com(t) = sign(V_com(t)) * V_max;
  end
  if(abs(W_com(t)) >= W_max)
      W_com(t) = sign(W_com(t)) * W_max;
  end  
  X(t+1) = X(t) + V_com(t) * cos(theta(t)) * deltaT;
  Y(t+1) = Y(t) + V_com(t) * sin(theta(t)) * deltaT;
  theta(t+1) = theta(t) + W_com(t) * deltaT;
  
%   plot(X(t+1),Y(t+1),'o');
  if(mod(t,40) == 1)
  line([X(t+1)+L*cos(theta(t+1)) X(t+1)+L*cos(theta(t+1)-150/360*2*pi)],[Y(t+1)+L*sin(theta(t+1)) Y(t+1)+L*sin(theta(t+1)-150/360*2*pi)]);
  line([X(t+1)+L*cos(theta(t+1)) X(t+1)+L*cos(theta(t+1)-210/360*2*pi)],[Y(t+1)+L*sin(theta(t+1)) Y(t+1)+L*sin(theta(t+1)-210/360*2*pi)]);
  line([X(t+1)+L*cos(theta(t+1)-210/360*2*pi) X(t+1)+L*cos(theta(t+1)-150/360*2*pi)],[Y(t+1)+L*sin(theta(t+1)-210/360*2*pi) Y(t+1)+L*sin(theta(t+1)-150/360*2*pi)]);
  pause(0.01);
  end
end