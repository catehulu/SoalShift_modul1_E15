#Rab Feb 20 17:50:59 WIB 2019
jam="`date +\"%H\"`"
menit="`date +\"%M\"`"
tanggal="`date +\"%d\"`"
bulan="`date +\"%m\"`"
tahun="`date +\"%Y\"`"

file="$jam:$menit $tanggal-$bulan-$tahun"
#echo $file

enc=""

to_change_low="`echo {a..z} | tr -d " "`"
to_change_up="`echo {A..Z} | tr -d " "`"
to_change_low="$to_change_low$to_change_low"
to_change_up="$to_change_up$to_change_up"
#echo "$to_change_up"

for (( i=0; i<26; i++)); do
    enc="$enc${to_change_low:$i+jam:1}"
done

for (( i=0; i<26; i++)); do
    enc="$enc${to_change_up:$i+jam:1}"
done

to_change="`echo {a..z} | tr -d " "``echo {A..Z} | tr -d " "`"

`tr $enc $to_change < /var/log/syslog > "$file"`