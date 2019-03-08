create table funcionario (
    primeiro_nome varchar(15) not null,
    nome_meio char,
    ultimo_nome varchar(15) not null,
    cpf char(11) not null,
    dt_nascimento date,
    endereco varchar(30),
    sexo char,
    salario decimal(10,2),
    cpf_supervisor char(11),
    numero_departamento int not null,
    ativo int default 1,
    primary key (cpf)
);

insert 
    into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, dt_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento, ativo) 
values 
    ('Paulo', 'A', 'Lima', '98765432112', '1971-12-12', 'Rua XIX de Novembro', 'M', 25000, null, 1,1),
    ('Alessandro', 'P', 'Souza', '12345678912', '1985-05-30', 'Rua Joaquim Barbosa', 'M', 2000, '98765432112', 1,1),
    ('Fernando', 'B', 'Castro', '91875163905', '2000-06-06', 'Rua Sao Jorge', 'M', 1800, '98765432112', 1,1),
    ('Felipe', 'C', 'Estevanato', '81457787946', '2002-08-14', 'Rua Santos Dumont (306)', 'M', 1800, '98765432112', 1,1),
    ('Arnaldo', 'D', 'Silva', '88070527927', '1998-01-19', 'Rua Espirito Santo (298)', 'M', 1800, '98765432112', 1,1),
    
    ('Ana', 'E', 'Ferreira', '02735545903', '2006-02-24', 'Rua Primeiro de Maio', 'F', 9000, '98765432112', 2,1),
    ('Maria', 'F', 'Aparecida', '56510547902', '1996-11-06', 'Rua Santa Rita', 'F', 1500, '02735545903', 2,1),
    ('José', 'G', 'Serante', '95782883952', '1996-10-27', 'Rua Goias', 'M', 1500, '02735545903', 2,1),
    ('Alfredo', 'D', 'Soares', '30801450977', '1991-10-23', 'Rua Das Flores', 'M', 1500, '02735545903', 2,0),
    ('Paulo', 'A', 'Filho', '33005893987', '1997-05-12', 'Rua Mato Grosso', 'M', 1750, '02735545903', 2,1),
    
    ('Diego', 'O', 'Ferreira', '92386274950', '1972-10-18', 'Rua Treze De Maio', 'M', 10500, '98765432112', 3,1),
    ('Guilherme', 'V', 'Nunes', '28594085923', '1993-02-11', 'Rua Da Paz', 'M', 2000, '92386274950', 3,1),
    ('Lucas', 'R', 'Abreu', '97403321960', '1991-04-09', 'Rua Castro Alves', 'M', 1855, '92386274950', 3,0),
    ('Heverton', 'M', 'Machado', '53200589930', '1996-04-07', 'Rua Bahia', 'M', 2150, '92386274950', 3,1),
    ('Henrique', 'P', 'Duarte', '67340385991', '1985-04-10', 'Rua Sete de Setembro', 'M', 1900, '92386274950', 3,1),
    ('Mario', 'Z', 'Vargas', '09421362926', '1987-05-25', 'Rua Sao Pedro', 'M', 1850, '92386274950', 3,1),
    ('Jessica', 'S', 'Lins', '90139762981', '2004-08-11', 'Rua São José', 'F', 1500, '92386274950', 3,0),
    ('Lorena', 'M', 'Ribeiro', '26245505933', '1994-10-20', 'Rua São Paulo', 'F', 1500, '92386274950', 3,1),
    ('Janete', 'F', 'Gonçalvez', '58609404919', '1992-03-06', 'Rua Amazonas', 'F', 1300, '92386274950', 3,1),
    ('Thiago', 'C', 'Trindade', '98463859941', '1998-05-10', 'Rua Duque De Caxias', 'M', 1300, '92386274950', 3,1)
;