# ==================================================
# LORENTZIAN SHELL AND EXTINCTION CROSS SECTION
# ==================================================
# Frequency-dependent permittivity of the shell, Eq. (11), and the extinction
# cross section with radiative correction (see Supplemental Material).
# Here w is the photon energy hbar*omega in eV, and a and b are passed
# explicitly so that the shell thickness can be scanned (Fig. 2(b)).
# Requires parameters.jl.

# Tangential and radial permittivities of the shell (type-II Lorentzian)
etw(w) = einf + f*w0^2/(w0^2 - w^2 - im*gamma*w)
erw(w) = einf

# Frequency-dependent exponents of the potential in the shell
t1w(w) = (-1 + sqrt(1 + 8*etw(w)/erw(w)))/2
t2w(w) = (-1 - sqrt(1 + 8*etw(w)/erw(w)))/2

# Effective permittivity of the core-shell particle: a homogeneous sphere of
# radius a with this permittivity has the same dipole coefficient B3.
function eeff(w, a, b)
    er0  = erw(w)
    t1_w = t1w(w)
    t2_w = t2w(w)

    # Since a is the outer radius and b the inner one, b/a < 1
    ratio_term = (b/a)^(t2_w - t1_w)

    factor1 = er0*t2_w - ec
    factor2 = er0*t1_w - ec

    num = factor1*t1_w*ratio_term - factor2*t2_w
    den = factor1*ratio_term - factor2

    return (num/den)*er0
end

# Quasi-static and radiatively corrected polarizabilities
aqs(w, a, b)  = 4*pi*a^3*e0*eh*(eeff(w, a, b) - eh)/(eeff(w, a, b) + 2*eh)
arad(w, a, b) = aqs(w, a, b)/(1 - im*(k(w/hbar)^3/(6*pi*e0*eh))*aqs(w, a, b))

# Extinction cross section (m^2)
sigmaext(w, a, b) = (k(w/hbar)/(e0*eh))*imag(arad(w, a, b))
