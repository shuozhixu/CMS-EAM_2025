#!/usr/bin/bash

rm -f *.lmp data.*

a=3.23
c=5.15

atomsk --create hcp $a $c Zr orient [-1-120] [1-100] [0001] -orthogonal-cell -duplicate 24 24 13 data.Zr.cfg lmp

mv data.Zr.lmp data.Zr

rm -f *.cfg