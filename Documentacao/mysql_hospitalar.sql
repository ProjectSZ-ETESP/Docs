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
tipoSanguineo varchar(3),
condicoesMedicas varchar(50),
fonePaciente char(11),
fotoPaciente char(1),

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
fotoFuncionario char(1),

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
tipoConsulta varchar(50) NOT NULL,
dataConsulta date NOT NULL,
horaConsulta time NOT NULL,

CONSTRAINT fk_HospitalConsulta FOREIGN KEY (cnpj)
	REFERENCES tblHospital (cnpj),
CONSTRAINT fk_MedicoConsulta FOREIGN KEY (crm)
	REFERENCES tblMedico (crm),
CONSTRAINT fk_idPacienteConsulta FOREIGN KEY (idPaciente)
	REFERENCES tblPaciente (idPaciente)
);
CREATE INDEX xConsulta ON tblConsulta (idConsulta, cnpj, crm, idPaciente);

CREATE TABLE tblPendente (
idPendente int PRIMARY KEY AUTO_INCREMENT,
idPaciente int,
cnpj char(14),
dataPendente date,
horaPendente time,
descPaciente varchar(500),

CONSTRAINT fk_PacientePendente FOREIGN KEY (idPaciente)
	REFERENCES tblPaciente (idPaciente),
CONSTRAINT fk_HospitalPendente FOREIGN KEY (cnpj)
	REFERENCES tblHospital (cnpj)
);
CREATE INDEX xPendente ON tblPendente (idPendente, idPaciente, cnpj);

CREATE TABLE tblNotificacao (
idNotificacao int PRIMARY KEY AUTO_INCREMENT,
idUsuario int,
idConsulta int,
tipoNotificacao varchar(50) NOT NULL,
textoNotificacao varchar(50) NOT NULL,
dataCriacao date NOT NULL,
horaCriacao time NOT NULL,
lida bit,

CONSTRAINT fk_UsuarioNotificacao FOREIGN KEY (idUsuario)
    REFERENCES tblUsuario (idUsuario),
CONSTRAINT fk_ConsultaNotificacao FOREIGN KEY (idConsulta)
    REFERENCES tblConsulta (idConsulta)
);
CREATE INDEX xNotificacao ON tblNotificacao (idNotificacao, idUsuario, idConsulta);

CREATE TABLE tblProntuario (
idProntuario int PRIMARY KEY AUTO_INCREMENT,
idConsulta int,
tipoConsulta varchar(50) NOT NULL,
descricao varchar(200) NOT NULL,
receituario varchar(100) NOT NULL,

CONSTRAINT fk_ConsultaProntuario FOREIGN KEY (idConsulta)
	REFERENCES tblConsulta (idConsulta)
);
CREATE INDEX xProntuario ON tblProntuario (idProntuario, idConsulta);

CREATE TABLE tblDisponibilidade (
idDisponibilidade int PRIMARY KEY AUTO_INCREMENT,
cnpj char(14),
dataIndisponivel date,
descricao varchar(100) NOT NULL,

CONSTRAINT fk_HospitalDisponibilidade FOREIGN KEY (cnpj)
	REFERENCES tblHospital (cnpj)
);
CREATE INDEX xDisponibilidade ON tblDisponibilidade (idDisponibilidade, cnpj);

INSERT INTO tblUsuario (email, senha) VALUES
    ('primeiro@gmail.com', '1'),
    ('segundo@gmail.com', '2'),
    ('terceiro@gmail.com', '3'),
    ('quarto@gmail.com', '4'),
    ('quinto@gmail.com', '5'),
    ('sexto@gmail.com', '6'),
    ('setimo@gmail.com', '7'),
    ('oitavo@gmail.com', '8'),
    ('nono@gmail.com', '9'),
    ('decimo@gmail.com', '10'),
    ('decimoprimeiro@gmail.com', '11'),
    ('decimosegundo@gmail.com', '12'),
    ('decimoterceiro@gmail.com', '13'),
    ('decimoquarto@gmail.com', '14'),
    ('decimoquinto@gmail.com', '15'),
    ('decimosexto@gmail.com', '16'),
    ('decimosetimo@gmail.com', '17'),
    ('decimooitavo@gmail.com', '18'),
    ('decimonono@gmail.com', '19'),
    ('vigesimo@gmail.com', '20');

