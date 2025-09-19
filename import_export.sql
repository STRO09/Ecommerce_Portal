-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 03, 2025 at 09:42 AM
-- Server version: 5.7.44-log
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `import_export`
--

DELIMITER $$
--
-- Procedures
--
select * from consumer_port;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddProduct` (IN `in_product_id` INT, IN `in_product_name` VARCHAR(255), IN `in_quantity` INT, IN `in_price` DECIMAL(10,2), IN in_seller_id INT)   BEGIN
    INSERT INTO products (product_id, product_name, quantity, price, seller_id)
    VALUES (in_product_id, in_product_name, in_quantity, in_price, in_seller_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteConsumer` (IN `userId` VARCHAR(255))   BEGIN
    -- Start a transaction
    START TRANSACTION;

    -- Delete from the consumers table
    DELETE FROM consumer_port WHERE port_id = userId;

    -- Check if the delete was successful
    IF ROW_COUNT() > 0 THEN
        COMMIT;  -- Commit if the delete was successful
    ELSE
        ROLLBACK;  -- Rollback if no rows were affected
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteProduct` (IN `in_product_id` INT)   BEGIN
    -- Delete the product with the specified product_id
    DELETE FROM products
    WHERE product_id = in_product_id;

    -- Return a success message
    SELECT 'Product deleted successfully.' AS message;

    -- Select and return the remaining products
    SELECT 
        product_id,
        product_name,
        quantity,
        price
    FROM 
        products;
END$$

drop procedure Login;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Login` (IN `in_port_name` varchar(300), IN `in_role` ENUM('Consumer','Seller'))   BEGIN
    IF in_role = 'Consumer' THEN
        SELECT password FROM consumer_port WHERE port_name = in_port_name;
    ELSEIF in_role = 'Seller' THEN
        SELECT password FROM seller_port WHERE port_name= in_port_name;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PlaceOrder` (IN `in_consumer_port_id` INT, IN `in_product_id` INT, IN `in_quantity` INT)   BEGIN
    DECLARE available_quantity INT;
    DECLARE new_order_id INT;

    -- Check available quantity of the product
    SELECT quantity INTO available_quantity
    FROM products
    WHERE product_id = in_product_id;

    IF available_quantity IS NULL THEN
        SELECT 'Order not possible: Product does not exist.' AS message;
    ELSEIF available_quantity < in_quantity THEN
        SELECT CONCAT('Order not possible: Only ', available_quantity, ' available.') AS message;
    ELSE
        -- Insert the order and capture the newly created order ID
        INSERT INTO orders (consumer_port_id, product_id, quantity, order_date, order_placed)
        VALUES (in_consumer_port_id, in_product_id, in_quantity, NOW(),1);
        
        -- Get the last inserted order ID
        SET new_order_id = LAST_INSERT_ID();
        
        -- Return confirmation message
        SELECT 'Order placed successfully.' AS message;
        
        -- View the details of the newly placed order
        SELECT 
            orders.order_id,
            orders.product_id,
            products.product_name,
            orders.consumer_port_id,
            orders.quantity,
            orders.order_date,
            orders.order_placed,
            orders.shipped,
            orders.out_for_delivery,
            orders.delivered
        FROM 
            orders
        INNER JOIN 
            products ON orders.product_id = products.product_id
        WHERE 
            orders.order_id = new_order_id;
    END IF;
END$$

drop procedure registerconsumer;

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegisterConsumer` (IN `in_port_name` varchar(300), IN `in_password` VARCHAR(255), IN `in_location` VARCHAR(255))   BEGIN
    -- Check if the consumer already exists
    IF EXISTS (SELECT 1 FROM consumer_port WHERE port_name = in_port_name) THEN
        SELECT 
            in_port_name AS port_name, 
            NULL AS password, 
            NULL AS location, 
            'Consumer' AS role,
            'Consumer already exists.' AS message;
    ELSE
        -- Insert into consumer_port table
        INSERT INTO consumer_port (port_name, password, location, role)
        VALUES (in_port_name, in_password, in_location, 'Consumer');

        -- Select the details of the added consumer
        SELECT 
            in_port_name AS port_name, 
            in_password AS password, 
            in_location AS location, 
            'Consumer' AS role,
            'Consumer registered successfully.' AS message;
    END IF;
END$$

