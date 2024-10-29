#!/usr/bin/bash

rm -f *.lmp data.*

a=3.19
c=5.05

atomsk --create hcp $a $c Hf orient [0001] [1-100] [-1-120] -orthogonal-cell -duplicate 16 25 20 data.Hf.cfg lmp

mv data.Hf.lmp data.Hf

rm -f *.cfg