#!/usr/bin/bash

rm -f *.lmp data.*

a=3.5564

atomsk --create fcc $a Cr orient [1-10] [11-2] [111] -duplicate 30 30 10 data.Cr.cfg lmp

mv data.Cr.lmp data.Cr_FCC

rm -f *.cfg