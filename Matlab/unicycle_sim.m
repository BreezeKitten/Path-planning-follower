clear all
X_int = -20;
Y_int = -20;
theta_int = 0; % unit:rad

X(1) = X_int;
Y(1) = Y_int;
theta(1) = theta_int;

T = 0.05; %time constant
L = 0.4;  %length constant

Xc = 0;
Yc = 0;

%-------------planning_via_Cartesian

X_i = -15;
Y_i = -15;
theta_i = pi*3/4;

X_f = -25;
Y_f = -5;
theta_f = pi/2;

k = 10;

ax = k * cos(theta_f) - 3 * X_f;
ay = k * sin(theta_f) - 3 * Y_f;

bx = k * cos(theta_i) + 3 * X_i;
by = k * sin(theta_i) + 3 * Y_i;

Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];

Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];

S = 0;
for i = 1:1000
S = S + sqrt((polyval(Xs,(i-1)/1000)-polyval(Xs,(i)/1000))^2 +(polyval(Ys,(i-1)/1000)-polyval(Ys,(i)/1000))^2 );
end
A = round(S*100);

k = round(A/100);

ax = k * cos(theta_f) - 3 * X_f;
ay = k * sin(theta_f) - 3 * Y_f;

bx = k * cos(theta_i) + 3 * X_i;
by = k * sin(theta_i) + 3 * Y_i;

Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];

Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];

for i = 1:A
    
  X_d(i) = polyval(Xs,(i-1)/A);
  Y_d(i) = polyval(Ys,(i-1)/A);
  
end
%--------------

% X_i = -20;
% Y_i = -10;
% theta_i = pi*3/4;
% 
% X_f = -25;
% Y_f = -5;
% theta_f = pi/2;
% 
% k = 10;
% 
% ax = k * cos(theta_f) - 3 * X_f;
% ay = k * sin(theta_f) - 3 * Y_f;
% 
% bx = k * cos(theta_i) + 3 * X_i;
% by = k * sin(theta_i) + 3 * Y_i;
% 
% Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];
% 
% Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];
% 
% S_bk = S;
% for i = 1:1000
% S = S + sqrt((polyval(Xs,(i-1)/1000)-polyval(Xs,(i)/1000))^2 +(polyval(Ys,(i-1)/1000)-polyval(Ys,(i)/1000))^2 );
% end
% A = round(S*100) - round(S_bk*100);
% 
% k = round(A/100);
% 
% ax = k * cos(theta_f) - 3 * X_f;
% ay = k * sin(theta_f) - 3 * Y_f;
% 
% bx = k * cos(theta_i) + 3 * X_i;
% by = k * sin(theta_i) + 3 * Y_i;
% 
% Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];
% 
% Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];
% 
% for i = 1:A
%     
%   X_d(i+round(S_bk*100)) = polyval(Xs,(i-1)/A);
%   Y_d(i+round(S_bk*100)) = polyval(Ys,(i-1)/A);
%   
% end

%============================
X_i = -25;
Y_i = -5;
theta_i = pi/2;

X_f = -25;
Y_f = 5;
theta_f = pi/2;

k = 10;

ax = k * cos(theta_f) - 3 * X_f;
ay = k * sin(theta_f) - 3 * Y_f;

bx = k * cos(theta_i) + 3 * X_i;
by = k * sin(theta_i) + 3 * Y_i;

Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];

Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];

S_bk = S;
for i = 1:1000
S = S + sqrt((polyval(Xs,(i-1)/1000)-polyval(Xs,(i)/1000))^2 +(polyval(Ys,(i-1)/1000)-polyval(Ys,(i)/1000))^2 );
end
A = round(S*100) - round(S_bk*100);

k = round(A/100);

ax = k * cos(theta_f) - 3 * X_f;
ay = k * sin(theta_f) - 3 * Y_f;

bx = k * cos(theta_i) + 3 * X_i;
by = k * sin(theta_i) + 3 * Y_i;

Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];

Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];

for i = 1:A
    
  X_d(i+round(S_bk*100)) = polyval(Xs,(i-1)/A);
  Y_d(i+round(S_bk*100)) = polyval(Ys,(i-1)/A);
  
end
%===============================
X_i = -25;
Y_i = 5;
theta_i = pi/2;

X_f = -25;
Y_f = 15;
theta_f = 0;

k = 10;


