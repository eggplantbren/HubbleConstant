library('rjags')

# Create the JAGS model object
m = jags.model(file="model.txt")

# Do some burn-in
update(m, 10000)

# Do the real MCMC
draw = jags.samples(m, 10000, thin=1, variable.names = c("H0"))

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

