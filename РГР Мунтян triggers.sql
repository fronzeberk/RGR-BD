CREATE TRIGGER prevent_customer_deletion
BEFORE DELETE ON Customers
FOR EACH ROW
BEGIN
    DECLARE order_count INT;
    SELECT COUNT(*) INTO order_count FROM Orders WHERE customer_id = OLD.customer_id;
    IF order_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Нельзя удалить клиента, имеющего заказы';
    END IF;
END;

CREATE TRIGGER prevent_order_update
BEFORE UPDATE ON Orders
FOR EACH ROW
BEGIN
    DECLARE payment_count INT;
    SELECT COUNT(*) INTO payment_count FROM Payments WHERE order_id = OLD.order_id;
    IF payment_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Нельзя изменить заказ, имеющий оплату';
    END IF;
END;

CREATE TRIGGER prevent_item_deletion
BEFORE DELETE ON Items
FOR EACH ROW
BEGIN
    DECLARE order_item_count INT;
    SELECT COUNT(*) INTO order_item_count FROM OrderItems WHERE item_id = OLD.item_id;
    IF order_item_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Нельзя удалить товар, используемый в заказах';
    END IF;
END;

CREATE TRIGGER prevent_employee_deletion
BEFORE DELETE ON Employees
FOR EACH ROW
BEGIN
    DECLARE employee_order_count INT;
    SELECT COUNT(*) INTO employee_order_count FROM EmployeeOrders WHERE employee_id = OLD.employee_id;
    IF employee_order_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Нельзя удалить сотрудника, имеющего назначенные заказы';
    END IF;
END;

CREATE TRIGGER prevent_orderitem_deletion
BEFORE DELETE ON OrderItems
FOR EACH ROW
BEGIN
    DECLARE status_order VARCHAR(50);
    SELECT status INTO status_order FROM Orders WHERE order_id = OLD.order_id;
    IF status_order = 'Завершён' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Нельзя удалить товар из заказа, если заказ завершён';
    END IF;
END;

CREATE TRIGGER prevent_payment_deletion
BEFORE DELETE ON Payments
FOR EACH ROW
BEGIN
    DECLARE status_order VARCHAR(50);
    SELECT status INTO status_order FROM Orders WHERE order_id = OLD.order_id;
    IF status_order = 'Завершён' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Нельзя удалить оплату, если связанный заказ завершён';
    END IF;
END;

CREATE TRIGGER prevent_payment_amount_exceed
BEFORE INSERT ON Payments
FOR EACH ROW
BEGIN
    DECLARE order_amount DECIMAL(10, 2);
    SELECT total_amount INTO order_amount FROM Orders WHERE order_id = NEW.order_id;
    IF NEW.amount > order_amount THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Нельзя внести оплату больше общей суммы заказа';
    END IF;
END;

CREATE TRIGGER prevent_orderitem_quantity_exceed
BEFORE INSERT ON OrderItems
FOR EACH ROW
BEGIN
    DECLARE available_quantity INT;
    SELECT quantity_available INTO available_quantity FROM Items WHERE item_id = NEW.item_id;
    IF NEW.quantity > available_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Нельзя внести количество товара больше доступного';
    END IF;
END;

CREATE TRIGGER prevent_item_price_update
BEFORE UPDATE ON Items
FOR EACH ROW
BEGIN
    DECLARE order_item_count INT;
    SELECT COUNT(*) INTO order_item_count FROM OrderItems WHERE item_id = OLD.item_id;
    IF order_item_count > 0 AND OLD.price <> NEW.price THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Нельзя изменить цену товара, если у него есть связанные заказы';
    END IF;
END;

CREATE TRIGGER prevent_employee_order_assignment
BEFORE UPDATE ON EmployeeOrders
FOR EACH ROW
BEGIN
    DECLARE status_order VARCHAR(50);
    SELECT status INTO status_order FROM Orders WHERE order_id = NEW.order_id;
    IF status_order = 'Завершён' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Нельзя изменить назначение сотрудника для завершённых заказов';
    END IF;
END;