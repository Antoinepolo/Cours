SELECT COUNT(*) FROM users WHERE age < 50

CREATE INDEX count_user ON users(age);

DROP INDEX count_user ON users;