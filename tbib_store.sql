-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 13, 2022 at 01:31 PM
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
(1, 'MS Store is The Fantastic E-Commerce Mobile Application in Egypt specialized in all supplies about Fashion./n Assisting you with the best shipping and after-sale-service in Egypt with the best prices with many big brands of fashion and explosive brand./n established in 2022', 'ام ستور هو تطبيق الهاتف المحمول الرائع للتجارة الإلكترونية في مصر والمتخصص في جميع المستلزمات الخاصة بالموضة. /n نساعدك في الحصول على أفضل خدمة الشحن وما بعد البيع في مصر بأفضل الأسعار مع العديد من العلامات التجارية الكبرى للأزياء والعلامات التجارية المتفجرة. /n تأسست في عام 2022');

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
(7, 'Sneakers', 'أحذية رياضية', 4, 'storage/category/img/629a548a644398.55741015.png', 0),
(8, 'Bags', 'شنط', 0, '', 1),
(9, 'Woman Bags', 'شنط حريمي', 8, 'storage/category/img/629a587aaf2684.98211010.png', 0),
(10, 'Dress', 'فستان', 1, 'storage/category/img/62a3a678ac0f71.90370374.png', 0),
(12, 'Backpack', 'حقيبة ظهر', 8, 'storage/category/img/62cd36bae8a971.38350476.png', 0),
(13, 'Hat', 'قبعة', 1, 'storage/category/img/62cd67963d2007.93208980.png', 0);

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
  `sale` tinyint(1) NOT NULL DEFAULT 0,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products_tbib_store`
--

INSERT INTO `products_tbib_store` (`id`, `nameEN`, `nameAR`, `image`, `price`, `price_after_dis`, `descriptionEN`, `descriptionAR`, `categoryId`, `offers`, `sale`, `stock`) VALUES
(1, 'AE Pique Polo Shirt', 'تي-شيرت بولو من نسيج البيكيه', 'storage/products/img/6286b32c5f43e9.19846430.png', 600, 0, 'The Details\n\n    Stretch pique fabric\n    Collared neck\n    Short sleeves\n    Two button placket\n    Tipped details\n\nMaterials & Care\n\n    97% Cotton, 3% Elastane\n    Machine wash\n\nSize & Fit\n\n    Standard fit: comfortable & casual, it\'s your go-to everyday fit\n    Standard length', 'تفاصيل\n\n    قطن بيكيه المرن\n    قبة مزودة بياقة\n    أكمام قصيرة\n    تصميم مزود بزرين\n    تفاصيل مدببة\n\nإرشادات العناية ومادة الصنع\n\n    97% قطن، 3% إيلاستان\n    قابل للغسيل في الغسالة\n\nالمقاس و القصة\n\n    قصة عادية: مناسبة للارتداء اليومي وتمنحك راحة الارتداء وإطلالة عصرية\n    طول عادي', 2, 0, 0, 0),
(2, 'dark-wash jeans', 'بنطلون جينز بكحته داكنة', 'storage/products/img/6286b48c91b628.48556054.png', 399.99, 0, 'Features and benefits\nJust like any other pair of jeans, but with one big difference – theyre comfy to wear! Thats because theyre made from soft cotton with added stretch to give legs room to hop, skip and jump. With an elasticated waistband for a great fit as they grow. And pockets for the important things, like sweets and action toys. If you like this pair, youll be pleased to hear they come in three different washes – choose your favourite now!\n\n    elasticated waistband for a great fit;mock fly with popper fastening for easy outfit changes;front and back pockets;soft, stretchy fabric for comfort\n    Blue\n    machine washable\n    98.8% cotton 1.2% elastane\n    keep away from fire\n\nSpecifications\n\n    Color: Blue\n    Product brand: Mothercare', 'المزايا و الفوائد\nأكثر ما يميز هذا البنطلون هو تصميمه المريح والمثالي للارتداء اليومي. فهو منسوج من القطن الناعم بتصميم أجزاء مرنة على الساقين توفر حرية الحركة في أوقات القفز والحركة. كما أنه مصمم بشريط خصر مرن لضبط المقاس والتكيف مع طفلك المتنامي. تكتمل أناقة البنطلون بجيوب عملة لتخزن الحلوى والألعاب. فضلاً عن كونه متوفر بثلاثة أنماط مختلفة ومميزة سيعشقها طفلك كثيراً.\n\n    لباس نوم مصنوع من القطن الناعم والمرن؛ أزرار تثبيت لضمان سهولة الارتداء؛ قفازات لمنع الخدوش (لمقاسات حتى 3-6 شهور)؛ تصميم مغلق عند القدمين يمنع التفاف الخيوط حول قدم الطفل؛ جوارب مقاومة للانزلاق (للمقاسات من عمر 9-12 شهر وأكبر)؛ أزرار ملونة لتثبيت الأزرار بشكل صحيح؛ جميع الأزرار خالية من النيكل لمنع تهيّج بشرة الطفل الرقيقة\n    وردي\n    إرشادات العناية: الغسيل في الغسالة\n    100% قطن\n    إرشادات السلامة: ابق المنتج بعيداً عن النار\n\nالمواصفات\n\n    اللون: أزرق\n    العلامة التجارية: Mothercare', 3, 0, 0, 0),
(3, 'SKECHERS FLEX APPEAL 4.0 SPORTS Collection for WOMEN color Navy Blue', 'SKECHERS FLEX APPEAL 4.0 SPORTS Collection for WOMEN color Navy BlueW', 'storage/products/img/6286b61e9d6997.66372757.png', 1199.99, 0, 'About this item\n\n    Skechers Memory Foam cushioned comfort insole\n    Lightweight flexible shock-absorbing midsole\n    Flexible rubber traction outsole\n    Flexible outsole\n    Lightweight shock-absorbing midsole\n\n    Date First Available: 17 April 2022\n    Manufacturer: Skechers\n    ASIN: B09Y4QYDFB\n    Item model number: 149303\n    Department: Womens\n\nDescription\n\nSKECHERS FLEX APPEAL 4.0 SHOES for WOMEN For All Day Comfort', 'حول هذا البند\n\n     نعل داخلي مبطن بتقنية ميموري فوم من سكيتشرز\n     نعل أوسط مرن خفيف الوزن ممتص للصدمات\n     نعل سفلي مطاطي مرن\n     نعل خارجي مرن\n     نعل اوسط خفيف الوزن ممتص للصدمات\n\n     تاريخ توفر أول منتج: 17 أبريل 2022\n     الشركة المصنعة: سكيتشرز\n     ASIN: B09Y4QYDFB\n     رقم موديل السلعة: 149303\n     القسم: نسائي\n\n وصف\n\n حذاء رياضي من سكيتشرز 4.0 مرن للنساء لراحة طوال اليوم', 5, 1, 0, 0),
(4, 'SKECHERS FLEX APPEAL 4.0 SPORTS Collection for WOMEN color Black', 'مجموعة SKECHERS FLEX APPEAL 4.0 SPORTS للألوان النسائيةاسود', 'storage/products/img/6286b9ec2aa411.01764094.png', 999.99, 499.99, 'About this item\n\n    Skechers Memory Foam cushioned comfort insole\n    Lightweight flexible shock-absorbing midsole\n    Flexible rubber traction outsole\n    Flexible outsole\n    Lightweight shock-absorbing midsole\n\n    Date First Available: 17 April 2022\n    Manufacturer: Skechers\n    ASIN: B09Y4QYDFB\n    Item model number: 149303\n    Department: Womens\n\nDescription\n\nSKECHERS FLEX APPEAL 4.0 SHOES for WOMEN For All Day Comfort', 'حول هذا البند\n\n نعل داخلي مبطن بتقنية ميموري فوم من سكيتشرز\n\n نعل أوسط مرن خفيف الوزن ممتص للصدمات\n\n نعل سفلي مطاطي مرن\n\n نعل خارجي مرن\n\n نعل اوسط خفيف الوزن ممتص للصدمات\n\n تاريخ توفر أول منتج: 17 أبريل 2022\n\n الشركة المصنعة: سكيتشرز\n\n ASIN: B09Y4QYDFB\n\n رقم موديل السلعة: 149303\n\n القسم: نسائي\n\n وصف\n\n حذاء رياضي من سكيتشرز 4.0 مرن للنساء لراحة طوال اليوم', 5, 0, 0, 0),
(5, 'Zelda Textile Faux Leather Round-Toe Lace-up Sneakers for Men Navy Color', 'زيلدا حذاء رياضي قماش جلد صناعي برباط للرجال لون كحلي', 'storage/products/img/6286ba9046e501.47650192.png', 349.99, 0, 'About this item\n\n    Made of faux leather and textile\n    Lace-up closure\n    Casual shoes\n\n    Date First Available: 15 July 2021\n    Manufacturer: Zelda\n    ASIN: B099L8Y7ZQ\n    amazon.eg Sales Rank #51,292 in Fashion (See Top 100 in Fashion)\n    #1,369 in Men\'s Classic & Fashion Sneakers', 'حول هذا البند\n\n     مصنوع من الجلد الصناعي والمنسوجات\n     رباط للإغلاق\n     الأحذية الكاجوال\n\n     تاريخ توفر أول منتج: 15 يوليو 2021\n     الماركة: زيلدا\n     ASIN: B099L8Y7ZQ\n     ترتيب مبيعات amazon.eg # 51،292 في الموضة (شاهد أفضل 100 في الموضة)\n     # 1،369 في أحذية رياضية كلاسيكية وعصرية للرجال', 7, 0, 0, 0),
(6, 'Blackstone Shoes Men\'s Sneakers Men\'s Shoes', 'أحذية بلاكستون أحذية رياضية رجالية أحذية رجالية', 'storage/products/img/629a536d91e266.21619033.png', 199, 0, 'Blackstone Shoes Men\'s Sneakers Men\'s Shoes /n Blackstone Shoes Men\'s Sneakers Men\'s Shoes Shoes MEN', 'أحذية بلاكستون أحذية رجالية أحذية رجالية /n أحذية بلاكستون أحذية رجالية أحذية رجالية أحذية رجالية', 7, 0, 0, 0),
(7, 'Microspec - Texlor Boys', 'ميكروسبيك - تيكسلور بويز', 'storage/products/img/629e3f8e998fe4.44899954.png', 59, 0, 'Keep it cool with easy-wearing comfort by wearing Skechers Microspec ` Texlor. This slip-on style features an athletic mesh fabric and synthetic upper with stitching and overlay accents.', 'حافظ على البرودة مع الراحة في الارتداء بسهولة من خلال ارتداء Skechers Microspec `Texlor. يتميز هذا النمط سهل الارتداء بنسيج شبكي رياضي وجزء علوي صناعي مع درزات وتراكبات.', 5, 0, 0, 0),
(8, 'Skechers Skech-Flex 2.0 Contrast Stitching Side-Logo Low-Top Lace-Up Running Sneakers for Kids', 'حذاء رياضي Skechers Skech-Flex 2.0 برباط وشعار جانبي متباين وخياطة متباينة للأطفال برباط علوي للأطفال', 'storage/products/img/62a213d8b36d34.01162978.png', 1599, 0, 'Date First Available ‏ : ‎ 9 July 2021 /n Manufacturer ‏ : ‎ Skechers /n ASIN ‏ : ‎ B09931WRH2 /n  Best Sellers Rank:#43-784 in Fashion (See Top 100 in Fashion) /n #98 in Girls\' Running Shoes /n  #124 in Boys\' Running Shoes.', 'تاريخ توفر أول مرة: 9 يوليو 2021 /n المُصنع: Skechers /n ASIN: B09931WRH2 /n تصنيف أفضل البائعين: # 43-784 في الموضة (شاهد أفضل 100 في الموضة) /n # 98 في الجري للفتيات أحذية /n # 124 في أحذية الجري للأولاد..', 5, 0, 0, 0),
(9, 'Microspec Max', 'مايكروسبك ماكس', 'storage/products/img/62a216d2eb7599.53695006.png', 1299, 0, 'Add some extra comfy cushioning to a sporty style with Skechers Microspec Max. This slip-on features a breathable athletic mesh and synthetic upper with stretch laces and a visible Skech-Air® air-cushioned midsole..', 'أضف بعض التوسيد المريح إلى الأسلوب الرياضي مع Skechers Microspec Max. يتميز هذا الحذاء المنزلق بشبكة رياضية مسامية وجزء علوي صناعي بأربطة مطاطية ونعل أوسط مبطن بالهواء Skech-Air® مرئي.', 5, 0, 0, 0),
(10, 'AKAI Cotton Printed T-Shirt - Light Grey', 'AKAI تي شيرت قطن مطبوع - رمادي فاتح', 'storage/products/img/62a3a32dc1e5b7.65160173.png', 149, 0, 'Made of pure cotton and non-blended with transfer printing to withstand the harshest conditions of consumption and washing.', 'مصنوع من القطن الخالص وغير مخلوط بطباعة منقولة لتحمل أقسى ظروف الاستهلاك والغسيل.', 2, 0, 0, 0),
(11, 'Ho Holland Round Neck White T-shirt - 2 Line', 'تيشيرت أبيض بياقة دائرية من هو هولاند - خطان', 'storage/products/img/62a48d33bb1bb6.28172256.png', 199, 0, 'In Ho Holland Marketplace we have a collection of the best product that are made of the best quality pure cotton.', 'في سوق Ho Holland ، لدينا مجموعة من أفضل المنتجات المصنوعة من أفضل أنواع القطن الخالص.', 2, 0, 0, 0),
(12, 'Lumex Sea And Sand Baby Dress Embroidered', 'فستان أطفال من Lumex Sea And Sand مطرز', 'storage/products/img/62a3a706d034b4.65981603.png', 199, 0, 'Baby Girl dress \n baby straps dress \n embroidery sea star \n sea creatures print \n Dark blue baby dress \n Sea star embroidery on the back.', 'فستان طفلة \n فستان بأشرطة للأطفال \n مطرز بنجمة البحر \n طباعة مخلوقات بحرية \n فستان أطفال أزرق داكن \n مطرز بنجمة البحر على الظهر.', 10, 0, 0, 0),
(13, 'BBRITTA BLACK', 'أسود ببريتا', 'storage/products/img/62a9d8b565fa83.80397956.png', 299, 0, 'Best bag for women ms-store', 'أفضل حقيبة للنساء متجر ام-ستور', 9, 0, 0, 0),
(14, 'Skechers Go Walk Max Mesh Notched Vamp Slip-On Running Sneakers for Kids', 'حذاء رياضي سكيتشرز Go Walk Max Mesh Notched Vamp سهل الارتداء للأطفال', 'storage/products/img/62cc1dc85e98b6.57776245.png', 829.99, 0, 'About this item\n\n    100% Textile\n    Low-top design\n    Made in China\n\n    Date First Available: 9 July 2021\n    Manufacturer: Skechers', 'حول هذا البند\n\n     100٪ نسيج\n     تصميم منخفض القمة\n     صنع بالصين\n\n     تاريخ توفر أول منتج: 9 يوليو 2021\n     الشركة المصنعة: سكيتشرز', 5, 0, 0, 0),
(15, 'GoWalk Max Slip-On Shoes Charcoal/Orange', 'حذاء GoWalk Max سهل الارتداء فحم / برتقالي', 'storage/products/img/62cc29bd202b24.92328346.png', 3089.99, 1589.99, 'Highlights\n\n    Breathable athletic air-mesh upper\n    Easy slip-on construction\n    Padded heel with pull-on loop\n    Lightweight, responsive 5GEN cushioning midsole and outsole\n    Goga Max cushioned comfort insole\n    Flexible rubber outsole\n    Skechers initial logo branding', 'يسلط الضوء\n\n     جزء علوي رياضي شبكي للتنفس\n     سهل التركيب\n     كعب مبطن بحلقة قابلة للسحب\n     نعل اوسط ونعل خارجي خفيف الوزن وسريع الاستجابة 5GEN\n     نعل داخلي مبطن ومريح من Goga Max\n     نعل خارجي مطاطي مرن\n     وضع شعار Skechers المبدئي', 5, 0, 0, 0),
(16, 'SKECHERS FASHION FIT SPORTS Collection for WOMEN color', 'مجموعة SKECHERS FASHION FIT SPORTS للون نسائي', 'storage/products/img/62cc36459116d7.44698776.png', 2139.99, 999.99, 'About this item\n\n    Skechers Memory Foam cushioned comfort insole\n    Crafted with 100% vegan materials\n    Flexible traction outsole\n    comfort fit\n    Breathable\n\n    Date First Available: 21 March 2022\n    Manufacturer: Skechers\n    Department: Womens', 'حول هذا البند\n\n     نعل داخلي مبطن بتقنية ميموري فوم من سكيتشرز\n     مصنوع من مواد نباتية 100٪\n     نعل خارجي مرن للجر\n     تناسب راحة\n     تنفس\n\n     تاريخ توفر أول منتج: 21 مارس 2022\n     الشركة المصنعة: سكيتشرز\n     القسم: نسائي', 5, 0, 0, 0),
(17, 'Skechers Men\'s Relaxed Fit-Creston-Moseco', 'للرجال من Skechers Relaxed Fit-Creston-Moseco', 'storage/products/img/62cc3b0365fe85.38201579.png', 2449.99, 0, 'Description\n\n    100% Textile Imported Rubber sole Shaft measures approximately not_applicable from arch Air Cooled Memory Foam Relaxed Fit Air Cooled Memory Foam 360 Double Gore Slip On Show more.\n\n    Imported from USA.\n\nDouble gore canvas moc toe slip on', 'وصف\n\n     100٪ نعل مطاطي مستورد من النسيج يقيس عمود الدوران تقريبًا غير قابل للتطبيق من إسفنج الذاكرة المقوس المبرد بالهواء المريح والملائم للهواء والمبرد من إسفنج الذاكرة 360 مزدوج الانزلاق على إظهار المزيد.\n\n     مستورد من الولايات المتحدة الأمريكية.\n\n زلة مقدمة من قماش الكانفاس المزدوج الجور', 5, 0, 0, 0),
(18, 'ZELDA Shoes Sneakers for Men 050', 'زيلدا حذاء سنيكرز للرجال 050', 'storage/products/img/62cc62f554a8c4.38468798.png', 399.99, 0, 'About this item\n\n    Men comfy sneakers\n    Exactly as picture\n    Fashionable shoes\n    Suitable for different occasions\n    High Quality\n\n    Date First Available: 13 April 2022\n    Manufacturer: ZELDA\n    Department: Mens', 'حول هذا البند\n\n     أحذية رياضية مريحة للرجال\n     بالضبط كصورة\n     أحذية عصرية\n     مناسب للمناسبات المختلفة\n     جودة عالية\n\n     تاريخ توفر أول منتج: 13 أبريل 2022\n     الشركة المصنعة: ZELDA\n     القسم: رجال', 7, 0, 0, 0),
(19, 'ZELDA Shoes Sneakers for Men', 'زيلدا أحذية سنيكرز للرجال', 'storage/products/img/62cc66fd6b3dd3.12032525.png', 399.99, 149.99, 'About this item\n\n      Comfortable sneakers for men\n      exactly as picture\n      Fashionable shoes\n      Suitable for different occasions\n      High quality\n\n      First Availability Date: April 13, 2022\n      Manufacturer: ZELDA\n      Section: Men', 'حول هذا البند\n\n     أحذية رياضية مريحة للرجال\n     بالضبط كصورة\n     أحذية عصرية\n     مناسب للمناسبات المختلفة\n     جودة عالية\n\n     تاريخ توفر أول منتج: 13 أبريل 2022\n     الشركة المصنعة: ZELDA\n     القسم: رجال', 7, 0, 0, 0),
(23, 'SHOESLINE Fashion Sneakers For Men', 'شوزلاين فاشن سنيكرز للرجال', 'storage/products/img/62cc8a47f1ff32.75270139.png', 199.99, 0, 'About this item\n\n    Brand : SHOESLINE\n    Color : Dark Blue\n    Material : Leather\n    Size : 44 EU\n    Targeted Group : Men\n    Style : Fashion Sneakers\n    Occasion : Casual Shoe\n    Are batteries needed to power the product or is this product a battery : No\n    Is this a Dangerous Good or a Hazardous Material, Substance or Waste that is regulated for transportation, storage, and/or disposal? : No', 'حول هذا البند\n\n     الماركة: SHOESLINE\n     اللون: ازرق غامق\n     الخامة: جلد\n     الحجم: 44 EU\n     المجموعة المستهدفة: رجال\n     النمط: فاشن سنيكرز\n     المناسبة: حذاء كاجوال\n     هل البطاريات مطلوبة لتشغيل المنتج أم أن هذا المنتج عبارة عن بطارية: لا\n     هل هذا منتج خطر أو مادة خطرة ، مادة أو نفايات يتم تنظيمها للنقل و / أو التخزين و / أو التخلص منها؟  : رقم', 7, 0, 0, 0),
(24, 'Hammer-H004-faux leather sneakers For Men', 'هامر- H004-حذاء رياضي من الجلد الصناعي للرجال', 'storage/products/img/62cc8b0c05b2e1.78302756.png', 499.99, 299.99, 'About this item\n\n    Breathable leather lining\n    Comfy\n    Trendy\n    Casual\n\n    Date First Available: 19 May 2022\n    Manufacturer: Hammer\n    Department: Mens', 'حول هذا البند\n\n     بطانة جلد مسامية\n     مريح\n     عصري\n     رسمي\n\n     تاريخ توفر أول منتج: 19 مايو 2022\n     الشركة المصنعة: Hammer\n     القسم: رجال', 7, 0, 0, 0),
(25, 'Gendy\'s men sneakers - White', 'حذاء رياضي Gendy\'s للرجال - أبيض', 'storage/products/img/62cc8c5138e305.38368035.png', 318.99, 0, 'About this item\n\n    display attribute: shoes display on website\n    brand: GENDY\'S\n    Item Category: shoes\n\n    Date First Available: 19 September 2021\n    Department: Men', 'حول هذا البند\n\n     سمة العرض: عرض الأحذية على موقع الويب\n     العلامة التجارية: GENDY\'S\n     فئة العنصر: أحذية\n\n     تاريخ توفر أول منتج: 19 سبتمبر 2021\n     القسم: رجال', 7, 0, 0, 0),
(26, 'AKAI Cotton T-Shirt First Rate For Men - Light Grey', 'تيشيرت قطن درجة اولى للرجال من اكاي - رمادي فاتح', 'storage/products/img/62cc935a6093f4.53122204.png', 150, 0, 'Made of pure cotton and non-blended with transfer printing to withstand the harshest conditions of consumption and washing', 'مصنوع من القطن الخالص وغير مخلوط بطباعة نقل لتحمل أقسى ظروف الاستهلاك والغسيل', 2, 0, 0, 0),
(27, 'AKAI Printed Cotton T-Shirt First Rate For Men - Mango Yellow', 'تيشيرت قطن مطبوع من اكاي فير فيرست للرجال - اصفر مانجو', 'storage/products/img/62cc94463868b3.58295495.png', 299.99, 149.99, 'Made of pure cotton and non-blended with transfer printing to withstand the harshest conditions of consumption and washing\n\nwith transfer printing', 'مصنوع من القطن الخالص وغير مخلوط بطباعة نقل لتحمل أقسى ظروف الاستهلاك والغسيل\n\n مع نقل الطباعة', 2, 0, 0, 0),
(28, 'grey skinny jeans', 'جينز رمادي ضيق', 'storage/products/img/62cc95bad097d2.68941095.png', 499.99, 0, 'Features and benefits\nWho say\'s jeans have to be blue? Our cool grey jeans are made from soft cotton with added stretch to give legs room to hop, skip and jump and are designed with a clever, adjustable waistband to provide the perfect fit as they grow. With pockets for the important things, like sweets and action toys.\n\n    5-pocket style ;skinny fit;mock fly with popper fastening for easy outfit changes;adjustable waistband for a great fit;cotton fabric with a little stretch for comfort;pre-worn fading and crease detailing\n    denim\n    machine washable\n    74% cotton 25% polyester 1% elastane\n    keep away from fire\n\nSpecifications\n\n    Color: Denim\n    Product brand: Blooming Marvellous', 'الميزات والفوائد\n من قال أن الجينز يجب أن يكون أزرق؟  صُنع الجينز الرمادي الرائع الخاص بنا من القطن الناعم مع امتداد إضافي لإعطاء الأرجل مساحة للقفز والقفز والقفز ، وهو مصمم بحزام خصر ذكي قابل للتعديل لتوفير المقاس المثالي أثناء نموها.  مع جيوب للأشياء المهمة ، مثل الحلويات وألعاب الحركة.\n\n     تصميم بخمسة جيوب ؛ قصة ضيقة ؛ ذبابة وهمية مع إبزيم بوبر لتغيير الزي بسهولة ؛ حزام خصر قابل للتعديل لملاءمة رائعة ؛ نسيج قطني قابل للتمدد قليلاً للراحة ؛ تلاشي باهت مسبقًا وتفاصيل تجعد\n     الدنيم\n     آلة قابل للغسل\n     74٪ قطن 25٪ بوليستر 1٪ إيلاستين\n     ابق بعيدا عن النار\n\n تحديد\n\n     اللون: الدنيم\n     ماركة المنتج: Blooming Marvelous', 3, 0, 0, 0),
(29, 'AE Ne(x)t Level AirFlex Athletic Fit Jean', 'مقاس AE Ne (x) t Level AirFlex Athletic Fit Jean', 'storage/products/img/62cc96f96074a0.38789820.png', 1199.99, 649.99, 'The Details\n\n    Ne(x)t Level AirFlex\n    Authentic denim look with flexibility and comfort you have to feel to believe.\n    High stretch level that keeps its shape\n    Soft, breathable denim\n    Dark wash - wear it like you mean it\n\nMaterials & Care\n\n    74% Cotton, 24% Polyester, 2% Elastane\n    Color may transfer when new: wash separately in cold water before wearing. Machine wash: cold, inside out and with like colors. Do not bleach, wring or twist. Tumble dry low. Cool iron if needed.\n\nSize & Fit\n\n    A slim fit designed for the guy who needs a little extra room in the thigh\n    Relaxed through thigh with a subtle tapered leg\n    Slim 13.5\" leg opening', 'التفاصيل\n\n     Ne (x) t Level AirFlex\n     مظهر الدنيم الأصيل مع المرونة والراحة التي يجب أن تشعر بها لتصدق.\n     مستوى تمدد عالي يحافظ على شكله\n     جينز ناعم ومسامي\n     غسيل غامق - ارتديه كما تقصده\n\n المواد والعناية\n\n     74٪ قطن ، 24٪ بوليستر ، 2٪ إيلاستين\n     قد يتغير اللون عندما يكون جديدًا: اغسل بشكل منفصل بالماء البارد قبل الارتداء.  غسيل آلي: بارد ، من الداخل إلى الخارج وبألوان متشابهة.  لا تبيض أو تعصر أو تلف.  تعثر منخفض جاف.  قم بتبريد الحديد إذا لزم الأمر.\n\n الحجم والملاءمة\n\n     قصة ضيقة مصممة للرجل الذي يحتاج إلى مساحة إضافية صغيرة في الفخذ\n     استرخاء من خلال الفخذ بساق مدببة رقيقة\n     فتحة رجل رفيعة مقاس 13.5 بوصة', 3, 0, 0, 0),
(30, 'Blue River 6441/6/34 Comfy boyfriend jeans for men', 'بنطلون جينز بوى فريند من بلو ريفر 6441/6/34 للرجال', 'storage/products/img/62cc983ed6bed6.96652556.png', 249.99, 0, 'About this item\n\n    Men Jeans size 36\n    Soft and smooth texture\n    Brand: Blue River\n    Excellent craftsmanship\n\n    Date First Available: 24 January 2022', 'حول هذا البند\n\n     جينز رجالي مقاس 36\n     ملمس ناعم وسلس\n     العلامة التجارية: بلو ريفر\n     براعة ممتازة\n\n     تاريخ توفر أول منتج: 24 يناير 2022', 3, 0, 0, 0),
(31, 'Mens Plain Sleeve Text Cotton T-Shirt Genetic', 'تي شيرت قطني نص كم عادي للرجال Genetic', 'storage/products/img/62cd33b3859637.60408846.png', 49.9, 0, 'About this item\n\n    Pill-resistant cotton material\n    Color Fastness Without Any Change With Washing\n    Suitable For Home, Sports Or Work With Nice Look\n    Wear alone or under a sweatshirt\n\n    Date First Available: 20 February 2022', 'حول هذا البند\n\n     مادة قطنية مقاومة للحبوب\n     ثبات اللون دون أي تغيير مع الغسيل\n     مناسب للمنزل أو الرياضة أو العمل بمظهر جميل\n     ارتدِ بمفردك أو تحت قميص من النوع الثقيل\n\n     تاريخ توفر أول منتج: 20 فبراير 2022', 2, 0, 0, 0),
(32, 'Cool Mens Casual Comfortable T-Shirt', 'تي شيرت رجالي كاجوال مريح مريح', 'storage/products/img/62cd359be7bd60.89534839.png', 119.99, 69.99, 'About this item\n\n    100% Cotton\n    Plain undershirt\n    Short sleeves design\n\n    Package Dimensions: 26.4 x 19.7 x 2.9 cm; 170 Grams\n    Date First Available: 28 April 2021\n    Manufacturer: Cool', 'حول هذا البند\n\n     100٪ قطن\n     قميص عادي\n     تصميم اكمام قصيرة\n\n     أبعاد العبوة: 26.4 × 19.7 × 2.9 سم ؛  170 جرام\n     تاريخ توفر أول منتج: 28 أبريل 2021\n     الشركة المصنعة: Cool', 2, 0, 0, 0),
(33, 'Andora unisex-adult Self Patterned Decorative Zipped Backpack Bags', 'حقائب ظهر Andora مزخرفة ذاتيًا بسوستة للجنسين والبالغين', 'storage/products/img/62cd37505aae60.57219520.png', 349.99, 0, 'About this item\n\n    100% Polyester Upper MaterialTwo Main Compartment Compartment For Laptop39cm Length, 46cm Height & 16cm WidthZipper Closure\n\n    Date First Available: 8 March 2022\n    Manufacturer: Andora', 'حول هذا البند\n\n     100٪ بوليستر مادة علوية ، حجرتان رئيسيتان للكمبيوتر المحمول ، 39 سم طول ، 46 سم ارتفاع و 16 سم عرض ، زيبر إغلاق\n\n     تاريخ توفر أول منتج: 8 مارس 2022\n     المُصنع: Andora', 12, 0, 0, 0),
(34, 'Black Minimalist Backpack PAVO', 'حقيبة ظهر سوداء صغيرة بافو', 'storage/products/img/62cd38bb0fb6a6.01753151.png', 549.99, 429.99, 'DETAILS\n\n    dimensions: 25x10x30 cm \n    premium quality Black leather with velvet\n    1 small interior pocket\n    1 small exterior pocket\n    Made in Egypt', 'تفاصيل\n\n     الأبعاد: 25 × 10 × 30 سم\n     جلد أسود عالي الجودة مع مخمل\n     1 جيب داخلي صغير\n     1 جيب خارجي صغير\n     صنع فى مصر', 12, 0, 0, 0),
(35, 'Laptop Classic Brown Backpack - Pavo', 'حقيبة كمبيوتر محمول كلاسيكية بنية اللون-', 'storage/products/img/62cd5c66f2fc10.94139844.png', 649.99, 0, 'DETAILS\n\n    dimensions: 30x11x40 cm \n    premium quality Black leather  \n    It fits till 15.6 inches laptop\n    1 external magnet lock pocket\n    2 small interior pocket\n    Made in Egypt', 'تفاصيل\n\n     الأبعاد: 30x11x40 سم\n     جلد أسود عالي الجودة\n     يناسب الكمبيوتر المحمول بحجم 15.6 بوصة\n     1 جيب قفل مغناطيسي خارجي\n     2 جيب داخلي صغير\n     صنع فى مصر', 12, 0, 0, 0),
(36, 'Duffle Bag Black Unisex leather Pavo', 'حقيبة دفل سوداء للجنسين جلد بافو', 'storage/products/img/62cd5d2ab058a4.09731369.png', 699.99, 499.99, 'Dimensions: 45x30x25 cm \npremium quality brown leather  \nMetal durable zippers\nHandle with a 1.5 m drop\n2 interior pockets\nMade in Egypt', 'الأبعاد: ٤٥ × ٣٠ × ٢٥ سم\n جلد بني عالي الجودة\n سحابات معدنية متينة\n تعامل مع قطره 1.5 متر\n عدد 2 جيوب داخلية\n صنع فى مصر', 9, 0, 0, 0),
(37, 'Deeda womens Women musso bag Women musso bag', 'حقيبة نسائية من ديدا حقيبة نسائية موسو', 'storage/products/img/62cd5e19d4d126.84743355.png', 479.99, 0, 'Package Dimensions: 42.5 x 26.1 x 12.6 cm; 800 Grams\nDate First Available: 16 August 2021\nManufacturer: Deeda\nCountry of origin: Egypt\nDepartment: Womens', 'أبعاد العبوة: 42.5 × 26.1 × 12.6 سم ؛  800 جرام\n تاريخ توفر أول منتج: 16 أغسطس 2021\n المُصنع: Deeda\n بلد المنشأ: مصر\n القسم: نسائي', 9, 0, 0, 0),
(38, 'Generic Unisex Casual Sports Summer Cap Hat', 'Generic قبعة صيفية رياضية كاجوال للجنسين', 'storage/products/img/62cd68081afad2.78132787.png', 49.99, 0, 'Date First Available: 11 June 2022\nDepartment: Men', 'تاريخ توفر أول منتج: 11 يونيو 2022\n القسم: رجال', 13, 0, 0, 0),
(39, 'dreamer straw sun hat', 'قبعة الشمس من القش الحالم', 'storage/products/img/62ce850ae3e8b4.41969323.png', 499.99, 0, 'Features and benefits\nAre you dreaming of sunny days? Lightweight, cool and comfy, this straw hat is designed with a wide brim to help shade your little girl\'s face and neck from the sun as she plays. With shimmering sequins, it\'s the prettiest finishing touch for any outfit.\n\n    lightweight sun hat;wide brim to shade face and neck;sequin hat band;sequin \'dreamer\' slogan\n    beige\n    86%paper ,14% polyester\n    keep away from fire\n\nSpecifications\n\n    Color: Beige\n    Product brand: Mothercare', 'الميزات والفوائد\n هل تحلم بأيام مشمسة؟  خفيفة الوزن ، باردة ومريحة ، هذه القبعة المصنوعة من القش مصممة بحافة عريضة للمساعدة في تظليل وجه طفلتك الصغيرة ورقبتها من الشمس أثناء لعبها.  مع الترتر المتلألئ ، إنها أجمل لمسة نهائية لأي جماعة.\n\n     قبعة شمسية خفيفة الوزن ؛ حافة عريضة لتظليل الوجه والرقبة ؛ شريط قبعة من الترتر ؛ شعار \"الحالم\" بالترتر\n     اللون البيج\n     86٪ ورق ، 14٪ بوليستر\n     ابق بعيدا عن النار\n\n تحديد\n\n     البيج اللون\n     ماركة المنتج: مذركير', 13, 0, 0, 0),
(40, 'Lightweight Metal Badge Baseball Cap', 'قبعة بيسبول بشارة معدنية خفيفة الوزن', 'storage/products/img/62ce85e7ba1552.58744169.png', 569.99, 299.99, 'Outdoors is where all the fun happens. So grab this adidas cap, and take your training session beyond the gym walls. The smooth fabric is lightweight for a comfortable feel. A medium-curved brim shields your eyes from the sun during your morning jog. Adjust the strap in back for just the right fit.', 'في الهواء الطلق هو المكان الذي يحدث فيه كل المرح.  لذا ارتدي قبعة أديداس هذه ، وانطلق في تدريبك إلى ما وراء جدران الصالة الرياضية.  النسيج الناعم خفيف الوزن لشعور مريح.  تحمي الحافة المتوسطة المنحنية عينيك من أشعة الشمس أثناء ممارسة رياضة الجري في الصباح.  اضبط الحزام في الخلف للحصول على المقاس المناسب تمامًا.', 13, 0, 0, 0),
(41, 'Generic Greek Fisherman Hat - Men Off White', 'Generic قبعة الصياد اليونانية - رجال أوف وايت', 'storage/products/img/62ce8a1cd80910.66695779.png', 199.99, 0, 'About this item\n    Date First Available: 18 May 2022\n    Country of origin: China\n    Department: Men', 'حول هذا البند\n     تاريخ توفر أول منتج: 18 مايو 2022\n     بلد المنشأ: الصين\n     القسم: رجال', 13, 0, 0, 0),
(42, 'white broderie dress', 'فستان بروديري أبيض', 'storage/products/img/62ce8aa71ac3b9.45627530.png', 1149.99, 999.99, 'Features and benefits\nIn pretty broderie fabric which brings nostalgic charm, this dress is perfect for taking your little girl from summer playtimes to garden parties. Simply fastened with buttons at the back and finished with a frilly flourish.\n\n    broderie dress with dipped back hem;ruffle frill sleeves;button fastening;cotton lined for comfort\n    White\n    machine washable\n    100 % cotton\n    keep away from fire\n\nSpecifications\n\n    Color: White\n    Product brand: Mothercare', 'الميزات والفوائد\n مصنوع من قماش بروديري جميل يضفي سحر الحنين إلى الماضي ، هذا الفستان مثالي لاصطحاب طفلتك الصغيرة من أوقات اللعب الصيفية إلى حفلات الحديقة.  يتم تثبيته ببساطة بأزرار في الخلف وينتهي بزخرفة مكشكشة.\n\n     فستان بروديري بحاشية خلفية مغموسة ؛ أكمام مكشكشة ؛ إغلاق بأزرار ؛ مبطن بالقطن للراحة\n     أبيض\n     آلة قابل للغسل\n     100٪ قطن\n     ابق بعيدا عن النار\n\n تحديد\n\n     اللون الابيض\n     ماركة المنتج: مذركير', 10, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rating_tbib_store`
--

