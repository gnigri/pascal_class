program trabalho;

uses
       biblioteca;

type
	cadastro = record
		nome:string;
		dre:longint;
		notas:array[1..2] of real;
		media:real;
		faltas:integer;
		status:string;
		end;
	ptrCadastro = ^cadastro1;
	arquivo = file of cadastro;
	cadastro1 = record
			turma:arquivo;
			nome:string;
			next:ptrCadastro;
			previous:ptrCadastro;
			end;

{parte do ponteiro}

procedure novaTurma( var primeiro:ptrCadastro; var ultimo:ptrCadastro);

var

    pNovo:ptrCadastro;
    pAtual:ptrCadastro;{esse é para realizar as comparações e identificar onde inserir na lista ativa}
    pAux:ptrCadastro;
    cada:cadastro1;

begin

    new(pNovo);
    cada.nome:=criarArquivo(cada.turma);
    cada.next:=nil;
    cada.previous:=nil;
    pNovo^ := cada;
    if primeiro = nil then
    begin
        primeiro:=pNovo;
        ultimo:=pNovo;
    end
    else
    begin
        pAtual:=primeiro;{confere se o a inserção deve ser feita no começo ou no meio}
        if pAtual^.nome > pNovo^.nome then
        begin

            pNovo^.next:=pAtual;
            pAtual^.previous:=pNovo;
            pNovo^.previous:=nil;
            primeiro:=pNovo;

        end
        else
        begin

            repeat 
                if pAtual^.nome > pNovo^.nome then
                begin
                    pNovo^.previous:=pAtual^.previous;
                    pAtual^.previous:=pNovo;
                    pNovo^.next:=pAtual;
                    pAux:=pNovo^.previous;
                    pAux^.next:=pNovo;
                end
                else
                begin
                    pAtual:=pAtual^.next;
                end;
            until (pAtual<>ultimo) or (pNovo^.previous <> nil);{isso cria uma condição para a execução do loop:enquanto o arquivo não for inserido na lista de ativos, ou seja, seu ponteiro(anterior) estiver apontando para nil.Observe que, como já foi feito o teste se ele devia ser inserido no começo, então o seu ponteiro anterior não pode apontar para nil}
            if (pNovo^.previous = nil) then{Ocorre o risco de o arquivo ter que ser inserido no final da lista.Nesse caso, após a execução do loop anterior ambos os ponteiros continuarão apontando para nil}
            Begin
                pNovo^.previous:=ultimo;
                pNovo^.next:=nil;
                ultimo^.next:=pNovo;
                ultimo:=pNovo;
            End; 
        end;{fim do else}
    end;{fim do outro else}
end;

procedure mostrarTudo (primeiro,ultimo:ptrCadastro);

var
	pAux : ptrCadastro;

begin
	if primeiro<>nil then
	begin
		pAux:=primeiro;
		repeat
			writeln('turma:',pAux^.nome);
			pAux := pAux^.next;	
		until pAux=nil
	end
	else
	writeln('nenhuma turma ativa');
end;

function buscaPonteiro (primeiro,ultimo:ptrCadastro):ptrcadastro;

var
	pAux:ptrCadastro;
	buscador:string;

begin
	writeln('nome da turma que deseja buscar');
		buscador:=lerString;
	if primeiro=nil then
	begin
		buscaPonteiro:=nil;
	end
	else
	begin
		pAux:=primeiro;
		while (pAux<>ultimo) and (pAux^.nome<>buscador) do
			begin
				pAux:=pAux^.next;
			end;
		if pAux^.nome=buscador then
			buscaPonteiro:=pAux
		else
		begin
			buscaPonteiro:=nil;
		end;
	end;
end;

procedure apagaTurma(var primeiro,ultimo:ptrCadastro);

var
	pAux:ptrCadastro;
	pAuxNext:ptrCadastro; {pAuxNext vai apontar para o proximo ao que será apagado}
	pAuxPrevious:ptrCadastro; {pAuxPrevious vai apontar para o anterior ao que sera apagado}
	cada:cadastro1;
