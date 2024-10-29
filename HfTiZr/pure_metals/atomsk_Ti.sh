#!/usr/bin/bash

rm -f *.lmp data.*

a=2.95
c=4.69

atomsk --create hcp $a $c Ti orient [-1-120] [1-100] [0001] -orthogonal-cell -duplicate 24 24 13 data.Ti.cfg lmp

mv data.Ti.lmp data.Ti

rm -f *.cfg