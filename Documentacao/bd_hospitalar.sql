USE master
go
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'sistemaHospitalar')
	DROP DATABASE sistemaHospitalar
go
CREATE DATABASE sistemaHospitalar
go
USE sistemaHospitalar
go

go
CREATE TABLE tblUsuario (
idUsuario int PRIMARY KEY IDENTITY(1,1),
email varchar(100) NOT NULL,
senha varchar(50) NOT NULL
)
go
CREATE INDEX xUsuario ON tblUsuario (idUsuario)
go

go
CREATE TABLE tblHospital (
cnpj char(14) PRIMARY KEY,
nomeHosp varchar(100) NOT NULL,
direcao varchar(100) NOT NULL,
descricaoHosp varchar(256) NOT NULL,
emailHosp varchar(256) NOT NULL,
endereco varchar(256) NOT NULL,
horarioHosp varchar(100),
foneHosp char(11)
)
go
CREATE INDEX xHospital ON tblHospital (cnpj)
go

go
CREATE TABLE tblPaciente (
idPaciente int PRIMARY KEY IDENTITY(1,1),
idUsuario int,
cpfPaciente char(11) NOT NULL,
nomePaciente varchar(100) NOT NULL,
sexoPaciente char(1) NOT NULL,
dataNascPaciente date NOT NULL,
fonePaciente char(11),
fotoPaciente varbinary(max),

CONSTRAINT fk_PacienteUsuario FOREIGN KEY (idUsuario)
	REFERENCES tblUsuario (idUsuario)
)
go
CREATE INDEX xPaciente ON tblPaciente (idPaciente, idUsuario)
go

go
CREATE TABLE tblFuncionario (
cpfFuncionario char(11) PRIMARY KEY,
idUsuario int,
cnpj char(14),
nomeFuncionario varchar(100) NOT NULL,
sexoFuncionario char(1) NOT NULL,
foneFuncionario char(11),
fotoFuncionario varbinary(max),

CONSTRAINT fkFuncionarioUsuario FOREIGN KEY (idUsuario)
	REFERENCES tblUsuario (idUsuario),
CONSTRAINT fkFuncionarioHospital FOREIGN KEY (cnpj)
	REFERENCES tblHospital (cnpj)
)
go
CREATE INDEX xFuncionario ON tblFuncionario (cpfFuncionario, idUsuario, cnpj)
go

go
CREATE TABLE tblMedico (
crm char(6) PRIMARY KEY,
cnpj char(14),
nomeMedico varchar(100) NOT NULL,
tipoMedico varchar(256) NOT NULL,
emailMedico varchar(256) NOT NULL,
sexoMedico char(1) NOT NULL,
dataNascMedico date NOT NULL,
foneMedico char(11) NOT NULL,

CONSTRAINT FK_cnpjMedico FOREIGN KEY (cnpj)
	REFERENCES tblHospital (cnpj)
)
go
CREATE INDEX xMedico ON tblMedico (crm, cnpj)
go

go
CREATE TABLE tblConsulta (
idConsulta int PRIMARY KEY IDENTITY,
cnpj char(14),
crm char(6),
idPaciente int,
dataConsulta date NOT NULL,
horaConsulta time NOT NULL,
preConsulta varchar(256) -- considerar se mantém ou não

CONSTRAINT FK_cnpjConsulta FOREIGN KEY (cnpj)
	REFERENCES tblHospital (cnpj),
CONSTRAINT FK_crm FOREIGN KEY (crm)
	REFERENCES tblMedico (crm),
CONSTRAINT FK_idPacienteCons FOREIGN KEY (idPaciente)
	REFERENCES tblPaciente (idPaciente)
)
go
CREATE INDEX xConsulta ON tblConsulta (idConsulta, cnpj, crm, idPaciente)
go

go
CREATE TABLE tblProntuario (
idProntuario int PRIMARY KEY IDENTITY,
idConsulta int,
descricao varchar(256) NOT NULL,
receituario varchar(256),

CONSTRAINT FK_consulta FOREIGN KEY (idConsulta)
	REFERENCES tblConsulta (idConsulta)
)
go
CREATE INDEX xProntuario ON tblProntuario (idProntuario, idConsulta)
go

go
CREATE TABLE tblDisponibilidade (
idDisponibilidade int PRIMARY KEY IDENTITY,
cnpj char(14),
dataIndisponivel date,
descricao varchar(256) NOT NULL,

CONSTRAINT FK_disponHospital FOREIGN KEY (cnpj)
	REFERENCES tblHospital (cnpj)
)
go
CREATE INDEX xDisponibilidade ON tblDisponibilidade (idDisponibilidade, cnpj)
go