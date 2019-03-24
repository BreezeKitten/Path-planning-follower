X_i = 0;
Y_i = 0;
theta_i = 0;

X_f = 0;
Y_f = 4;
theta_f = 2*pi;

Z1_i = theta_i;
Z2_i = X_i * cos(theta_i) + Y_i * sin(theta_i);
Z3_i = X_i * sin(theta_i) - Y_i * cos(theta_i);

Z1_f = theta_f;
Z2_f = X_f * cos(theta_f) + Y_f * sin(theta_f);
Z3_f = X_f * sin(theta_f) - Y_f * cos(theta_f);

delta = Z1_f - Z1_i ;
D = [abs(delta) , ((delta)^2)/2 ; sign(delta)*((delta)^2)/2 , ((delta)^3)/6];
d = [Z2_f-Z2_i ; Z3_f-Z3_i-Z2_i*delta];
C = inv(D)*d;


Z1s = [delta Z1_i];
Z2s = [C(2)*(abs(delta))^2/2 C(1)*abs(delta) Z2_i];
Z3s = [sign(delta)*C(2)*(abs(delta))^3/6 sign(delta)*C(1)*(abs(delta))^2/2 sign(delta)*Z2_i*abs(delta) Z3_i];

for i = 1:1001
  
  Z1(i) = polyval(Z1s,(i-1)/1000);
  Z2(i) = polyval(Z2s,(i-1)/1000);
  Z3(i) = polyval(Z3s,(i-1)/1000);
    
    
  X(i) = Z2(i) * cos(Z1(i)) + Z3(i) * sin(Z1(i));
  Y(i) = Z2(i) * sin(Z1(i)) - Z3(i) * cos(Z1(i)); 
  
end

figure(1)
plot(X,Y)
hold on
plot(X_i,Y_i,'x')
plot(X_f,Y_f,'o')
xlabel('X')
ylabel('Y')
title('planning via para input')
axis([-5 5 -5 5])