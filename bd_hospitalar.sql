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
CREATE TABLE tblPaciente (
cpfPaciente char(11) PRIMARY KEY,
nomePaciente varchar(100) NOT NULL,
emailPaciente varchar(256) NOT NULL,
sexoPaciente char(1) NOT NULL,
dataNascPaciente date NOT NULL,
fonePaciente char(11),
fotoPaciente varbinary(max),
senhaPaciente varchar(50) NOT NULL
)
go
CREATE INDEX xPaciente ON tblPaciente (cpfPaciente)
go

go
CREATE TABLE tblHospital (
cnpj char(14) PRIMARY KEY,
nomeHosp varchar(100) NOT NULL,
diretor varchar(100) NOT NULL,
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
CREATE TABLE tblTipoFunc (
idTipoFunc int PRIMARY KEY,
descricaoTipoFunc varchar(256) NOT NULL
)
go
CREATE INDEX xTipoFunc ON tblTipoFunc (idTipoFunc)
go

go
CREATE TABLE tblFuncionario (
cpfFunc char(11) PRIMARY KEY,
cnpj char(14),
idTipoFunc int,
nomeFunc varchar(100) NOT NULL,
emailFunc varchar(256) NOT NULL,
sexoFunc char(1) NOT NULL,
dataNascFunc date NOT NULL,
foneFunc char(11),
fotoFunc varbinary(max),
senhaFunc varchar(50) NOT NULL,

CONSTRAINT FK_cnpjFunc FOREIGN KEY (cnpj)
	REFERENCES tblHospital (cnpj),
CONSTRAINT FK_idTipoFunc FOREIGN KEY (idTipoFunc)
	REFERENCES tblTipoFunc (idTipoFunc)
)
go
CREATE INDEX xFuncionario ON tblFuncionario (cpfFunc, cnpj)
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
cpfPaciente char(11),
dataConsulta date NOT NULL,
horacConsulta time NOT NULL,

CONSTRAINT FK_cnpjConsulta FOREIGN KEY (cnpj)
	REFERENCES tblHospital (cnpj),
CONSTRAINT FK_crm FOREIGN KEY (crm)
	REFERENCES tblMedico (crm),
CONSTRAINT FK_cpfPacienteCons FOREIGN KEY (cpfPaciente)
	REFERENCES tblPaciente (cpfPaciente)
)
go
CREATE INDEX xConsulta ON tblConsulta (idConsulta, cnpj, crm, cpfPaciente)
go

go
CREATE TABLE tblProntuario ( -- faltam mais coisas
idProntuario int PRIMARY KEY IDENTITY,
cpfPaciente char(11),
idConsulta int,
receituario varchar(256),
atestado varchar(256),
descricao varchar(256) NOT NULL,

CONSTRAINT FK_cpfPacientePront FOREIGN KEY (cpfPaciente)
	REFERENCES tblPaciente (cpfPaciente),
CONSTRAINT FK_consulta FOREIGN KEY (idConsulta)
	REFERENCES tblConsulta (idConsulta)
)
go
CREATE INDEX xProntuario ON tblProntuario (idProntuario, cpfPaciente, idConsulta)
go

go
CREATE TABLE tblForum (
idForum int PRIMARY KEY IDENTITY,
nomeForum varchar(100) NOT NULL,
descricaoForum varchar(256) NOT NULL,
dataCria date NOT NULL
)
go
CREATE INDEX xForum ON tblForum (idForum)
go

go
CREATE TABLE tblPostagem (
idPostagem int PRIMARY KEY IDENTITY,
cpfPaciente char(11),
idForum int,
mensagem varchar(256) NOT NULL,
dataPostagem date NOT NULL,
horaPostagem time NOT NULL,

CONSTRAINT FK_cpfPacientePost FOREIGN KEY (cpfPaciente)
	REFERENCES tblPaciente (cpfPaciente),
CONSTRAINT FK_idForumPost FOREIGN KEY (idForum)
	REFERENCES tblForum (idForum)
)
go
CREATE INDEX xPostagem ON tblPostagem (idPostagem, cpfPaciente, idForum)
go

go
CREATE TABLE tblResposta (
idResposta int PRIMARY KEY IDENTITY,
idPostagem int,
idForum int,
cpfFunc char(11),
mensagem varchar(256) NOT NULL,
dataResposta date NOT NULL,
horaResposta time NOT NULL,

CONSTRAINT FK_postagem FOREIGN KEY (idPostagem)
	REFERENCES tblPostagem (idPostagem),
CONSTRAINT FK_cpfFuncionario FOREIGN KEY (cpfFunc)
	REFERENCES tblFuncionario (cpfFunc),
CONSTRAINT FK_idForumResp FOREIGN KEY (idForum)
	REFERENCES tblForum (idForum)
)
go
CREATE INDEX xResposta ON tblResposta (idResposta, idPostagem, cpfFunc, idForum)
go
