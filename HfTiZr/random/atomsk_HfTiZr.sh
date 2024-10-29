#!/usr/bin/bash

rm -f *.lmp data.*

a=3.15
c=4.98

atomsk --create hcp $a $c Hf orient [0001] [1-100] [-1-120] -orthogonal-cell -duplicate 16 25 20 Hf.cfg

atomsk Hf.cfg -select random 33.33% Hf -sub Hf Ti HfTi.cfg

atomsk HfTi.cfg -select random 50% Hf -sub Hf Zr data.HfTiZr_random.cfg lmp

mv data.HfTiZr_random.lmp data.HfTiZr_random

rm -f *.cfg