#!/usr/bin/bash

rm -f *.lmp data.*

a=3.23
c=5.15

atomsk --create hcp $a $c Zr orient [1-100] [-1-120] [0001] -orthogonal-cell -duplicate 14 43 13 data.Zr.cfg lmp

mv data.Zr.lmp data.Zr

rm -f *.cfg