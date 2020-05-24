program klasmen_pertandingan;
uses crt;

const
nmax = 20;

type
team = record
	nama   : string;
	main   : integer;
	menang : integer;
	seri   : integer;
	kalah  : integer;
	poin   : integer;
end;

type
array_klasmen = array [1..nmax] of team;

var
	klasmen : array_klasmen;
	no,jum_team   : integer;

Procedure TampilanAwal();
{IS. -
 FS. Menampilkan User Interface }
BEGIN
		clrscr;
		writeln(' ==================================');
		writeln('|          SELAMAT DATANG          |');
		writeln('|                DI                |');
		writeln('|        DEMO APLIKASI BOLA        |');
		writeln(' ==================================');
		  write('        tekan enter...');
		readln;
END;

Procedure InputData (var klasmen : array_klasmen; var jum_team : integer); //menginputkan team yang akan bertanding
{IS. -
 FS. User Menginputkan Jumlah Team Maksimum 20 team }
var
	i,jum_team2: integer;
	klasmen2: array_klasmen;
BEGIN
	clrscr;
	i:=1;
	write('Masukan jumlah tim (<=20) : '); readln(jum_team);
	if(jum_team >= 2) then
	begin
		while (i <= jum_team) do
		begin
			write('Klub ke-',i,' : ');
			readln(klasmen[i].nama);
			i:=i+1;
		{endWhile}
		end;
	end
	else 
		InputData(klasmen2,jum_team2);
	{endIf}
	readln;
END;

Procedure EditData(var klasmen : array_klasmen);
{IS. menginputkan data integer yang ingin di edit
 FS. mengubah data nama berupa string yang terdapat di array klasmen}
var 
	jum_team : integer;
BEGIN
	writeln();
	write('Edit Data ke: ');		 	  readln(jum_team);
	write('Masukan Nama Team: ');       read(klasmen[jum_team].nama);
	readln;
END;

Procedure DeleteData(var klasmen : array_klasmen; var jum_team : integer);
{IS. menginputkan data integer yang ingin di hapus
 FS. menghapus array klasmen nama yang sudah diinputkan oleh user}
var
	key,i: integer;
BEGIN	
	write('Data Ke :'); readln(key); 
	i:= key;
	while (i <= jum_team-1) do
	begin
			klasmen[i]:=klasmen[i+1];
			i:=i+1;
	{endWhile}
	end;
	jum_team:=jum_team-1;
END;

Procedure LihatData (var klasmen : array_klasmen; var jum_team : integer); //Melihat kembali data yang sudah diinputkan berupa nama team
{IS. array klasmen terdefinisi nama team
 FS. menampilakn array klasmen nama yang sudah diinputkan oleh user}
var
	i : integer;
	no : integer;
BEGIN
	repeat
		clrscr;
		i:=1;
		while (i <= jum_team) do
		begin
			writeln('Team ke-',i);
			writeln('Nama Team : ',klasmen[i].nama);
			writeln;
			i:=i+1;
		{endWhile}
		end;
		writeln;
		writeln('MENU :');
		writeln('[1]. Edit');
		writeln('[2]. Delete'); 
		writeln('[3]. Kembali');
		writeln();
		write('Pilih no :'); read(no);
		writeln();
		if  (no = 1) then
		begin
			EditData(klasmen);
			LihatData(klasmen,jum_team);
		end
		else if (no = 2) then
		begin
			DeleteData(klasmen,jum_team);
			LihatData(klasmen,jum_team);
		end;
		{endIf}
	until (no=1) or (no=2) or (no=3);
	{endRepeat}
END;

Procedure Pertandingan (var klasmen : array_klasmen; jum_team : integer); //Meinputkan goal antar team yang bertanding
{IS. array klasmen terdefinisi suatu nama team yang bertanding
 FS. menginputkan score pertandingan antar team dan tidak akan bertanding dengan team yang sama }
var
	i,i_dua,ronde,goal1,goal2 : integer;
