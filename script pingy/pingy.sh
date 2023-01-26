#!/usr/bin/bash
#перший скріпт
#ключ ALL
#get the first octets of the network ip
function all() {
#get the first octets of the network ip
ifconfig | grep "broadcast" | cut -d " " -f 10 | cut -d "." -f 1,2,3 | uniq > octets.txt
#Set variable to have the value of octets.txt
OCTETS=$(cat octets.txt)
#create a new .txt
echo "" > $OCTETS.txt
#Loop
for ip in {1..254}
do
        ping -c 1 $OCTETS.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" >> $OCTETS.txt &
done
cat $OCTETS.txt | sort > sorted_$OCTETS.txt
cat sorted_$OCTETS.txt
exit 0
}
#другій скріпт
#Ключ Target
function target() {
sudo nmap -sS --top-ports 20 -iL sorted_*.txt
exit
}
echo "Welcome to the scan network you have 2 keys
 -    ALL (its scan all hosts your Lan network)
 -    target (its scan all hosts ports )
      choose key and press Enter"
read KEY
if [[ "$KEY" == "ALL" ]]
then
  all
elif
  [[ "$KEY" == "target" ]]
then
target
else
echo "Wrong key"
fi
