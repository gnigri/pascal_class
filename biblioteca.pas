unit biblioteca;

interface

function criarArquivo(var arq:file):string;

function lerString:string;

function lerInteger:integer;

function lerLongint:longint;

implementation

function criarArquivo (var arq:file):string;

var
	nome,resp:string;

begin
	writeln('qual o nome do arquivo');
	readln(nome);
	assign(arq,nome);
	{$I-}
	reset(arq);
	{$I+}
	if ioresult=2 then
	begin
		writeln('deseja criar esse arquivo?');
		writeln('para criar digite sim');
		readln(resp);
		if resp='sim' then
		begin
			rewrite(arq);
			criarArquivo:=nome;
			writeln('o arquivo foi criado');
		end
		else
		begin
			criarArquivo:='n';
		end;
	end
	else
	begin
		writeln('arquivo aberto');
		criarArquivo:=nome;
	end;

end;



function lerString:string;

var
	palavra:string;
	erro:integer;

begin
	repeat
	{$I-}
	readln(palavra);
	{$I+}
	erro:=ioresult;
	if erro<>0 then
	begin
		writeln('opção invalida');
		writeln('tente novamente');
	end;
	until (erro=0);
	lerString:=palavra;	
end;

function lerInteger:integer;

var
	numero:integer;
	erro:integer;

begin
	repeat
	{$I-}
	readln(numero);
	{$I+}
	erro:=ioresult;
	if erro<>0 then
	begin
		writeln('opção invalida');
       		writeln('tente novamente');
	end;
	until (erro=0);
	lerInteger:=numero;	
end;

function lerLongint:longint;

var
	numero:longint;
	erro:integer;

begin
	repeat
	{$I-}
	readln(numero);
	{$I+}
	erro:=ioresult;
	if erro<>0 then
	begin
		writeln('opção invalida');
		writeln('tente novamente');
	end;
	until (erro=0);
	lerLongint:=numero;	
end;

end.

