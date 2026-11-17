# ==================================================
# PARAMETERS
# ==================================================
# Lengths are in SI units (m) and energies in eV.
# These are the values used for Figs. 1(c) and 2 of the paper.

# Physical constants
hbar = 6.582119569e-16    # reduced Planck constant (eV s)
c    = 2.99792458e8       # speed of light in vacuum (m/s)
e0   = 8.8541878128e-12   # vacuum permittivity (F/m)

# Permittivities
ec = 1    # core permittivity
er = 1    # radial permittivity of the shell
eh = 1    # host-medium permittivity

# Radii of the core-shell particle (m)
a = 30e-9   # outer radius of the shell
b = 10e-9   # inner radius of the shell (core radius)

# Amplitude of the incident electric field.
# We fix E0 = 1, so all fields are normalized as E/E0.
E0 = 1

# Lorentzian model of the tangential permittivity, Eq. (11)
einf  = 1      # background permittivity
gamma = 0.05   # damping, hbar*gamma (eV)
f     = 1      # oscillator strength
w0    = 2.0    # resonance energy, hbar*omega_0 (eV)

# Wavenumber in the host medium, for an angular frequency w (rad/s)
k(w) = sqrt(eh)*w/c
