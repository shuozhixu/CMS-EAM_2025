#!/usr/bin/bash

rm -f *.lmp data.*

a=3.5564

atomsk --create fcc $a Co orient [1-10] [11-2] [111] -duplicate 30 30 10 data.Co.cfg lmp

mv data.Co.lmp data.Co_FCC

rm -f *.cfg