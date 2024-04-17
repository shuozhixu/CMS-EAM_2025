#!/usr/bin/bash

rm -f *.lmp data.*

a=3.23
c=5.15

atomsk --create hcp $a $c Zr orient [0001] [2-310] [-1-230] -orthogonal-cell -duplicate 16 10 3 data.Zr.cfg lmp

mv data.Zr.lmp data.Zr

rm -f *.cfg