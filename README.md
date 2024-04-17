# Non-dilute random alloys

## Foreword

In this project, we will study the effect of chemical short-range order (CSRO) on lattice parameters, generalized stacking fault energies (GSFEs), and/or melting point of 26 non-dilute random alloys, including three binaries, 21 ternaries, one quaternary, and one quinary.

As summarized in [another GitHub repository](https://github.com/shuozhixu/MSMSE_2024), there are two methods to build a CSRO structure. In this project, the NPT method will be used to generate the CSRO structures; the embedded-atom method (EAM) potential will be employed for the interatomic interactions, unless stated otherwise.

The purpose of this project is to answer the following three questions

- [1] Does the segregation and/or local ordering of the same atomic pair vary across different MEAs?
	- Answer: Mostly likely yes
- [2] How does the CSRO affect lattice parameter, GSFE, and melting point across MPEAs? What is the relationship between properties of the MPEAs and those of individual elements?

for those, we will investigate 21 ternaries, including CoCrNi, HfTiZr, MoNbTa, MoTaW, NbTaW, MoNbTi, HfNbTa, NbTiV, NbTiZr, HfNbTi, HfTaTi, TaTiZr, MoTaTi, MoNbV, MoNbW, MoTaV, MoVW, NbTaV, NbTaTi, NbVW, and TaVW. These last 19 alloys were chosen for their stable body-centered cubic (BCC) structures.

The last question we aim to answer is:

- [3] Are the answers to the questions [1,2] dependent on the interatomic potential?

for that, we will investigate MoNbTa, MoNbV, NbTaV, and NbVW using a moment tensor potential (MTP). This is done in [another project](https://github.com/shuozhixu/CMS-MTP_2025). We will also investigate NbTa, NbTi, NbV, NbTaTi, NbTaV, NbTiV, NbTaTiV, and NbTaTiVZr using [a modified embedded-atom method (MEAM) potential](https://doi.org/10.1016/j.commatsci.2024.112886) in another project.

[A recent work](https://doi.org/10.3390/modelling5010019) calculated the GSFEs in CoCrNi, MoNbTa, HfMoNbTaTi, and HfNbTaTiZr. In that work, EAM potentials were used, and the SGC method was employed to build the CSRO structures. It was found that the CSRO lowers the GSFE in MoNbTa but increases the GSFEs in the other three alloys. Relatedly, while most work found that the critical resolved shear stress increases with CSRO, [Liu and Curtin](https://doi.org/10.1016/j.actamat.2023.119471) found the opposite in a Mo-Nb binary.

[An earlier work](https://doi.org/10.1038/s41524-023-01046-z) calculated the GSFEs in MoNbTi and NbTaTi. In that work, an MTP (not the same MTP to be used in this project) was used, and the NPT method was employed to build the CSRO structures. It was found that the CSRO increases the GSFEs in both alloys, see [Supplementary Figure 10](https://static-content.springer.com/esm/art%3A10.1038%2Fs41524-023-01046-z/MediaObjects/41524_2023_1046_MOESM1_ESM.pdf). 

## LAMMPS

Following [another GitHub repository](https://github.com/shuozhixu/MSMSE_2024), we can build LAMMPS with MANYBODY and MC packages and submit jobs on both [OSCER](http://www.ou.edu/oscer.html) and [Bridges-2](https://www.psc.edu/resources/bridges-2).

## CSRO structure

In [another project](https://github.com/shuozhixu/MSMSE_2024), the CSRO structures in CoCrNi, MoNbTa, and HfTiZr were built using the NPT method. Here, we focus on the remaining 18 ternaries (all BCC).

### NbTiZr

Here, we take NbTiZr as an example. First, modify the file `lmp_mcnpt.in` in the `MoNbTa/csro/` directory in [a previous GitHub repository](https://github.com/shuozhixu/MSMSE_2024). Take NbTiZr as an example:

- Replace all `Mo`, `Nb`, and `Ta` with `Nb`, `Ti`, and `Zr`, respectively; the replacement should be case-sensitive, e.g., don’t replace `mo` in the word `thermo` with another element
- Change line 28 to
	`pair_coeff * * HfMoNbTaTiVWZr_Zhou04.eam.alloy Nb Ti Zr`

Submit the job using `lmp_mcnpt.in` and `HfMoNbTaTiVWZr_Zhou04.eam.alloy`. The last file can be found in this GitHub repository. Once the simulation is finished, you will find two files, among others. The first one is `data.NbTiZr_CSRO`, which will be used to calculate the lattice parameter, GSFE, and melting point (to be described later). The second file `cn.out`, which can be used to calculate the Warren-Cowley (WC) parameters following [another project](https://github.com/shuozhixu/MSMSE_2024).

### Other 17 ternaries

Follow the steps above to build CSRO structures for the other 17 ternaries and calculate the WC parameters.

## Lattice parameter

Lattice parameters of random and CSRO CoCrNi and MoNbTa were calculated in [a previous paper](https://doi.org/10.3390/modelling5010019). Here we will calculate the lattice parameter of the remaining 18 BCC ternaries and HfTiZr, in both random and CSRO structures. The lattice parameter of the 18 random BCC ternaries can be found in the file `a0.txt` in this GitHub repository.

### NbTiZr with CSRO

Here, we take NbTiZr as an example. Its lattice parameter can be calculated by

	(lx/(10*sqrt(6.))+ly/(46*sqrt(3.)/2.)+lz/(14*sqrt(2.)))/3.
	
where

	lx = xhi - xlo
	ly = yhi - ylo
	lz = zhi - zlo

where `xhi`, `xlo`, `yhi`, `ylo`, `zhi`, and `zlo` can be found in the first few lines of the data file `data.NbTiZr_CSRO`.

Let's denote the lattice parameter as $a_0$.

### Other 17 BCC ternaries with CSRO

Follow the steps above to calculate the lattice parameter of the other 17 BCC MEAs.

### Random HfTiZr

Run a LAMMPS simulation using `lmp_0K.in`, `data.HfTiZr_random`, and `HfNbTaTiZr_Xu2022.eam.alloy`. The first two files can be found in the `HfTiZr/` directory in this GitHub repository. The simulation will generate a file `data.HfTiZr_min` upon finished.

HfTiZr has two lattice parameters, $a$ and $c$.

$c$ can be calculated by

	lx/16.
	
where

	lx = xhi - xlo

where `xhi` and `xlo` can be found in the first few lines of the data file `data.HfTiZr_min`.

$a$ can be estimated in OVITO by looking into the _x_ axis and measuring the size of the hexagon.

### HfTiZr with CSRO

Repeat the simulation above, but using the data file `data.HfTiZr_CSRO` generated using the NPT method in [another project](https://github.com/shuozhixu/MSMSE_2024).

## GSFE

GSFEs of random and CSRO CoCrNi and MoNbTa were calculated in [a previous paper](https://doi.org/10.3390/modelling5010019). Here we will calculate the GSFE of the remaining 18 BCC ternaries with CSRO.

### NbTiZr

Here, we take NbTiZr as an example.

#### Plane 1

The simulation requires files 
`lmp_gsfe.in`, `data.NbTiZr_CSRO`, and `HfMoNbTaTiVWZr_Zhou04.eam.alloy`. The first file can be found in the `gsfe/` directory in this GitHub repository.

Modify `lmp_gsfe.in`:

- line 18, replace the number `3.3` with $a_0$

Then run the simulation. Once it is finished, we will find a new file `gsfe_ori`. Run

	sh gsfe_curve.sh

which would yield a new file `gsfe`. The first column is the displacement along the $\left<111\right>$ direction while the second column is the GSFE value, in units of mJ/m<sup>2</sup>. The unstable stacking fault energy (USFE) is the peak GSFE value.

#### Other planes

According to [this paper](http://dx.doi.org/10.1016/j.intermet.2020.106844), in an alloy, multiple GSFE curves should be calculated. Hence, we need to make one more change to `lmp_gsfe.in`:

- line 48, replace the number `1` with `2`

Then run the simulation and obtain another USFE value.

We can then replace that number with `3`, `4`, `5`, ..., `20`, respectively. It follows that we run 18 more simulations. Eventually, we obtain 20 USFE values in total. We then calculate the mean USFE value for NbTiZr.

### Other 17 BCC ternaries

Follow the steps above to calculate the mean GSFEs of the other 17 BCC ternaries.

## Melting point

The melting point of a material is calculated using the [liquid-solid coexistence method](https://doi.org/10.1063/5.0101548). The input file `lmp_mp.in` can be found in the directory `melting_point/` in this GitHub repository. Value of `liquidt`, set in line 6, may be lowered if a material is found to break up during a simulation.

### CoCrNi

The data file for random CoCrNi is from [this paper](http://dx.doi.org/10.1016/j.actamat.2020.08.044), while that for CSRO CoCrNi built using the NPT method is from [another project](https://github.com/shuozhixu/MSMSE_2024).

#### Random CoCrNi

Run the simulation with files `lmp_mp.in`, `data.CoCrNi_gsfe_random`, and `CoCrNi.lammps.eam`. The first file can be in the directory `melting_point/` in this GitHub repository.

Once it is finished, we will find a file `avePE.out`. Plot its 2nd and 4th column as the _x_ and _y_ axes, respectively. It should look like one of the curves in Figure 2(b) of [this paper](http://dx.doi.org/10.1098/rspa.2017.0084).

In line 7 of `lmp_mp.in`, the trial melting point is set as 1200 K.

- If 1200 K is lower than the actual melting point, the curve we plot will decrease. Then increase the last number in line 7 and rerun the simulation.
- If 1200 K is higher than the actual melting point, the curve we plot will increase. Then decrease the last number in line 7 and rerun the simulation.

Repeat the steps above until we find the actual melting point, which should lead to a curve that neither increases nor decreases.

Note:

- The trial melting point cannot be equal to or higher than `liquidt`.
- Save the data for each curve because eventually we will need to plot multiple curves like those in Figure 2(b) of [this paper](http://dx.doi.org/10.1098/rspa.2017.0084).

#### CoCrNi with CSRO

Note: the CSRO structure was annealed at 350 K.

- Use the data file `data.CoCrNi_CSRO` instead
- Use the correct data file name in line 18 of the file `lmp_mp.in`

#### Pure metals

Run the atomsk script, `atomsk_Ni.sh`, which can be found in `CoCrNi/pure_metals/` in this GitHub repository, to build a Ni structure named `data.Ni`, by

	sh atomsk_Ni.sh

Then use the data file and the same potential file to calculate its melting point.

Then follow the same procedure to calculate the melting points of Co and Cr. Use `atomsk_Co.sh` and `atomsk_Cr.sh`.

In each case, remember to modify `lmp_mp.in` accordingly.

Note: In pure metals, Co has an HCP lattice while Cr has a BCC lattice, and so the two `atomsk_*.sh` files build corresponding lattices. However, Co and Cr take the FCC lattice in CoCrNi. We then use `atomsk_Co_FCC.sh` and `atomsk_Cr_FCC.sh` to generate data files `data.Co_FCC` and `data.Cr_FCC`, respectively, and recalculate the melting points. Finally, for the same metal, we take the average melting points of the two lattices as the melting point of this metal.

### MoNbTa

The data file for random MoNbTa is from [this paper](https://doi.org/10.3390/modelling5010019), while that for CSRO CoCrNi built using the NPT method is from [another project](https://github.com/shuozhixu/MSMSE_2024).

#### Random MoNbTa

Run the simulations with files `lmp_mp.in`, `data.MoNbTa_random`, and `HfMoNbTaTiVWZr_Zhou04.eam.alloy` to calculate its melting point. The second file can be found in the directory `MoNbTa/` in this GitHub repository.

Make the following two changes in the file `lmp_mp.in`:

- line 18. Use the correct data file name
- line 24. Change it to `pair_coeff * * HfMoNbTaTiVWZr_Zhou04.eam.alloy Mo Nb Ta`

#### MoNbTa with CSRO

Note: the CSRO structure was annealed at 300 K.

Use files `lmp_mp.in`, `data.MoNbTa_CSRO`, and `HfMoNbTaTiVWZr_Zhou04.eam.alloy` to calculate its melting point.

Remember to modify `lmp_mp.in` accordingly.

#### Pure metals

Run the atomsk script, `atomsk_Mo.sh`, which can be found in `MoNbTa/pure_metals/` in this GitHub repository, to build a Mo structure named `data.Mo`, by

	sh atomsk_Mo.sh

Then use the data file and the same potential file to calculate its melting point.

Follow the same procedure to calculate the melting points of Nb and Ta. Use `atomsk_Nb.sh` and `atomsk_Ta.sh`.

In each case, modify `lmp_mp.in` accordingly.

### HfTiZr

Data files for both random and CSRO HfTiZr are from [another project](https://github.com/shuozhixu/MSMSE_2024).

#### Random HfTiZr

Run the simulations with files `lmp_mp.in`, `data.HfTiZr_random`, and `HfMoNbTaTiVWZr_Zhou04.eam.alloy` to calculate its melting point.

Remember to modify `lmp_mp.in` accordingly.

#### HfTiZr with CSRO

Note: the CSRO structure was annealed at 300 K.

Use files `lmp_mp.in`, `data.HfTiZr_CSRO`, and `HfMoNbTaTiVWZr_Zhou04.eam.alloy` to calculate its melting point.

Remember to modify `lmp_mp.in` accordingly.

#### Pure metals

Run the atomsk script, `atomsk_Hf.sh`, which can be found in `HfTiZr/pure_metals/` in this GitHub repository, to build a structure named `data.Hf`, by

	sh atomsk_Hf.sh

Then use the data file and the same potential file to calculate its melting point.

Follow the same procedure to calculate the melting points of Ti and Zr. Use `atomsk_Ti.sh` and `atomsk_Zr.sh`.

In each case, modify `lmp_mp.in` accordingly.

## The SGC method

In [a previous paper](https://doi.org/10.3390/modelling5010019), the CSRO MoNbTa structure was built using the SGC method, before the lattice parameter and GSFE were calculated. Here, we focus on the remaining 17 MEAs. Below, we take HfNbTa as an example.

### HfNbTa

#### Chemical potential differences

Among the 18 MEAs, the chemical potential differences for 12 MEAs can be found in the file `mu.txt` in this GitHub repository.

Here, we calculate the two chemical potential differences for each of the remaining 6 MEAs: HfNbTa, MoTaTi, MoNbV, MoNbW, MoTaV, NbTaV.

First, modify the file `lmp_sgc.in` in the `MoNbTa/csro/` directory in [a previous GitHub repository](https://github.com/shuozhixu/Modelling_2024). Take HfNbTa as an example:

- Replace all `Mo`, `Nb`, and `Ta` with `Hf`, `Nb`, and `Ta`, respectively; the replacement should be case-sensitive, e.g., don’t replace `mo` in the word `thermo` with another element
- Change line 28 to
	`pair_coeff * * HfMoNbTaTiVWZr_Zhou04.eam.alloy Hf Nb Ta`

Submit the job using `lmp_sgc.in` and `HfMoNbTaTiVWZr_Zhou04.eam.alloy`. The last two files can be found in this GitHub repository. Whenever necessary, modify `lmp_psc.batch` to include the correct input file name in line 30.

#### Build the CSRO structure

Here, we build the CSRO structures using the SGC method for the remaining 17 MEAs.

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

Next, run LAMMPS simulation using `lmp_vcsgc.in`, `data.Hf` and `HfMoNbTaTiVWZr_Zhou04.eam.alloy`. Again, when necessary, modify `lmp_psc.batch` to include the correct input file name in line 30.

Once the simulation is finished, we will find a file `data.HfNbTa_CSRO`, which will be used later.

## Reference

If you use any files from this GitHub repository, please cite

- Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, [Ideal simple shear strengths of two HfNbTaTi-based quinary refractory multi-principal element alloys](http://dx.doi.org/10.1063/5.0116898), APL Mater. 10 (2022) 111107
