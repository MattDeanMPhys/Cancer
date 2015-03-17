module MyModule

function f(uhat, duhat, d2uhat, k, h, deltaX)
	
	1 - k*( duhat + deltaX*d2uhat/2 ) + (uhat*k/h) - (uhat*k*deltaX/h^2)
end
	
function u(x, M)

	#(0.9 * (cos(2 * pi * x /1)).^2 + 0.1 )
	0.1 + 0*x
end

function du(x, M)

	#- (2*pi)/M * 0.9 * sin((4*pi*x)/M)
	0*x
end

function d2u(x, M)
	
	#- 8 * pi^2 /M^2 * 0.9* ( 1- 2 * (sin((2*pi*x/M))).^2)
	0*x
end


end
