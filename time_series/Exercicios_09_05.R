# Exemplo

# y[t] = 0.3*y[t-1] + 0.2*y[t-2] + w[t]
# w[t] é ruído branco com variância unitária
#y[0] = 0; y[-1]=0

phi_1 = 0.3; phi_2 = 0.2 #depois teste com phi_1 = 0.3; phi_2 = 0.8

# Raízes da série
z = polyroot(c(1, -phi_1, -phi_2)) #polyroot(c(a0,a1,a2))
# Como as raízes possuem módulos maiores do que 1, a serie é estacionária


# autovalores
F = matrix(c(phi_1, phi_2, 1, 0),byrow = T,nrow = 2, ncol = 2)
autovalores = eigen(F)$values
mod_autovalores = abs(autovalores)
# Como os autovalores possuem módulos menores do que 1, a serie é estacionária


# y[t] = 0.3*y[t-1] + 0.2*y[t-2] + w[t]
y = rep(0,1000);
y[1] = rnorm(1)
y[2] = 0.3*y[1] + rnorm(1)

for (t in 3:1000) {
  y[t] = phi_1*y[t-1]+phi_2*y[t-2]+ rnorm(1)
}
par(mfrow=c(1,1))
plot(y,type="l") 
