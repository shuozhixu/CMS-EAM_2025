# Refractory medium entropy alloys

## Foreword

In this project, we will build the chemical short-range order (CSRO) structures of 18 equal-molar body-centered cubic (BCC) refractory medium element alloys (MEAs) and calculate their lattice parameter and generalized stacking fault energies (GSFEs).

As summarized in [another GitHub repository](https://github.com/shuozhixu/MSMSE_2024), there are two methods to build a CSRO structure. In this project, the first will be used and the embedded-atom method (EAM) potential will be employed, unless stated otherwise.

The first question we aim to answer is:

- [1] Are the two chemical potential differences unique for a specific MEA?
	- If not, do they affect the Warren-Cowley (WC) parameters and GSFEs differently?

for that, we will use NbTaTi and TaVW as examples. This is done in [another project](https://github.com/tannercabaniss/Comp_Mat_Sci_Proj_Help).

The next three questions we aim to answer are:

- [2] Does the chemical potential difference between the same two elements vary across different MEAs?
	- Answer: Yes
- [3] Does the segregation and/or local ordering of the same atomic pair vary across different MEAs?
	- Answer: Mostly likely yes
- [4] How does the CSRO affect GSFEs across MEAs?

for those, we will investigate 18 MEAs, including MoTaW, NbTaW, MoNbTi, HfNbTa, NbTiZr, HfNbTi, HfTaTi, TaTiZr, MoTaTi, MoNbV, MoNbW, MoTaV, MoTaW, MoVW, NbTaV, NbTaTi, NbVW, and TaVW. These 18 MEAs were chosen for their stable BCC structures.

The last question we aim to answer is:

- [5] Are the answers to the questions [3,4] dependent on the interatomic potential?

for that, we will investigate MoNbTa, MoNbV, NbTaV, and NbVW using a moment tensor potential (MTP). The CSRO structures will be built using the second method. This is done in [another project](https://github.com/shuozhixu/CMS-MTP_2025).

[A recent work](https://doi.org/10.3390/modelling5010019) calculated the GSFEs in MoNbTa, HfMoNbTaTi, and HfNbTaTiZr. In that work, EAM potentials were used, and the first method was employed to build the CSRO structures. It was found that the CSRO lowers the GSFE in MoNbTa but increases the GSFEs in the other two alloys.

[An earlier work](https://doi.org/10.1038/s41524-023-01046-z) calculated the GSFEs in MoNbTi and NbTaTi. In that work, an MTP (not the same MTP to be used in this project) was used, and the second method was employed to build the CSRO structures. It was found that the CSRO increases the GSFEs in both alloys, see [Supplementary Figure 10](https://static-content.springer.com/esm/art%3A10.1038%2Fs41524-023-01046-z/MediaObjects/41524_2023_1046_MOESM1_ESM.pdf). 

## LAMMPS

As of February 2024, the latest version of LAMMPS installed on [Bridges-2](https://www.psc.edu/resources/bridges-2) was from June 2022. That version does not allow us to use the [`fix sgcmc` command](https://docs.lammps.org/fix_sgcmc.html), which we need to build the CSRO structure using the first method.

So we need to build our own LAMMPS version with two packages:

- MANYBODY package. This is to use the manybody potential such as the EAM potential.
- MC package. This is to generate materials with chemical short-range order at a given temperature using the first method. [This paper](http://dx.doi.org/10.1103/PhysRevB.85.184203) and [this paper](https://doi.org/10.1103/PhysRevB.86.134204) should be cited if one uses this package.

To build LAMMPS, use the file `lmp_mbmc.sh`. First, cd to any directory on Bridges-2, e.g., \$HOME, then

	sh lmp_mbmc.sh

Note that the second command in `lmp_mbmc.sh` will load three modules. If one cannot load them, try `module purge` first.

Once the `sh` run is finished, we will find a file `lmp_mpi` in the `lammps_mbmc/src` directory on Bridges-2. And that is the LAMMPS executable with MANYBODY and MC packages.

## 18 MEAs

In [a previous paper](https://doi.org/10.3390/modelling5010019), the CSRO MoNbTa structure was built using the first method, before the lattice parameter and GSFE were calculated. Here, we focus on the remaining 17 MEAs. Below, we take HfNbTa as an example.

### HfNbTa

#### Chemical potential differences

Among the 18 MEAs, the chemical potential differences for 12 MEAs can be found in the file `mu.txt` in this GitHub repository.

Here, we calculate the two chemical potential differences for each of the remaining 6 MEAs: HfNbTa, MoTaTi, MoNbV, MoNbW, MoTaV, NbTaV.

First, modify the file `lmp_sgc.in` in the `MoNbTa/csro/` directory in [a previous GitHub repository](https://github.com/shuozhixu/Modelling_2024). Take HfNbTa as an example:

- Replace all `Mo`, `Nb`, and `Ta` with `Hf`, `Nb`, and `Ta`, respectively; the replacement should be case-sensitive, e.g., don’t replace `mo` in the word `thermo` with another element
- Change line 28 to
	`pair_coeff * * HfMoNbTaTiVWZr_Zhou04.eam.alloy Hf Nb Ta`

Submit the job using `lmp_sgc.in`, `lmp_psc.batch`, and `HfMoNbTaTiVWZr_Zhou04.eam.alloy`. The last two files can be found in this GitHub repository. Whenever necessary, modify `lmp_psc.batch` to include the correct input file name in line 30.

#### Build the CSRO structure

Here, we build the CSRO structures using the first method for the remaining 17 MEAs.

First, modify the file `atomsk_Mo.sh` in the `MoNbTa/csro/` directory in [another GitHub repository](https://github.com/shuozhixu/Modelling_2024).

- Replace `Mo` with the first element in the MEA, i.e., `Hf`

After we run the modified atomsk script, we will find a new file `data.Hf`. Make two changes to that file:

- Line 4. Change the first number `1` to `3`
- Line 12 contains the atomic atomic mass (also known as atomic weight) of Nb. Add two lines after it, i.e.,

		Masses
		
		1   178.49    # Hf
		2   92.9063   # Nb
		3   180.95    # Ta
		
		Atoms # atomic

Use [this page](https://en.wikipedia.org/wiki/List_of_chemical_elements) to find out the atomic mass of an element.

Then, modify the file `lmp_vcsgc.in` in the `MoNbTa/csro/` directory in the other GitHub repository.

- Replace all `Mo`, `Nb`, and `Ta` with `Hf`, `Nb`, and `Ta`, respectively; the replacement should be case-sensitive, e.g., don’t replace `mo` in the word `thermo` with another element
- Change line 29 to
	`pair_coeff * * HfMoNbTaTiVWZr_Zhou04.eam.alloy Hf Nb Ta`
- Change the two chemical potential differences in lines 10 and 11 to the correct values

Next, run LAMMPS simulation using `lmp_vcsgc.in`, `data.Hf`, `lmp_psc.batch`, and `HfMoNbTaTiVWZr_Zhou04.eam.alloy`. Again, when necessary, modify `lmp_psc.batch` to include the correct input file name in line 30.

Once the simulation is finished, we will find a file `data.HfNbTa_CSRO`, which will be used later.

#### Lattice parameter

The lattice parameter of HfNbTa can be calculated by

	(lx/(10*sqrt(6.))+ly/(46*sqrt(3.)/2.)+lz/(14*sqrt(2.)))/3.
	
where

	lx = xhi - xlo
	ly = yhi - ylo
	lz = zhi - zlo

where `lx`, `ly`, and `lz` can be found in the first few lines of the data file `data.HfNbTa_CSRO`.

Let's denote the lattice parameter as $a_0$.

#### GSFE

##### Plane 1

The simulation requires files 
`lmp_gsfe.in`, `data.HfNbTa_CSRO`, `lmp_psc.batch`, and `HfMoNbTaTiVWZr_Zhou04.eam.alloy`. The first file can be found in the `gsfe/` directory in this GitHub repository.

Modify `lmp_gsfe.in`:

- line 18, replace the number `3.3` with $a_0$

Then run the simulation. Once it is finished, we will find a new file `gsfe_ori`. Run

	sh gsfe_curve.sh

which would yield a new file `gsfe`. The first column is the displacement along the $\left<111\right>$ direction while the second column is the GSFE value, in units of mJ/m<sup>2</sup>. The unstable stacking fault energy (USFE) is the peak GSFE value.

##### Other planes

According to [this paper](http://dx.doi.org/10.1016/j.intermet.2020.106844), in an alloy, multiple GSFE curves should be calculated. Hence, we need to make one more change to `lmp_gsfe.in`:

- line 48, replace the number `1` with `2`

Then run the simulation and obtain another USFE value.

We can then replace that number with `3`, `4`, `5`, ..., `20`, respectively. It follows that we run 18 more simulations. Eventually, we obtain 20 USFE values in total. We then calculate the mean USFE value for HfNbTa.

### Other 16 MEAs

Follow the steps above to build CSRO structures for the other 16 MEAs, and then calculate the lattice parameters and GSFEs.

## References

If you use any files from this GitHub repository, please cite

- Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, [Ideal simple shear strengths of two HfNbTaTi-based quinary refractory multi-principal element alloys](http://dx.doi.org/10.1063/5.0116898), APL Mater. 10 (2022) 111107
