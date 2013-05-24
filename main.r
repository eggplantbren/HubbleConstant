library('rjags')

data = as.matrix(read.table('h0_data.txt', header=FALSE))
data = list(y=data[,1], sig=data[,2], N=length(data[,1]))

# Create the JAGS model object
m = jags.model(file="model1.txt", data=data)

# Do some burn-in
update(m, 50000)

# Do the real MCMC
draw = jags.samples(m, 50000, thin=10, variable.names = c("H0", "log_nu", "log_K"))

# Manipulate the output into a list
results = list()
for(name in names(draw))
{
	temp = as.array(draw[[name]])[,,1]
	temp = as.array(temp)
	if(length(dim(temp)) == 2)
		temp = t(temp)
	results[[name]] = as.array(temp)
}

hist(results$H0, breaks=100)

