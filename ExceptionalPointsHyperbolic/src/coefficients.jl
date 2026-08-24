# Here we define the exponents (t_{1,2}) and coefficients of the electric potential/field (A1,A2,B2,B3)

# Exponents of the electric potential/field in the shell

t1(et) = (-1 + sqrt(Complex(1+8*et/er)))/2
t2(et) = (-1 - sqrt(Complex(1+8*et/er)))/2

# Coefficients of the electric potential/field in the shell

function A1(et)
if et/er != -1/8
# A1 in the non-exceptional case (Eq )
return 3*a*E0*eh*er*(t1(et)-t2(et))/(b*(a^t1(et)*b^(-t1(et))*(2*eh+er*t1(et))*(-ec+er*t2(et))+a^t2(et)*b^(-t2(et))*(ec-er*t1(et))*(2*eh+er*t2(et))))
else
# A1 in the exceptional case (Eq )
return -12*a^(3/2)*E0*eh*er/(b^(3/2)*(4*(2*eh+ec)*er+(4*eh-er)*(2*ec+er)*log(a/b)))
end
end

function A2(et)
if et/er != -1/8
return -3*a*b^t2(et)*E0*eh*(ec-er*t2(et))/(a^t1(et)*b^t2(et)*(2*eh+er*t1(et))*(ec-er*t2(et))-a^t2(et)*b^t1(et)*(ec-er*t1(et))*(2*eh+er*t2(et)))
else
return 6*a^(3/2)*E0*eh*(-2*er+(2*ec+er)*log(b))/(4*(2*eh+ec)*er+(4*eh-er)*(2*ec+er)*log(a/b))
end
end

function B2(et)
if et/er != -1/8
return -3*a*b^t1(et)*E0*eh*(ec-er*t1(et))/(a^t1(et)*b^t2(et)*(2*eh+er*t1(et))*(-ec+er*t2(et))+a^t2(et)*b^t1(et)*(ec-er*t1(et))*(2*eh+er*t2(et)))
else
return -6*a^(3/2)*E0*eh*(2*ec+er)/(4*(2*eh+ec)*er+(4*eh-er)*(2*ec+er)*log(a/b))
end
end

function B3(et)
if et/er != -1/8 
return a^3*E0*(a^t1(et)*b^t2(et)*(eh-er*t1(et))*(ec-er*t2(et))+a^t2(et)*b^t1(et)*(ec-er*t1(et))*(-eh+er*t2(et)))/(a^t1(et)*b^t2(et)*(2*eh+er*t1(et))*(-ec+er*t2(et))+a^t2(et)*b^t1(et)*(ec-er*t1(et))*(2*eh+er*t2(et)))
else
return a^3*E0*(4*(ec-eh)*er-(2*eh+er)*(2*ec+er)*log(a/b))/(4*(2*eh+ec)*er+(4*eh-er)*(2*ec+er)*log(a/b))
end
end 