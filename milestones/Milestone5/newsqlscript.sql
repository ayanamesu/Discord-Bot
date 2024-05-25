-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP DATABASE IF EXISTS airportmanagementsysdb;
CREATE DATABASE IF NOT EXISTS airportmanagementsysdb;
USE airportmanagementsysdb;
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `GeneralUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneralUser` ;

CREATE TABLE IF NOT EXISTS `GeneralUser` (
  `user_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `paymentMethod` ;

CREATE TABLE IF NOT EXISTS `paymentMethod` (
  `method_id` TINYINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`method_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tickets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Tickets` ;

CREATE TABLE IF NOT EXISTS `Tickets` (
  `ticket_id` TINYINT NOT NULL,
  `payment_type` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ticket_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Luggage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Luggage` ;

CREATE TABLE IF NOT EXISTS `Luggage` (
  `luggage_id` TINYINT NOT NULL,
  `weight` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`luggage_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Account` ;

CREATE TABLE IF NOT EXISTS `Account` (
  `account_id` TINYINT NOT NULL,
  `accountowner` TINYINT NOT NULL,
  `profile_name` VARCHAR(45) NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE INDEX `accountowner_UNIQUE` (`accountowner` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Passenger`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Passenger` ;

CREATE TABLE IF NOT EXISTS `Passenger` (
  `passenger_id` TINYINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `payment_method` TINYINT NULL,
  `luggage` TINYINT NULL,
  PRIMARY KEY (`passenger_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_Passenger_Luggage_idx` (`luggage` ASC) VISIBLE,
  CONSTRAINT `PKFK_Passenger_GeneralUser`
    FOREIGN KEY (`passenger_id`)
    REFERENCES `GeneralUser` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Passenger_paymentMethod1`
    FOREIGN KEY (`payment_method`)
    REFERENCES `paymentMethod` (`method_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Passenger_tickets`
    FOREIGN KEY (`payment_method`)
    REFERENCES `Tickets` (`ticket_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Passenger_Luggage`
    FOREIGN KEY (`luggage`)
    REFERENCES `Luggage` (`luggage_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Passenger_account`
    FOREIGN KEY (`passenger_id`)
    REFERENCES `Account` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Roles` ;

CREATE TABLE IF NOT EXISTS `Roles` (
  `role_id` TINYINT NOT NULL,
  `roleName` VARCHAR(45) NOT NULL,
  `roleDescription` VARCHAR(100) NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CompanyAirline`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CompanyAirline` ;

CREATE TABLE IF NOT EXISTS `CompanyAirline` (
  `airline_id` TINYINT NOT NULL,
  `airlineName` VARCHAR(45) NOT NULL,
  `airlinelocation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`airline_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Shifts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Shifts` ;

CREATE TABLE IF NOT EXISTS `Shifts` (
  `shift_id` TINYINT NOT NULL AUTO_INCREMENT,
  `schedules` VARCHAR(45) NOT NULL,
  `workdays` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`shift_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Staff` ;

CREATE TABLE IF NOT EXISTS `Staff` (
  `staff_id` TINYINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `Company_airline` TINYINT NULL,
  `role` TINYINT NULL,
  `shifts` TINYINT NULL,
  PRIMARY KEY (`staff_id`),
  INDEX `fk_staff_role_idx` (`role` ASC) VISIBLE,
  INDEX `fk_staff_airline_idx` (`Company_airline` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `PKFK_staff_shifts_idx` (`shifts` ASC) VISIBLE,
  CONSTRAINT `fk_staff_role`
    FOREIGN KEY (`role`)
    REFERENCES `Roles` (`role_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_Compairline`
    FOREIGN KEY (`Company_airline`)
    REFERENCES `CompanyAirline` (`airline_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `PKFK_staff_shifts`
    FOREIGN KEY (`shifts`)
    REFERENCES `Shifts` (`shift_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airline`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Airline` ;

CREATE TABLE IF NOT EXISTS `Airline` (
  `airline_id` TINYINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`airline_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Lounge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Lounge` ;

CREATE TABLE IF NOT EXISTS `Lounge` (
  `lounge_id` TINYINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `Airline` TINYINT NULL,
  PRIMARY KEY (`lounge_id`),
  INDEX `fk_gate_airline_idx` (`Airline` ASC) VISIBLE,
  CONSTRAINT `fk_gate_airline`
    FOREIGN KEY (`Airline`)
    REFERENCES `Airline` (`airline_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Flight` ;

CREATE TABLE IF NOT EXISTS `Flight` (
  `flight_id` TINYINT NOT NULL,
  `airplaneName` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`flight_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gate` ;

CREATE TABLE IF NOT EXISTS `Gate` (
  `gate_id` TINYINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `flightPlane` TINYINT NULL,
  PRIMARY KEY (`gate_id`),
  INDEX `fk_gate_flight_idx` (`flightPlane` ASC) VISIBLE,
  CONSTRAINT `fk_gate_flight`
    FOREIGN KEY (`flightPlane`)
    REFERENCES `Flight` (`flight_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Terminal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Terminal` ;

CREATE TABLE IF NOT EXISTS `Terminal` (
  `terminal_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NULL,
  `Terminal_has` TINYINT NULL,
  `Lounge` TINYINT NULL,
  `gate` TINYINT NULL,
  `passenger` TINYINT NULL,
  `payments` VARCHAR(100) NULL,
  PRIMARY KEY (`terminal_id`),
  INDEX `fk_terminal_lounge_idx` (`Lounge` ASC) VISIBLE,
  INDEX `fk_gate_lounge_idx` (`gate` ASC) VISIBLE,
  INDEX `fk_terminal_passenger_idx` (`passenger` ASC) VISIBLE,
  CONSTRAINT `fk_terminal_lounge`
    FOREIGN KEY (`Lounge`)
    REFERENCES `Lounge` (`lounge_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_terminalgate_gate`
    FOREIGN KEY (`gate`)
    REFERENCES `Gate` (`gate_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_terminal_passenger`
    FOREIGN KEY (`passenger`)
    REFERENCES `Passenger` (`passenger_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssignedToTerminal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AssignedToTerminal` ;

CREATE TABLE IF NOT EXISTS `AssignedToTerminal` (
  `Assigned_id` TINYINT NOT NULL,
  `terminal_id` TINYINT NULL,
  `staff` TINYINT NULL,
  INDEX `fk_assignedToTerm_staff_idx` (`staff` ASC) VISIBLE,
  INDEX `fk_terminalID_terminal_idx` (`terminal_id` ASC) VISIBLE,
  PRIMARY KEY (`Assigned_id`),
  CONSTRAINT `fk_assignedToTerm_staff`
    FOREIGN KEY (`staff`)
    REFERENCES `Staff` (`staff_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_assignedToTerm_terminal`
    FOREIGN KEY (`terminal_id`)
    REFERENCES `Terminal` (`terminal_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Restaurant` ;

CREATE TABLE IF NOT EXISTS `Restaurant` (
  `restaurant_id` TINYINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`restaurant_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Stores` ;

CREATE TABLE IF NOT EXISTS `Stores` (
  `store_id` TINYINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`store_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TerminalHas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TerminalHas` ;

CREATE TABLE IF NOT EXISTS `TerminalHas` (
  `terminalhas_id` TINYINT NOT NULL,
  `stores_id` TINYINT NULL,
  `restaurant_id` TINYINT NULL,
  INDEX `fk_terminalhas_stores_idx` (`stores_id` ASC) VISIBLE,
  INDEX `fk_terminalhas_restaurant_idx` (`restaurant_id` ASC) VISIBLE,
  PRIMARY KEY (`terminalhas_id`),
  CONSTRAINT `PKFK_terminalhas_terminalhas`
    FOREIGN KEY (`terminalhas_id`)
    REFERENCES `Terminal` (`terminal_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_terminalhas_stores`
    FOREIGN KEY (`stores_id`)
    REFERENCES `Stores` (`store_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_terminalhas_restaurant`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `Restaurant` (`restaurant_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;