INSERT INTO tblHospital VALUES
    ('11111111111111', 'Hospital Um', 'João Primeiro', 'Uma clínica de primeira', 'uno@gmail.com', 'Rua Primária, 1', 'segunda à sexta: 06:00-22:00', '11111111111'),
    ('22222222222222', 'Hospital Dois', 'João Segundo', 'Uma clínica de segunda', 'dos@gmail.com', 'Rua Secundária, 2', 'segunda à sexta: 06:00-22:00', '22222222222'),
    ('33333333333333', 'Hospital Três', 'João Terceiro', 'Uma clínica de terceira', 'tres@gmail.com', 'Rua Terciária, 3', 'segunda à sexta: 06:00-22:00', '33333333333'),
    ('44444444444444', 'Hospital Quatro', 'João Quarto', 'Uma clínica de quarta', 'quatro@gmail.com', 'Rua Quartenária, 4', 'segunda à sexta: 06:00-22:00', '44444444444'),
    ('55555555555555', 'Hospital Cinco', 'João Quinto', 'Uma clínica de quinta', 'cinque@gmail.com', 'Rua Quintenária, 5', 'segunda à sexta: 06:00-22:00', '55555555555'),
    ('66666666666666', 'Hospital Seis', 'João Sexto', 'Uma clínica de sexta', 'ses@gmail.com', 'Rua Senáris, 6', 'segunda à sexta: 06:00-22:00', '66666666666'),
    ('77777777777777', 'Hospital Sete', 'João Sétimo', 'Uma clínica de sétima', 'sete@gmail.com', 'Rua Setenário, 7', 'segunda à sexta: 06:00-22:00', '77777777777'),
    ('88888888888888', 'Hospital Oito', 'João Oitavo', 'Uma clínica de oitava', 'otcho@gmail.com', 'Rua Oitenária, 8', 'segunda à sexta: 06:00-22:00', '88888888888'),
    ('99999999999999', 'Hospital Nove', 'João Nono', 'Uma clínica de nona', 'nove@gmail.com', 'Rua Nomenárie, 9', 'segunda à sexta: 06:00-22:00', '99999999999'),
    ('10101010101010', 'Hospital Dez', 'João Décimo', 'Uma clínica de décima', 'dez@gmail.com', 'Rua Decenário, 10', 'segunda à sexta: 06:00-22:00', '10101010101');

INSERT INTO tblPaciente (idUsuario, cpfPaciente, nomePaciente, sexoPaciente, dataNascPaciente, tipoSanguineo, condicoesMedicas, fonePaciente, fotoPaciente) VALUES
    (1, '11111111111', 'Pacio Primeiro I', 'm', '2000-01-01', 'A+', 'virose', '11111111110', '1'),
    (2, '22222222222', 'Pacia Segunda II', 'f', '2000-01-01', 'B+', 'TDAH', '22222222220', '2'),
    (3, '33333333333', 'Pacio Terceiro III', 'm', '2000-01-01', 'AB', 'hemorragia interna pulmonar', '33333333330', '1'),
    (4, '44444444444', 'Pacia Quarta IV', 'f', '2000-01-01', 'A-', 'punturas na região do estômago', '44444444440', '3'),
    (5, '55555555555', 'Pacie Quinto V', 'm', '2000-01-01', 'A', 'fratura da clavícula', '55555555550', '4'),
    (6, '66666666666', 'Pacio Sexto VI', 'm', '2000-01-01', 'B', 'autismo', '66666666660', '1'),
    (7, '77777777777', 'Pacio Sétimo VII', 'm', '2000-01-01', 'A-', 'tumor no cérebro', '77777777770', '2'),
    (8, '88888888888', 'Pacia Oitava VIII', 'f', '2000-01-01', 'A+', 'dengue', '88888888880', '2'),
    (9, '99999999999', 'Pacia Nona IX', 'f', '2000-01-01', 'B+', 'amnésia leve', '99999999990', '1'),
    (10, '10101010101', 'Pacio Décimo X', 'm', '2000-01-01', 'O-', 'resfriado forte', '10101010100', '3');

