CREATE TABLE Customers (
    customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Orders (
    order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status_order VARCHAR(50) NOT NULL, 
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Items (
    item_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity_available INT NOT NULL
);

CREATE TABLE OrderItems (
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES Items(item_id)
);

CREATE TABLE Employees (
    employee_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL
);

CREATE TABLE EmployeeOrders (
    employee_id INT NOT NULL,
    order_id INT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Payments (
    payment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Customers (name, email, phone) VALUES
('Анна', 'anna@mail.com', '89130000000'),
('Петр', 'petr@mail.com', '89131111111'),
('Мария', 'maria@mail.com', '89132222222'),
('Иван', 'ivan@mail.com', '89133333333'),
('Елена', 'elena@mail.com', '89134444444'),
('Дмитрий', 'dmitry@mail.com', '89135555555'),
('Ольга', 'olga@mail.com', '89136666666'),
('Сергей', 'sergey@mail.com', '89137777777'),
('Татьяна', 'tatyana@mail.com', '89138888888'),
('Алексей', 'alexey@mail.com', '89139999999');

INSERT INTO Orders (customer_id, total_amount, status_order) VALUES
(1, 150.00, 'Ожидание'),
(2, 200.50, 'В процессе'),
(3, 75.25, 'Завершён'),
(4, 300.00, 'Ожидание'),
(5, 120.75, 'Ожидание'),
(6, 180.00, 'В процессе'),
(7, 90.50, 'Завершён'),
(8, 250.00, 'В процессе'),
(9, 80.00, 'Ожидание'),
(10, 150.25, 'Завершён');

INSERT INTO Items (name, price, quantity_available) VALUES
('Платье', 50.00, 20),
('Юбка', 40.00, 30),
('Брюки', 60.00, 25),
('Рубашка', 35.00, 40),
('Пиджак', 80.00, 15),
('Пальто', 100.00, 10),
('Футболка', 20.00, 50),
('Джинсы', 45.00, 35),
('Костюм', 120.00, 18),
('Куртка', 90.00, 22);

INSERT INTO OrderItems (order_id, item_id, quantity) VALUES
(1, 1, 2),
(2, 3, 1),
(3, 5, 3),
(4, 2, 4),
(5, 7, 2),
(6, 10, 1),
(7, 9, 5),
(8, 4, 2),
(9, 8, 3),
(10, 6, 1);

INSERT INTO Employees (name, position) VALUES
('Ирина', 'Кутюрье'),
('Александр', 'Швея'),
('Евгений', 'Модельер'),
('Виктория', 'Дизайнер'),
('Николай', 'Технолог'),
('Маргарита', 'Менеджер'),
('Станислав', 'Руководитель цеха'),
('Елена', 'Вышивальщица'),
('Антон', 'Столяр'),
('Ольга', 'Стажер');

INSERT INTO EmployeeOrders (employee_id, order_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO Payments (order_id, amount, payment_date) VALUES
(1, 150.00, '2023-10-15'),
(3, 75.25, '2023-11-22'),
(5, 120.75, '2023-12-05'),
(7, 90.50, '2023-12-18'),
(9, 80.00, '2024-01-02'),
(2, 50.00, '2023-11-01'),
(4, 150.00, '2023-11-10'),
(6, 180.00, '2023-11-25'),
(8, 200.00, '2023-12-01'),
(10, 150.25, '2024-01-03');