BEGIN
	clrscr;
	i:=1;
	ronde:=1;
	while (i <= jum_team) do
	begin
		i_dua:= i+1;
		while (i_dua <= jum_team)do
		begin
			writeln('Pertandingan Ke-',ronde);
			writeln(klasmen[i].nama,' VS ',klasmen[i_dua].nama);
			write('Goal ',klasmen[i].nama,' : ');
			readln(goal1);
			write('Goal ',klasmen[i_dua].nama,' : ');
			readln(goal2);
			if 		(goal1>goal2) then
			begin
				klasmen[i].poin:=klasmen[i].poin+3;
				klasmen[i].menang:=klasmen[i].menang+1;
				klasmen[i_dua].kalah:=klasmen[i_dua].kalah+1;
			end
			else if (goal2>goal1) then
			begin
				klasmen[i_dua].poin:=klasmen[i_dua].poin+3;
				klasmen[i_dua].menang:=klasmen[i_dua].menang+1;
				klasmen[i].kalah:=klasmen[i].kalah+1;
			end
			else
			begin
				klasmen[i].poin:=klasmen[i].poin+1;
				klasmen[i_dua].poin:=klasmen[i_dua].poin+1;
				klasmen[i].seri:=klasmen[i].seri+1;
				klasmen[i_dua].seri:=klasmen[i_dua].seri+1;
			end;
			{endIf}			
		writeln;
		i_dua:=i_dua+1;
		ronde:=ronde+1;
		{EndWhile}
		end;
	i:=i+1;
	{EndWhile}	
	end;
END;

Procedure BubblePoin(var klasmen: array_klasmen; jum_team:integer); //Skema Bubble Sort hasil poin(Desending)
{IS. array klasmen terdefinisi 
 FS. mengurutkan array klasmen poin yang sudah terisi dari poin terbesar ke poin terkecil }
var
		i,pass : integer;
		tmp    : team;
BEGIN 
	clrscr;
	pass:=1; 
	while (pass <= jum_team-1) do
	begin	
		i:=1;
		while (i <= jum_team-pass) do
		begin	
			if (klasmen[i].poin < klasmen[i+1].poin) then
			begin
				tmp          := klasmen[i];
				klasmen[i]   := klasmen[i+1];
				klasmen[i+1] := tmp;
			end;
			{endIf}
			i:=i+1;
		end;
		{endWhile}
		pass:= pass + 1;
	end;
	{endWhile}
	clrscr;
	writeln('PERINGKAT KLASEMEN');
	i:=1;
	while (i <= jum_team) do
	begin
		writeln(i,')',' Team : ',klasmen[i].nama);
		writeln('  Poin : ',klasmen[i].poin);
		writeln('  Menang : ',klasmen[i].menang);
		writeln('  Seri : ',klasmen[i].seri);
		writeln('  Kalah : ',klasmen[i].kalah);
		i:=i+1;
		writeln();
	{endWhile}
	end;
	readln;
END;

Procedure InsertionMenang(var klasmen: array_klasmen; jum_team:integer); //Skema Insertion Sort Hasil Kemenangan (Desending)
{IS. array klasmen terdefinisi
 FS. mengurutkan array klasmen menang yang sudah terisi dari menang terbesar ke menang terkecil}
var
	 	i,pass 	: integer;
	 	temp	: team;
BEGIN
	 	pass := 1;
	 	while (pass <= jum_team-1) do
	 	begin
	 		i  := pass + 1;
	 		temp:= klasmen[i];
	 		while (temp.menang > klasmen[i-1].menang) and (i>1) do
	 		begin
	 			klasmen[i] := klasmen[i-1];
	 			i          := i-1;
	 		{endWhile}
	 		end; 
	 		klasmen[i] := temp;
	 		pass 	   := pass+1;
	 	{endWhile}
	 	end;
END;