INSERT INTO tblFuncionario VALUES
    ('01111111111', 11, '11111111111111', 'Carlos', 'm', '01111111111', '1'),
    ('02222222222', 12, '22222222222222', 'Bea', 'f', '02222222222', '2'),
    ('03333333333', 13, '33333333333333', 'Gabriel', 'm', '03333333333', '3'),
    ('04444444444', 14, '44444444444444', 'Felipe', 'm', '04444444444', '1'),
    ('05555555555', 15, '55555555555555', 'Sara', 'f', '05555555555', '2'),
    ('06666666666', 16, '66666666666666', 'Malcon', 'm', '06666666666', '2'),
    ('07777777777', 17, '77777777777777', 'Rafa', 'm', '07777777777', '3'),
    ('08888888888', 18, '88888888888888', 'Samuela', 'f', '08888888888', '3'),
    ('09999999999', 19, '99999999999999', 'Joana', 'f', '09999999999', '1'),
    ('01010101010', 20, '10101010101010', 'Mercuria', 'f', '01010101010', '1');

INSERT INTO tblMedico VALUES
    ('111111', '11111111111111', 'Roberto', 'Psicólogo', 'rob@gmail.com', 'm', '2000-01-01', '01111111110'),
    ('222222', '22222222222222', 'Gabriela', 'Neurocirurgião', 'gab@gmail.com', 'f', '2000-01-01', '02222222220'),
    ('333333', '33333333333333', 'Felix', 'Pediatra', 'fel@gmail.com', 'm', '2000-01-01', '03333333330'),
    ('444444', '44444444444444', 'Santos', 'Cirurgião', 'santos@gmail.com', 'f', '2000-01-01', '04444444440'),
    ('555555', '55555555555555', 'Britto', 'Médico geral', 'brito@gmail.com', 'm', '2000-01-01', '05555555550'),
    ('666666', '66666666666666', 'Peter', 'Psicólogo', 'pete@gmail.com', 'm', '2000-01-01', '06666666660'),
    ('777777', '77777777777777', 'Capaldi', 'Cirurgião', 'cap@gmail.com', 'f', '2000-01-01', '07777777770'),
    ('888888', '88888888888888', 'Paola', 'Neurocirurgião', 'paola@gmail.com', 'f', '2000-01-01', '08888888880'),
    ('999999', '99999999999999', 'Beatrice', 'Enfermeiro', 'beat@gmail.com', 'f', '2000-01-01', '09999999990'),
    ('101010', '10101010101010', 'Diego', 'Obstetra', 'diggo@gmail.com', 'm', '2000-01-01', '01010101019');

INSERT INTO tblConsulta (cnpj, crm, idPaciente, tipoConsulta, dataConsulta, horaConsulta) VALUES
    ('11111111111111', '111111', 1, 'consulta psicológica', '2005-01-01', '01:20:59'),
    ('22222222222222', '222222', 2, 'cirurgia de remoção do lóbulo frontal', '2005-02-28', '23:59:59'),
    ('33333333333333', '333333', 3, 'teste do pezinho', '2005-01-01', '01:20:59'),
    ('44444444444444', '444444', 4, 'cirurgia cardíaca', '2005-01-01', '01:20:59'),
    ('55555555555555', '555555', 5, 'triagem', '2005-01-01', '01:20:59'),
    ('66666666666666', '666666', 6, 'consulta psicológica', '2005-01-01', '01:20:59'),
    ('77777777777777', '777777', 7, 'cirurgia de remoção do apêndice', '2005-01-01', '01:20:59'),
    ('88888888888888', '888888', 8, 'exame cerebral', '2005-01-01', '01:20:59'),
    ('99999999999999', '999999', 9, 'exame de sangue', '2005-01-01', '01:20:59'),
    ('10101010101010', '101010', 10, 'parto', '2005-01-01', '01:20:59');

