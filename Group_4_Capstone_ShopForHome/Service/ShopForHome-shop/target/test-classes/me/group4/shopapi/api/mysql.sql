CREATE TABLE IF NOT EXISTS ecommerce.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
);


CREATE TABLE IF NOT EXISTS ecommerce.discount
(
    id character varying(255) NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS ecommerce.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) ,
    category_type integer,
    create_time timestamp ,
    update_time timestamp ,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
);

ALTER TABLE `ecommerce`.`product_category` 
CHANGE COLUMN `category_id` `category_id` INT NOT NULL AUTO_INCREMENT ;


CREATE TABLE IF NOT EXISTS ecommerce.product_info
(
    product_id character varying(255)  NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp ,
    product_description character varying(255) ,
    product_icon character varying(255) ,
    product_name character varying(255)  NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp ,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
);

CREATE TABLE IF NOT EXISTS ecommerce.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) ,
    email character varying(255) ,
    name character varying(255) ,
    password character varying(255) ,
    phone character varying(255) ,
    role character varying(255) ,
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
);

ALTER TABLE `ecommerce`.`users` 
CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT ;



CREATE TABLE IF NOT EXISTS ecommerce.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) ,
    buyer_email character varying(255) ,
    buyer_name character varying(255) ,
    buyer_phone character varying(255) ,
    create_time timestamp,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
);

ALTER TABLE `ecommerce`.`order_main` 
CHANGE COLUMN `order_id` `order_id` BIGINT NOT NULL AUTO_INCREMENT ;



CREATE TABLE IF NOT EXISTS ecommerce.product_in_order
(
    id bigint NOT NULL AUTO_INCREMENT,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255)  NOT NULL,
    product_icon character varying(255) ,
    product_id character varying(255) ,
    product_name character varying(255) ,
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES ecommerce.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES ecommerce.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        ,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
);



