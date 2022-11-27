-- JAVA
-- quando lemos um valor (double, por exemplo)
-- o usuario nao sabe que nao deve separar as casas
-- decimais com "," ao inves de ".", mas isso pode
-- ser facilmente concertado ao fazer:
-- variavelString.replace(",", ".");

-- AULA 1
-- comentários
-- a linha abaixo cria um bd
create database dbinfox;
create database gxg;
-- a linha abaixo escolhe o bd a ser utilizado
use dbinfox;
-- criando uma tabela
create table tbusuarios(
	iduser int primary key,
    -- varchar: tipo de dados que aceita qualquer caractere
    fone varchar(25),
    -- not null: obriga o preenchimento do campo
    usuario varchar(50) not null,
    -- unique: nao permite dois login iguais
    login varchar(15) not null unique,
    senha varchar(15) not null
);
-- a linha abaixo descreve a tabela
describe tbusuarios;
-- a linha abaixo insere dados na tabela (CRUD)
-- (CRUD) Create Read Update Delete
-- as 4 operações básicas para a manipulação de dados
-- create -> insert
insert into tbusuarios(iduser, fone, usuario, login, senha)
 values (1, '+55 (24) 99976-2839', '422UR4H', 'Azzurah', '123');
-- a linha abaixo exibe os dados da tabela (CRUD)
-- read -> select
select * from tbusuarios;

-- criando mais 2 usuarios
-- segundo
insert into tbusuarios(iduser, fone, usuario, login, senha)
 values (2, '+55 (24) 99976-2839', 'segundo', 'segundo', '123');
-- terceiro
insert into tbusuarios(iduser, fone, usuario, login, senha)
 values (3, '+55 (24) 99976-2839', 'terceiro', 'terceiro', '123');
-- a linha abaixo modifica dados na tabela
-- update -> update
-- modificando fone do usuario de iduser 2 na tabela de usuarios
update tbusuarios set fone = '+32 (33) 555-3553' where iduser = 2;

-- a linha abaico apaga um registro da tabela
-- delete -> delete
-- apagando o registro do usuario de iduser 3
delete from tbusuarios where iduser = 3;

select * from tbusuarios;

-- IMPORTANTE:
-- vamos alterar a tabela tbusuarios, mudando
-- usuario varchar(50) para usuario varchar(40) not null
alter table tbusuarios
modify column usuario varchar(40) not null;

-- alterando o nome de usuario para user
alter table tbusuarios
change column usuario user varchar(20);

-- deletando uma coluna
alter table tbusuarios
drop column usuario;

-- alterando o nome da tabela inteira
alter table tbusuarios
rename to tbusuario;

-- criando a coluna descrição em tbusuarios
alter table tbusuarios
add column descricao text;

-- criando uma tabela que entende acentuação, etc.
create table acentos(
	nomeTexto varchar(20),
    descricao text,
    texto text
) default charset = utf8;

-- apagando toda uma tabela (não sua estrutura)
truncate table acentos;


-- AULA 2: (Cadastro de Clientes)
create table tbclientes(
	-- como teremos muitos clientes, geraremos id automaticos
	-- auto_increment: incrementa automaticamente idclient
	idclient int primary key auto_increment,
    nomeclient varchar(50) not null,
    enderecoclient varchar(100),
    foneclient varchar(50) not null,
    emailclient varchar(50)
);

describe tbclientes;

insert into tbclientes(nomeclient, enderecoclient, foneclient, emailclient)
 values('Azzulah', 'Av. A, 742, Acude 2', '+99 (99) 99999-9999', 'azzulah@gmail.com');

select * from tbclientes;


-- AULA 4: (Tabela Ordem de Serviço)
create table tbos(
	-- criando a chave primaria os automaticamente
    -- a chave primaria para identificar o "acesso" do cliente
	os int primary key auto_increment,
    -- falando para o mysql gerar data e hora automaticamente quando houver um insert aqui
    -- tecnicamente: puxando a data e hora do servidor e inserindo no campo os_data
    -- criando campo chamado os_data do tipo timestamp e definindo valor padrão como
    -- a hora atual (current) através do comando current_timestamp
    os_data timestamp default current_timestamp,
    equipamento varchar(150) not null,
    defeito varchar(150) not null,
    servico varchar(150),
    tecnico varchar(100),
    valor decimal(10,2),
    -- chave estrangeira que servirá para puxar os dados do cliente cadastrado
	idclient int not null,
	-- o tipo de dados de idclient acima deve ser igual ao do da tbclientes
	-- a linha abaixo constroi o relacionamento dos clientes
	foreign key(idclient) references tbclientes(idclient)
);

describe tbos;

-- como idclient é not null, ele DEVE ser inserido no bd, ou um erro será gerado
insert into tbos(equipamento, defeito, servico, tecnico, valor, idclient)
values ('notebook', 'nao liga', 'troca da fonte', 'cristina', 88.98, 2);


-- o codigo abaixo traz informacoes de duas tabelas
select
	-- criando variavel O e inserindo os campos entre as vírgulas
	O.os,equipamento,defeito,servico,valor,
    -- criando variavel C que representará a tabela de clientes e inserindo os 2 campos
    C.nomeclient,foneclient
-- vinculando tbos com O
from tbos as O
-- unindo isso à tabela de clientes, e vinculando essa tabela à C
inner join tbclientes as C
-- unindo O com C onde idclient de O for igual ao idclient de C
on (O.idclient = C.idclient);


-- adicionando um campo (uma coluna), chamada perfil, à tbusuarios
alter table tbusuarios add column perfil varchar(20) not null;
-- a linha abaixo remove um campo (uma coluna) da tabela
-- alter table tbusuarios drop column perfil;

-- setando os perfis que faltam
update tbusuarios
set perfil = 'user'
where iduser = 2;

select * from tbusuarios;



