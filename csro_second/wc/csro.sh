#!/bin/bash

aveC=0.33333333333333

echo "step a_AA a_AB a_AC a_BB a_BC a_CC" > csro.a1.dat
echo "step a_AA a_AB a_AC a_BB a_BC a_CC" > csro.a2.dat
echo "step a_AA a_AB a_AC a_BB a_BC a_CC" > csro.a3.dat

for file in rdf.*.dat
do
    s=$(echo "$file" | cut -d'.' -f2)
    echo $s
    awk -v stp=$s -v c=$aveC \
        '{
            if(FNR>4 && $2>=3.0){
                a_AA = ($6/$4 - c) / (1 - c);
                a_AB = 1 - $8/$4/c;
                a_AC = 1 - $10/$4/c;
                a_BB = ($14/$4 - c) / (1 - c);
                a_BC = 1 - $16/$4/c;
                a_CC = ($22/$4 - c) / (1 - c);
                printf "%d %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f\n", stp,a_AA,a_AB,a_AC,a_BB,a_BC,a_C,$4,$6,$8,$10,$14,$16,$22; 
                exit(0);
            }
        }' < $file >> tmp1

    cn1=`tail -1 tmp1 | awk '{print $8}'`
    AA=`tail -1 tmp1 | awk '{print $9}'`
    AB=`tail -1 tmp1 | awk '{print $10}'`
    AC=`tail -1 tmp1 | awk '{print $11}'`
    BB=`tail -1 tmp1 | awk '{print $12}'`
    BC=`tail -1 tmp1 | awk '{print $13}'`
    CC=`tail -1 tmp1 | awk '{print $14}'`
    #echo $cn1 $MoMo $MoNb $MoTa $NbNb $NbTa $TaTa >test.txt

    awk -v cn_prev=$cn1 -v stp=$s -v c=$aveC \
        -v p1=$AA -v p2=$AB -v p3=$AC -v p4=$BB -v p5=$BC \
        -v p6=$CC \
        '{
            if(FNR>4 && $2>=4.0){
                a_AA = (($6-p1)/($4-cn_prev)-c)/(1-c);
                a_AB = 1 - ($8-p2)/($4-cn_prev)/c;
                a_AC = 1 - ($10-p3)/($4-cn_prev)/c;
                a_BB = (($14-p4)/($4-cn_prev)-c)/(1-c);
                a_BC = 1 - ($16-p5)/($4-cn_prev)/c;
                a_CC = (($22-p6)/($4-cn_prev)-c)/(1-c);
                printf "%d %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f\n", stp,a_AA,a_AB,a_AC,a_BB,a_BC,a_CC,$4,$6,$8,$10,$14,$16,$22; 
                exit(0);
            }
         }' < $file >> tmp2

    cn2=`tail -1 tmp2 | awk '{print $8}'`
    AA=`tail -1 tmp2 | awk '{print $9}'`
    AB=`tail -1 tmp2 | awk '{print $10}'`
    AC=`tail -1 tmp2 | awk '{print $11}'`
    BB=`tail -1 tmp2 | awk '{print $12}'`
    BC=`tail -1 tmp2 | awk '{print $13}'`
    CC=`tail -1 tmp2 | awk '{print $14}'`
    #echo $cn2 $MoMo $MoNb $MoTa $NbNb $NbTa $TaTa

    awk -v cn_prev=$cn2 -v stp=$s -v c=$aveC \
        -v p1=$AA -v p2=$AB -v p3=$AC -v p4=$BB -v p5=$BC \
        -v p6=$CC \
        '{
            if(FNR>4 && $2>=4.7){
                a_AA = (($6-p1)/($4-cn_prev)-c)/(1-c);
                a_AB = 1 - ($8-p2)/($4-cn_prev)/c;
                a_AC = 1 - ($10-p3)/($4-cn_prev)/c;
                a_BB = (($14-p4)/($4-cn_prev)-c)/(1-c);
                a_BC = 1 - ($16-p5)/($4-cn_prev)/c;
                a_CC = (($22-p6)/($4-cn_prev)-c)/(1-c);
                printf "%d %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f\n", stp,a_AA,a_AB,a_AC,a_BB,a_BC,a_CC,$4,$6,$8,$10,$14,$16,$22; 
                exit(0);
            }
         }' < $file >> tmp3
done

sort -gk1 tmp1 >> csro.a1.dat
sort -gk1 tmp2 >> csro.a2.dat
sort -gk1 tmp3 >> csro.a3.dat
rm tmp1 tmp2 tmp3
