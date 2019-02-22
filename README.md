# SoalShift_modul1_E15

# NOMOR 1
Pada soal nomor 1, kita diminta untuk mendecode sebuah folder yang berisi dengan file file yang telah didecode. Langkah pertama yang dilakukan adalah dengan menggunakan base64 yang berfungsi untuk encode atau decode sebuah data, dengan option "base64 -d" yang artinya kita mendecode sebuah file. Lalu hexadump digunakan untuk membaca hexadecimal file menjadi binary file dengan perintah "xxd -r". Karena dalam file terdapat lebih dari satu file maka yang perlu dilakukan adalah membuat perulangan dari file pertama hingga file terakhir dalam folder tersebut. Untuk cron kita menggunakan config 14 14 14 2 5 /bin/bash soal1.sh atau bisa juga dalam 14 14 14 FEB FRI /bin/bash soal1.sh.

# NOMOR 2
Pada soal nomor 2, kita diminta untuk mencari negara dengan penjualan paling banyak, product line dalam negara yang sebelumnya sudah dicari, dan juga produk produk dari product line yang didapat pada hasil sebelumnya. Dalam hal ini kita menggunakan awk untuk mengolah data yang ada pada file csv. Ada beberapa hal penting yang kita gunakan yaitu:

-. FS "," artinya awk akan memisahkan text menjadi field field tersendiri jika bertemu dengan tanda koma(karena csv adalah format file yang dipisahakan dengan tanda koma)

-. -v var artinya dalam awk tersebut kita membuat variabel bernama var

-. NR artinya berapa banyak baris yang kita ambil

-. sort -rg artinya mengurutkan secara terbalik(-r karena default dari sort pada linux adalah ascending) dan juga yang diurutkan berdasarkan data yang bersifat numerik(-g)

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

kalau untuk dekripsinya caranya persis sama dengan enkripsi, hanya pada bagian assign variabel indeksnya dikurangi dengan jamnya, bukan ditambah. Untuk script dekripsi, membutuhkan argumen nama file. Dari nama file tersebut diambil jam yang akan dijadikan key untuk dekripsi. Jika array diakses dengan index minus, maka array akan mengakses mulai dari index terakhir.
```
file="$1"
filedec="$1dec"
jam="${file:0:2}"
```
lalu dilakukan prosesnya tetapi dikurangi
```
for (( i=0; i<26; i++)); do
    dec="$dec${to_change_low:$i-jam:1}"
done

for (( i=0; i<26; i++)); do
    dec="$dec${to_change_up:$i-jam:1}"
done
```

crontab
@hourly bash soal4.sh

# NOMOR 5

Pada soal nomor 5, kita diminta untuk mencari syslog dengan adanya kata CRON dan juga tidak diketemukannya kata SUDO(case insensitive) sekaligus mencetak hasil tersebut yang mempunyai field sebanyak kurang dari 13. Pada hal ini kita menggunakan perintah awk. Adanya NF dalam script awk tersebut artinya banyaknya field yang berada dalam suatu baris. Hal ini digunakan untuk memenuhi syarat dari nomor 5b.
Untuk konfigurasi cron nya dapat digunakan dengan cara
* 2-30/2 * * * /bin/bash soal5.sh