function Status(klasmen: array_klasmen; i_min: integer; i: integer): boolean;
{IS. array klasmen kalah terdefinisi
 FS. menghasilkan nilai true dari suatu array klasmen kalah, jika true maka akan di lempar di procedure dan aksinya dijalankan, jika
     false maka akan di lempar tetapi aksi tidak di jalankan }
BEGIN 
	Status := klasmen[i_min].kalah > klasmen[i].kalah;
END; 

Procedure SelectionKalah(var klasmen: array_klasmen; jum_team:integer); //Skema Selection Sort Hasil Kekalahan (Ascending)
{IS. array klasmen kalah terdefinisi
 FS. mengurutkan aray klasmen kalah dari kalah terkecil ke kalah terbesar}
var
		i,pass,i_min  : integer;
		lanjut        : team;
BEGIN
		clrscr;
		pass:=1;
		while (pass <= jum_team-1) do
		begin	
			i_min:= pass;
			i:= pass+1;
			while (i <= jum_team) do
			begin
				if (Status(klasmen,i_min,i)) then
					i_min := i;
				{endIf} 
				i:=i+1;			
			{endwhile}
			end;
			lanjut		   := klasmen[i_min];
			klasmen[i_min] := klasmen[pass];
			klasmen[pass]  := lanjut;
			pass:=pass+1;
		{endWhile}
		end;
END;			

Procedure HasilPertandingan(var klasmen : array_klasmen; jum_team : integer ); //Hasil pertandingan Team yang sudah bertanding
{IS. array klasmen terdefinisi
 FS. menampilkan hasil pertandingan berupa nama team,poin,senang,seri dan kalah. terdapat 3 Menu, menu 1 untuk menampilkan peringkat klasmen
	 menu 2 untuk menampilkan array klasmen dgn kalah terendah dan menu 3 untuk menampilkan array klasmen dgn menang tertinggi}
var
	i,no : integer;
BEGIN
	clrscr;
	i:=1;
	repeat
		while (i <= jum_team) do
		begin
			writeln(i,')',' Team : ',klasmen[i].nama);
			writeln('  Poin : ',klasmen[i].poin);
			writeln('  Menang : ',klasmen[i].menang);
			writeln('  Seri : ',klasmen[i].seri);
			writeln('  Kalah : ',klasmen[i].kalah);
			i:=i+1;
			writeln();
		{endWhile}
		end;	
		writeln('Sort By');
		writeln('[1]. Poin(Descending)');
		writeln('[2]. Kalah(Ascending)');
		writeln('[3]. Menang(Descending)');
		writeln('[0]. Kembali');
		writeln;
		write('Pilih No :'); readln(no);
		if (no = 1) then
		begin
			BubblePoin(klasmen,jum_team);
			HasilPertandingan(klasmen , jum_team );
		end
		else if (no = 2)then
		begin
			SelectionKalah(klasmen,jum_team);
			HasilPertandingan(klasmen , jum_team );
		end
		else if (no = 3) then
		begin
			InsertionMenang(klasmen,jum_team);
			HasilPertandingan(klasmen , jum_team);
		end	;
		{endIF}
	until (no = 0) or (no = 1) or (no = 2) or (no = 3);				
	{endRepeat}
END;

Procedure SequensialNama (klasmen : array_klasmen; jum_team : integer); //Skema Squensial Search untuk mencari nama team dan data tidak harus terurut 
{IS. suatu array klasmen terdefinisi user menginputkan nama team berupa string
 FS. mencari array klasmen nama team yang sudah diinputkan user}
var
	i:integer;
	key:string;
BEGIN
	clrscr;
	write('Cari Nama Team :'); readln(key);
	i:=1;
	while (i <= jum_team) and (key <> klasmen[i].nama) do
		i:= i+1;
		{endWhile}
	if (key = klasmen[i].nama) or (i < jum_team) then
	begin
	    writeln('Nama Team : ',klasmen[i].nama);
	    writeln('Poin : ',klasmen[i].poin);
	    writeln('Menang : ',klasmen[i].menang);
	    writeln('Seri : ',klasmen[i].seri);
	    writeln('Kalah : ',klasmen[i].kalah);
	end
	else 
	    writeln('Data tidak ditemukan');
	{endIF}
	readln;	
