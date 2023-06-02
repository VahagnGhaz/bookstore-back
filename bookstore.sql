DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) default null,
    `type` VARCHAR(255) default null,
    `author` VARCHAR(255) default null,
    `price` DECIMAL(10, 2) default null,
    `description` VARCHAR(2000) default null,
    `inventory` INT(11) default null,
    `image` VARCHAR(255) default null
);
INSERT INTO `books` VALUES ('1',  'The Great Gatsby', 'Fiction', 'F. Scott Fitzgerald', '95.20', 'A novel about the decadence and excess of the Jazz Age', '1000', 'https://m.media-amazon.com/images/I/71jaj8WPG4L._AC_UF1000,1000_QL80_.jpg');
INSERT INTO `books` VALUES ('2',  '1984', 'Dystopian', 'George Orwell', '120.50', 'A dystopian novel about a society under total surveillance', '900', 'https://m.media-amazon.com/images/I/519zR2oIlmL._AC_UF894,1000_QL80_.jpg');
INSERT INTO `books` VALUES ('3',  'To Kill a Mockingbird', 'Fiction', 'Harper Lee', '85.75', 'A classic novel of racism and injustice', '1200', 'https://yourwebsite.com/path/to/imageMockingbird.jpg');
INSERT INTO `books` VALUES ('4',  'Moby-Dick', 'Adventure', 'Herman Melville', '110.00', 'An epic sea story of Captain Ahab’s obsessive quest to hunt down the great white whale Moby Dick', '700', 'https://yourwebsite.com/path/to/imageMobyDick.jpg');
INSERT INTO `books` VALUES ('5', 'Pride and Prejudice', 'Romance', 'Jane Austen', '80.25', 'A romantic novel about manners, upbringing, morality, education, and marriage in the society of the British landed gentry', '1300', 'https://yourwebsite.com/path/to/imagePrideAndPrejudice.jpg');


CREATE TABLE users (
	`id` int(11) PRIMARY KEY AUTO_INCREMENT,
    `name` varchar(255) Not Null,
	`address` VARCHAR(255)  default NULL,
    `telephone` VARCHAR(15)  default NULL
   --  `userAuth` Int(11)  default NULL
);

CREATE TABLE user_auth (
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `email` VARCHAR(255) NOT NULL UNIQUE,
	`password` VARCHAR(255) NOT NULL,
    -- `user_type` int(11) NOT NULL, -- 1 = admin, 2 = user
    `user_id` INT(11),
	FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

-- ALTER TABLE UserAuth ADD CONSTRAINT FK_UserAuth_UserID FOREIGN KEY (user) REFERENCES Users(id);
-- ALTER TABLE Users ADD CONSTRAINT FK_User_UserAuthID FOREIGN KEY (userAuth) REFERENCES UserAuth(id);

-- Add admin user
INSERT INTO users (name, address, telephone) VALUES ('Vahagn', 'st. Bagratunyac 30, Yerevan, Armenia', '+717269740816');
SET @last_id_in_Users = LAST_INSERT_ID();
INSERT INTO user_auth (email, password, user_type, user_id) VALUES ('vgn.ghazaryan@gmail.com', '123', 1, @last_id_in_Users);

-- Add standard user
INSERT INTO users (name, address, telephone) VALUES ('Simon', 'st. dongchuanglu 800, Shanghai, China', '+717269540816');
SET @last_id_in_Users = LAST_INSERT_ID();
INSERT INTO user_auth (email, password, user_type, user_id) VALUES ('simon.krkyasharyan@gmail.com', '321', 2, @last_id_in_Users);

CREATE TABLE `cart_items` (
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT(11),
    `book_id` INT(11),
    `quantity` INT(11) NOT NULL,
    `price` DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    FOREIGN KEY (`book_id`) REFERENCES `books` (`id`)
);

CREATE TABLE `orders` (
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT(11),
    `order_date` DATETIME NOT NULL,
    `total_price` DECIMAL(10,2) NOT NULL,
    `shipping_address` VARCHAR(255) NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

CREATE TABLE `order_items` (
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
	`order_id` INT(11),
    `book_id` INT(11),
    `quantity` INT(11) NOT NULL,
    `price` DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
    FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
);



DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS cart_items;
DROP TABLE IF EXISTS user_auth;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS books;