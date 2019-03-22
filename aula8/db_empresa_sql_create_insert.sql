drop table if exists funcionario cascade;
drop table if exists departamento cascade;
drop table if exists localizacoes_departamento cascade;
drop table if exists projeto cascade;
drop table if exists trabalha_em cascade;
drop table if exists dependente cascade;

-- 1) Criar Funcionário
create table funcionario (
    primeiro_nome varchar(15) not null,
    nome_meio char,
    ultimo_nome varchar(15) not null,
    cpf char(11) primary key,
    dt_nascimento date,
    endereco varchar(30),
    sexo char,
    salario decimal(10,2),
    cpf_supervisor char(11),
    num_depto int not null,
    ativo int default 1
);

-- 2)  Criar tabela departamento
create table departamento (
    nome_departamento varchar(15) not null,
    num_depto int not null,
    cpf_gerente char(11) not null,
    data_inicio_gerente date,
    primary key (num_depto),
    unique (nome_departamento),
    foreign key (cpf_gerente) 
        references funcionario(cpf)
);

-- 3) incluir os funcionários
insert 
    into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, dt_nascimento, endereco, sexo, salario, cpf_supervisor, num_depto, ativo) 
values 
    ('Paulo', 'A', 'Lima', '98765432112', '1971-12-12', 'Rua XIX de Novembro', 'M', 20000, null, 1,1),
    ('Alessandro', 'P', 'Souza', '12345678912', '1985-05-30', 'Rua Joaquim Barbosa', 'M', 2000, '98765432112', 1,1),
    ('Fernando', 'B', 'Castro', '91875163905', '2000-06-06', 'Rua Sao Jorge', 'M', 1800, '98765432112', 1,1),
    ('Felipe', 'C', 'Estevanato', '81457787946', '2002-08-14', 'Rua Santos Dumont (306)', 'M', 1800, '98765432112', 1,1),
    ('Arnaldo', 'D', 'Silva', '88070527927', '1998-01-19', 'Rua Espirito Santo (298)', 'M', 1800, '98765432112', 1,1),
    ('Ana', 'E', 'Ferreira', '02735545903', '2006-02-24', 'Rua Primeiro de Maio', 'F', 9000, '98765432112', 2,1),
    ('Maria', 'F', 'Aparecida', '56510547902', '1996-11-06', 'Rua Santa Rita', 'F', 1500, '02735545903', 2,1),
    ('José', 'G', 'Serante', '95782883952', '1996-10-27', 'Rua Goias', 'M', 1500, '02735545903', 2,1),
    ('Alfredo', 'B', 'Soares', '30801450977', '1991-10-23', 'Rua Das Flores', 'M', 1500, '02735545903', 2,0),
    ('Paulo', 'A', 'Filho', '33005893987', '1997-05-12', 'Rua Mato Grosso', 'M', 1750, '02735545903', 2,1),
    ('Diego', 'O', 'Ferreira', '92386274950', '1972-10-18', 'Rua Treze De Maio', 'M', 10500, '98765432112', 3,1),
    ('Guilherme', 'V', 'Nunes', '28594085923', '1993-02-11', 'Rua Da Paz', 'M', 2000, '92386274950', 3,1),
    ('Lucas', null, 'Abreu', '97403321960', '1991-04-09', 'Rua Castro Alves', 'M', 1855, '92386274950', 3,0),
    ('Heverton', null, 'Machado', '53200589930', '1996-04-07', 'Rua Bahia', 'M', 2150, '92386274950', 3,1),
    ('Henrique', 'P', 'Duarte', '67340385991', '1985-04-10', 'Rua Sete de Setembro', 'M', 1900, '92386274950', 3,1),
    ('Mario', 'Z', 'Vargas', '09421362926', '1987-05-25', 'Rua Sao Pedro', 'M', 1850, '92386274950', 3,1),
    ('Jessica', 'S', 'Lins', '90139762981', '2004-08-11', 'Rua São José', 'F', 1500, '92386274950', 3,0),
    ('Lorena', null, 'Ribeiro', '26245505933', '1994-10-20', 'Rua São Paulo', 'F', 1500, '92386274950', 3,1),
    ('Janete', 'F', 'Gonçalvez', '58609404919', '1992-03-06', 'Rua Amazonas', 'F', 1300, '92386274950', 3,1),
    ('Thiago', 'C', 'Trindade', '98463859941', '1998-05-10', 'Rua Duque De Caxias', 'M', 1300, '92386274950', 3,1),
    ('Alan', 'A', 'Oliveira', '91263853941', '1986-07-25', 'Rua das Flores', 'M', 5000, '98765432112', 4,1),
    ('Diego', null, 'Saturnino', '97463853142', '1999-05-10', 'Rua Cristovao Colombo', 'M', 1800, '91263853941', 4,1)
