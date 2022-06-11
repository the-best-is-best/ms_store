-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 11, 2022 at 09:04 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tbib_store`
--

-- --------------------------------------------------------

--
-- Table structure for table `about_us_tbib_store`
--

CREATE TABLE `about_us_tbib_store` (
  `id` int(11) NOT NULL,
  `textEN` text NOT NULL,
  `textAR` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `about_us_tbib_store`
--

INSERT INTO `about_us_tbib_store` (`id`, `textEN`, `textAR`) VALUES
(1, 'about us', 'من نحن');

-- --------------------------------------------------------

--
-- Table structure for table `cart_tbib_store`
--

CREATE TABLE `cart_tbib_store` (
  `id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `category_tbib_store`
--

CREATE TABLE `category_tbib_store` (
  `id` int(11) NOT NULL,
  `nameEN` varchar(255) NOT NULL,
  `nameAR` varchar(255) NOT NULL,
  `parent` int(11) DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `displayInHome` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category_tbib_store`
--

INSERT INTO `category_tbib_store` (`id`, `nameEN`, `nameAR`, `parent`, `image`, `displayInHome`) VALUES
(1, 'Clothes', 'ملابس', 0, '', 1),
(2, 'T-Shirt', 'تي شيرت', 1, 'storage/category/img/6286b2585ddfc2.01306582.png', 0),
(3, 'jeans', 'جينز', 1, 'storage/category/img/6286b3fb1b9d70.26356101.png', 0),
(4, 'Shoes', 'احزيه', 0, '', 1),
(5, 'Skechers', 'سكيتشرز', 4, 'storage/category/img/6286b585aa7f15.82829518.png', 0),
(6, 'Zelda', 'زيلدا', 4, 'storage/category/img/6286ba3533baa7.09532027.png', 0),
(7, 'Sneakers', 'أحذية رياضية', 4, 'storage/category/img/629a548a644398.55741015.png', 0),
(8, 'Bags', 'شنط', 0, '', 1),
(9, 'Woman Bags', 'شنط حريمي', 8, 'storage/category/img/629a587aaf2684.98211010.png', 0),
(10, 'Dress', 'فستان', 1, 'storage/category/img/62a3a678ac0f71.90370374.png', 0),
(11, 'Steve Madden', 'ستيف مادن', 8, 'storage/category/img/62a3a8f12ebdb1.34274201.jpg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `contact_us_tbib_store`
--

CREATE TABLE `contact_us_tbib_store` (
  `id` int(11) NOT NULL,
  `titleEN` text NOT NULL,
  `titleAR` text NOT NULL,
  `telephone` varchar(255) NOT NULL,
  `facebookUrl` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contact_us_tbib_store`
--

INSERT INTO `contact_us_tbib_store` (`id`, `titleEN`, `titleAR`, `telephone`, `facebookUrl`) VALUES
(1, 'Contact Us via', 'اتصل بنا عبر', '01271221461', 'https://www.facebook.com/');

-- --------------------------------------------------------

--
-- Table structure for table `favorite_tbib_store`
--

CREATE TABLE `favorite_tbib_store` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `products_tbib_store`
--

CREATE TABLE `products_tbib_store` (
  `id` int(11) NOT NULL,
  `nameEN` varchar(255) NOT NULL,
  `nameAR` varchar(255) NOT NULL,
  `image` text NOT NULL,
  `price` float NOT NULL,
  `price_after_dis` float NOT NULL,
  `descriptionEN` text NOT NULL,
  `descriptionAR` text NOT NULL,
  `categoryId` int(11) NOT NULL,
  `offers` tinyint(1) NOT NULL DEFAULT 0,
  `sale` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products_tbib_store`
--

INSERT INTO `products_tbib_store` (`id`, `nameEN`, `nameAR`, `image`, `price`, `price_after_dis`, `descriptionEN`, `descriptionAR`, `categoryId`, `offers`, `sale`) VALUES
(1, 'AE Pique Polo Shirt', 'تي-شيرت بولو من نسيج البيكيه', 'storage/products/img/6286b32c5f43e9.19846430.png', 600, 0, 'The Details\n\n    Stretch pique fabric\n    Collared neck\n    Short sleeves\n    Two button placket\n    Tipped details\n\nMaterials & Care\n\n    97% Cotton, 3% Elastane\n    Machine wash\n\nSize & Fit\n\n    Standard fit: comfortable & casual, it\'s your go-to everyday fit\n    Standard length', 'تفاصيل\n\n    قطن بيكيه المرن\n    قبة مزودة بياقة\n    أكمام قصيرة\n    تصميم مزود بزرين\n    تفاصيل مدببة\n\nإرشادات العناية ومادة الصنع\n\n    97% قطن، 3% إيلاستان\n    قابل للغسيل في الغسالة\n\nالمقاس و القصة\n\n    قصة عادية: مناسبة للارتداء اليومي وتمنحك راحة الارتداء وإطلالة عصرية\n    طول عادي', 2, 0, 0),
(2, 'dark-wash jeans', 'بنطلون جينز بكحته داكنة', 'storage/products/img/6286b48c91b628.48556054.png', 399.99, 0, 'Features and benefits\nJust like any other pair of jeans, but with one big difference – theyre comfy to wear! Thats because theyre made from soft cotton with added stretch to give legs room to hop, skip and jump. With an elasticated waistband for a great fit as they grow. And pockets for the important things, like sweets and action toys. If you like this pair, youll be pleased to hear they come in three different washes – choose your favourite now!\n\n    elasticated waistband for a great fit;mock fly with popper fastening for easy outfit changes;front and back pockets;soft, stretchy fabric for comfort\n    Blue\n    machine washable\n    98.8% cotton 1.2% elastane\n    keep away from fire\n\nSpecifications\n\n    Color: Blue\n    Product brand: Mothercare', 'المزايا و الفوائد\nأكثر ما يميز هذا البنطلون هو تصميمه المريح والمثالي للارتداء اليومي. فهو منسوج من القطن الناعم بتصميم أجزاء مرنة على الساقين توفر حرية الحركة في أوقات القفز والحركة. كما أنه مصمم بشريط خصر مرن لضبط المقاس والتكيف مع طفلك المتنامي. تكتمل أناقة البنطلون بجيوب عملة لتخزن الحلوى والألعاب. فضلاً عن كونه متوفر بثلاثة أنماط مختلفة ومميزة سيعشقها طفلك كثيراً.\n\n    لباس نوم مصنوع من القطن الناعم والمرن؛ أزرار تثبيت لضمان سهولة الارتداء؛ قفازات لمنع الخدوش (لمقاسات حتى 3-6 شهور)؛ تصميم مغلق عند القدمين يمنع التفاف الخيوط حول قدم الطفل؛ جوارب مقاومة للانزلاق (للمقاسات من عمر 9-12 شهر وأكبر)؛ أزرار ملونة لتثبيت الأزرار بشكل صحيح؛ جميع الأزرار خالية من النيكل لمنع تهيّج بشرة الطفل الرقيقة\n    وردي\n    إرشادات العناية: الغسيل في الغسالة\n    100% قطن\n    إرشادات السلامة: ابق المنتج بعيداً عن النار\n\nالمواصفات\n\n    اللون: أزرق\n    العلامة التجارية: Mothercare', 3, 0, 0),
(3, 'SKECHERS FLEX APPEAL 4.0 SPORTS Collection for WOMEN color Navy Blue', 'SKECHERS FLEX APPEAL 4.0 SPORTS Collection for WOMEN color Navy Blue', 'storage/products/img/6286b61e9d6997.66372757.png', 1199.99, 0, 'About this item\n\n    Skechers Memory Foam cushioned comfort insole\n    Lightweight flexible shock-absorbing midsole\n    Flexible rubber traction outsole\n    Flexible outsole\n    Lightweight shock-absorbing midsole\n\n    Date First Available: 17 April 2022\n    Manufacturer: Skechers\n    ASIN: B09Y4QYDFB\n    Item model number: 149303\n    Department: Womens\n\nDescription\n\nSKECHERS FLEX APPEAL 4.0 SHOES for WOMEN For All Day Comfort', 'حول هذا البند\n\n     نعل داخلي مبطن بتقنية ميموري فوم من سكيتشرز\n     نعل أوسط مرن خفيف الوزن ممتص للصدمات\n     نعل سفلي مطاطي مرن\n     نعل خارجي مرن\n     نعل اوسط خفيف الوزن ممتص للصدمات\n\n     تاريخ توفر أول منتج: 17 أبريل 2022\n     الشركة المصنعة: سكيتشرز\n     ASIN: B09Y4QYDFB\n     رقم موديل السلعة: 149303\n     القسم: نسائي\n\n وصف\n\n حذاء رياضي من سكيتشرز 4.0 مرن للنساء لراحة طوال اليوم', 5, 1, 0),
(4, 'SKECHERS FLEX APPEAL 4.0 SPORTS Collection for WOMEN color Black', 'مجموعة SKECHERS FLEX APPEAL 4.0 SPORTS للألوان النسائيةاسود', 'storage/products/img/6286b9ec2aa411.01764094.png', 999.99, 499.99, 'About this item\n\n    Skechers Memory Foam cushioned comfort insole\n    Lightweight flexible shock-absorbing midsole\n    Flexible rubber traction outsole\n    Flexible outsole\n    Lightweight shock-absorbing midsole\n\n    Date First Available: 17 April 2022\n    Manufacturer: Skechers\n    ASIN: B09Y4QYDFB\n    Item model number: 149303\n    Department: Womens\n\nDescription\n\nSKECHERS FLEX APPEAL 4.0 SHOES for WOMEN For All Day Comfort', 'حول هذا البند\n\n نعل داخلي مبطن بتقنية ميموري فوم من سكيتشرز\n\n نعل أوسط مرن خفيف الوزن ممتص للصدمات\n\n نعل سفلي مطاطي مرن\n\n نعل خارجي مرن\n\n نعل اوسط خفيف الوزن ممتص للصدمات\n\n تاريخ توفر أول منتج: 17 أبريل 2022\n\n الشركة المصنعة: سكيتشرز\n\n ASIN: B09Y4QYDFB\n\n رقم موديل السلعة: 149303\n\n القسم: نسائي\n\n وصف\n\n حذاء رياضي من سكيتشرز 4.0 مرن للنساء لراحة طوال اليوم', 5, 0, 0),
(5, 'Zelda Textile Faux Leather Round-Toe Lace-up Sneakers for Men Navy Color', 'زيلدا حذاء رياضي قماش جلد صناعي برباط للرجال لون كحلي', 'storage/products/img/6286ba9046e501.47650192.png', 349.99, 0, 'About this item\n\n    Made of faux leather and textile\n    Lace-up closure\n    Casual shoes\n\n    Date First Available: 15 July 2021\n    Manufacturer: Zelda\n    ASIN: B099L8Y7ZQ\n    amazon.eg Sales Rank #51,292 in Fashion (See Top 100 in Fashion)\n    #1,369 in Men\'s Classic & Fashion Sneakers', 'حول هذا البند\n\n     مصنوع من الجلد الصناعي والمنسوجات\n     رباط للإغلاق\n     الأحذية الكاجوال\n\n     تاريخ توفر أول منتج: 15 يوليو 2021\n     الماركة: زيلدا\n     ASIN: B099L8Y7ZQ\n     ترتيب مبيعات amazon.eg # 51،292 في الموضة (شاهد أفضل 100 في الموضة)\n     # 1،369 في أحذية رياضية كلاسيكية وعصرية للرجال', 6, 0, 0),
(6, 'Blackstone Shoes Men\'s Sneakers Men\'s Shoes', 'أحذية بلاكستون أحذية رياضية رجالية أحذية رجالية', 'storage/products/img/629a536d91e266.21619033.png', 199, 0, 'Blackstone Shoes Men\'s Sneakers Men\'s Shoes /n Blackstone Shoes Men\'s Sneakers Men\'s Shoes Shoes MEN', 'أحذية بلاكستون أحذية رجالية أحذية رجالية /n أحذية بلاكستون أحذية رجالية أحذية رجالية أحذية رجالية', 7, 0, 0),
(7, 'Microspec - Texlor Boys', 'ميكروسبيك - تيكسلور بويز', 'storage/products/img/629e3f8e998fe4.44899954.png', 59, 0, 'Keep it cool with easy-wearing comfort by wearing Skechers Microspec ` Texlor. This slip-on style features an athletic mesh fabric and synthetic upper with stitching and overlay accents.', 'حافظ على البرودة مع الراحة في الارتداء بسهولة من خلال ارتداء Skechers Microspec `Texlor. يتميز هذا النمط سهل الارتداء بنسيج شبكي رياضي وجزء علوي صناعي مع درزات وتراكبات.', 5, 0, 0),
(8, 'Skechers Skech-Flex 2.0 Contrast Stitching Side-Logo Low-Top Lace-Up Running Sneakers for Kids', 'حذاء رياضي Skechers Skech-Flex 2.0 برباط وشعار جانبي متباين وخياطة متباينة للأطفال برباط علوي للأطفال', 'storage/products/img/62a213d8b36d34.01162978.png', 1599, 0, 'Date First Available ‏ : ‎ 9 July 2021 /n Manufacturer ‏ : ‎ Skechers /n ASIN ‏ : ‎ B09931WRH2 /n  Best Sellers Rank:#43-784 in Fashion (See Top 100 in Fashion) /n #98 in Girls\' Running Shoes /n  #124 in Boys\' Running Shoes.', 'تاريخ توفر أول مرة: 9 يوليو 2021 /n المُصنع: Skechers /n ASIN: B09931WRH2 /n تصنيف أفضل البائعين: # 43-784 في الموضة (شاهد أفضل 100 في الموضة) /n # 98 في الجري للفتيات أحذية /n # 124 في أحذية الجري للأولاد..', 5, 0, 0),
(9, 'Microspec Max', 'مايكروسبك ماكس', 'storage/products/img/62a216d2eb7599.53695006.png', 1299, 0, 'Add some extra comfy cushioning to a sporty style with Skechers Microspec Max. This slip-on features a breathable athletic mesh and synthetic upper with stretch laces and a visible Skech-Air® air-cushioned midsole..', 'أضف بعض التوسيد المريح إلى الأسلوب الرياضي مع Skechers Microspec Max. يتميز هذا الحذاء المنزلق بشبكة رياضية مسامية وجزء علوي صناعي بأربطة مطاطية ونعل أوسط مبطن بالهواء Skech-Air® مرئي.', 5, 0, 0),
(10, 'AKAI Cotton Printed T-Shirt - Light Grey', 'AKAI تي شيرت قطن مطبوع - رمادي فاتح', 'storage/products/img/62a3a32dc1e5b7.65160173.png', 149, 0, 'Made of pure cotton and non-blended with transfer printing to withstand the harshest conditions of consumption and washing.', 'مصنوع من القطن الخالص وغير مخلوط بطباعة منقولة لتحمل أقسى ظروف الاستهلاك والغسيل.', 2, 0, 0),
(11, 'Ho Holland Round Neck White T-shirt - 2 Line', 'تيشيرت أبيض بياقة دائرية من هو هولاند - خطان', 'storage/products/img/62a48d33bb1bb6.28172256.png', 199, 0, 'In Ho Holland Marketplace we have a collection of the best product that are made of the best quality pure cotton.', 'في سوق Ho Holland ، لدينا مجموعة من أفضل المنتجات المصنوعة من أفضل أنواع القطن الخالص.', 2, 0, 0),
(12, 'Lumex Sea And Sand Baby Dress Embroidered', 'فستان أطفال من Lumex Sea And Sand مطرز', 'storage/products/img/62a3a706d034b4.65981603.png', 199, 0, 'Baby Girl dress \n baby straps dress \n embroidery sea star \n sea creatures print \n Dark blue baby dress \n Sea star embroidery on the back.', 'فستان طفلة \n فستان بأشرطة للأطفال \n مطرز بنجمة البحر \n طباعة مخلوقات بحرية \n فستان أطفال أزرق داكن \n مطرز بنجمة البحر على الظهر.', 10, 0, 0),
(14, 'BBRITTA BLACK', 'أسود ببريتا', 'storage/products/img/62a3a963e1b603.00531584.png', 199, 0, 'Puff quilted shoulder bag \n Synthetic materials \n 9.25 H x 12.5 W x 5 D \n 11 Shoulder chain drop \n Front flap closure.', 'حقيبة كتف مبطنة منفوخة \n مواد اصطناعية \n 9.25 ارتفاع × 12.5 عرض × 5 عمق \n 11 إسقاط سلسلة الكتف \n إغلاق بغطاء أمامي..', 11, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rules_tbib_store`
--

CREATE TABLE `rules_tbib_store` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rules_tbib_store`
--

INSERT INTO `rules_tbib_store` (`id`, `name`) VALUES
(1, 'admin'),
(2, 'normal');

-- --------------------------------------------------------

--
-- Table structure for table `slider_tbib_store`
--

CREATE TABLE `slider_tbib_store` (
  `id` int(11) NOT NULL,
  `imageEN` varchar(255) NOT NULL,
  `imageAR` varchar(255) NOT NULL,
  `open_category_id` int(11) DEFAULT NULL,
  `open_product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `slider_tbib_store`
--

INSERT INTO `slider_tbib_store` (`id`, `imageEN`, `imageAR`, `open_category_id`, `open_product_id`) VALUES
(1, 'storage/slider/img/629a4723e3b689.73258579.png', 'storage/slider/img/629a550d700c30.08581440.png', NULL, 7),
(2, 'storage/slider/img/629a59108d4a18.74820913.png', 'storage/slider/img/629a592ef1ef75.59446196.png', 9, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users_tbib_store`
--

CREATE TABLE `users_tbib_store` (
  `id` int(11) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` text NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `rule` int(11) NOT NULL DEFAULT 2,
  `email_active` tinyint(1) NOT NULL DEFAULT 0,
  `code` varchar(255) NOT NULL,
  `tokenSocial` text DEFAULT NULL,
  `loginBySocial` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users_tbib_store`
--

INSERT INTO `users_tbib_store` (`id`, `userName`, `email`, `password`, `phone`, `rule`, `email_active`, `code`, `tokenSocial`, `loginBySocial`) VALUES
(8, 'mesho 1', 'mes@mes.com', '$2y$10$X/d0CBkcKBTAXVi0PpiFsOfu2i9ily5Cg3oS0/BwEmOL.KgDyqfK6', '', 2, 1, '', NULL, 0),
(14, 'mesho raouf', 'meshoraouf515@gmail.com', '$2y$10$4SzDuiA2bVWXZAjOb3YYkeJANSpnD56lhPL38iZadZVjzzC6rqaIW', NULL, 2, 1, '0', '116517405042981778152', 1),
(15, 'mesho raouf', 'meshoraouf515@gmail.com', '$2y$10$Ajq0oUlf5Y3AK79VNVLgvOJMzuvmjqO.4Z2Zf4m9r0hlui4Llzvcu', NULL, 2, 1, '0', '', 0),
(18, 'Michelle Raouf', 'eng.michelle.raouf@gmail.com', '$2y$10$Av/HPEmV6pSZEEoNd/0baezr6SCRbuL3YBXnvkbyF1rZQxcskDkWS', NULL, 2, 1, '0', NULL, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `about_us_tbib_store`
--
ALTER TABLE `about_us_tbib_store`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart_tbib_store`
--
ALTER TABLE `cart_tbib_store`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productId` (`productId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `category_tbib_store`
--
ALTER TABLE `category_tbib_store`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_us_tbib_store`
--
ALTER TABLE `contact_us_tbib_store`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favorite_tbib_store`
--
ALTER TABLE `favorite_tbib_store`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `products_tbib_store`
--
ALTER TABLE `products_tbib_store`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nameEN` (`nameEN`),
  ADD UNIQUE KEY `nameAR` (`nameAR`),
  ADD KEY `categoryId` (`categoryId`);

--
-- Indexes for table `rules_tbib_store`
--
ALTER TABLE `rules_tbib_store`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `slider_tbib_store`
--
ALTER TABLE `slider_tbib_store`
  ADD PRIMARY KEY (`id`),
  ADD KEY `open_category_id` (`open_category_id`),
  ADD KEY `open_product_id` (`open_product_id`);

--
-- Indexes for table `users_tbib_store`
--
ALTER TABLE `users_tbib_store`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `rule` (`rule`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `about_us_tbib_store`
--
ALTER TABLE `about_us_tbib_store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cart_tbib_store`
--
ALTER TABLE `cart_tbib_store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category_tbib_store`
--
ALTER TABLE `category_tbib_store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `contact_us_tbib_store`
--
ALTER TABLE `contact_us_tbib_store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `favorite_tbib_store`
--
ALTER TABLE `favorite_tbib_store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_tbib_store`
--
ALTER TABLE `products_tbib_store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `rules_tbib_store`
--
ALTER TABLE `rules_tbib_store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `slider_tbib_store`
--
ALTER TABLE `slider_tbib_store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users_tbib_store`
--
ALTER TABLE `users_tbib_store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart_tbib_store`
--
ALTER TABLE `cart_tbib_store`
  ADD CONSTRAINT `cart_tbib_store_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products_tbib_store` (`id`),
  ADD CONSTRAINT `cart_tbib_store_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users_tbib_store` (`id`);

--
-- Constraints for table `favorite_tbib_store`
--
ALTER TABLE `favorite_tbib_store`
  ADD CONSTRAINT `favorite_tbib_store_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users_tbib_store` (`id`),
  ADD CONSTRAINT `favorite_tbib_store_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `products_tbib_store` (`id`);

--
-- Constraints for table `products_tbib_store`
--
ALTER TABLE `products_tbib_store`
  ADD CONSTRAINT `products_tbib_store_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `category_tbib_store` (`id`);

--
-- Constraints for table `users_tbib_store`
--
ALTER TABLE `users_tbib_store`
  ADD CONSTRAINT `rule` FOREIGN KEY (`rule`) REFERENCES `rules_tbib_store` (`id`) ON DELETE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
