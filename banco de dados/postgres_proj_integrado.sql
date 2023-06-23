--
-- Criação da tabela endereço
--

CREATE TABLE vasco.endereco (
                endereco_id NUMERIC NOT NULL,
                CEP VARCHAR NOT NULL,
                numero NUMERIC NOT NULL,
                complemento VARCHAR(255),
                CONSTRAINT endereco_pk PRIMARY KEY (endereco_id)
);
COMMENT ON TABLE vasco.endereco IS 'endereço dos departamentos. tem como pk endereco_id';
COMMENT ON COLUMN vasco.endereco.endereco_id IS 'endereço id dos departamentos / pk da tabela enderecos';
COMMENT ON COLUMN vasco.endereco.CEP IS 'CEP dos departamentos';
COMMENT ON COLUMN vasco.endereco.numero IS 'número do endereço do departamento';
COMMENT ON COLUMN vasco.endereco.complemento IS 'complemento do endereço';

--
-- Criação da tabela soft skills
--

CREATE TABLE vasco.soft_skills (
                identificador_soft_skill NUMERIC NOT NULL,
                soft_skill VARCHAR NOT NULL,
                CONSTRAINT soft_skills_pk PRIMARY KEY (identificador_soft_skill)
);
COMMENT ON TABLE vasco.soft_skills IS 'soft skills do funcionário. tem como PK identificador_soft_skill.';
COMMENT ON COLUMN vasco.soft_skills.identificador_soft_skill IS 'código da soft skill do funcionário / pk da tabela soft_skills';
COMMENT ON COLUMN vasco.soft_skills.soft_skill IS 'soft skill dos funcionários';

--
-- Criação da tabela de hard skills
--

CREATE TABLE vasco.hard_skills (
                identificador_hard_skill NUMERIC NOT NULL,
                hard_skill VARCHAR NOT NULL,
                CONSTRAINT hard_skills_pk PRIMARY KEY (identificador_hard_skill)
);
COMMENT ON TABLE vasco.hard_skills IS 'hard skills dos funcionários. tem como PK identificador_hard_skill.';
COMMENT ON COLUMN vasco.hard_skills.identificador_hard_skill IS 'código da hard skill / pk da tabela hard_skills';
COMMENT ON COLUMN vasco.hard_skills.hard_skill IS 'hard skill do funcionário';

--
-- Criação da tabela departamentos
--

CREATE TABLE vasco.departamentos (
                codigo_dep NUMERIC NOT NULL,
                nome VARCHAR(255) NOT NULL,
                horario_funcionamento TIME NOT NULL,
                endereco_id NUMERIC NOT NULL,
                CONSTRAINT departamentos_pk PRIMARY KEY (codigo_dep)
);
COMMENT ON TABLE vasco.departamentos IS 'departamentos de atuação dos funcionários';
COMMENT ON COLUMN vasco.departamentos.codigo_dep IS 'código do departamento/ pk do departamento';
COMMENT ON COLUMN vasco.departamentos.nome IS 'nome do departamento';
COMMENT ON COLUMN vasco.departamentos.horario_funcionamento IS 'horario de funcionamento do departamento';
COMMENT ON COLUMN vasco.departamentos.endereco_id IS 'endereço id dos departamentos / pk da tabela enderecos';

--
-- Criação da tabela funcionários
--

CREATE TABLE vasco.funcionarios (
                cpf NUMERIC(11) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                salario NUMERIC NOT NULL,
                nacionalidade VARCHAR,
                descricao BYTEA NOT NULL,
                codigo_dep NUMERIC NOT NULL,
                CONSTRAINT funcionarios_pk PRIMARY KEY (cpf)
);
COMMENT ON TABLE vasco.funcionarios IS 'tabela responsável por armazenar todos os funcionários e suas atribuições. tem como pk o cpf. Além da fk codigo_dep da tabela departamentos';
COMMENT ON COLUMN vasco.funcionarios.cpf IS 'cpf dos funcionários/ pk da tabela';
COMMENT ON COLUMN vasco.funcionarios.nome IS 'nome dos funcionários';
COMMENT ON COLUMN vasco.funcionarios.salario IS 'Salário atual dos funcionários';
COMMENT ON COLUMN vasco.funcionarios.nacionalidade IS 'nacionalidade do funcionário';
COMMENT ON COLUMN vasco.funcionarios.descricao IS 'descrição dos funcionários';
COMMENT ON COLUMN vasco.funcionarios.codigo_dep IS 'código do departamento/ pk do departamento';

