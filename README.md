# freekit
Free your hands to use VASP.

This project provided some code to help everyone use VASP easily.

The INCAR file is a basic input template file.

Run source ./setpu.sh to configure the necessary environment variables.

QuickStart:
1. cd your_vasp_workdir;
2. type incar, then a basic input template file  will be pulled in the current directory.
3. type pre.sh modify_type1 modify_type2 ... to modify the incar template by your need.
For example,
(a) type pre.sh zpe, then the incar file will be generated for freq cal.
(b) type pre.sh dos; then the incar file will be generated for dos cal.

tips:
    You can see some details about modification of INCAR from pre_modify_incar.sh
