CREATE TABLE IF NOT EXISTS `user` (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  version int(11) NOT NULL DEFAULT '0',
  created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- insert 3 rows to users table if not exists (for testing)
INSERT IGNORE INTO `user` (id, name, email, password) VALUES
(1, 'John Doe', 'john.doe@gmail.com', '123456'),
(2, 'Jane Doe', 'jane.doe@gmail.com', '123456'),
(3, 'John Smith', 'john.smith@gmail.com', '123456');

