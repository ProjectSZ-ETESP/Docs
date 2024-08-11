
CREATE TABLE tblUsuario (
idUsuario int PRIMARY KEY AUTO_INCREMENT,
email varchar(50) NOT NULL,
senha varchar(30) NOT NULL
);
CREATE INDEX xUsuario ON tblUsuario (idUsuario);

CREATE TABLE tblHospital (
cnpj char(14) PRIMARY KEY,
nomeHosp varchar(50) NOT NULL,
direcao varchar(50) NOT NULL,
descricaoHosp varchar(100) NOT NULL,
emailHosp varchar(50) NOT NULL,
endereco varchar(100) NOT NULL,
horarioHosp varchar(50),
foneHosp char(11)
);
CREATE INDEX xHospital ON tblHospital (cnpj);

CREATE TABLE tblPaciente (
idPaciente int PRIMARY KEY AUTO_INCREMENT,
idUsuario int,
cpfPaciente char(11) NOT NULL,
nomePaciente varchar(50) NOT NULL,
sexoPaciente char(1) NOT NULL,
dataNascPaciente date NOT NULL,
fonePaciente char(11),
fotoPaciente varbinary(8000),

CONSTRAINT fk_PacienteUsuario FOREIGN KEY (idUsuario)
	REFERENCES tblUsuario (idUsuario)
);
CREATE INDEX xPaciente ON tblPaciente (idPaciente, idUsuario);

CREATE TABLE tblFuncionario (
cpfFuncionario char(11) PRIMARY KEY,
idUsuario int,
cnpj char(14),
nomeFuncionario varchar(50) NOT NULL,
sexoFuncionario char(1) NOT NULL,
foneFuncionario char(11),
fotoFuncionario varbinary(8000),

CONSTRAINT fk_FuncionarioUsuario FOREIGN KEY (idUsuario)
	REFERENCES tblUsuario (idUsuario),
CONSTRAINT fk_FuncionarioHospital FOREIGN KEY (cnpj)
	REFERENCES tblHospital (cnpj)
);
CREATE INDEX xFuncionario ON tblFuncionario (cpfFuncionario, idUsuario, cnpj);

CREATE TABLE tblMedico (
crm char(6) PRIMARY KEY,
cnpj char(14),
nomeMedico varchar(50) NOT NULL,
tipoMedico varchar(50) NOT NULL,
emailMedico varchar(50) NOT NULL,
sexoMedico char(1) NOT NULL,
dataNascMedico date NOT NULL,
foneMedico char(11),

CONSTRAINT fk_HospitalMedico FOREIGN KEY (cnpj)
	REFERENCES tblHospital (cnpj)
);
CREATE INDEX xMedico ON tblMedico (crm, cnpj);

CREATE TABLE tblConsulta (
idConsulta int PRIMARY KEY AUTO_INCREMENT,
cnpj char(14),
crm char(6),
idPaciente int,
dataConsulta date NOT NULL,
horaConsulta time NOT NULL,
preConsulta varchar(256),

CONSTRAINT fk_HospitalConsulta FOREIGN KEY (cnpj)
	REFERENCES tblHospital (cnpj),
CONSTRAINT fk_MedicoConsulta FOREIGN KEY (crm)
	REFERENCES tblMedico (crm),
CONSTRAINT fk_idPacienteConsulta FOREIGN KEY (idPaciente)
	REFERENCES tblPaciente (idPaciente)
);
CREATE INDEX xConsulta ON tblConsulta (idConsulta, cnpj, crm, idPaciente);

CREATE TABLE tblProntuario (
idProntuario int PRIMARY KEY AUTO_INCREMENT,
idConsulta int,
descricao varchar(200) NOT NULL,
receituario varchar(100) NOT NULL,

CONSTRAINT fk_ConsultaProntuario FOREIGN KEY (idConsulta)
	REFERENCES tblConsulta (idConsulta)
);
CREATE INDEX xProntuario ON tblProntuario (idProntuario, idConsulta);

CREATE TABLE tblDisponibilidade (
idDisponibilidade int PRIMARY KEY AUTO_INCREMENT,
cnpj char(14),
dataDisponivel date,
descricao varchar(100) NOT NULL,

CONSTRAINT fk_HospitalDisponibilidade FOREIGN KEY (cnpj)
	REFERENCES tblHospital (cnpj)
);
CREATE INDEX xDisponibilidade ON tblDisponibilidade (idDisponibilidade, cnpj);



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_cadastroUser`(
    IN p_email VARCHAR(50),
    IN p_senha VARCHAR(30),
    OUT p_retorno INT UNSIGNED
)
BEGIN
    IF (SELECT COUNT(*) FROM tblUsuario WHERE email = p_email) = 0 THEN
        INSERT INTO tblUsuario (email, senha) VALUES (p_email, p_senha);
        SET p_retorno = (SELECT idUsuario FROM tblUsuario WHERE email = p_email);
    ELSE
        SET p_retorno = 0;
    END IF;
END$$
DELIMITER;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_cadastroPac`(
    IN p_idUsuario INT,
    IN p_cpf CHAR(14),
    IN p_nome VARCHAR(50),
    IN p_sexo CHAR(1),
    IN p_dataNasc DATE,
    IN p_fone CHAR(15)
)
BEGIN

    INSERT INTO tblPaciente (
        idUsuario, 
        cpfPaciente, 
        nomePaciente, 
        sexoPaciente, 
        dataNascPaciente, 
        fonePaciente
    ) VALUES (
        p_idUsuario, 
        p_cpf, 
        p_nome, 
        p_sexo, 
        p_dataNasc, 
        p_fone
    );
END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_loginPac`(
    IN p_email VARCHAR(50),
    IN p_senha VARCHAR(30),
    OUT p_retorno INT
)
BEGIN
    IF (SELECT COUNT(*) 
        FROM tblUsuario 
        WHERE email = p_email 
          AND idUsuario IN (SELECT idUsuario FROM tblPaciente)) > 0 THEN
        SET p_retorno = (SELECT idUsuario 
                         FROM tblUsuario 
                         WHERE email = p_email);
    ELSE
        SET p_retorno = 0;
    END IF;
END$$
DELIMITER ;
