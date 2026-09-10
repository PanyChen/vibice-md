#################################################################################

Nanoscale insights into vibration-induced heterogeneous ice nucleation

#################################################################################

############################## Files (Folders) ##################################

#### System Setup (./a_init)

LAMMPS data file (250A_IdenWalls.dat) with initial atomic coordinates.


#### Equilibration (./b_equil)

in.equil: LAMMPS script for isothermal equilibration of water at 290K. Outputs a restart file (restart.*.equil) for in.ramp.


#### Temperature Ramp (./c_ramping)

in.ramp: Reads restart.*.equil and cools surfaces from 290K to 220K at 1 K/ns. Heat is extracted via surface thermostats. Outputs restart.*.ramp for in.config.


#### Configuration Generation (./d_config)

in.config: Reads restart.*.ramp and equilibrates surfaces at 220K. Saves restart.*.config every 2 ns as an initial configuration for in.meas.


#### Surface Vibration (./e_meas)

Simulations monitor potential energy every 10 ns. If ice nucleates, an additional 10 ns run is performed. Otherwise, runs continue until 100 ns.

in.meas: Reads restart.*.config and performs surface vibration on one surface while keeping the other static. Both surfaces are thermalized at 220K. Frequency and amplitude are adjustable. Simulations run in 10 ns increments, generating a new restart.*.config file after each run which will be used as the initial configuration for the next 10 ns simulation.

numChk.cpp: Analyzes meas_final.txt to check water's potential energy after each 10 ns simulation. This potential energy will be compared with the critical value in meas.slurm to distinguish if the ice nucleation occurs. 

meas.slurm: Automates repeated submissions of in.meas. If nucleation occurs, one final submission is performed before termination. Otherwise, runs continue up to 100 ns (max 10 submissions).

## New fix command (./e_meas/fix_movenve)
This fix will work with LAMMPS version ‘23Jun2022’. To build LAMMPS with this new fix, place the files in the ‘src’ directory and compile the LAMMPS.
