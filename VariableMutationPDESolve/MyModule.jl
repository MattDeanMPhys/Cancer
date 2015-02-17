module MyModule

function f(u, du, d2u, k, h, deltaX)
	
	1 - k*( du + deltaX*d2u/2 ) + (u*k/h) - (u*k*deltaX/h^2)
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
