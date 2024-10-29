#!/usr/bin/bash

rm -f *.lmp data.*

a=2.95
c=4.69

atomsk --create hcp $a $c Ti orient [0001] [1-100] [-1-120] -orthogonal-cell -duplicate 16 25 20 data.Ti.cfg lmp

mv data.Ti.lmp data.Ti

rm -f *.cfg