ax = k * cos(theta_f) - 3 * X_f;
ay = k * sin(theta_f) - 3 * Y_f;

bx = k * cos(theta_i) + 3 * X_i;
by = k * sin(theta_i) + 3 * Y_i;

Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];

Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];

S_bk = S;
for i = 1:1000
S = S + sqrt((polyval(Xs,(i-1)/1000)-polyval(Xs,(i)/1000))^2 +(polyval(Ys,(i-1)/1000)-polyval(Ys,(i)/1000))^2 );
end
A = round(S*100) - round(S_bk*100);

k = round(A/100);

ax = k * cos(theta_f) - 3 * X_f;
ay = k * sin(theta_f) - 3 * Y_f;

bx = k * cos(theta_i) + 3 * X_i;
by = k * sin(theta_i) + 3 * Y_i;

Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];

Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];

for i = 1:A
    
  X_d(i+round(S_bk*100)) = polyval(Xs,(i-1)/A);
  Y_d(i+round(S_bk*100)) = polyval(Ys,(i-1)/A);
  
end
%==================
X_i = -25;
Y_i = 15;
theta_i = 0;

X_f = -15;
Y_f = 15;
theta_f = 0;

k = 10;

ax = k * cos(theta_f) - 3 * X_f;
ay = k * sin(theta_f) - 3 * Y_f;

bx = k * cos(theta_i) + 3 * X_i;
by = k * sin(theta_i) + 3 * Y_i;

Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];

Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];

S_bk = S;
for i = 1:1000
S = S + sqrt((polyval(Xs,(i-1)/1000)-polyval(Xs,(i)/1000))^2 +(polyval(Ys,(i-1)/1000)-polyval(Ys,(i)/1000))^2 );
end
A = round(S*100) - round(S_bk*100);

k = round(A/100);

ax = k * cos(theta_f) - 3 * X_f;
ay = k * sin(theta_f) - 3 * Y_f;

bx = k * cos(theta_i) + 3 * X_i;
by = k * sin(theta_i) + 3 * Y_i;

Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];

Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];

for i = 1:A
    
  X_d(i+round(S_bk*100)) = polyval(Xs,(i-1)/A);
  Y_d(i+round(S_bk*100)) = polyval(Ys,(i-1)/A);
  
end

%===================
X_i = -15;
Y_i = 15;
theta_i = 0;

X_f = -5;
Y_f = 15;
theta_f = 0;

k = 10;

ax = k * cos(theta_f) - 3 * X_f;
ay = k * sin(theta_f) - 3 * Y_f;

bx = k * cos(theta_i) + 3 * X_i;
by = k * sin(theta_i) + 3 * Y_i;

Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];

Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];

S_bk = S;
for i = 1:1000
S = S + sqrt((polyval(Xs,(i-1)/1000)-polyval(Xs,(i)/1000))^2 +(polyval(Ys,(i-1)/1000)-polyval(Ys,(i)/1000))^2 );
end
A = round(S*100) - round(S_bk*100);

k = round(A/100);

ax = k * cos(theta_f) - 3 * X_f;
ay = k * sin(theta_f) - 3 * Y_f;

bx = k * cos(theta_i) + 3 * X_i;
by = k * sin(theta_i) + 3 * Y_i;

Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];

Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];

for i = 1:(A+2)
    
  X_d(i+round(S_bk*100)) = polyval(Xs,(i-1)/A);
  Y_d(i+round(S_bk*100)) = polyval(Ys,(i-1)/A);
  
end

% for i = 1:10002
%     X_d(i) = Xc + 10*sin((i-1)*T/15);
%     Y_d(i) = Yc + 10*sin(((i-1))*T*2/15);
% %     plot(X_d(i),Y_d(i),'x')
% %     pause(0.01);
% end


% X_d = linspace(0,-10,1000);
% Y_d = linspace(0,10,1000);
% X_d(10001) = -10.01;
% X_d(10002) = -10.02;
% Y_d(10001) = 10.01;
% Y_d(10002) = 10.02; 

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
pause(5)
for i = 1:(round(S*100)+1)
   
    X_d_dot(i) = (X_d(i+1) - X_d(i))/T;
    Y_d_dot(i) = (Y_d(i+1) - Y_d(i))/T;
    theta_d(i) = atan2(Y_d_dot(i),X_d_dot(i));
    if(i > 1)
        if(theta_d(i) > theta_d(i-1) + pi)
            theta_d(i) = theta_d(i) - 2*pi;
        end
    end
    V_d(i) = sqrt((X_d_dot(i))^2+(Y_d_dot(i))^2);
    
