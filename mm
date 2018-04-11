#!/bin/bash  
# marvin-make tool for Programmierparadigmen.
# Usage: mm filename arg1 arg2 etc.

## uploads given file to marvin, compiles on marvin, runs on marvin (while printing output to local stdout) and cleans up the mess afterwards
## supports ada, java, c, c++, haskell

# enter your username here
user=
# hint: install your public ssh key to omit the ssh password prompt
[ $user ] || { echo "no marvin username supplied, aborting" && exit 1; }

absolute_filename=$1
filename=$(basename $absolute_filename)
shift # now, $@ contains (only) all args for execution
build_dir=pp_build

cc="c++ -std=c++11 -Wall -Werror -pedantic -O3 $filename"
c="gcc -std=c99 -pedantic -Wall -Wextra -Werror $filename"
haskell="ghc -fwarn-tabs $filename"
java="javac -Xlint:all -Xlint:-serial -Werror $filename"
ada="gnatmake -gnat12 -gnatwa -gnatwl -gnaty3abcefhiklmnprt $filename"

# determine make command
case $filename in 
    *.java)
        make=$java
        outfile=$(echo $filename | sed 's/.java//')
        execute="java "
        ;;
    *.adb)
        make=$ada
        outfile=$(echo $filename | sed 's/.adb//')
        execute="./"
        ;;
    *.c)
        echo "c++? [y/N]"
        read result
        [ "$result" == y ] && make=$c || make=$cc
        outfile=a.out
        execute="./"
        ;;
    *.hs)
        make=$haskell
        outfile=$(echo $filename | sed 's/.hs//')
        execute="./"
        ;;
    *)
        echo Unsupported filetype && exit 1
esac

scp $absolute_filename $user@marvin.informatik.uni-stuttgart.de:$filename >/dev/null
ssh $user@marvin.informatik.uni-stuttgart.de "\
    rm -rf $build_dir >/dev/null; 
    mkdir $build_dir; 
    mv $filename $build_dir; 
    cd $build_dir; 
    $make >/dev/null && echo && echo Output: && $execute$outfile $@; 
    cd .. ; rm -rf $build_dir"
