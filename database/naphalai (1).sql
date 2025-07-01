-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 26, 2025 at 10:10 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `naphalai`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_addresses`
--

CREATE TABLE `tb_addresses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(144) NOT NULL,
  `address_line1` varchar(255) NOT NULL,
  `address_line2` varchar(255) NOT NULL,
  `city` varchar(144) NOT NULL,
  `postal_code` varchar(10) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Address details of user';

-- --------------------------------------------------------

--
-- Table structure for table `tb_carts`
--

CREATE TABLE `tb_carts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_cart_items`
--

CREATE TABLE `tb_cart_items` (
  `id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_sku_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_categories`
--

CREATE TABLE `tb_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Categories table which is parent of sub categories';

-- --------------------------------------------------------

--
-- Table structure for table `tb_order_details`
--

CREATE TABLE `tb_order_details` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_order_items`
--

CREATE TABLE `tb_order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_sku_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_payment_details`
--

CREATE TABLE `tb_payment_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `provider` varchar(255) NOT NULL,
  `status` enum('pending','paid','failed','cancelled') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_products`
--

CREATE TABLE `tb_products` (
  `id` int(11) NOT NULL,
  `name` varchar(144) NOT NULL,
  `desciprion` varchar(600) NOT NULL,
  `summary` varchar(255) NOT NULL,
  `cover` varchar(255) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `categories_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='products table which include sub categories';

-- --------------------------------------------------------

--
-- Table structure for table `tb_products_atrributes`
--

CREATE TABLE `tb_products_atrributes` (
  `id` int(11) NOT NULL,
  `type` enum('size','color') NOT NULL,
  `value` varchar(255) NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_products_skus`
--

CREATE TABLE `tb_products_skus` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `size_attribute_id` int(11) NOT NULL,
  `color_attribute_id` int(11) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `quantitty` int(11) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_sub_categories`
--

CREATE TABLE `tb_sub_categories` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_users`
--

CREATE TABLE `tb_users` (
  `id` int(11) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `username` varchar(24) NOT NULL,
  `password` varchar(180) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `email` varchar(64) NOT NULL,
  `date_of_birth` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_users`
--

INSERT INTO `tb_users` (`id`, `avatar`, `first_name`, `last_name`, `username`, `password`, `phone_number`, `email`, `date_of_birth`, `created_at`) VALUES
(1, '', '', '', 'lambo', '$2b$10$9/5d8GOP1gkr0bk9KrRcoOvA/wIVA4bu9xES.I9uLqxNBjMKwr/B6', '2012345', 'bo@gmail.com', '0000-00-00', '2025-06-25 16:24:45'),
(2, '', '', '', 'lambos', '$2b$10$QYRLzmK1cOtlvlU4NYyLnODv31bfXZyw7wYSlxQiMWOKYi.KDXoAe', '2012345', 'bo@gmail.com', '0000-00-00', '2025-06-25 16:26:33'),
(3, '', '', '', 'lambo1', '$2b$10$hs9YL85nTc2y5ICZuqhxbu4ZCBcpF0lQdRHhJUj0hqlF1y949OE8C', '2012345', 'bo@gmail.com', '0000-00-00', '2025-06-25 16:26:41');

-- --------------------------------------------------------

--
-- Table structure for table `tb_wishlist`
--

CREATE TABLE `tb_wishlist` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_addresses`
--
ALTER TABLE `tb_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Users` (`user_id`);

--
-- Indexes for table `tb_carts`
--
ALTER TABLE `tb_carts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_cart_items`
--
ALTER TABLE `tb_cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Cart items w/ Cart` (`cart_id`),
  ADD KEY `Cart items w/ Products` (`product_id`),
  ADD KEY `Cart items w/ P_SKU` (`product_sku_id`);

--
-- Indexes for table `tb_categories`
--
ALTER TABLE `tb_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_order_details`
--
ALTER TABLE `tb_order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_order_items`
--
ALTER TABLE `tb_order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Order item w/ Products` (`product_id`),
  ADD KEY `Order item w/ Order Details` (`order_id`),
  ADD KEY `Order item w/ P_SKU` (`product_sku_id`);

--
-- Indexes for table `tb_payment_details`
--
ALTER TABLE `tb_payment_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Payment details w/ Order details` (`order_id`);

--
-- Indexes for table `tb_products`
--
ALTER TABLE `tb_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Product w/ Categories` (`categories_id`);

--
-- Indexes for table `tb_products_atrributes`
--
ALTER TABLE `tb_products_atrributes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_products_skus`
--
ALTER TABLE `tb_products_skus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Size attribute` (`size_attribute_id`),
  ADD KEY `Color attribute` (`color_attribute_id`);

--
-- Indexes for table `tb_sub_categories`
--
ALTER TABLE `tb_sub_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Categories` (`parent_id`);

--
-- Indexes for table `tb_users`
--
ALTER TABLE `tb_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_wishlist`
--
ALTER TABLE `tb_wishlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Wishlist w/ Users` (`user_id`),
  ADD KEY `Wishlist w/ Products` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_users`
--
ALTER TABLE `tb_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tb_addresses`
--
ALTER TABLE `tb_addresses`
  ADD CONSTRAINT `Users` FOREIGN KEY (`user_id`) REFERENCES `tb_users` (`id`);

--
-- Constraints for table `tb_cart_items`
--
ALTER TABLE `tb_cart_items`
  ADD CONSTRAINT `Cart items w/ Cart` FOREIGN KEY (`cart_id`) REFERENCES `tb_carts` (`id`),
  ADD CONSTRAINT `Cart items w/ P_SKU` FOREIGN KEY (`product_sku_id`) REFERENCES `tb_products_skus` (`id`),
  ADD CONSTRAINT `Cart items w/ Products` FOREIGN KEY (`product_id`) REFERENCES `tb_products` (`id`);

--
-- Constraints for table `tb_order_items`
--
ALTER TABLE `tb_order_items`
  ADD CONSTRAINT `Order item w/ Order Details` FOREIGN KEY (`order_id`) REFERENCES `tb_order_details` (`id`),
  ADD CONSTRAINT `Order item w/ P_SKU` FOREIGN KEY (`product_sku_id`) REFERENCES `tb_products_skus` (`id`),
  ADD CONSTRAINT `Order item w/ Products` FOREIGN KEY (`product_id`) REFERENCES `tb_products` (`id`);

--
-- Constraints for table `tb_payment_details`
--
ALTER TABLE `tb_payment_details`
  ADD CONSTRAINT `Payment details w/ Order details` FOREIGN KEY (`order_id`) REFERENCES `tb_order_details` (`id`);

--
-- Constraints for table `tb_products`
--
ALTER TABLE `tb_products`
  ADD CONSTRAINT `Product w/ Categories` FOREIGN KEY (`categories_id`) REFERENCES `tb_sub_categories` (`id`);

--
-- Constraints for table `tb_products_skus`
--
ALTER TABLE `tb_products_skus`
  ADD CONSTRAINT `Color attribute` FOREIGN KEY (`color_attribute_id`) REFERENCES `tb_products_atrributes` (`id`),
  ADD CONSTRAINT `Size attribute` FOREIGN KEY (`size_attribute_id`) REFERENCES `tb_products_atrributes` (`id`);

--
-- Constraints for table `tb_sub_categories`
--
ALTER TABLE `tb_sub_categories`
  ADD CONSTRAINT `Categories` FOREIGN KEY (`parent_id`) REFERENCES `tb_categories` (`id`);

--
-- Constraints for table `tb_wishlist`
--
ALTER TABLE `tb_wishlist`
  ADD CONSTRAINT `Wishlist w/ Products` FOREIGN KEY (`product_id`) REFERENCES `tb_products` (`id`),
  ADD CONSTRAINT `Wishlist w/ Users` FOREIGN KEY (`user_id`) REFERENCES `tb_users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