CREATE TABLE IF NOT EXISTS ecommerce.wishlist
(
    id bigint NOT NULL AUTO_INCREMENT,
    created_date timestamp ,
    user_id bigint,
    product_id character varying(255),
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES ecommerce.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_wish_Fkey FOREIGN KEY (user_id)
        REFERENCES ecommerce.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE `ecommerce`.`discount`
ADD COLUMN user_email VARCHAR(255);

ALTER TABLE `ecommerce`.`discount` 
ADD INDEX `user_email_fkey_idx` (`user_email` ASC) VISIBLE;
;
ALTER TABLE `ecommerce`.`discount` 
ADD CONSTRAINT `user_email_fkey`
  FOREIGN KEY (`user_email`)
  REFERENCES `ecommerce`.`users` (`email`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `ecommerce`.`discount` 
DROP PRIMARY KEY;
;

ALTER TABLE `ecommerce`.`discount` 
ADD COLUMN `coupon` VARCHAR(255) NULL AFTER `user_email`,
CHANGE COLUMN `id` `id` BIGINT NOT NULL ,
ADD PRIMARY KEY (`id`);
;

ALTER TABLE `ecommerce`.`discount` 
CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT ;



INSERT INTO ecommerce.product_category VALUES (2147483641, 'Furniture', 0, '2022-08-23 23:03:26', '2022-08-25 23:03:26');
INSERT INTO ecommerce.product_category VALUES (2147483642, 'Garden & Outdoor', 1, '2022-08-23 23:03:26', '2022-08-25 23:03:26');
INSERT INTO ecommerce.product_category VALUES (2147483643, 'Wall Decoration', 2, '2022-08-23 23:03:26', '2022-08-25 23:03:26');
INSERT INTO ecommerce.product_category VALUES (2147483644, 'Lighting', 3, '2022-08-23 23:03:26', '2022-08-25 23:03:26');


INSERT INTO ecommerce.product_info VALUES ('IF001', 0, '2022-08-25 13:23:16', 'A comfortable seat with a back and usually with arms, which 2 or 3 people can sit on', 'https://ii1.pepperfry.com/media/catalog/product/m/i/568x284/miranda-3-seater-sofa-in-navy-blue-colour-by-woodsworth-miranda-3-seater-sofa-in-navy-blue-colour-by-reeh4d.jpg', 'Miranda 3 Seater Sofa In Navy Blue Colour', 8670.00, 0, 12, '2022-08-25 13:23:16');
INSERT INTO ecommerce.product_info VALUES ('IF002', 0, '2022-08-25 13:23:16', 'Adjustable lumbar support for exclusive comfort The adjustable handle and soft pads lets you rest your handle comfortably', 'https://ii1.pepperfry.com/media/catalog/product/b/u/800x880/buick-iconic-chair-yellow-in-colour-by-furniturstation-buick-iconic-chair-yellow-in-colour-by-furnit-x0kcut.jpg', 'Buick Iconic chair Yellow in Colour', 9446.00, 0, 16, '2022-08-25 13:23:16');
INSERT INTO ecommerce.product_info VALUES ('IF003', 0, '2022-08-25 13:23:16', 'A table is an arrangement of information or data, typically in rows and columns, or possibly in a more complex structure', 'https://ii1.pepperfry.com/media/catalog/product/h/a/800x880/haruka-6-seater-dining-set-in-walnut---sky-blue-finish---casacraft-by-pepperfry-haruka-6-seater-dini-1xzvtc.jpg', 'Haruka 6 Seater Dining Set in Walnut & Sky Blue Finish', 5045.00, 0, 15, '2022-08-25 13:23:16');

INSERT INTO ecommerce.product_info VALUES ('AF001', 3, '2022-08-25 13:13:26', 'this floor lamp will enhance the interiors of your space by giving it a modern and beautiful look', 'https://ii3.pepperfry.com/media/wysiwyg/banners/Floorlamp_trends_web_24122021_2.jpg', 'Tripod Lamp', 2910.00, 0, 29, '2022-08-25 13:13:26');
INSERT INTO ecommerce.product_info VALUES ('AF002', 3, '2022-08-25 13:13:26', 'A side lamp is a light that is placed next to a bed. It is usually small in size so it can fit on a nightstand or table', 'https://ii2.pepperfry.com/media/catalog/product/b/e/494x544/beige-jute-parchment-shade-floor-lamp-with-natural-wood-base-by-new-era-beige-jute-parchment-shade-f-htcmfl.jpg', 'Side Lamp', 4376.00, 0, 75, '2022-08-25 13:13:26');
INSERT INTO ecommerce.product_info VALUES ('AF003', 3, '2022-08-25 13:13:26', 'A club lamp, another ubiquitous type, is a stick lamp designed for area lighting.', 'https://ii2.pepperfry.com/media/catalog/product/c/o/494x544/copper-finish-modern-arc-floor-lamp-with-wooden-base---white-shade-by-the-lighting-hub-copper-finish-kvi1o0.jpg', 'Clud floor lamp', 8342.00, 0, 20, '2022-08-25 13:13:26');

INSERT INTO ecommerce.product_info VALUES ('WS001', 1, '2022-08-25 13:36:16', 'The Glossy Triangle from the collection Summer Gardens', 'https://ii1.pepperfry.com/media/catalog/product/b/l/800x880/black-iron-desk-pot-with-triangle-shape-planter-stand-by-amaya-decors-black-iron-desk-pot-with-trian-ttqemy.jpg', 'Black Iron Desk Pot with Triangle Shape Planter Stand', 5443.00, 0, 20, '2022-08-25 13:36:16');
INSERT INTO ecommerce.product_info VALUES ('WS002', 1, '2022-08-25 13:36:16', 'UNIQ WORLD Decorative Pebbles Stones River Rock Unplanted Substrate Pebble Stone for Garden/Lawn', 'https://ii1.pepperfry.com/media/catalog/product/y/e/800x880/yellow-stone-rock--decorative-pebbles-by--home-yellow-stone-rock--decorative-pebbles-by--home-ogdmka.jpg', 'Yellow Stone Rock Decorative Pebbles', 3485.00, 0, 10, '2022-08-25 13:36:16');
INSERT INTO ecommerce.product_info VALUES ('WS003', 1, '2022-08-25 13:36:16', 'Patiofy premium macrame hammock swing chair is designed with sturdy woven macrame cotton ropes', 'https://ii1.pepperfry.com/media/catalog/product/l/u/800x880/luxury-macrame-swing-chair-with-blue-cushion---hanging-kit-in-white-colour-by-patiofy-luxury-macrame-oro5op.jpg', 'Luxury Macrame Swing Chair with Blue Cushion & Hanging Kit in White Colour', 7435.00, 0, 30, '2022-08-25 13:36:16');

INSERT INTO ecommerce.product_info VALUES ('PA001', 2, '2022-08-23 23:03:26', 'Fine Art Home Decor Metal Art & Craft Bird Ring Small with Led Light', 'https://m.media-amazon.com/images/I/81+mbR9nw-L._SX679_.jpg', 'Home Decor Metal Art ', 74233.00, 0, 45, '2022-08-25 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('PA002', 2, '2022-08-23 23:03:26', 'World Decor Led Couple Peacock Birds Metal Wall Art - Big, Multicolour', 'https://m.media-amazon.com/images/I/61LsEgD7uTL._SX679_.jpg', 'Led Couple Peacock Birds', 5742.00, 0, 53, '2022-08-25 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('PA003', 2, '2022-08-23 23:03:26', 'Fine Art Home Decor Metal & MDF Art & Craft Bike Panel', 'https://m.media-amazon.com/images/I/81wdvBLTBkL._SX679_.jpg', 'Home Decor Metal & MDF Art ', 9345.00, 0, 70, '2022-08-25 23:03:26');

INSERT INTO ecommerce.users VALUES (2147483645, true, 'Delhi', 'admin@gmail.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');




