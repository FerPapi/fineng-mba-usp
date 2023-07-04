# Exercicios 15/05
# 1) estimar a ACF de y_t = e_t + 0.25*e_{t-1} + 0.3*e_{t-2} + 0.1*e_{t-3} 
# sendo e_t ruído branco com variância sigma^2 = 0.01
th_1 = 0.25
th_2 = 0.3
th_3 = 0.1
sigma_2 = 0.01
y0 = arima.sim(model = list(ma = c(th_1, th_2, th_3)), sd = 0.1, n=1e4)
plot(y0)
ACF_y0 = acf(y0)
gamma_1 = (th_1+th_2*th_1+th_3*th_2)*sigma_2
gamma_2 = (th_2+th_3*th_1)*sigma_2
gamma_3 = (th_3)*sigma_2
gamma_0 = (1+th_1^2+th_2^2+th_3^2)*sigma_2
rho_1 = gamma_1/gamma_0
rho_2 = gamma_2/gamma_0
rho_3 = gamma_3/gamma_0


# 2) verificar estacionaridade de y_t = 0.3*y_{t-1}+0.5*y_{t-2}+e_t
# sendo e_t ruído branco com variância sigma^2 = 0.01
phi_1 = 0.3
phi_2 = 0.5
raizes = polyroot(c(1,-phi_1,-phi_2))
modulo_raizes = abs(raizes)
# como as raízes possuem módulo maior do que 1, a série é estável.
# Vamos resolver de outra forma:
F = matrix(c(phi_1, phi_2,1, 0),nrow = 2,byrow=T)
eig = eigen(F)
modulo_auto_valores = abs(eig$values)
# como os autovalores possuem módulo menor do que 1, a série é estacionária.
y1 = arima.sim(model = list(ar = c(phi_1, phi_2)), sd = 0.1, n=1e4)
plot(y1)

#Estimativa da ACF:
y1_ACF = acf(y1)
#Estimativa da PACF:
y1_PACF = pacf(y1)

# 3) verificar estacionaridade de y_t = -0.5*y_{t-1}+0.5*y_{t-2}+e_t
phi_1 = -0.5
phi_2 = 0.5
raizes = polyroot(c(1,-phi_1,-phi_2))
modulo_raizes = abs(raizes)
# como uma as raízes possui modulo unitário a série não é estacionaria
# Vamos resolver de outra forma:
F = matrix(c(phi_1, phi_2,1, 0),nrow = 2,byrow=1)
eig = eigen(F)
modulo_auto_valores = abs(eig$values)
# como um dos autovalores possui modulo unitário, a série não é estacionária
#y_t = -0.5*y_{t-1}+0.5*y_{t-2}+e_t
# 
# A simulação será criada com um laço "for"
y2 = rep(0,1,1e4)
y2[1]= rnorm(1,0,0.01)# y[-1] = 0; y[0] = 0;
y2[2] = phi_1*y[1]+rnorm(1,0,0.01)# y[0] = 0;
t_sim = 1e4
for(i in 3:t_sim){
   y2[i] = phi_1*y2[i-1]+phi_2*y2[i-2]+rnorm(1,0,0.01)
 }
 idx = 1:t_sim;
plot(idx,y2,type="l")