END;

Procedure BinarryPoin (klasmen : array_klasmen; jum_team : integer ); //Skema Binnary Search untuk mencari poin dengan syarat data harus terurut terlebih dahulu dgn menggunakan bubblesort
{IS. suatu array klasmen terdefinisi user menginputkan poin berupa integer 
 FS. mencari array klasmen poin yang sudah diinputkan user}
var
i,pass,key,kiri,kanan,tengah,lokasi : integer;
status : boolean;
tmp : team;
BEGIN 
	clrscr;
	write('Cari Poin Team :'); readln(key);
	pass:=1; 
	//bubble sort ascending
	while (pass <= jum_team-1) do
	begin	
		i:=1;
		while (i <= jum_team-pass) do
		begin	
			if (klasmen[i].poin > klasmen[i+1].poin) then
			begin
				tmp          := klasmen[i];
				klasmen[i]   := klasmen[i+1];
				klasmen[i+1] := tmp;
			end;
			{endIf}
			i:=i+1;
		{endWhile}
		end;
		pass:= pass + 1;
	{endWhile}
	end;

	kiri:=1;
	kanan:=jum_team;
	status:=false;
	lokasi:=0;
	while (kiri <= kanan) and (status = false) do
	begin
		tengah :=(kanan+kiri) div 2;
		if klasmen[tengah].poin = key then
		begin
			status:=true;
			lokasi:=tengah;
		end
		else if klasmen[tengah].poin < key then //set untuk ascending
			kiri:=tengah+1
		else if klasmen[tengah].poin > key then //set untuk ascending
			kanan:=tengah-1;
		{EndIF}
	{EndWhile}
	end;
	if (status = true) and (lokasi <> 0) then
	begin
		write('Nama Team :'); writeln(klasmen[lokasi].nama);
		write('Poin :'); writeln(klasmen[lokasi].poin);
		readln;
	end
	else if (status = false) then
	begin
		write('Data tidak ditemukan');
		readln;
	end;
	{endIF}
END;	

//7 MENU yang terdapat di MENU UTAMA
Procedure MenuUtama();
{IS.user menginputkan integer untuk memilih salah satu smenu
 FS.Menampilkan Menu Utama dengan 7 menu yang akan ditampilkan sesuai inputan user}
BEGIN

	repeat
		clrscr;
		writeln('---------------------------');
		writeln('|        MENU UTAMA       |');
	 	writeln('---------------------------');
		writeln;
		writeln('[1]. Input');
		writeln('[2]. List Team');
		writeln('[3]. Pertandingan');
		writeln('[4]. Hasil Pertandingan');
		writeln('[5]. Search Nama Team');
		writeln('[6]. Search Poin Team');
		writeln('[0]. Keluar');
		write('Pilih No : ');
		readln(no);
		if (no=1) then
		begin
			InputData(klasmen,jum_team);
			MenuUtama();
		end
		else if (no=2) then
		begin	
			LihatData(klasmen,jum_team);
			MenuUtama();
		end
		else if (no=3) then
		begin	
			Pertandingan(klasmen,jum_team);
			MenuUtama();
		end
		else if (no=4) then
		begin	
			HasilPertandingan(klasmen,jum_team);
			MenuUtama();
		end
		else if (no=5) then
		begin
			SequensialNama(klasmen,jum_team);
			MenuUtama();
		end
		else if (no=6) then
		begin
			BinarryPoin(klasmen,jum_team);
			MenuUtama();
		end;
		{endIF}
	until (no=1) or (no=2) or (no=3) or (no=4) or (no=5) or (no=6) or (no=0);	
	{endRepeat}
END;

//Program Utama memanggil 2 procedure
BEGIN
	TampilanAwal();
	MenuUtama();
END.