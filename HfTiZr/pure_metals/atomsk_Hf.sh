#!/usr/bin/bash

rm -f *.lmp data.*

a=3.19
c=5.05

atomsk --create hcp $a $c Hf orient [0001] [2-310] [-1-230] -orthogonal-cell -duplicate 16 10 3 data.Hf.cfg lmp

mv data.Hf.lmp data.Hf

rm -f *.cfg