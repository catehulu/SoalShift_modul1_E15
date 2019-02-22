# SoalShift_modul1_E15

# NOMOR 3

Soal ini meminta untuk membuatkan script yang mengenerate password 12 karakter yang terdiri dari alfabet uppercase dan lowercase serta angka. Password tersebut disimpan dalam file benama "passwordX.txt." dimana x adalah nomor file tersebut. nomor file tersebut increment sesuai dengan file keberapa yang terakhir dibuat.

untuk menyelesaikan problem ini pertama dilakukan pengecekan terhadap file yang sudah ada.
    
```
  if [ -f $check ]
  then
   #echo "Berhasil!"
   let "ptr++"
  else
   #echo "Tidak!"
   gate=0
  fi
```
variabel cek berisi nama file yang sedang dicek, apabila tidak ada file yang bernama sama dengan check, maka check akan digunakan. Apabila terdapat file dengan nama yang sama, maka ptr akan di increment, yang membuat nomor pada check bertambah.

```
password=`< /dev/urandom tr -dc a-z0-9 | head -c1 >> $check`

password=`< /dev/urandom tr -dc A-Za-z0-9 | head -c10 >> $check`

password=`< /dev/urandom tr -dc 0-9 | head -c1 >> $check`
```
untuk generate password digunakan file urandom yang terdapat pada linux. File tersebut akan dijadikan file input, lalu dengan tr akan dihapus karakter yang kita inginkan, lalu yang dihapus tersebut akan disimpan. Setelah itu dari string yang didapat diambil dari awal sesuai yang diinginkan. Kami membuat proses tersebut 3 kali agar memastikan pasti terdapat angka termasuk dalam password tersebut. Setelah itu password dimasukkan ke file dengan nama yang telah dicheck pada proses diatas.


# NOMOR 4

Soal ini meminta script untuk melakukan backup terhadap file syslog tetapi dengan penengkripsian terhadap file tersebut sesuai dengan jam dimana file tersebut terbuat.

```
jam="`date +\"%H\"`"
menit="`date +\"%M\"`"
tanggal="`date +\"%d\"`"
bulan="`date +\"%m\"`"
tahun="`date +\"%Y\"`"

file="$jam:$menit $tanggal-$bulan-$tahun"
```
pertama-tama digenerate nama file daribackupnya.

untuk penengkripsiannya digunakan 2 string, string untuk penggantian lowercase dan uppercase. huruf dari a-z dimasukkan kedalam string dan diulang 2 kali.

```
to_change_low="`echo {a..z} | tr -d " "`"
to_change_up="`echo {A..Z} | tr -d " "`"
to_change_low="$to_change_low$to_change_low"
to_change_up="$to_change_up$to_change_up"
```
dengan ini huruf dari a-z tersusun dengan index urutan huruf tersebut dikurang 1. jadi a tersimpan pada index ke 0, yang akan mempermudah dalam perubahan stringnya. setelah itu dilakukan loop untuk menentukan huruf-huruf yang terenkripsi sesuai urutan dari a-z. Lalu huruf-huruf tersebut dimasukkan kedalam variable dengan urutan lowercase lalu uppercase
```
for (( i=0; i<26; i++)); do
    enc="$enc${to_change_low:$i+jam:1}"
done

for (( i=0; i<26; i++)); do
    enc="$enc${to_change_up:$i+jam:1}"
done
```
setelah itu menggunakan tr diganti seluruh karakter didalam syslog lalu diinputkan ke file yang ditentukan. jika tr diberikan 2 substring dengan panjang yang sama, maka tr akan mengganti karakter sesuai dari index string tersebut.
```
to_change="`echo {a..z} | tr -d " "``echo {A..Z} | tr -d " "`"

`tr $enc $to_change < /var/log/syslog > "$file"`
```
crontab
@hourly bash soal4.sh
