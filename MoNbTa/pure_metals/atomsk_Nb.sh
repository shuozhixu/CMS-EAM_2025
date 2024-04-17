#!/usr/bin/bash

rm -f *.lmp data.*

a=3.3

atomsk --create bcc $a Nb orient [11-2] [111] [1-10] -duplicate 10 46 14 data.Nb.cfg lmp

mv data.Nb.lmp data.Nb

rm -f *.cfg