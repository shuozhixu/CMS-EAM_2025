#!/usr/bin/bash

rm -f *.lmp data.*

a=3.19
c=5.05

atomsk --create hcp $a $c Hf orient [-1-120] [1-100] [0001] -orthogonal-cell -duplicate 24 24 13 data.Hf.cfg lmp

mv data.Hf.lmp data.Hf

rm -f *.cfg