CREATE TABLE `rating_tbib_store` (
  `id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `productId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `rating` double NOT NULL,
  `comment` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(1, 'storage/slider/img/629a4723e3b689.73258579.png', 'storage/slider/img/629a550d700c30.08581440.png', NULL, 3),
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
  `phoneVerify` tinyint(1) NOT NULL,
  `rule` int(11) NOT NULL DEFAULT 2,
  `email_active` tinyint(1) NOT NULL DEFAULT 0,
  `code` varchar(255) NOT NULL,
  `tokenSocial` text DEFAULT NULL,
  `loginBySocial` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users_tbib_store`
--

INSERT INTO `users_tbib_store` (`id`, `userName`, `email`, `password`, `phone`, `phoneVerify`, `rule`, `email_active`, `code`, `tokenSocial`, `loginBySocial`) VALUES
(1, 'mesho raouf', 'meshoraouf515@gmail.com', '$2y$10$LarlFHIVpNQ711rKxjpYB.bYzuocIHK0YYSsszWq143XP38LV6eEy', NULL, 0, 2, 1, '0', '116517405042981778152', 1),
(2, 'Michelle', 'meshoraouf515@gmail.com', '$2y$10$YzerCQ8uSbdnBDAE9Kss4u80XM0TbTTBv9H4Vq4GEdiM3HZ4e53Fi', NULL, 0, 2, 1, '0', NULL, 0),
(3, 'mesho', 'meshoraouf500@gmail.com', '$2y$10$qm6lqN/l6vIeD5yIShG7ZeVrI/LMtQApEyz/Nosuvj90T0WmALLnu', NULL, 0, 2, 1, '0', NULL, 0);

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
-- Indexes for table `rating_tbib_store`
--
ALTER TABLE `rating_tbib_store`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productId` (`productId`),
  ADD KEY `userId` (`userId`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `rating_tbib_store`
--
ALTER TABLE `rating_tbib_store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
-- Constraints for table `rating_tbib_store`
--
ALTER TABLE `rating_tbib_store`
  ADD CONSTRAINT `rating_tbib_store_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products_tbib_store` (`id`),
  ADD CONSTRAINT `rating_tbib_store_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users_tbib_store` (`id`);

--
-- Constraints for table `users_tbib_store`
--
ALTER TABLE `users_tbib_store`
  ADD CONSTRAINT `rule` FOREIGN KEY (`rule`) REFERENCES `rules_tbib_store` (`id`) ON DELETE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