INSERT INTO tblNotificacao (idUsuario, idConsulta, tipoNotificacao, textoNotificacao, dataCriacao, horaCriacao, lida) VALUES
    (11, 1, 'Agendamento efetuado', 'Exame psicotécnico', '2004-01-01', '23:59:59', 0),
    (9, 2, 'Agendamento efetuado', 'Cirurgia cerebral', '2004-01-01', '23:59:59', 1),
    (9, 2, 'Agendamento atualizado', 'Cirurgia cerebral', '2004-01-02', '23:59:59', 1),
    (4, 3, 'Agendamento efetuado', 'Teste do pezinho', '2004-01-01', '23:59:59', 1),
    (1, 4, 'Agendamento efetuado', 'Cirurgia cardíaca', '2004-01-01', '23:59:59', 0),
    (1, 5, 'Agendamento efetuado', 'Triagem: exame geral', '2004-01-01', '23:59:59', 1),
    (6, 6, 'Agendamento efetuado', 'Exame psicológico', '2004-01-01', '23:59:59', 1),
    (4, 7, 'Agendamento efetuado', 'Cirurgia de remoção do apêndice', '2004-01-01', '23:59:59', 1),
    (20, 8, 'Agendamento efetuado', 'Exame cerebral', '2004-01-01', '23:59:59', 0),
    (17, 9, 'Agendamento efetuado', 'Exame de sangue', '2004-01-01', '23:59:59', 0),
    (15, 10, 'Agendamento efetuado', 'Cirurgia de parto', '2004-01-01', '23:59:59', 1);

INSERT INTO tblProntuario (idConsulta, tipoConsulta, descricao, receituario) VALUES
    (1, 'consulta psicológica', 'blablablablablablablablablablabla', 'tome remédio A'),
    (2, 'cirurgia de remoção do lóbulo frontal', 'blablablablablablablablablablabla', 'tome remédio B'),
    (3, 'teste do pezinho', 'blablablablablablablablablablabla', 'tome remédio C'),
    (4, 'cirurgia cardíaca', 'blablablablablablablablablablabla', 'tome remédio D'),
    (5, 'triagem', 'blablablablablablablablablablabla', 'tome remédio E'),
    (6, 'consulta psicológica', 'blablablablablablablablablablabla', 'tome remédio F'),
    (7, 'cirurgia de remoção do apêndice', 'blablablablablablablablablablabla', 'tome remédio G'),
    (8, 'exame cerebral', 'blablablablablablablablablablabla', 'tome remédio X'),
    (9, 'exame de sangue', 'blablablablablablablablablablabla', 'tome remédio Y'),
    (10, 'parto', 'blablablablablablablablablablabla', 'tome remédio Z');
    
INSERT INTO tblDisponibilidade (cnpj, dataIndisponivel, descricao) VALUES
    ('11111111111111', '2005-11-25', 'ponto facultativo'),
    ('22222222222222', '2005-11-25', 'ponto facultativo'),
    ('33333333333333', '2005-11-25', 'ponto facultativo'),
    ('44444444444444', '2005-11-25', 'ponto facultativo'),
    ('55555555555555', '2005-11-25', 'ponto facultativo'),
    ('66666666666666', '2005-11-25', 'ponto facultativo'),
    ('77777777777777', '2005-11-25', 'ponto facultativo'),
    ('88888888888888', '2005-11-25', 'ponto facultativo'),
    ('99999999999999', '2005-11-25', 'ponto facultativo'),
    ('11111111111111', '2005-09-17', 'ponto facultativo');

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
DELIMITER ;



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
        fonePaciente,
	fotoPaciente
    ) VALUES (
        p_idUsuario, 
        p_cpf, 
        p_nome, 
        p_sexo, 
        p_dataNasc, 
        p_fone,
	'1'
    );
END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_cadastroFunc`(
    IN p_cpf CHAR(14),
    IN p_idUsuario INT,
    IN p_cnpj VARCHAR(14),
    IN p_nome VARCHAR(50),
    IN p_sexo CHAR(1),
    IN p_fone CHAR(15)
)
BEGIN

    INSERT INTO tblFuncionario (
        cpfFuncionario, 
        idUsuario, 
        cnpj, 
        nomeFuncionario, 
        sexoFuncionario, 
        foneFuncionario
    ) VALUES (
        p_cpf, 
        p_idUsuario, 
        p_cnpj, 
        p_nome, 
        p_sexo, 
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


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_loginFunc`(
    IN p_email VARCHAR(50),
    IN p_senha VARCHAR(30),
    OUT p_retorno INT
)
BEGIN
    IF (SELECT COUNT(*) 
        FROM tblUsuario 
        WHERE email = p_email 
          AND idUsuario IN (SELECT idUsuario FROM tblFuncionario)) > 0 THEN
        SET p_retorno = (SELECT idUsuario 
                         FROM tblUsuario 
                         WHERE email = p_email);
    ELSE
        SET p_retorno = 0;
    END IF;
