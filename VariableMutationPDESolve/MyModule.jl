module MyModule

function f(u, du, d2u, k, h, deltaX)
	
	1 - k*( du + deltaX*d2u/2 ) + (u*k/h) - (u*k*deltaX/h^2)
end
	
function u(x, M)

	(0.9 * (cos(2 * pi * x /1)).^2 + 0.1 )
end

function du(x, M)

	- (2*pi)/M * 0.9 * sin((4*pi*x)/M)
end

function d2u(x, M)
	
	- 8 * pi^2 /M^2 * 0.9* ( 1- 2 * (sin((2*pi*x/M))).^2)
end


end
