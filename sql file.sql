-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema databasenametask
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema databasenametask
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `databasenametask` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `databasenametask` ;

-- -----------------------------------------------------
-- Table `databasenametask`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databasenametask`.`users` (
  `user_id` INT NOT NULL,
  `username` VARCHAR(255) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role` VARCHAR(255) NULL DEFAULT NULL,
  `createdAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `databasenametask`.`mentors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databasenametask`.`mentors` (
  `mentor_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `full_name` VARCHAR(255) NOT NULL,
  `address` TEXT NOT NULL,
  `phone_number` VARCHAR(255) NOT NULL,
  `qualification` TEXT NOT NULL,
  `work_experience` TEXT NOT NULL,
  PRIMARY KEY (`mentor_id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `mentors_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `databasenametask`.`users` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `databasenametask`.`topics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databasenametask`.`topics` (
  `topic_id` INT NOT NULL,
  `topic_name` VARCHAR(255) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `num_sessions` INT NULL DEFAULT NULL,
  `mentor_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`topic_id`),
  INDEX `mentor_id` (`mentor_id` ASC) VISIBLE,
  CONSTRAINT `topics_ibfk_1`
    FOREIGN KEY (`mentor_id`)
    REFERENCES `databasenametask`.`mentors` (`mentor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `databasenametask`.`attendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databasenametask`.`attendance` (
  `attendance_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `topic_id` INT NOT NULL,
  `session_date` DATE NULL DEFAULT NULL,
  `status` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`attendance_id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  INDEX `topic_id` (`topic_id` ASC) VISIBLE,
  CONSTRAINT `attendance_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `databasenametask`.`users` (`user_id`),
  CONSTRAINT `attendance_ibfk_2`
    FOREIGN KEY (`topic_id`)
    REFERENCES `databasenametask`.`topics` (`topic_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `databasenametask`.`capstone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databasenametask`.`capstone` (
  `capstone_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `project_name` VARCHAR(255) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`capstone_id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `capstone_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `databasenametask`.`users` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `databasenametask`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databasenametask`.`students` (
  `student_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `full_name` VARCHAR(255) NOT NULL,
  `address` TEXT NOT NULL,
  `phone_number` VARCHAR(255) NOT NULL,
  `qualification` TEXT NOT NULL,
  `work_experience` TEXT NOT NULL,
  PRIMARY KEY (`student_id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `students_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `databasenametask`.`users` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `databasenametask`.`portfolio_submission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databasenametask`.`portfolio_submission` (
  `submission_id` INT NOT NULL,
  `student_id` INT NULL DEFAULT NULL,
  `capstone_id` INT NULL DEFAULT NULL,
  `submission_date` DATE NULL DEFAULT NULL,
  `github_url` VARCHAR(255) NULL DEFAULT NULL,
  `portfolio_url` VARCHAR(255) NULL DEFAULT NULL,
  `resume_url` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`submission_id`),
  INDEX `student_id` (`student_id` ASC) VISIBLE,
  INDEX `capstone_id` (`capstone_id` ASC) VISIBLE,
  CONSTRAINT `portfolio_submission_ibfk_1`
    FOREIGN KEY (`student_id`)
    REFERENCES `databasenametask`.`students` (`student_id`),
  CONSTRAINT `portfolio_submission_ibfk_2`
    FOREIGN KEY (`capstone_id`)
    REFERENCES `databasenametask`.`capstone` (`capstone_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `databasenametask`.`queries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databasenametask`.`queries` (
  `query_id` INT NOT NULL,
  `student_id` INT NULL DEFAULT NULL,
  `mentor_id` INT NOT NULL,
  `topic_id` INT NOT NULL,
  `question` VARCHAR(255) NOT NULL,
  `answer` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`query_id`),
  UNIQUE INDEX `mentor_id` (`mentor_id` ASC) VISIBLE,
  UNIQUE INDEX `topic_id` (`topic_id` ASC) VISIBLE,
  UNIQUE INDEX `question` (`question` ASC) VISIBLE,
  UNIQUE INDEX `student_id` (`student_id` ASC) VISIBLE,
  CONSTRAINT `queries_ibfk_1`
    FOREIGN KEY (`student_id`)
    REFERENCES `databasenametask`.`students` (`student_id`),
  CONSTRAINT `queries_ibfk_2`
    FOREIGN KEY (`mentor_id`)
    REFERENCES `databasenametask`.`mentors` (`mentor_id`),
  CONSTRAINT `queries_ibfk_3`
    FOREIGN KEY (`topic_id`)
    REFERENCES `databasenametask`.`topics` (`topic_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `databasenametask`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databasenametask`.`task` (
  `task_id` INT NOT NULL,
  `topic_id` INT NULL DEFAULT NULL,
  `task_name` VARCHAR(255) NULL DEFAULT NULL,
  `description` TEXT NOT NULL,
  `deadline` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  INDEX `topic_id` (`topic_id` ASC) VISIBLE,
  CONSTRAINT `task_ibfk_1`
    FOREIGN KEY (`topic_id`)
    REFERENCES `databasenametask`.`topics` (`topic_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