END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_excluirPac`(
    IN p_id INT
)
BEGIN
    DELETE FROM tblPaciente WHERE idUsuario = p_id;
    DELETE FROM tblUsuario WHERE idUsuario = p_id;
END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_excluirFunc`(
    IN p_id INT
)
BEGIN
    DELETE FROM tblFuncionario WHERE idUsuario = p_id;
    DELETE FROM tblUsuario WHERE idUsuario = p_id;
END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_editFunc`(
    IN p_id INT,
    IN p_nome VARCHAR(50),
    IN p_email VARCHAR(50),
    IN p_cpf CHAR(14),
    IN p_cnpj VARCHAR(14),
    IN p_sexo CHAR(1),
    IN p_fone CHAR(15)
)
BEGIN
    UPDATE tblUsuario SET email = p_email
    WHERE idUsuario = p_id;
    UPDATE tblFuncionario SET nomeFuncionario = p_nome, cpfFuncionario = p_cpf, cnpj = p_cnpj, sexoFuncionario = p_sexo, foneFuncionario = p_fone
    WHERE idUsuario = p_id;
END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_editPac`(
    IN p_id INT,
    IN p_nome VARCHAR(50),
    IN p_email VARCHAR(50),
    IN p_date DATE,
    IN p_sexo CHAR(1),
    IN p_tel CHAR(15),
    IN p_cpf CHAR(14),
    IN p_foto CHAR(1)
)
BEGIN
    UPDATE tblUsuario SET email = p_email
    WHERE idUsuario = p_id;
    UPDATE tblPaciente SET nomePaciente = p_nome, dataNascPaciente = p_date, sexoPaciente = p_sexo, fonePaciente = p_tel, cpfPaciente = p_cpf, fotoPaciente = p_foto
    WHERE idUsuario = p_id;
END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_baseLoad`(
    IN p_id INT,
    OUT p_nome VARCHAR(50),
    OUT p_email VARCHAR(50),
    OUT p_data DATE,
    OUT p_sexo CHAR(1),
    OUT p_tel CHAR(15),
    OUT p_cpf CHAR(14),
    OUT p_foto CHAR(1)
)
BEGIN
    SELECT nomePaciente INTO p_nome
    FROM tblPaciente
    WHERE idUsuario = p_id;
    
    SELECT email INTO p_email
    FROM tblUsuario
    WHERE idUsuario = p_id;
    
    SELECT dataNascPaciente INTO p_data
    FROM tblPaciente
    WHERE idUsuario = p_id;
    
    SELECT sexoPaciente INTO p_sexo
    FROM tblPaciente
    WHERE idUsuario = p_id;
    
    SELECT fonePaciente INTO p_tel
    FROM tblPaciente
    WHERE idUsuario = p_id;
    
    SELECT cpfPaciente INTO p_cpf
    FROM tblPaciente
    WHERE idUsuario = p_id;

    SELECT fotoPaciente INTO p_foto
    FROM tblPaciente
    WHERE idUsuario = p_id;
END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_consultaLoad`(
    IN p_id INT,
    OUT p_data DATE,
    OUT p_hora TIME,
    OUT p_clinica VARCHAR(50),
    OUT p_doutor VARCHAR(50),
    OUT p_tipoConsulta VARCHAR(50)
)
BEGIN
    SELECT dataConsulta INTO p_data
    FROM tblConsulta
    WHERE idPaciente IN (SELECT idPaciente FROM tblUsuario WHERE idUsuario = p_id);
    
    SELECT horaConsulta INTO p_hora
    FROM tblConsulta
    WHERE idPaciente IN (SELECT idPaciente FROM tblUsuario WHERE idUsuario = p_id);

    SELECT cnpj INTO p_clinica
    FROM tblConsulta
    WHERE idPaciente IN (SELECT idPaciente FROM tblUsuario WHERE idUsuario = p_id);

    SELECT crm INTO p_doutor
    FROM tblConsulta
    WHERE idPaciente IN (SELECT idPaciente FROM tblUsuario WHERE idUsuario = p_id);

    SELECT tipoConsulta INTO p_tipoConsulta
    FROM tblConsulta
    WHERE idPaciente IN (SELECT idPaciente FROM tblUsuario WHERE idUsuario = p_id);
END$$
DELIMITER ;
