-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema examenoef
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema examenoef
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `examenoef` DEFAULT CHARACTER SET utf8 ;
USE `examenoef` ;

-- -----------------------------------------------------
-- Table `examenoef`.`affected`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examenoef`.`affected` (
  `idaffected` INT NOT NULL,
  `affected_gene` VARCHAR(45) NULL,
  `discription_gene` TEXT NULL,
  PRIMARY KEY (`idaffected`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examenoef`.`mutation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examenoef`.`mutation` (
  `idmutation` INT NOT NULL,
  `start` DECIMAL(45) NULL,
  `end` DECIMAL(45) NULL,
  `chromosome` DECIMAL(45) NULL,
  `affected_id` INT NOT NULL,
  PRIMARY KEY (`idmutation`),
  INDEX `fk_mutation_affected1_idx` (`affected_id` ASC),
  CONSTRAINT `fk_mutation_affected1`
    FOREIGN KEY (`affected_id`)
    REFERENCES `examenoef`.`affected` (`idaffected`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examenoef`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examenoef`.`patient` (
  `idpatient` INT NOT NULL,
  `patient_name` VARCHAR(45) NULL,
  `patient_syndrome` INT NOT NULL,
  `patient_gender` ENUM('F', 'M') NULL,
  `patient_age` DATE NULL,
  `patient_diagnose` VARCHAR(45) NULL,
  `mutation_id` INT NOT NULL,
  PRIMARY KEY (`idpatient`),
  UNIQUE INDEX `idpatient_UNIQUE` (`idpatient` ASC),
  INDEX `fk_patient_mutation1_idx` (`mutation_id` ASC),
  CONSTRAINT `fk_patient_mutation1`
    FOREIGN KEY (`mutation_id`)
    REFERENCES `examenoef`.`mutation` (`idmutation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examenoef`.`Syndrome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examenoef`.`Syndrome` (
  `idSyndrome` INT NOT NULL,
  `discription_syndrome` TEXT NULL,
  `mutation_id` INT NOT NULL,
  PRIMARY KEY (`idSyndrome`),
  INDEX `fk_Syndrome_mutation1_idx` (`mutation_id` ASC),
  CONSTRAINT `fk_Syndrome_patient`
    FOREIGN KEY (`idSyndrome`)
    REFERENCES `examenoef`.`patient` (`patient_syndrome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Syndrome_mutation1`
    FOREIGN KEY (`mutation_id`)
    REFERENCES `examenoef`.`mutation` (`idmutation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
