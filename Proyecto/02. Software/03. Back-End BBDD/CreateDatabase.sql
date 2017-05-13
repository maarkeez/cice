create database SELL_IT_EASY;
CREATE USER 'selliteasy'@'localhost' IDENTIFIED BY '9DZ6pwO7';
GRANT ALL PRIVILEGES ON SELL_IT_EASY . * TO 'selliteasy'@'localhost';
FLUSH PRIVILEGES;