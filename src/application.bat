# Beginning of parallelizable section
lcc application3.c
lcc application2.c
lcc application1.c
# End of parallelizable section
lcclnk -s -o application.exe @application.lnk
