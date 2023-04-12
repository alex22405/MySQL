DROP DATABASE IF EXISTS `bookstore`;
CREATE DATABASE IF NOT EXISTS `bookstore`;

USE `bookstore`;


CREATE TABLE `publication`(
    `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `isbn` VARCHAR(13) NOT NULL,
    `ean` VARCHAR(128) NOT NULL,
    `available` BOOLEAN DEFAULT 1,
    `publishing_date` DATE NOT NULL,
    `volume` INT UNSIGNED,
    `astract` TEXT NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE=InnoDb;

CREATE TABLE `prize`(
    `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `name` VARCHAR(32) NOT NULL,
    `description` TEXT NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE=InnoDb;

CREATE TABLE `prize_for_publication`(
    `prize` INT UNSIGNED,
    `publication` INT UNSIGNED,
    `prizing-date` DATE NOT NULL,
    PRIMARY KEY (`prize`, `publication`)
) ENGINE=InnoDb;

CREATE TABLE `prize_for_contributor`(
    `prize`INT UNSIGNED,
    `contributor`INT UNSIGNED,
    `prizing_date` DATE NOT NULL,
    PRIMARY KEY (`prize`, `contributor`)
) ENGINE=InnoDb;

CREATE TABLE `manuscript`(
    `uuid` VARCHAR(32) NOT NULL,
    `reference` VARCHAR(32) NOT NULL,
    `title` VARCHAR(32) NOT NULL,
    `subtitle` VARCHAR(32) NOT NULL,
    `content` VARCHAR(32) NOT NULL,
    `creation_date` DATE NOT NULL,
    `language` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDb;

CREATE TABLE `manuscript_by_publication`(
    `manuscript` VARCHAR(32),
    `publication` INT UNSIGNED,
    PRIMARY KEY (`manuscript`,`publication`)
) ENGINE=InnoDb;

CREATE TABLE `manuscript_by_contributor`(
    `manuscript` VARCHAR(32),
    `contributor`INT UNSIGNED,
    PRIMARY KEY (`manuscript`, `contributor`)
) ENGINE=InnoDb;

CREATE TABLE `contributor`(
    `id` INT UNSIGNED,
    `firstname` VARCHAR(32) NOT NULL,
    `lastname` VARCHAR(32) NOT NULL,
    `nickname` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDb;

CREATE TABLE `contributor_by_role`(
    `role` VARCHAR(32) NOT NULL,
    `contributor`INT UNSIGNED,
    PRIMARY KEY (`role`, `contributor`)
) ENGINE=InnoDb;

CREATE TABLE `contributor_role`(
    `label` VARCHAR(32) NOT NULL,
    `name` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`label`)
) ENGINE=InnoDb;

CREATE TABLE `publication_by_collection`(
    `collection` VARCHAR(32) NOT NULL,
    `publication` INT UNSIGNED,
    PRIMARY KEY (`collection`,`publication`)
) ENGINE=InnoDb;

CREATE TABLE `collection`(
    `label` VARCHAR(32) NOT NULL,
    `publisher` VARCHAR(32) NOT NULL,
    `name` VARCHAR(32) NOT NULL,
    `description` TEXT NOT NULL,
    PRIMARY KEY (`label`)
) ENGINE=InnoDb;

CREATE TABLE `publisher`(
    `label`VARCHAR(32) NOT NULL,
    `headquarter` INT UNSIGNED,
    `name` VARCHAR(32) NOT NULL,
    `logo` VARCHAR(255) NOT NULL,
    `siret` VARCHAR(14) NOT NULL,
    `siren` VARCHAR(9) NOT NULL,
    `phone` INT(15),
    `email` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`label`)
) ENGINE=InnoDb;

CREATE TABLE `place`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `country` VARCHAR(32) NOT NULL,
    `zipcode` INT,
    `street` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDb;

CREATE TABLE `third_party`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `where` INT UNSIGNED,
    PRIMARY KEY (`id`)
) ENGINE=InnoDb;

CREATE TABLE `implied_third_party`(
    `publication` INT UNSIGNED,
    `third_party` INT UNSIGNED,
    PRIMARY KEY (`publication`, `third_party`)
) ENGINE=InnoDb;

CREATE TABLE `third_party_by_role`(
    `role` VARCHAR(32) NOT NULL,
    `third_party` INT UNSIGNED,
    PRIMARY KEY (`role`,`third_party`)
) ENGINE=InnoDb;

CREATE TABLE `third_party_role`(
    `label` VARCHAR(32) NOT NULL,
    `name` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`label`)
) ENGINE=InnoDb;

/* ***********Création des clés étrangères********** */

ALTER TABLE `prize_for_publication` ADD FOREIGN KEY (`prize`) REFERENCES `prize`(`id`);
ALTER TABLE `prize_for_publication` ADD FOREIGN KEY (`publication`) REFERENCES `publication`(`id`);

ALTER TABLE `prize_for_contributor`ADD FOREIGN KEY (`prize`) REFERENCES `prize` (`id`);
ALTER TABLE `prize_for_contributor` ADD FOREIGN KEY (`contributor`) REFERENCES `contributor` (`id`);

ALTER TABLE `manuscript_by_publication`ADD FOREIGN KEY (`manuscript`) REFERENCES `manuscript` (`uuid`);
ALTER TABLE `manuscript_by_publication` ADD FOREIGN KEY (`publication`) REFERENCES `publication` (`id`);

ALTER TABLE `manuscript`ADD FOREIGN KEY (`reference`) REFERENCES `manuscript` (`uuid`);

ALTER TABLE `manuscript_by_contributor`ADD FOREIGN KEY (`manuscript`) REFERENCES `manuscript` (`uuid`);
ALTER TABLE `manuscript_by_contributor` ADD FOREIGN KEY (`contributor`) REFERENCES `contributor` (`id`);

ALTER TABLE `contributor_by_role`ADD FOREIGN KEY (`role`) REFERENCES `contributor_role` (`label`);
ALTER TABLE `contributor_by_role` ADD FOREIGN KEY (`contributor`) REFERENCES `contributor` (`id`);

ALTER TABLE `publisher`ADD FOREIGN KEY (`headquarter`) REFERENCES `place` (`id`);

ALTER TABLE `collection`ADD FOREIGN KEY (`publisher`) REFERENCES `publisher` (`label`);

ALTER TABLE `publication_by_collection`ADD FOREIGN KEY (`collection`) REFERENCES `collection` (`label`);
ALTER TABLE `publication_by_collection` ADD FOREIGN KEY (`publication`) REFERENCES `publication` (`id`);

ALTER TABLE `implied_third_party`ADD FOREIGN KEY (`publication`) REFERENCES `publication` (`id`);
ALTER TABLE `implied_third_party` ADD FOREIGN KEY (`third_party`) REFERENCES `third_party` (`id`);

ALTER TABLE `third_party`ADD FOREIGN KEY (`where`) REFERENCES `place` (`id`);

ALTER TABLE `third_party_by_role`ADD FOREIGN KEY (`role`) REFERENCES `third_party_role` (`label`);
ALTER TABLE `third_party_by_role` ADD FOREIGN KEY (`third_party`) REFERENCES `third_party` (`id`);
