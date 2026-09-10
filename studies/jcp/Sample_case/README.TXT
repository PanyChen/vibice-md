#################################################################################

Freezing under motion: How surface vibrations suppress ice nucleation in water nanofilms

#################################################################################

############################## Files (Folders) ##################################

#### System Setup (./a_init)

Generate LAMMPS data file (data.nanofile) with initial atomic coordinates.


#### Temperature Ramp (./b_ramp)

in.ramp: Reads data.nanofile, equilibrate and then cools surfaces from 290K to 237K at 1 K/ns. Heat is extracted via surface thermostats. Outputs restart.*.ramp for in.config.


#### Temperature Ramp (./b_ramp)

in.ramp: Reads restart.*.equil and cools water from 290K to 220K at 1 K/ns. Generate restart file restart.*.ramp after.


#### Configuration Generation (./c_equil)

in.equil: Reads restart.*.ramp and equilibrates surfaces at 237K. Saves restart.*.equil every 500 ps as an initial configuration for in.meas.


#### Surface Vibration (./d_meas)

in.meas: Reads restart.*.equil and performs production simulations on either static surface (./d_meas/static) or vibration surfaces (./d_meas/vibration). In vibration simulations, frequency and amplitude are adjustable.

