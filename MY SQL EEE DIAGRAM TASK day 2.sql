create database DatabaseNameTask;
use DatabaseNameTask;
create table users(
user_id int primary key,
username varchar(255) not null,
email varchar(50) not null unique,
password varchar(255) not null,
role varchar(255),
createdAt datetime default now(),
updated_at datetime
);
create table students(
student_id int primary key,
user_id int not null,
full_name varchar(255) not null,
address text not null,
phone_number varchar(255) not null,
qualification text not null,
work_experience text not null
);
create table mentors(
mentor_id int primary key,
user_id int not null,
full_name varchar(255) not null,
address text not null,
phone_number varchar(255) not null,
qualification text not null,
work_experience text not null
);
CREATE TABLE topics (
  topic_id INT PRIMARY KEY,
  topic_name VARCHAR(255),
  description TEXT,
  num_sessions INT,
  mentor_id INT
);
create table task(
task_id INT PRIMARY KEY,
  topic_id INT,
  task_name VARCHAR(255),
  description TEXT not null,
  deadline DATE
);
create table attendance(
attendance_id INT PRIMARY KEY,
  user_id INT not null,
  topic_id INT not null,
  session_date DATE,
  status VARCHAR(255)
);

create table capstone(
capstone_id INT PRIMARY KEY,
  user_id INT not null,
  project_name VARCHAR(255),
  description TEXT
);
create table queries(
query_id INT PRIMARY KEY,
  student_id INT unique,
  mentor_id INT unique not null,
  topic_id INT unique not null,
  question varchar(255) unique not null,
  answer TEXT
);
CREATE TABLE portfolio_submission (
  submission_id INT PRIMARY KEY,
  student_id INT,
  capstone_id INT,
  submission_date DATE,
  github_url VARCHAR(255),
  portfolio_url VARCHAR(255),
  resume_url VARCHAR(255)
);
ALTER TABLE `students` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
ALTER TABLE `mentors` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
ALTER TABLE `topics` ADD FOREIGN KEY (`mentor_id`) REFERENCES `mentors` (`mentor_id`);
ALTER TABLE `task` ADD FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`);
ALTER TABLE `attendance` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
ALTER TABLE `attendance` ADD FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`);
ALTER TABLE `capstone` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
ALTER TABLE `queries` ADD FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);
ALTER TABLE `queries` ADD FOREIGN KEY (`mentor_id`) REFERENCES `mentors` (`mentor_id`);
ALTER TABLE `queries` ADD FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`);
ALTER TABLE `portfolio_submission` ADD FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);
ALTER TABLE `portfolio_submission` ADD FOREIGN KEY (`capstone_id`) REFERENCES `capstone` (`capstone_id`);