begin
	pAux:=buscaPonteiro(primeiro,ultimo);
	if pAux=nil then
		writeln('aluno inexistente');
	if (pAux<>nil) then
	begin
		cada:=pAux^;
		if (pAux<>primeiro) and (pAux<>ultimo) then
		begin
			pAuxNext:= pAux^.next;
			pAuxPrevious:=pAux^.previous;
			pAuxPrevious^.next:=pAuxNext;
			pAuxNext^.previous:=pAuxPrevious;
			dispose(pAux);
			writeln('turma apagada com sucesso');
			close(cada.turma);
			erase(cada.turma);
		end
		else
		begin
			if (pAux=primeiro) and (pAux^.next<>nil) then
			begin
				pAuxNext:= pAux^.next;
				primeiro:=pAuxNext;
				pAuxNext^.previous:=nil;
				dispose(pAux);
				writeln('turma apagada com sucesso');
				close(cada.turma);
				erase(cada.turma);
			end;
			if (pAux=primeiro) and (pAux^.next=nil) then
			begin
				primeiro:=nil;
				ultimo:=nil;
				dispose(pAux);
				writeln('turma apagada com sucesso');
				close(cada.turma);
				erase(cada.turma);
			end;
			if (pAux=ultimo) then
			begin
				pAuxPrevious:=pAux^.previous;
				ultimo:=pAuxprevious;
				ultimo^.next:=nil;
				dispose(pAux);
				writeln('turma apagada com sucesso');
				close(cada.turma);
				erase(cada.turma);
			end;
		end;
	end;
end;

procedure fechaTurma (var primeiro,ultimo:ptrCadastro);

var
	pAux:ptrCadastro;
	pAuxNext:ptrCadastro; {pAuxNext vai apontar para o proximo ao que será apagado}
	pAuxPrevious:ptrCadastro; {pAuxPrevious vai apontar para o anterior ao que sera apagado}
	cada:cadastro1;
begin
	pAux:=buscaPonteiro(primeiro,ultimo);
	if pAux=nil then
		writeln('aluno inexistente');
	if (pAux<>nil) then
	begin
		cada:=pAux^;
		if (pAux<>primeiro) and (pAux<>ultimo) then
		begin
			pAuxNext:= pAux^.next;
			pAuxPrevious:=pAux^.previous;
			pAuxPrevious^.next:=pAuxNext;
			pAuxNext^.previous:=pAuxPrevious;
			dispose(pAux);
			writeln('turma retirada da lista das ativas com sucesso');
			close(cada.turma);
		end
		else
		begin
			if (pAux=primeiro) and (pAux^.next<>nil) then
			begin
				pAuxNext:= pAux^.next;
				primeiro:=pAuxNext;
				primeiro^.previous:=nil;
				dispose(pAux);
				close(cada.turma);
				writeln('turma retirada da lista das ativas com sucesso');
			end;
			if (pAux=primeiro) and (pAux^.next=nil) then
			begin
				primeiro:=nil;
				ultimo:=nil;
				dispose(pAux);
				close(cada.turma);
				writeln('turma retirada da lista das ativas com sucesso');
			end;
			if (pAux=ultimo) then
			begin
				pAuxPrevious:=pAux^.previous;
				ultimo:=pAuxprevious;
				ultimo^.next:=nil;
				dispose(pAux);
				writeln('turma retirada da lista das ativas com sucesso');
				close(cada.turma);
			end;
		end;
	end;
end;


{parte do arquivo}

procedure incluir (var arq:arquivo);

var
	cada:cadastro;
	cada1:cadastro;
	encontrou:boolean;
	posicao:integer;

