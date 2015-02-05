module MyModule

function f(u, du, d2u, k, h)
	
	1 - k*( du + d2u ) + (u*k/h) - (2*u*k/h^2)
end
	
function u(x, M)

	0*(x.^3)/(M^3) + 0.1
end

function du(x, M)

	0*(3/M^3)*x.^2
end

function d2u(x, M)
	
	0*6*x/M^3
end


end
