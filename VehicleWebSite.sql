# 车系（车系ID，车系名称）
CREATE TABLE VehicleBrand (
	`vehicle_brand_id` INTEGER AUTO_INCREMENT CHECK (`vehicle_brand_id` >= 0),
	`vehicle_brand_name` VARCHAR(45) NOT NULL,
	PRIMARY KEY (`vehicle_brand_id`) 
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
INSERT INTO VehicleBrand VALUES
	(1, 'A'),
	(2, 'B'),
	(3, 'C')
;

# 车型（车型ID，车系ID，时速，营销状态）
CREATE TABLE VehicleType (
	`vehicle_type_id` VARCHAR(45),
	`vehicle_brand_id` INTEGER NOT NULL,
	`vehicle_speed` SMALLINT NOT NULL CHECK (`vehicle_speed` >= 0),
	`sale_status` TINYINT NOT NULL CHECK (`sales_status` IN (0, 1, 2)),
	PRIMARY KEY (`vehicle_type_id`),
	FOREIGN KEY (`vehicle_brand_id`) REFERENCES VehicleBrand(`vehicle_brand_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
INSERT INTO VehicleType VALUES
	('A123-1', 1, 220, 1),
	('B324-2', 2, 230, 1),
	('A123-9', 1, 220, 1),
	('C8-2', 3, 300, 1),
	('C0-0', 3, 400, 0)
;

CREATE INDEX idx_brand_speed_salestatus ON 
	VehicleType(`vehicle_brand_id`, `vehicle_speed`, `sale_status`);


# 车型颜色（车型ID，颜色）
CREATE TABLE VehicleColour (
	`vehicle_type_id` VARCHAR(45),
	`vehicle_colour` VARCHAR(45),
	PRIMARY KEY (`vehicle_type_id`, `vehicle_colour`),
	FOREIGN KEY (`vehicle_type_id`) REFERENCES VehicleType(`vehicle_type_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
INSERT INTO VehicleColour VALUES
	('A123-1', 'white'),
	('A123-1', 'black'),
	('B324-2', 'silver'),
	('A123-9', 'dark blue'),
	('C8-2', 'red'),
	('C0-0', 'sky blue')
;

# 经销商（经销商ID）
CREATE TABLE Shop (
	`shop_id` VARCHAR(45),
	PRIMARY KEY (`shop_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
INSERT INTO Shop VALUES
	('S-A-1'),
	('S-B-1'),
	('S-B-2'),
	('S-C-1')
;

# 生产商（生产商ID）
CREATE TABLE Manufacturer (
	`manufacturer_id` VARCHAR(45),
	PRIMARY KEY (`manufacturer_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
INSERT INTO Manufacturer VALUES
	('M-A-1'),
	('M-B-1'),
	('M-C-1')
;

# 用户（用户ID，电话号码）
CREATE TABLE WebUser (
	`user_id` VARCHAR(45),
	`phone` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`user_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
INSERT INTO WebUser VALUES
	('aaa', '123456789'),
	('bbb', '987654321')
;

# 车型评价（评价ID，车型ID，用户ID，经销商ID，评价时间，评价内容，评分）
CREATE TABLE VehicleEvaluation (
	`evaluation_id` INTEGER AUTO_INCREMENT,
	`vehicle_type_id` VARCHAR(45) NOT NULL,
	`user_id` VARCHAR(45) NOT NULL,
	`shop_id` VARCHAR(45) NOT NULL,
	`evaluation_date` TIME NOT NULL,
	`evaluation_content` TEXT NOT NULL,
	`score` REAL NOT NULL CHECK (`score` >= 0),
	PRIMARY KEY (`evaluation_id`),
	FOREIGN KEY (`vehicle_type_id`) REFERENCES VehicleType(`vehicle_type_id`),
	FOREIGN KEY (`user_id`) REFERENCES WebUser(`user_id`),
	FOREIGN KEY (`shop_id`) REFERENCES Shop(`shop_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX idx_vehicle_type ON VehicleEvaluation(`vehicle_type_id`);

CREATE INDEX idx_user ON VehicleEvaluation(`user_id`);


# 作品（作品ID，用户ID，作品类型，作品内容）
CREATE TABLE Works (
	`works_id` VARCHAR(45),
	`user_id` VARCHAR(45) NOT NULL,
	`works_type` TINYINT NOT NULL CHECK (`works_type` IN (0, 1, 2)),
	`works_content` TEXT NOT NULL,
	PRIMARY KEY (`works_id`),
	FOREIGN KEY (`user_id`) REFERENCES WebUser(`user_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX idx_user ON Works(`user_id`);

CREATE INDEX idx_works_type ON Works(`works_type`);

# 作品回复（回复ID，用户ID，作品ID，回复内容）
CREATE TABLE WorksReply (
	`reply_id` VARCHAR(45),
	`user_id` VARCHAR(45) NOT NULL,
	`works_id` VARCHAR(45) NOT NULL,
	`reply_content` TEXT NOT NULL,
	PRIMARY KEY (`reply_id`),
	FOREIGN KEY (`user_id`) REFERENCES WebUser(`user_id`),
	FOREIGN KEY (`works_id`) REFERENCES Works(`works_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX idx_user ON WorksReply(`user_id`);

	
# 订单（订单ID，用户ID，经销商ID，车型ID，订单日期）
CREATE TABLE Indent (
	`indent_id` VARCHAR(45),
	`user_id` VARCHAR(45) NOT NULL,
	`shop_id` VARCHAR(45) NOT NULL,
	`vehicle_type_id` VARCHAR(45) NOT NULL,
	`indent_date` TIME NOT NULL,
	PRIMARY KEY (`indent_id`),
	FOREIGN KEY (`user_id`) REFERENCES WebUser(`user_id`),
	FOREIGN KEY (`shop_id`) REFERENCES Shop(`shop_id`),
	FOREIGN KEY (`vehicle_type_id`) REFERENCES VehicleType(`vehicle_type_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
CREATE INDEX idx_user ON Indent(`user_id`);

CREATE INDEX idx_shop ON Indent(`shop_id`);


# 车系生产（生产商ID，车系ID）
CREATE TABLE VehicleBrandManufacture (
	`manufacturer_id` VARCHAR(45),
	`vehicle_brand_id` INTEGER,
	PRIMARY KEY (`manufacturer_id`, `vehicle_brand_id`),
	FOREIGN KEY (`manufacturer_id`) REFERENCES Manufacturer(`manufacturer_id`),
	FOREIGN KEY (`vehicle_brand_id`) REFERENCES VehicleBrand(`vehicle_brand_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

# 车型生产（生产商ID，车型ID，生产数量）
CREATE TABLE VehicleTypeManufacture (
	`manufacturer_id` VARCHAR(45),
	`vehicle_type_id` VARCHAR(45),
	`quantity` INTEGER NOT NULL CHECK (`quantity` >= 0),
	PRIMARY KEY (`manufacturer_id`, `vehicle_type_id`),
	FOREIGN KEY (`manufacturer_id`) REFERENCES Manufacturer(`manufacturer_id`),
	FOREIGN KEY (`vehicle_type_id`) REFERENCES VehicleType(`vehicle_type_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

# 车型经销（经销商ID，车型ID，售价）
CREATE TABLE VehicleTypeShop (
	`shop_id` VARCHAR(45),
	`vehicle_type_id` VARCHAR(45),
	`vehicle_price` REAL NOT NULL CHECK (`vehicle_price` >= 0),
	PRIMARY KEY (`shop_id`, `vehicle_type_id`),
	FOREIGN KEY (`shop_id`) REFERENCES Shop(`shop_id`),
	FOREIGN KEY (`vehicle_type_id`) REFERENCES VehicleType(`vehicle_type_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX idx_price ON VehicleTypeShop(`vehicle_price`);

# 用户好友（用户ID，用户ID）
CREATE TABLE UserFriend (
	`user_idx` VARCHAR(45),
	`user_idy` VARCHAR(45),
	PRIMARY KEY (`user_idx`, `user_idy`),
	FOREIGN KEY (`user_idx`) REFERENCES WebUser(`user_id`),
	FOREIGN KEY (`user_idy`) REFERENCES WebUser(`user_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
	
# 车系作品（作品ID，车系ID）
CREATE TABLE WorksAboutVehicleBrand (
	`works_id` VARCHAR(45),
	`vehicle_brand_id` INTEGER,
	PRIMARY KEY (`works_id`, `vehicle_brand_id`),
	FOREIGN KEY (`works_id`) REFERENCES Works(`works_id`),
	FOREIGN KEY (`vehicle_brand_id`) REFERENCES VehicleBrand(`vehicle_brand_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE VIEW AllIndentsofAllUsers AS SELECT * FROM WebUser NATURAL JOIN Indent;

CREATE VIEW AllEvaluationsofAllVehicleTypes AS SELECT * FROM VehicleType NATURAL JOIN VehicleEvaluation;

CREATE VIEW RepliesofAllWorks AS SELECT * FROM Works NATURAL JOIN WorksReply;

CREATE VIEW VehicleTypeAVGScore AS SELECT DISTINCT `vehicle_type_id`, AVG(`score`) `avg_score` FROM VehicleType NATURAL join VehicleEvaluation GROUP BY vehicle_type_id ;

/*
车系 - vehicle brand
生产商 - manufacturer
车型 - vehicle type 
颜色 - colour
时速 - speed per hour
营销状态 - sales status
生产数量 - quantity
车型评价 - vehicle evaluation
评价内容 - content of evaluation
评分 - score
经销商 - delaer/shop
销售价 - marketing price
用户 - user
电话号码 - telephone
作品 - user works
作品类型 - type of works
作品内容 - content of works
作品回复 - comment
回复内容 - content of comment
订单 - indent
订单日期 - date
*/