#!/usr/bin/bash

rm -f *.lmp data.*

a=2.881

atomsk --create bcc $a Cr orient [1-10] [11-2] [111] -duplicate 19 19 25 data.Cr.cfg lmp

mv data.Cr.lmp data.Cr

rm -f *.cfg