--
-- Criação da tabela soft skills funcionarios (tabela associativa)
--

CREATE TABLE vasco.soft_skills_funcionarios (
                cpf NUMERIC(11) NOT NULL,
                identificador_soft_skill NUMERIC NOT NULL,
                CONSTRAINT soft_skills_funcionarios_pk PRIMARY KEY (cpf, identificador_soft_skill)
);
COMMENT ON TABLE vasco.soft_skills_funcionarios IS 'tabela associativa das soft skills dos funcionários (entre tabela soft_skills e tabela funcionarios). Tem como pk composta: cpf (pfk da tabela funcionarios) e identificador_soft_skill (da tabela soft_skills)';
COMMENT ON COLUMN vasco.soft_skills_funcionarios.cpf IS 'cpf dos funcionários/ pk da tabela';
COMMENT ON COLUMN vasco.soft_skills_funcionarios.identificador_soft_skill IS 'código da soft skill do funcionário';

--
-- Criação da tabela hard skills funcionarios (tabela associativa)
--

CREATE TABLE vasco.hard_skills_funcionarios (
                cpf NUMERIC(11) NOT NULL,
                identificador_hard_skill NUMERIC NOT NULL,
                CONSTRAINT hard_skills_funcionarios_pk PRIMARY KEY (cpf, identificador_hard_skill)
);
COMMENT ON TABLE vasco.hard_skills_funcionarios IS 'tabela associativa das hard skills dos funcionários (entre tabela hard_skills e tabela funcionarios). Tem como pk composta: cpf (pfk da tabela funcionarios) e identificador_hard_skill (da tabela hard_skills)';
COMMENT ON COLUMN vasco.hard_skills_funcionarios.cpf IS 'cpf dos funcionários/ pk da tabela';
COMMENT ON COLUMN vasco.hard_skills_funcionarios.identificador_hard_skill IS 'código da hard skill';

--
-- Criação da tabela de cargos dos funcionarios
--

CREATE TABLE vasco.cargos_funcionarios (
                cpf NUMERIC(11) NOT NULL,
                data_de_admissao DATE NOT NULL,
                cargo VARCHAR NOT NULL,
                data_de_saida DATE,
                CONSTRAINT cargos_funcionarios_pk PRIMARY KEY (cpf, data_de_admissao)
);
COMMENT ON TABLE vasco.cargos_funcionarios IS 'todos os cargos ja ocupados pelo funcionário.
tem como pk composta: cpf (pfk da tabela funcionarios) e data_de_admissao';
COMMENT ON COLUMN vasco.cargos_funcionarios.cpf IS 'cpf dos funcionários/ pk da tabela funcionários';
COMMENT ON COLUMN vasco.cargos_funcionarios.data_de_admissao IS 'data de inicio de cargo do funcionário/ pk da tabela cargos_funcionarios';
COMMENT ON COLUMN vasco.cargos_funcionarios.cargo IS 'cargo ocupado pelo funcionário';
COMMENT ON COLUMN vasco.cargos_funcionarios.data_de_saida IS 'data de fim do cargo do funcionário. Caso seja null, o funcionário ainda ocupa o cargo';

--
-- Criação da tabela telefones
--

