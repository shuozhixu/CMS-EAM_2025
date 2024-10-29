#!/usr/bin/bash

rm -f *.lmp data.*

a=3.23
c=5.15

atomsk --create hcp $a $c Zr orient [0001] [1-100] [-1-120] -orthogonal-cell -duplicate 16 25 20 data.Zr.cfg lmp

mv data.Zr.lmp data.Zr

rm -f *.cfg