begin
	reset(arq);
	writeln('escreva o nome');
	cada.nome:=lerString;
	writeln('escreva o dre');
	cada.dre:=lerLongint;
	writeln('escreva a nota1');
	cada.notas[1]:=lerInteger;
	writeln('escreva a nota2');
	cada.notas[2]:=lerInteger;
	cada.media:=(cada.notas[1]+cada.notas[2])/2;
	writeln('escreva o numero de faltas');
	cada.faltas:=lerInteger;
	if (cada.media>=7) then
		cada.status:='aluno aprovado'
	else 
	begin
		cada.status:='aluno reprovado';
	end;
	seek(arq,0);
	encontrou:=false;
	while not(EOF(arq)) and not(encontrou) do
	begin
		read(arq , cada1);
		if cada1.nome>cada.nome then {compara para ver o lugar}
		begin
			posicao:=filepos(arq)-1;
			encontrou:=true;
		end;
	end;
	if not(encontrou) then {se ele nÃ£o Ã© menor que ninguem vai pro final}
	begin
		seek(arq, (filesize(arq)));
		write(arq, cada);
		close(arq);
	end
	else
	begin
		seek(arq,posicao);        {se encontrou vai pro meio}
		while not eof(arq) do
		begin
			read(arq,cada1);
			write(arq,cada1);
		end;
		seek(arq,posicao);
		write(arq,cada);
		close(arq);
	end;
end;

function buscarDre (var arq:arquivo):integer; 

var
	codigo:longint;
	cada:cadastro;
	encontrou:boolean;

begin
	encontrou:=false;
	writeln('escreva o dre do aluno procurado');
	codigo:=lerLongint;
	seek(arq,0);
	while not(EOF(arq)) and not(encontrou) do
	begin
		read(arq , cada);
		if cada.dre = codigo then
		begin
			buscarDre:=filepos(arq) -1;
			encontrou:=true;
		end;
	end;
	if not(encontrou) then
	begin
		buscarDre:=-1;      {-1 indica que o nome do aluno nao foi encontrado}
	end;
end;

function buscarNome (var arq:arquivo):integer; 

var
	nome:string;
	cada:cadastro;
	encontrou:boolean;

begin
	encontrou:=false;
	writeln('escreva o nome do aluno que deseja buscar');
	nome:=lerString;
	seek(arq,0);
	while not(EOF(arq)) and not(encontrou) do
	begin
		read(arq , cada);
		if cada.nome = nome then
		begin
			buscarNome:=filepos(arq) -1;
			encontrou:=true;
		end;
	end;
	if not(encontrou) then
	begin
		buscarNome:=-1;      {-1 indica que o nome do aluno nao foi encontrado}
	end;
end;

procedure apagar (var arq:arquivo);

var
	temp:integer;
	cada:cadastro;

begin
	temp:=buscarNome(arq);
	if temp=-1 then
		writeln('aluno inexistente')
	else
	begin
		seek(arq, temp+1);
		while not eof(arq) do
		begin
			read(arq, cada);
			seek(arq, filepos(arq)-2);
			write(arq,cada);
			seek(arq, filepos(arq)+1);

		end;
		seek(arq, filepos(arq)-1);
		truncate(arq);
		writeln('aluno apagado com sucesso');
	end;
end;

procedure alterar (var arq:arquivo);

var
	opcao:integer;
	cada:cadastro;
	nota1,nota2:real;
	temp,faltas:integer;

begin
	temp:=buscarNome(arq);
	if temp=-1 then
		writeln('aluno inexistente')
	else begin
		seek(arq,temp);
		read(arq, cada);
		writeln('1-alterar nota1');
		writeln('2-alterar nota2');
		writeln('3-alterar falta');
		opcao:=lerInteger;
		case opcao of
			1:begin
				writeln('escreva o nova nota');
				nota1:=lerInteger;
				cada.notas[1]:=nota1;
				cada.media:=(cada.notas[1]+cada.notas[2])/2;
				if (cada.media>=7) then
					cada.status:='aluno aprovado'
				else 
				cada.status:='aluno reprovado';
				seek(arq,temp);
				write(arq,cada);
				close(arq);
			end;
			2:begin
				writeln('escreva o nova nota');
				nota2:=lerInteger;
				cada.notas[2]:=nota2;
				cada.media:=(cada.notas[1]+cada.notas[2])/2;
				if (cada.media>=7) then
					cada.status:='aluno aprovado'
				else 
					cada.status:='aluno reprovado';
				seek(arq,temp);
				write(arq,cada);
				close(arq);
			end;
			3:begin
				writeln('escreva o novo numero de faltas');
				faltas:=lerInteger;
				cada.faltas:=faltas;
				seek(arq,temp);
				write(arq,cada);
				close(arq);
			end;
		end;
	end;
end;

procedure mostrar (var arq:arquivo);

