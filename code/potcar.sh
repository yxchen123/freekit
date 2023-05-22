#!/bin/bash

#creat a GGA_PAW POTCAR file
#By Qiang Li. 

repo="/home/scms/yxchen/bin/pot/"

if [ -f POTCAR ] ; then
    mv -f POTCAR old-POTCAR
    echo " ** Warning: old POTCAR file found and renamed to 'old-POTCAR'. "
fi

for i in $*
do
    if test -f $repo/$i/POTCAR ; then 
        cat $repo/$i/POTCAR >> POTCAR
    elif test -f $repo/$i/POTCAR.Z ; then
        zcat $repo/$i/POTCAR.Z >> POTCAR
    elif test -f $repo/$i/POTCAR.gz ; then
        gunzip -c $repo/$i/POTCAR.gz >> POTCAR
    elif test -f $repo/${i}_sv/POTCAR ; then
        cat $repo/${i}_sv/POTCAR >> POTCAR
    else
        echo " ** Warning: No suitable POTCAR for element '$i' found!! Skipped this element. "
    fi
done

echo +---------------------------------+
echo \| \ \ \ \ \ \ POTCAR generated \ \ \ \ \ \ \ \ \ \|
echo +---------------------------------+
grep TIT POTCAR 
echo +---------------------------------+
echo \| \ \ \ \ \ \ Please Check it! \ \ \ \ \ \ \ \ \ \|
echo +---------------------------------+
