-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema barbearia
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema barbearia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `barbearia` DEFAULT CHARACTER SET utf8 ;
USE `barbearia` ;

-- -----------------------------------------------------
-- Table `barbearia`.`barbeiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `barbearia`.`barbeiro` (
  `idbarbeiro` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `CPF` VARCHAR(20) NOT NULL,
  `telefone` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idbarbeiro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `barbearia`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `barbearia`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `CPF` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `barbearia`.`agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `barbearia`.`agendamento` (
  `idAgenda` INT NOT NULL AUTO_INCREMENT,
  `horario` DATETIME NOT NULL,
  `status` ENUM('Agendado', 'Cancelado', 'Finalizado') NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  `barbeiro_idbarbeiro` INT NOT NULL,
  PRIMARY KEY (`idAgenda`, `cliente_idcliente`, `barbeiro_idbarbeiro`),
  INDEX `fk_agendamento_cliente1_idx` (`cliente_idcliente` ASC) ,
  INDEX `fk_agendamento_barbeiro1_idx` (`barbeiro_idbarbeiro` ASC) ,
  CONSTRAINT `fk_agendamento_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `barbearia`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_agendamento_barbeiro1`
    FOREIGN KEY (`barbeiro_idbarbeiro`)
    REFERENCES `barbearia`.`barbeiro` (`idbarbeiro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `barbearia`.`corte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `barbearia`.`corte` (
  `idcorte` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `tempo` TIME NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  `valor` DOUBLE NOT NULL,
  PRIMARY KEY (`idcorte`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `barbearia`.`agendamento_has_corte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `barbearia`.`agendamento_has_corte` (
  `agendamento_idAgenda` INT NOT NULL,
  `corte_idcorte` INT NOT NULL,
  PRIMARY KEY (`agendamento_idAgenda`, `corte_idcorte`),
  INDEX `fk_agendamento_has_corte_corte1_idx` (`corte_idcorte` ASC) ,
  INDEX `fk_agendamento_has_corte_agendamento_idx` (`agendamento_idAgenda` ASC) ,
  CONSTRAINT `fk_agendamento_has_corte_agendamento`
    FOREIGN KEY (`agendamento_idAgenda`)
    REFERENCES `barbearia`.`agendamento` (`idAgenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_agendamento_has_corte_corte1`
    FOREIGN KEY (`corte_idcorte`)
    REFERENCES `barbearia`.`corte` (`idcorte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
