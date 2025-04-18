rm -rf configure config.status config.log aclocal.m4 missing install-sh ./autom4te.cache/

aclocal
autoconf
automake --add-missing
./configure