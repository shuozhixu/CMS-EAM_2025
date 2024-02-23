#!/usr/bin/bash

rm -rf lammps-mbmc
module load intelmpi/2021.3.0-intel2021.3.0 gcc/10.2.0 cuda/11.7.1
git clone -b stable https://github.com/lammps/lammps.git lammps-mbecmc
cd lammps-mbmc/src
make yes-manybody
make yes-mc
make mpi
