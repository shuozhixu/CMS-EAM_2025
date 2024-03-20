# Generalized stacking fault energies in refractory medium entropy alloys

## Foreword

The purpose of this project is to calculate the generalized stacking fault energies (GSFE) of 17 equal-molar body-centered cubic (BCC) refractory medium element alloys (MEAs). The effect of chemical short-range order (CSRO) will be considered.

In [a previous project](https://github.com/shuozhixu/Modelling_2024), we calculated the GSFEs in MoNbTa, HfMoNbTaTi, and HfNbTaTiZr, respectively; it was found that the CSRO lowers the GSFE in MoNbTa but increases the GSFEs in the other two alloys. In the meantime, [another work](https://doi.org/10.1038/s41524-023-01046-z) in MoNbTi and NbTaTi showed that the CSRO increases the GSFEs, see [Supplementary Figure 10](https://static-content.springer.com/esm/art%3A10.1038%2Fs41524-023-01046-z/MediaObjects/41524_2023_1046_MOESM1_ESM.pdf). Therefore, we aim to answer the following question through this project:

- How does CSRO affect GSFEs across MEAs?

Here, we will investigate 17 MEAs, including NbTaW, MoNbTi, HfNbTa, NbTiZr, HfNbTi, HfTaTi, TaTiZr, MoTaTi, MoNbV, MoNbW, MoTaV, MoTaW, MoVW, NbTaV, NbTaTi, NbVW, and TaVW. These 17 MEAs were chosen for their stable BCC structures.

We also aim to answer the following question, using NbTaW and NbVW as example:

- How do different chemical potential differences affect the CSRO and then the GSFEs?

Please read the following journal articles to understand how the GSFE is calculated in BCC metals using the atomistic simulation method.

\[Elemental materials\]:

- Xiaowang Wang, Shuozhi Xu, Wu-Rong Jian, Xiang-Guo Li, Yanqing Su, Irene J. Beyerlein, [Generalized stacking fault energies and Peierls stresses in refractory body-centered cubic metals from machine learning-based interatomic potentials](http://dx.doi.org/10.1016/j.commatsci.2021.110364), Comput. Mater. Sci. 192 (2021) 110364

\[Random alloys\]:

- Subah Mubassira, Wu-Rong Jian, Shuozhi Xu, [Effects of chemical short‑range order and temperature on basic structure parameters and stacking fault energies in multi‑principal element alloys](https://doi.org/10.3390/modelling5010019), Modelling 5 (2024) 352--366
- Rebecca A. Romero, Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, C.V. Ramana, [Atomistic calculations of the local slip resistances in four refractory multi-principal element alloys](http://dx.doi.org/10.1016/j.ijplas.2021.103157), Int. J. Plast. 149 (2022) 103157
- Shuozhi Xu, Emily Hwang, Wu-Rong Jian, Yanqing Su, Irene J. Beyerlein, [Atomistic calculations of the generalized stacking fault energies in two refractory multi-principal element alloys](http://dx.doi.org/10.1016/j.intermet.2020.106844), Intermetallics 124 (2020) 106844

\[Alloys with CSRO\]:

- Hui Zheng, Lauren T.W. Fey, Xiang-Guo Li, Yong-Jie Hu, Liang Qi, Chi Chen, Shuozhi Xu, Irene J. Beyerlein, Shyue Ping Ong, [Multi-scale investigation of short-range order and dislocation glide in MoNbTi and TaNbTi multi-principal element alloys](http://dx.doi.org/10.1038/s41524-023-01046-z), npj Comput. Mater. 9 (2023) 89
- Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, [Ideal simple shear strengths of two HfNbTaTi-based quinary refractory multi-principal element alloys](http://dx.doi.org/10.1063/5.0116898), APL Mater. 10 (2022) 111107

## LAMMPS

As of February 2024, the latest version of LAMMPS installed on [Bridges-2](https://www.psc.edu/resources/bridges-2) was from June 2023. That version does not allow us to use the [`fix sgcmc` command](https://docs.lammps.org/fix_sgcmc.html), which we need for this project.

So we need to build own LAMMPS version with two packages:

- MANYBODY package. This is to use the manybody potential such as the embedded-atom method potential.
- MC package. This is to generate materials with chemical short-range order at a given temperature. [This paper](http://dx.doi.org/10.1103/PhysRevB.85.184203) and [this paper](https://doi.org/10.1103/PhysRevB.86.134204) should be cited if one uses this package.

To build LAMMPS, use the file `lmp_mbmc.sh`. First, cd to any directory on Bridges-2, e.g., \$HOME, then

	sh lmp_mbmc.sh

Note that the second command in `lmp_mbmc.sh` will load a module. If one cannot load it, try `module purge` first.

Once the `sh` run is finished, we will find a file `lmp_mpi` in the `lammps_mbmc/src` directory on Bridges-2. And that is the LAMMPS executable with MANYBODY and MC packages.

## Chemical potential differences

In [a previous project](https://github.com/shuozhixu/Modelling_2024), the two chemical potential differences in the MoNbTa MEA were calculated. Among the 17 MEAs, the chemical potential differences for 11 MEAs can be found in the file `mu.txt` in this GitHub repository.

Here, we calculate the two chemical potential differences for each of the remaining 6 MEAs: HfNbTa, MoTaTi, MoNbV, MoNbW, MoTaV, NbTaV.

First, modify the file `lmp_sgc.in` in the `MoNbTa/csro/` directory in the other GitHub repository. Take HfNbTa as an example:

- Replace all `Mo`, `Nb`, and `Ta` with `Hf`, `Nb`, and `Ta`, respectively; the replacement should be case-sensitive, e.g., don’t replace `mo` in the word `thermo` with another element
- Change line 28 to
	`pair_coeff * * HfMoNbTaTiVWZr_Zhou04.eam.alloy Hf Nb Ta`

Submit the job using `lmp_sgc.in`, `lmp_psc.batch`, and `HfMoNbTaTiVWZr_Zhou04.eam.alloy`. The last two files can be found in this GitHub repository. When necessary, modify `lmp_psc.batch` to include the correct input file name.

## Build the CSRO structure

In [a previous project](https://github.com/shuozhixu/Modelling_2024), the CSRO MoNbTa structure was built.

Here, we build the CSRO structures for all 17 MEAs.

### NbTaW

First, modify the file `atomsk_Mo.sh` in the `MoNbTa/csro/` directory in the other GitHub repository.

- Replace `Mo` with the first element in the MEA, i.e., `Nb`

After we run the modified atomsk script, we will find a new file `data.Nb`. Make two changes to that file:

- Line 4. Change the first number `1` to `3`
- Line 12 contains the atomic atomic mass (also known as atomic weight) of Nb. Add two lines after it, i.e.,

		Masses
		
		1   92.9063   # Nb
		2   180.95    # Ta
		3   183.84    # W
		
		Atoms # atomic

Use [this page](https://en.wikipedia.org/wiki/List_of_chemical_elements) to find out the atomic mass of an element.

Then, modify the file `lmp_vcsgc.in` in the `MoNbTa/csro/` directory in the other GitHub repository.

- Replace all `Mo`, `Nb`, and `Ta` with `Nb`, `Ta`, and `W`, respectively; the replacement should be case-sensitive, e.g., don’t replace `mo` in the word `thermo` with another element
- Change line 29 to
	`pair_coeff * * HfMoNbTaTiVWZr_Zhou04.eam.alloy Nb Ta W`
- Change the two chemical potential differences in lines 10 and 11 to the correct values

Next, run LAMMPS simulation using `lmp_vcsgc.in`, `data.Nb`, `lmp_psc.batch`, and `HfMoNbTaTiVWZr_Zhou04.eam.alloy`. Again, when necessary, modify `lmp_psc.batch` to include the correct input file name.

### Other 16 MEAs

Follow the steps above to build CSRO structures for the other 16 MEAs.

Each time we run a simulation for a new MEA, create a new directory.

## GSFE

In [a previous project](https://github.com/shuozhixu/Modelling_2024), the GSFEs of random MoNbTa and CSRO MoNbTa were calculated.

I will add more later.

## References

If you use any files from this GitHub repository, please cite

- Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, [Ideal simple shear strengths of two HfNbTaTi-based quinary refractory multi-principal element alloys](http://dx.doi.org/10.1063/5.0116898), APL Mater. 10 (2022) 111107
- Shuozhi Xu, Emily Hwang, Wu-Rong Jian, Yanqing Su, Irene J. Beyerlein, [Atomistic calculations of the generalized stacking fault energies in two refractory multi-principal element alloys](http://dx.doi.org/10.1016/j.intermet.2020.106844), Intermetallics 124 (2020) 106844
