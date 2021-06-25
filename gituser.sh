#!/bin/bash
pause()
{
read -s -n 1 -p "Press any key to continue...";
}

quit() 
{
clear; 
exit;
}

gitverify(){
clear;
printf '\n\n';
echo "Current Username   :   $(git config --global user.name)";
echo "Current EmailID    :   $(git config --global user.email)";
printf '\n\n';
pause;
}

gitexecute(){
git config --global --replace-all user.name $name
git config --global --replace-all user.email $email
gitverify;
}

init(){
iofile=.sec/seed
if [ -f "$iofile" ]; then
    count=$(grep -o -i ::email .sec/seed | wc -l)
else 
count=0; 
mkdir -p .sec
fi

}

inputto(){  
clear;
while :
do   
count=$(($count+1));
printf %s "enter username   :    "; 
read uname;
    if  [[ "$uname" == ":q" ]];
then
    break;
fi;
printf %s "enter emailID   :    "; 
read email;

if  [[ "$email" == ":q" ]];
then
break;
fi;

echo "::username$count : $uname">>.sec/seed
echo "::email$count : $email">>.sec/seed
printf '\nenter :q to exit\n';

done

}

readfrom(){
if [[ "$count" > 0 ]];
then    
    for c in `seq 1 $(grep -o -i ::email .sec/seed | wc -l)`
    do
    echo " $c - $(grep "::username$c" .sec/seed  | cut -d " " -f3)  ($(grep "::email$c" .sec/seed  | cut -d " " -f3)) ";
    echo "---------------------------------------------------";
    done
fi;
}

editdata(){
clear
if [[ "$count" > 0 ]]; then
    readfrom;
    echo " b - back";
    echo "---------------------------------------------------";
    read eval;
    if [[ $eval ]] && [ $eval -eq $eval 2>/dev/null ];
    then
    if [[ "$eval" -gt 0 && "$eval" -le $c ]];
    then
    clear;
    echo "Previous username   :    $(grep "::username$eval" .sec/seed  | cut -d " " -f3)";
    printf %s "new username        :  ";
    read newval;
    sed -i "s/$(grep "::username$eval" .sec/seed  | cut -d " " -f3)/$newval/" .sec/seed
    
    echo "Previous email      :    $(grep "::email$eval" .sec/seed  | cut -d " " -f3)";
    printf %s "new emailID         :   ";
    read newval;
    sed -i "s/$(grep "::email$eval" .sec/seed  | cut -d " " -f3)/$newval/" .sec/seed
    
    fi;
    fi;
    
fi;
}

window()
{
clear
echo "Change Default gitAccount ";
echo "---------------------------------------------------";
readfrom;
echo " d - input data                                    ";
echo "---------------------------------------------------";
if [[ "$count" > 0 ]];
then    
echo " e - edit data";
echo "---------------------------------------------------";
fi;
echo " i - info                                          ";
echo "---------------------------------------------------";
echo " c - clear                                         ";
echo "---------------------------------------------------";
echo " q - quit                                          ";
echo "---------------------------------------------------";
printf %s "Enter the option :  ";

read val;
if [[ "$val" == "d" || "$val" == "D" ]];
    then
    inputto;
fi;
if [[ "$val" == "c" || "$val" == "C" ]];
    then
    rm -rf .sec
fi;

if [[ "$count" > 0 ]];
then

if [[ $val ]] && [ $val -eq $val 2>/dev/null ];
then
echo "pass 1";
    if [[ "$val" -gt 0 && "$val" -le $c ]];
    then
    echo "pass 2";
    name=$(grep "::username$val" .sec/seed  | cut -d " " -f3);
    email=$(grep "::email$val" .sec/seed  | cut -d " " -f3);
    gitexecute;
    else
    echo "$val $c";
    fi;
fi;

if [[ "$val" == "e" || "$val" == "E" ]];
    then
    editdata;
fi;

fi;

if [[ "$val" == "i" || "$val" == "I" ]];
    then
    gitverify;
fi;
if [[ "$val" == "q" || "$val" == "Q" ]];
    then
    quit;
fi;
}

init;

while :
do
    window;
done
