#!/bin/bash
#configuration file 
CONFILE="conf.txt" 

#last read line number default 1
HISTORY=1 
if [ ! -f $CONFILE ];then
  echo "1">$CONFILE 
else
	HISTORY=`cat $CONFILE`
fi
echo "Last Line:$HISTORY"
#line space default 15 lines
LINE=15
#$1 is the book file
if [ -f $1 ];then
	lines=$HISTORY
	while true
	do
        #get input 
		read -n1 key
        echo -ne "\b"
        #j down page
		if [ "$key" = "j" ];then
            linee=`expr $lines + $LINE`
            cmd="sed -n '$lines,${linee}p' $1"
            eval $cmd
            lines=`expr $lines + $LINE`
            echo $lines>$CONFILE
        #k up page
        elif [ "$key" = "k" ];then
            lines=`expr $lines - $LINE`
            if [ $lines -le 0 ];then
                lines=1
            fi
            echo $lines>$CONFILE
            linee=`expr $lines - $LINE`
            cmd="sed -n '$lines,${linee}p' $1"
            eval $cmd
        #q exit 
        elif [ "$key" = "q" ];then
            exit 0
        fi
    done
fi