drop procedure RegisterSeller;

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegisterSeller` (IN `in_port_name` varchar(300), IN `in_password` VARCHAR(255))   BEGIN
    -- Check if the seller already exists
    IF EXISTS (SELECT 1 FROM seller_port WHERE port_name= in_port_name) THEN
        SELECT 
            in_port_name AS port_name, 
            NULL AS password, 
            'Seller' AS role,
            'Seller already exists.' AS message;
    ELSE
        -- Insert into seller_port table
        INSERT INTO seller_port (port_name, password, role)
        VALUES (in_port_name, in_password, 'Seller');

        -- Select the details of the added seller
        SELECT 
            in_port_name AS port_name, 
            in_password AS password, 
            'Seller' AS role,
            'Seller registered successfully.' AS message;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ReportIssue` (IN `in_consumer_port_id` INT, IN `in_product_id` INT, IN `in_issue_type` ENUM('Damage','Wrong Product','Delayed','Still Not Received','Missing'))   BEGIN
    -- Insert the reported issue without assigning a solution
    INSERT INTO reported_products (consumer_port_id, product_id, issue_type, solution, report_date)
    VALUES (in_consumer_port_id, in_product_id, in_issue_type, NULL, NOW());

    SELECT 'Issue reported successfully. Awaiting resolution.' AS report_status;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ResolveIssue` (IN `in_report_id` VARCHAR(255), IN `in_solution` VARCHAR(255))   BEGIN
    -- Update the solution for the reported issue
    UPDATE reported_products
    SET solution = in_solution
    WHERE report_id = in_report_id;

    -- Check if the update was successful
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Report ID not found or no changes made.';
    ELSE
        SELECT CONCAT('Issue resolved successfully. Solution: ', in_solution) AS resolution_status;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TrackOrder` (IN `in_order_id` INT)   BEGIN
    SELECT 
        *
    FROM orders
    WHERE order_id = in_order_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateOrderStatus` (IN `in_order_id` INT, IN `in_new_status` VARCHAR(50))   BEGIN
    DECLARE existing_order INT;

    -- Check if the order exists
    SELECT COUNT(*) INTO existing_order 
    FROM orders 
    WHERE order_id = in_order_id;

    IF existing_order = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order not found.';
    ELSE
        -- Update status based on the input
        CASE in_new_status
            WHEN 'Order Placed' THEN
                UPDATE orders 
                SET order_placed = 1, shipped = 0, out_for_delivery = 0, delivered = 0
                WHERE order_id = in_order_id;
            WHEN 'Shipped' THEN
                UPDATE orders 
                SET shipped = 1, out_for_delivery = 0, delivered = 0
                WHERE order_id = in_order_id;
            WHEN 'Out for Delivery' THEN
                UPDATE orders 
                SET shipped = 1, out_for_delivery = 1, delivered = 0
                WHERE order_id = in_order_id;
            WHEN 'Delivered' THEN
                UPDATE orders 
                SET shipped = 1, out_for_delivery = 1, delivered = 1
                WHERE order_id = in_order_id;
            ELSE
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid status update';
        END CASE;

        SELECT 'Order status updated successfully.' AS message;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateProduct` (IN `in_product_id` INT, IN `in_product_name` VARCHAR(255), IN `in_quantity` INT, IN `in_price` DECIMAL(10,2))   BEGIN
    UPDATE products
    SET product_name = COALESCE(NULLIF(in_product_name, ''), product_name),
        quantity = COALESCE(in_quantity, quantity),
        price = COALESCE(in_price, price)
    WHERE product_id = in_product_id;

    SELECT 'Product updated successfully.' AS message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateProfile` (IN `in_port_id` INT, IN `in_password` VARCHAR(255), IN `in_location` VARCHAR(255))   BEGIN
    UPDATE consumer_port
    SET password = COALESCE(NULLIF(in_password, ''), password),
        location = COALESCE(NULLIF(in_location, ''), location)
    WHERE port_id = in_port_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewConsumers` ()   BEGIN
    SELECT * 
    FROM consumer_port;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewIssues` ()   BEGIN
    SELECT * 
    FROM reported_products;
END$$

drop procedure viewOrders;

CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewOrders` (in_seller_id int)   BEGIN
    SELECT 
        o.order_id,
        o.product_id,
        o.consumer_port_id,
        o.quantity,
        o.order_date,
        o.order_placed,
        o.shipped,
        o.out_for_delivery,
        o.delivered
    FROM 
        orders o inner join products p 
        on o.product_id = p.product_id 
        where p.seller_id = in_seller_id;
