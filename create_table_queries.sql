Database name - credit_card_ranking

Table-1: CREATE TABLE `credit_card` (
  `CId` int(11) NOT NULL AUTO_INCREMENT,
  `card_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`CId`)
);

Table-2: CREATE TABLE `question_table` (
  `QId` int(11) NOT NULL AUTO_INCREMENT,
  `Text` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`QId`)
);

Table-3: CREATE TABLE `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `email_id` varchar(200) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(200) NOT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `email_id` (`email_id`)
);

Table-4: CREATE TABLE `questions_for_credit_cards` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `QuesNo` int(11) NOT NULL,
  `CardNo` int(11) NOT NULL,
  `Points` int(11) NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `card_quest_combination` (`CardNo`,`QuesNo`),
  KEY `QuesNo` (`QuesNo`),
  CONSTRAINT `questions_for_credit_cards_ibfk_1` FOREIGN KEY (`CardNo`) REFERENCES `credit_card` (`CId`),
  CONSTRAINT `questions_for_credit_cards_ibfk_2` FOREIGN KEY (`QuesNo`) REFERENCES `question_table` (`QId`)
);

Table-5: CREATE TABLE `user_preference` (
  `user_id` int(11) NOT NULL,
  `QuesNo` int(11) NOT NULL,
  UNIQUE KEY `card_quest_combination` (`user_id`,`QuesNo`),
  KEY `QuesNo` (`QuesNo`),
  CONSTRAINT `user_preference_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`userId`),
  CONSTRAINT `user_preference_ibfk_2` FOREIGN KEY (`QuesNo`) REFERENCES `question_table` (`QId`)
);
