# Here we define the electric field in spherical coordinates

# Radial component

function Er(et,r,theta)
#Core (r<b)
if r<b
return -A1(et)*cos(theta)
#Shell (a<r<b)
elseif b<=r<a 
if et/er != -1/8
return (-t1(et)*A2(et)*r^(t1(et)-1)-t2(et)*B2(et)*r^(t2(et)-1))*cos(theta)
else 
return r^(-3/2)*cos(theta)*(-1/2*A2(et) + B2(et)*(1-1/2*log(r)))
end
#Host medium (r>a)
else
return (E0 + 2*r^-3*B3(et))*cos(theta)
end
end

# Tangential/theta component

function Eth(et,r,theta)
#Core (r<b)
if r<b
return A1(et)*sin(theta)
#Shell (a<r<b)
elseif b<=r<a 
if et/er != -1/8
return (A2(et)*r^(t1(et)-1)+B2(et)*r^(t2(et)-1))*sin(theta)
elseif et/er == -1/8
return r^(-3/2)*sin(theta)*(A2(et)+ B2(et)*log(r))
end
#Host medium (r>a)
else
return (-E0 + r^-3*B3(et))*sin(theta)
end
end

# Vectorial field
E(et,r,theta) = [Er(et,r,theta),Eth(et,r,theta)]

# Amplitude of the electric field
Eabs(et,r,theta) = sqrt(norm(Er(et,r,theta)).^2+norm(Eth(et,r,theta)).^2)

# Map of electric field amplitude, between xmin and xmax and ymin and ymax, with step xst and yst.
Emap(xmin,xmax,ymin,ymax,xst,yst,et) = [Eabs(et,sqrt(x^2+y^2), Base.angle(x+im*y)) for x in xmin:xst:xmax, y in ymin:yst:ymax];
