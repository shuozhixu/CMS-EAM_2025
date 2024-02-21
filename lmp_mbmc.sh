#!/usr/bin/bash

rm -rf lammps-mbmc
module load intel/2021.3.0
git clone -b stable https://github.com/lammps/lammps.git lammps-mbecmc
cd lammps-mbmc/src
make yes-manybody
make yes-mc
make mpi