;

-- 4) Inserir os departamentos
insert 
    into departamento (nome_departamento, num_depto, cpf_gerente, data_inicio_gerente)
values 
    ('Matriz', 1, '98765432112', '2003-04-20'),
    ('Administração', 3, '92386274950', '2007-06-30'),
    ('Financeiro', 2, '02735545903', '2008-05-16'),
    ('TI', 4, '91263853941', '2010-06-22')
;

-- 5) incluir as chaves estrangeiras na tabela funcionário
ALTER TABLE funcionario 
    ADD CONSTRAINT funcionario_supervisor_fk 
        FOREIGN KEY (cpf_supervisor) REFERENCES funcionario(cpf);
ALTER TABLE funcionario 
    ADD CONSTRAINT funcionario_departamento_fk 
        FOREIGN KEY (num_depto) REFERENCES departamento(num_depto);

-- 6) criar tabela localizações departamento
create table localizacoes_departamento (
    num_depto int not null,
    local varchar(15),
    primary key (num_depto, local),
    foreign key (num_depto) references departamento(num_depto)
);

-- 7) Insert Localizações
insert into 
    localizacoes_departamento (num_depto, local)
values
    (1, 'Cianorte'),
    (2, 'Cianorte'),
    (3, 'Cianorte'),
    (3, 'Maringa'),
    (3, 'Curitiba'),
    (4, 'Curitiba'),
    (4, 'Cianorte'),
    (4, 'Maringa')
;

-- 8) Projeto
create table projeto (
    num_projeto int primary key,
    nome_projeto varchar(50) not null,
    local_projeto varchar(15),
    num_depto int not null,
    foreign key (num_depto,local_projeto) 
        references localizacoes_departamento(num_depto,local)
);

-- 9) Insere projetos
insert into
    projeto(nome_projeto, num_projeto, local_projeto, num_depto)
values
    ('ProdutoX', 1, 'Cianorte', 1),
    ('ProdutoY', 2, 'Cianorte', 1),
    ('ProdutoZ', 3, 'Cianorte', 1),
    ('Software para Admnistração', 10, 'Cianorte', 4),
    ('Software para Envio de Guias Financeiro', 20, 'Cianorte', 4),
    ('Automação de envio de relatórios', 30, 'Maringa', 4),
    ('Levantar Contas a Receber de Clientes', 31, 'Cianorte', 2),
    ('Reorganização', 32, 'Cianorte', 3)
;

-- 10) Cria tabela trabalha_em
create table trabalha_em (
    cpf_funcionario char(11),
    num_projeto int not null,
    horas decimal(5,1) not null,
    primary key (cpf_funcionario, num_projeto),
    foreign key (cpf_funcionario) references funcionario(cpf),
    foreign key (num_projeto) references projeto(num_projeto)
);

-- 11) Popular tabela trabalha_em
insert into trabalha_em
values
    -- Alan gerente departamento TI
    ('91263853941',10,16.5),
    ('91263853941',20,20.5),
    ('91263853941',30,9),
    -- Diego Funcionario Depto TI
    ('97463853142',10,30.5),
    ('97463853142',20,36),
    ('97463853142',30,20),
    -- Paulo gerente geral
    ('98765432112', 1, 4),
    ('98765432112', 2, 5),
    ('98765432112', 3, 4.5),
    ('98765432112', 10, 2.5),
    ('98765432112', 20, 1.5),
    ('98765432112', 30, 1),
    -- Alessandro
    ('12345678912', 1, 15),
    ('12345678912', 2, 15.5),
    ('12345678912', 3, 14.5),
    -- Fernando
    ('91875163905', 1, 17.5),
    ('91875163905', 2, 18.5),
    ('91875163905', 3, 19),
    -- Felipe
    ('81457787946', 1, 17.5),
    ('81457787946', 2, 18),
    ('81457787946', 3, 22),
    -- Arnaldo
    ('88070527927', 1, 14),
    ('88070527927', 2, 21),
    ('88070527927', 3, 26)
;

-- 12) Criar tabela dependente
create table dependente (
    cpf_funcionario char(11),
    nome_dependente varchar(50) not null,
    sexo char(1) not null,
    dt_nascimento date not null,
    -- F => filho, A => filha, E => esposa, M => marido
    parentesco char(1) not null 
        check (parentesco in ('F', 'A', 'E', 'M')), 
    primary key (cpf_funcionario, nome_dependente),
    foreign key (cpf_funcionario) references funcionario(cpf)
);

-- 13) Inserir dados tabela dependente
insert into dependente
values
    ('98765432112','Alicia', 'F', '2011-08-14','A'),
    ('98765432112','Tiago', 'M', '2009-11-22','F'),
    ('98765432112','Janaina', 'M', '1979-06-12','E')
;