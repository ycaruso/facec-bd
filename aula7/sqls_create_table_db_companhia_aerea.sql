-- 1 Criar o Voo
create table voo (
	num_voo int primary key,
	companhia_aerea varchar(50) not null,
	data_hora timestamp not null
);

-- 2 Criar o Aeroporto
create table aeroporto (
	cod_aeroporto int primary key,
	nome varchar(50) unique,
	cidade varchar(30) not null,
	estado char(2) not null
);

-- 3) Trecho contém um Voo com inicio no aerporto X as XX horas até o aeroporto Y as YY horas;
create table trecho (
	num_voo int, -- não precisa colocar not null
	num_trecho int, -- idem ao de cima
	cod_aeroporto_ini int not null,
	hora_ini timestamp not null,
	cod_aeroporto_fim int not null,
	hora_fim timestamp not null,
	primary key (num_voo, num_trecho),
	foreign key (num_voo) references voo(num_voo),
	foreign key (cod_aeroporto_ini) references aeroporto(cod_aeroporto),
	foreign key (cod_aeroporto_fim) references aeroporto(cod_aeroporto)
);


-- 4) Criar o modelo de aeronave
create table modelo_aeronave (
	nome_modelo char(10) primary key,
	max_assentos int not null,
	empresa varchar(50) not null
);

-- 5) Criar a Aeronave que possui um modelo
create table aeronave (
	cod_aeronave int primary key,
	num_assentos smallint not null,
	nome_modelo char(10),
	foreign key (nome_modelo) references modelo_aeronave(nome_modelo)
);

-- 6) Criar o Trecho Sobrevoado que depende do Trecho, Aeronave e aeroportos
create table trecho_sobrevoado (
	num_voo int,
	num_trecho int,
	data date not null,
	num_assentos_disp smallint not null,
	cod_aeronave int not null,
	cod_aeroporto_ini int not null,
	hora_ini timestamp not null,
	cod_aeroporto_fim int not null,
	hora_fim timestamp not null,
	primary key (num_voo, num_trecho, data),
	-- referência a 2 atributos da tabela trecho
	foreign key (num_voo, num_trecho) references trecho(num_voo, num_trecho),
	foreign key (cod_aeronave) references aeronave(cod_aeronave),
	foreign key (cod_aeroporto_ini) references aeroporto(cod_aeroporto),
	foreign key (cod_aeroporto_fim) references aeroporto(cod_aeroporto)
);

-- 7) Para cada trecho sobrevoado existem varias reservas de assento
create table reserva_assento (
	num_voo int,
	num_trecho int,
	data date,
	num_assento smallint not null,
	nome_cliente varchar(50) not null,
	telefone_cliente varchar(20) not null,
	primary key (num_voo, num_trecho, data, num_assento),
	-- 3 chaves estrangeiras da tabela trecho_sobrevoado
	foreign key (num_voo, num_trecho, data) references trecho_sobrevoado(num_voo, num_trecho, data)
);

-- 8) Para Cada voo são mantidas tarifas
create table tarifa (
	num_voo int,
	cod_tarifa int,
	qtde int,
	restricoes varchar(255),
	primary key (num_voo, cod_tarifa),
	foreign key (num_voo) references voo(num_voo)
);

-- 9) Dependendo do modelo de avião é verificado se pode pousar em um aeroporto
create table pode_pousar (
	nome_modelo char(10),
	cod_aeroporto int,
	primary key (nome_modelo, cod_aeroporto),
	foreign key (nome_modelo) references modelo_aeronave(nome_modelo),
	foreign key (cod_aeroporto) references aeroporto(cod_aeroporto)
);
