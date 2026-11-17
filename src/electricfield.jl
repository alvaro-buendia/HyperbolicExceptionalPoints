# ==================================================
# ELECTRIC FIELD (dipole, l = 1)
# ==================================================
# Radial and polar components of E = -grad(phi) in the core, shell and host,
# Eqs. (7)-(8); full expressions in the Supplemental Material.
# theta is measured from the polarization direction of the incident field.
# Requires coefficients.jl and parameters.jl.

# Radial component
function Er(et, r, theta)
    if r < b                    # core
        return -A1(et)*cos(theta)
    elseif b <= r < a           # shell
        if et/er != -1/8
            return (-t1(et)*A2(et)*r^(t1(et)-1) - t2(et)*B2(et)*r^(t2(et)-1))*cos(theta)
        else                    # exceptional point
            return r^(-3/2)*cos(theta)*(1/2*A2(et) - B2(et)*(1 - 1/2*log(r/b)))
        end
    else                        # host
        return (E0 + 2*r^-3*B3(et))*cos(theta)
    end
end

# Polar (theta) component
function Eth(et, r, theta)
    if r < b                    # core
        return A1(et)*sin(theta)
    elseif b <= r < a           # shell
        if et/er != -1/8
            return (A2(et)*r^(t1(et)-1) + B2(et)*r^(t2(et)-1))*sin(theta)
        else                    # exceptional point
            return r^(-3/2)*sin(theta)*(A2(et) + B2(et)*log(r/b))
        end
    else                        # host
        return (-E0 + r^-3*B3(et))*sin(theta)
    end
end

# Field vector (E_r, E_theta)
E(et, r, theta) = [Er(et, r, theta), Eth(et, r, theta)]

# Field amplitude |E|
Eabs(et, r, theta) = sqrt(abs(Er(et, r, theta))^2 + abs(Eth(et, r, theta))^2)

# Map of |E| on a Cartesian grid, x in [xmin, xmax] and y in [ymin, ymax] with
# steps xst and yst. The polar axis (theta = 0) is along x.
Emap(xmin, xmax, ymin, ymax, xst, yst, et) =
    [Eabs(et, sqrt(x^2 + y^2), Base.angle(x + im*y)) for x in xmin:xst:xmax, y in ymin:yst:ymax]