END$$

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewOrdersConsumer` (IN in_con_id int)   BEGIN
    SELECT 
        o.order_id,
        o.product_id,
        o.consumer_port_id,
        o.quantity,
        o.order_date,
        o.order_placed,
        o.shipped,
        o.out_for_delivery,
        o.delivered
    FROM 
        orders o 
        where o.consumer_port_id = in_con_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewProducts` ()   BEGIN
    SELECT * 
    FROM products;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewSellers` ()   BEGIN
    SELECT * 
    FROM seller_port;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `consumer_port`
--

CREATE TABLE `consumer_port` (
  `port_id` int auto_increment primary key,
  `port_name` varchar(300) UNIQUE NOT NULL,
  `password` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `role` enum('Consumer') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Dumping data for table `consumer_port`
--

INSERT INTO `consumer_port` (`port_id`, `password`, `location`, `role`) VALUES
(23, 'SAGAR', 'MUMBAI', 'Consumer');

--
-- Triggers `consumer_port`
--
DELIMITER $$
CREATE TRIGGER `BeforeUpdatePasswordValidation` BEFORE UPDATE ON `consumer_port` FOR EACH ROW BEGIN
    -- Enforce password length validation for consumer profile updates
    IF LENGTH(NEW.password) < 8 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password must be at least 8 characters long.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) auto_increment primary key,
  `product_id` int(11) DEFAULT NULL,
  `consumer_port_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `order_placed` tinyint(1) DEFAULT '1',
  `shipped` tinyint(1) DEFAULT '0',
  `out_for_delivery` tinyint(1) DEFAULT '0',
  `delivered` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `AfterInsertOrders` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
    -- Reduce stock quantity of the ordered product after an order is placed
    UPDATE products
    SET quantity = quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `BeforeInsertOrders` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN
    DECLARE available_quantity INT;
    -- Check available stock before inserting an order
    SELECT quantity INTO available_quantity FROM products WHERE product_id = NEW.product_id;

    IF available_quantity < NEW.quantity THEN
        -- Raise an error if the stock is insufficient
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock for product.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) auto_increment primary key,
  `product_name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `seller_id` int NOT NULL, foreign key(`seller_id`) references seller_port(`port_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `quantity`, `price`) VALUES
(12, 'Something', 12, 50.00);

-- --------------------------------------------------------

--
-- Table structure for table `reported_products`
--

CREATE TABLE `reported_products` (
  `report_id` int auto_increment primary key,
  `consumer_port_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `issue_type` varchar(255) NOT NULL,
  `solution` varchar(100) DEFAULT 'pending',
  `report_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `reported_products`
--
DELIMITER $$
CREATE TRIGGER `GenerateReportToken` BEFORE INSERT ON `reported_products` FOR EACH ROW BEGIN
    -- Generate a UUID for the report_id before inserting into reported_products
    SET NEW.report_id = UUID();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `seller_port`
--


CREATE TABLE `seller_port` (
  `port_id` int auto_increment primary key,
  `port_name` varchar(300) UNIQUE NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Seller') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `seller_port`
--

INSERT INTO `seller_port` (`port_id`, `password`, `role`) VALUES
(12, '$2a$10$.tKQhsxYeulAm3CgSLIQaOL.5lC/8j.bAQKHh1dlhxpsJFiXX.wAq', 'Seller'),
(21, '$2a$10$Gj0JIxN6zBbrVecNi3ihLulTh7jeYPon6wCe0wE.MwqL8ZSr6.fui', 'Seller');

--
-- Triggers `seller_port`
--
DELIMITER $$
CREATE TRIGGER `BeforeUpdatePasswordValidationSeller` BEFORE UPDATE ON `seller_port` FOR EACH ROW BEGIN
    -- Enforce password length validation for seller profile updates
    IF LENGTH(NEW.password) < 8 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password must be at least 8 characters long.';
    END IF;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `consumer_port`
--
ALTER TABLE `consumer_port`
  ADD PRIMARY KEY (`port_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `consumer_port_id` (`consumer_port_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `reported_products`
--
ALTER TABLE `reported_products`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `consumer_port_id` (`consumer_port_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `seller_port`
--
ALTER TABLE `seller_port`
  ADD PRIMARY KEY (`port_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `consumer_port`
--
ALTER TABLE `consumer_port`
  MODIFY `port_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seller_port`
--
ALTER TABLE `seller_port`
  MODIFY `port_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`consumer_port_id`) REFERENCES `consumer_port` (`port_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reported_products`
--
ALTER TABLE `reported_products`
  ADD CONSTRAINT `reported_products_ibfk_1` FOREIGN KEY (`consumer_port_id`) REFERENCES `consumer_port` (`port_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reported_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