end

for i = 1:round(S*100)
    
    W_d(i) = (theta_d(i+1) - theta_d(i))/T;
       
end

% ---------kinetic model control----------------

a = 1;
damp = 0.7;
k1 = 2*damp*a;
k3 = k1;


for t = 1:round(S*100)
  
  if(mod(t,2) == 1)
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
  X(t+1) = X(t) + V_com(t) * cos(theta(t)) * T;
  Y(t+1) = Y(t) + V_com(t) * sin(theta(t)) * T;
  theta(t+1) = theta(t) + W_com(t) * T;
  
%   plot(X(t+1),Y(t+1),'o');
  if(mod(t,40) == 1)
  line([X(t+1)+L*cos(theta(t+1)) X(t+1)+L*cos(theta(t+1)-150/360*2*pi)],[Y(t+1)+L*sin(theta(t+1)) Y(t+1)+L*sin(theta(t+1)-150/360*2*pi)]);
  line([X(t+1)+L*cos(theta(t+1)) X(t+1)+L*cos(theta(t+1)-210/360*2*pi)],[Y(t+1)+L*sin(theta(t+1)) Y(t+1)+L*sin(theta(t+1)-210/360*2*pi)]);
  line([X(t+1)+L*cos(theta(t+1)-210/360*2*pi) X(t+1)+L*cos(theta(t+1)-150/360*2*pi)],[Y(t+1)+L*sin(theta(t+1)-210/360*2*pi) Y(t+1)+L*sin(theta(t+1)-150/360*2*pi)]);
  pause(0.02);
  end
end


%-------Input/output linearization
% b = 0.2;
% for i = 1:1000
%    
%     y1_d(i) = X_d(i) +  b * cos(theta_d(i));
%     y2_d(i) = Y_d(i) +  b * sin(theta_d(i));
%     y1_dot_d(i) = V_d(i) * cos(theta_d(i)) - b * sin(theta_d(i)) * W_d(i);
%     y2_dot_d(i) = V_d(i) * sin(theta_d(i)) + b * cos(theta_d(i)) * W_d(i);
%     
% end
% 
% k1 = 2;
% k2 = 2;
% 
% for t = 1:1000
%   
%   y1(t) = X(t) + b * cos(theta(t));
%   y2(t) = Y(t) + b * sin(theta(t));
%   
%   u_1(t) = y1_dot_d(t) + k1*(y1_d(t) - y1(t));
%   u_2(t) = y2_dot_d(t) + k2*(y2_d(t) - y2(t));
%   V_com(t) = cos(theta(t)) * u_1(t) + sin(theta(t)) * u_2(t);
%   W_com(t) = -sin(theta(t)) * u_1(t) / b + cos(theta(t)) * u_2(t) / b;
%   X(t+1) = X(t) + V_com(t) * cos(theta(t)) * T;
%   Y(t+1) = Y(t) + V_com(t) * sin(theta(t)) * T;
%   theta(t+1) = theta(t) + W_com(t) * T;
%   
% %   plot(X(t+1),Y(t+1),'o');
%   if(mod(t,10) == 1)
%   line([X(t+1)+L*cos(theta(t+1)) X(t+1)+L*cos(theta(t+1)-150/360*2*pi)],[Y(t+1)+L*sin(theta(t+1)) Y(t+1)+L*sin(theta(t+1)-150/360*2*pi)]);
%   line([X(t+1)+L*cos(theta(t+1)) X(t+1)+L*cos(theta(t+1)-210/360*2*pi)],[Y(t+1)+L*sin(theta(t+1)) Y(t+1)+L*sin(theta(t+1)-210/360*2*pi)]);
%   line([X(t+1)+L*cos(theta(t+1)-210/360*2*pi) X(t+1)+L*cos(theta(t+1)-150/360*2*pi)],[Y(t+1)+L*sin(theta(t+1)-210/360*2*pi) Y(t+1)+L*sin(theta(t+1)-150/360*2*pi)]);
%   pause(0.02);
%   end
% end

%----------response result
% figure(2)
% subplot(2,3,1)
% plot(X_d)
% hold on
% plot(X)
