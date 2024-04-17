#!/usr/bin/bash

rm -f *.lmp data.*

a=3.303

atomsk --create bcc $a Ta orient [11-2] [111] [1-10] -duplicate 10 46 14 data.Ta.cfg lmp

mv data.Ta.lmp data.Ta

rm -f *.cfg