var
	cada:cadastro;
	temp:integer;

begin
	temp:=buscarNome(arq);
	if temp=-1 then
		writeln('aluno inexistente')
	else 
	begin
		seek(arq, temp);
		read(arq, cada);
		writeln('nome:',cada.nome,' dre:',cada.dre,' nota1:',cada.notas[1]:2:2,' nota2:',cada.notas[2]:2:2,' media:',cada.media:2:2,' faltas:',cada.faltas,' status:',cada.status);
	end;
end;

procedure imprimeArquivo (var arq:arquivo);

var
	cada:cadastro;

begin
	reset(arq);
	while not eof(arq) do
	begin
		read(arq, cada);
		writeln('nome:',cada.nome,' dre:',cada.dre,' nota1:',cada.notas[1]:2:2,' nota2:',cada.notas[2]:2:2,' media:',cada.media:2:2,' faltas:',cada.faltas,' status:',cada.status);
	end;
	close(arq);
end;

procedure exibeAprovados (var arq:arquivo);

var
	cada:cadastro;

begin
	reset(arq);
	while not eof(arq) do
	begin
		read(arq, cada);
		if cada.status='aluno aprovado' then
		begin
			writeln('nome:',cada.nome,' dre:',cada.dre,' nota1:',cada.notas[1]:2:2,' nota2:',cada.notas[2]:2:2,' media:',cada.media:2:2,' faltas:',cada.faltas,' status:',cada.status);
		end;
	end;
	close(arq);
end;
		

procedure exibeReprovados (var arq:arquivo);

var
	cada:cadastro;

begin
	reset(arq);
	while not eof(arq) do
	begin
		read(arq, cada);
		if cada.status='aluno reprovado' then
		begin
			writeln('nome:',cada.nome,' dre:',cada.dre,' nota1:',cada.notas[1]:2:2,' nota2:',cada.notas[2]:2:2,' media:',cada.media:2:2,' faltas:',cada.faltas,' status:',cada.status);
		end;
	end;
	close(arq);
end;

{parte dos menus}

procedure menu (primeiro:ptrCadastro; ultimo:ptrCadastro);

var
	opcao,y:integer;
	pAux:ptrCadastro;

begin
	y:=0;
	pAux:=buscaPonteiro(primeiro,ultimo);
		if pAux<>nil then
		begin
		repeat
		reset(pAux^.turma);
		writeln('1-inserir novo aluno');
		writeln('2-apagar aluno');
		writeln('3-editar nota ou faltas');
		writeln('4-buscar aluno');
		writeln('5-alunos aprovados');
		writeln('6-alunos reprovados');
		writeln('7-todos os alunos');
		writeln('8-voltar ao menu anterior');
		opcao:=lerInteger;
		case opcao of
			1:incluir(pAux^.turma);
			2:apagar(pAux^.turma);
			3:alterar(pAux^.turma);
			4:mostrar(pAux^.turma);
			5:exibeAprovados(pAux^.turma);
			6:exibeReprovados(pAux^.turma);
			7:imprimeArquivo(pAux^.turma);
			8:y:=1;
		end;
		until (y=1)
		end
	else
		writeln('turma inexistente');
end;

procedure menuP(var ultimo,primeiro:ptrCadastro);

var
	opcao,y:integer;

begin
	repeat
		writeln('1-ACRESCENTA NOVA TURMA A LISTA DE TURMAS ATIVAS');
		writeln('2-TIRA A TURMA DA LISTA DAS TURMAS ATIVAS');
		writeln('3-IMPRIME LISTA DE TURMAS ATIVAS');
		writeln('4-ABRE TURMA');
		writeln('5-APAGA TURMA');
		writeln('6-SAIR');
		opcao:=lerInteger;
		case opcao of
			1:novaTurma(primeiro,ultimo);
			2:fechaTurma(primeiro,ultimo);
			3:mostrarTudo(primeiro,ultimo);
			4:menu(primeiro,ultimo);
			5:apagaTurma(primeiro,ultimo);
			6:y:=1;
		end;
	until y=1
end;


{programa principal}

var
	first,last:ptrCadastro;

begin
	last:=nil;
	first:=nil;
	menuP(first,last);
end.
