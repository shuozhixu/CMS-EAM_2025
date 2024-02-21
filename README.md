# Medium entropy alloys

## Foreword

The purpose of this project is to calculate the unstable stacking fault energies (GSFE) of 17 equal-molar medium element alloys (MEAs). The effects of chemical short-range order (CSRO) will be considered.

Please read the following journal articles to understand how the aforementioned material properties can be calculated.

\[Elemental materials\]:

- Xiaowang Wang, Shuozhi Xu, Wu-Rong Jian, Xiang-Guo Li, Yanqing Su, Irene J. Beyerlein, [Generalized stacking fault energies and Peierls stresses in refractory body-centered cubic metals from machine learning-based interatomic potentials](http://dx.doi.org/10.1016/j.commatsci.2021.110364), Comput. Mater. Sci. 192 (2021) 110364

\[Random alloys\]:

- Rebecca A. Romero, Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, C.V. Ramana, [Atomistic calculations of the local slip resistances in four refractory multi-principal element alloys](http://dx.doi.org/10.1016/j.ijplas.2021.103157), Int. J. Plast. 149 (2022) 103157

\[Alloys with CSRO\]:

- Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, [Ideal simple shear strengths of two HfNbTaTi-based quinary refractory multi-principal element alloys](http://dx.doi.org/10.1063/5.0116898), APL Mater. 10 (2022) 111107

## LAMMPS

As of February 2024, the latest version of LAMMPS installed on [Bridges-2](https://www.psc.edu/resources/bridges-2) was from June 2023. That version does not have all [packages](https://docs.lammps.org/Build_package.html) we need.

To finish this project, at least two packages are needed.

- MANYBODY package. This is to use the manybody potential such as the embedded-atom method potential.
- MC package. This is to generate materials with chemical short-range order at a given temperature. [This paper](http://dx.doi.org/10.1103/PhysRevB.85.184203) and [this paper](https://doi.org/10.1103/PhysRevB.86.134204) should be cited if one uses this package.

To build LAMMPS with these two packages, use the file `lmp_mbmc.sh`. First, cd to any directory on OSCER, e.g., \$HOME, then

	sh lmp_mbmc.sh

Note that the second command in `lmp_mbmc.sh` will load a module. If one cannot load it, try `module purge` first.

Once the `sh` run is finished, we will find a file `lmp_mpi` in the `lammps_mbmc/src` directory on OSCER. And that is the LAMMPS executable with MANYBODY and MC packages.

## Chemical potential differences

In [a previous project](https://github.com/shuozhixu/Modelling_2024), the two chemical potential differences in the MoNbTa MEA were calculated.

Here, please calculate the two chemical potential differences for each of these MEAs: NbTaW, NbVW, and TaVW.

First, modify the file `lmp_sgc.in` in the `MoNbTa/csro/` directory in the other GitHub repository. Take the first MEA, NbTaW, as an example:

- Replace all `Mo`, `Nb`, and `Ta` with `Nb`, `Ta`, and `W`, respectively; the replacement should be case-sensitive, e.g., don’t replace `mo` in the word `thermo` with another element
- Change line 28 to `pair_coeff * * HfMoNbTaTiVWZr_Zhou04.eam.alloy Nb Ta W`

Submit the job using `lmp_sgc.in`, `lmp_psc.batch`, and `HfMoNbTaTiVWZr_Zhou04.eam.alloy`. The last two files can be found in this GitHub repository. When necessary, modify `lmp_psc.batch` to include the correct input file name.

## Build the CSRO structure

Each time we run a new type of simulation, create a new directory.

## References

If you use any files from this GitHub repository, please cite

- Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, [Ideal simple shear strengths of two HfNbTaTi-based quinary refractory multi-principal element alloys](http://dx.doi.org/10.1063/5.0116898), APL Mater. 10 (2022) 111107
- Shuozhi Xu, Emily Hwang, Wu-Rong Jian, Yanqing Su, Irene J. Beyerlein, [Atomistic calculations of the generalized stacking fault energies in two refractory multi-principal element alloys](http://dx.doi.org/10.1016/j.intermet.2020.106844), Intermetallics 124 (2020) 106844
