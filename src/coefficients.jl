# ==================================================
# COEFFICIENTS OF THE ELECTRIC POTENTIAL (dipole, l = 1)
# ==================================================
# Exponents t1,2 of the potential in the shell, Eq. (5), and the amplitudes
# of the potential in Eq. (6): A1 (core), A2 and B2 (shell), B3 (host).
# The derivation and the expressions for a general multipole l are given in
# the Supplemental Material.
#
# All functions take the tangential permittivity of the shell, et. The other
# parameters (er, ec, eh, a, b, E0) are defined in parameters.jl.
# At the exceptional point, et/er = -1/8, the Jordan-form solution is used.

# Exponents of the potential in the shell
t1(et) = (-1 + sqrt(Complex(1 + 8*et/er)))/2
t2(et) = (-1 - sqrt(Complex(1 + 8*et/er)))/2

# Core amplitude
function A1(et)
    if et/er != -1/8
        return 3*a*E0*eh*er*(t1(et)-t2(et))/
            (b*(a^t1(et)*b^(-t1(et))*(2*eh+er*t1(et))*(-ec+er*t2(et))
            +a^t2(et)*b^(-t2(et))*(ec-er*t1(et))*(2*eh+er*t2(et))))
    else    # exceptional point
        return -12*a^(3/2)*E0*eh*er/
            (b^(3/2)*(4*(2*eh+ec)*er+(4*eh-er)*(2*ec+er)*log(a/b)))
    end
end

# Shell amplitude of the r^t1 solution (of r^(-1/2) at the EP)
function A2(et)
    if et/er != -1/8
        return -3*a*b^t2(et)*E0*eh*(ec-er*t2(et))/
            (a^t1(et)*b^t2(et)*(2*eh+er*t1(et))*(ec-er*t2(et))
            -a^t2(et)*b^t1(et)*(ec-er*t1(et))*(2*eh+er*t2(et)))
    else    # exceptional point
        return -12*a^(3/2)*E0*eh*er/
            (4*(2*eh+ec)*er+(4*eh-er)*(2*ec+er)*log(a/b))
    end
end

# Shell amplitude of the r^t2 solution (of r^(-1/2) log(r/b) at the EP)
function B2(et)
    if et/er != -1/8
        return -3*a*b^t1(et)*E0*eh*(ec-er*t1(et))/
            (a^t1(et)*b^t2(et)*(2*eh+er*t1(et))*(-ec+er*t2(et))
            +a^t2(et)*b^t1(et)*(ec-er*t1(et))*(2*eh+er*t2(et)))
    else    # exceptional point
        return -6*a^(3/2)*E0*eh*(2*ec+er)/
            (4*(2*eh+ec)*er+(4*eh-er)*(2*ec+er)*log(a/b))
    end
end

# Host amplitude (induced dipole); the poles of B3 give the resonances
function B3(et)
    if et/er != -1/8
        return a^3*E0*(
            a^t1(et)*b^t2(et)*(eh-er*t1(et))*(ec-er*t2(et))
            +a^t2(et)*b^t1(et)*(ec-er*t1(et))*(-eh+er*t2(et))
        )/(
            a^t1(et)*b^t2(et)*(2*eh+er*t1(et))*(-ec+er*t2(et))
            +a^t2(et)*b^t1(et)*(ec-er*t1(et))*(2*eh+er*t2(et))
        )
    else    # exceptional point
        return a^3*E0*(
            4*(ec-eh)*er-(2*eh+er)*(2*ec+er)*log(a/b)
        )/(
            4*(2*eh+ec)*er+(4*eh-er)*(2*ec+er)*log(a/b)
        )
    end
end
