#!/usr/bin/bash

rm -f *.lmp data.*

a=2.51
c=4.07

atomsk --create hcp $a $c Co orient [0001] [2-310] [-1-230] -orthogonal-cell -duplicate 19 12 3 data.Co.cfg lmp

mv data.Co.lmp data.Co

rm -f *.cfg