CREATE TABLE vasco.telefones (
                DDD NUMERIC(3) NOT NULL,
                numero VARCHAR NOT NULL,
                cod_pais VARCHAR NOT NULL,
                cpf NUMERIC(11) NOT NULL,
                CONSTRAINT telefones_pk PRIMARY KEY (DDD, numero)
);
COMMENT ON TABLE vasco.telefones IS 'numeros de telefone dos funcionários. Tem como pk composta: DDD e numero.
além da FK cpf da tabela funcionarios';
COMMENT ON COLUMN vasco.telefones.DDD IS 'ddd do telefone / pk da tabela telefones';
COMMENT ON COLUMN vasco.telefones.numero IS 'numero de telefone do funcionário / pk da tabela telefones';
COMMENT ON COLUMN vasco.telefones.cod_pais IS 'código do país';
COMMENT ON COLUMN vasco.telefones.cpf IS 'cpf dos funcionários/ pk da tabela';

--
-- Criação da tabela emails
--

CREATE TABLE vasco.emails (
                cpf NUMERIC(11) NOT NULL,
                email VARCHAR(255) NOT NULL,
                CONSTRAINT emails_pk PRIMARY KEY (cpf, email)
);
COMMENT ON TABLE vasco.emails IS 'e-mails dos funcionários.
tem como pk composta: cpf (pfk da tabela funcionarios) e e-mail.';
COMMENT ON COLUMN vasco.emails.cpf IS 'cpf dos funcionários/ pk da tabela';
COMMENT ON COLUMN vasco.emails.email IS 'e-mail dos funcionários/pk da tabela e-mails';

--
-- FK endereco_id da tabela endereco para a tabela departamentos
--

ALTER TABLE vasco.departamentos ADD CONSTRAINT endereco_departamentos_fk
FOREIGN KEY (endereco_id)
REFERENCES vasco.endereco (endereco_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--
-- FK identificador_soft_skill da tabela soft_skills para a tabela soft_skills_funcionarios
--

ALTER TABLE vasco.soft_skills_funcionarios ADD CONSTRAINT soft_skills_soft_skills_funcionarios_fk
FOREIGN KEY (identificador_soft_skill)
REFERENCES vasco.soft_skills (identificador_soft_skill)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--
-- FK identificador_hard_skill da tabela hard_skills para a tabela hard_skills_funcionarios
--

ALTER TABLE vasco.hard_skills_funcionarios ADD CONSTRAINT hard_skills_hard_skills_funcionarios_fk
FOREIGN KEY (identificador_hard_skill)
REFERENCES vasco.hard_skills (identificador_hard_skill)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--
-- FK codigo_dep da tabela departamentos para a tabela funcionarios
--

ALTER TABLE vasco.funcionarios ADD CONSTRAINT departamentos_funcionarios_fk
FOREIGN KEY (codigo_dep)
REFERENCES vasco.departamentos (codigo_dep)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--
-- FK cpf da tabela funcionarios para a tabela emails
--

ALTER TABLE vasco.emails ADD CONSTRAINT funcionarios_e_mails_fk
FOREIGN KEY (cpf)
REFERENCES vasco.funcionarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--
-- FK cpf da tabela funcionarios para a tabela telefones
--

ALTER TABLE vasco.telefones ADD CONSTRAINT funcionarios_numeros_fk
FOREIGN KEY (cpf)
REFERENCES vasco.funcionarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--
-- FK cpf da tabela funcionarios para a tabela cargo_funcionarios
--

ALTER TABLE vasco.cargos_funcionarios ADD CONSTRAINT funcionarios_cargos_funcionarios_fk
FOREIGN KEY (cpf)
REFERENCES vasco.funcionarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--
-- FK cpf da tabela funcionarios para a tabela hard_skills_funcionarios
--

ALTER TABLE vasco.hard_skills_funcionarios ADD CONSTRAINT funcionarios_hard_skills_funcionarios_fk
FOREIGN KEY (cpf)
REFERENCES vasco.funcionarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--
-- FK cpf da tabela funcionarios para a tabela soft_skills_funcionarios
--

ALTER TABLE vasco.soft_skills_funcionarios ADD CONSTRAINT funcionarios_soft_skills_funcionarios_fk
FOREIGN KEY (cpf)
REFERENCES vasco.funcionarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
