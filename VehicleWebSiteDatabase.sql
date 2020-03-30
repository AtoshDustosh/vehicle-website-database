营销状态（营销状态ID，状态名称）
CREATE TABLE SaleStatus (
	'sale_status_id' TINYINT,
	'sale_status_name' VARCHAR(255),
	PRIMARY KEY('sale_status_id')
);
INSERT INTO SaleStatus VALUES
	(0, 'off sale'),
	(1, 'on sale'),
	(2, 'coming soon')
;

车型（车型ID，车系ID，时速，营销状态ID）
CREATE TABLE VehicleType (
	'vehicle_type_id' VARCHAR(45),
	'vehicle_style_id' VARCHAR(45),
	'vehicle_speed' SMALLINT,
	'sale_status_id' TINYINT,
	PRIMARY KEY('type_id'),
	FOREIGN KEY ('sale_status_id') REFERENCES SaleStatus('sale_status_id')
)
INSERT INTO VehicleType VALUES
	('A123-1', 'A', 220, 1),
	('B324-2', 'B', 230, 1),
	('A123-9', 'A', 220, 1),
	('C8-2', 'C', 300, 1),
	('C0-0', 'C', 400, 0)
;

车型颜色（车型ID，颜色）
CREATE TABLE VehicleColour (
	'vehicle_type_id' VARCHAR(45),
	'vehicle_colour' VARCHAR(45)
	PRIMARY KEY ('vehicle_type_id', 'vehicle_colour'),
	FOREIGN KEY ('vehicle_type_id') REFERENCES VehicleType('vehicle_type_id')
);
INSERT INTO VehicleColour VALUES
	('A123-1', 'white'),
	('A123-1', 'black'),
	('B324-2', 'silver'),
	('A123-9', 'dark blue'),
	('C8-2', 'red'),
	('C0-0', 'sky blue')
;

用户（用户ID，电话号码）
CREATE TABLE WebUser (
	'user_id' VARCHAR(255),
	'phone' VARCHAR(45)
);
INSERT INTO WebUser VALUES
	('aaa', '123456789'),
	('bbb', '987654321')
;

车型评价（评价ID，车型ID，用户ID，经销商ID，评价时间，评价内容，评分）
CREATE TABLE VehicleEvaluation (
	'evaluation_id' INTEGER,
	'vehicle_type_id' VARCHAR(45),
	'user_id' VARCHAR(255),
	'shop_id' VARCHAR(255),
	'evaluation_date' DATE,
	'evaluation_content' VARBINARY,
	'score' REAL,
	PRIMARY KEY ('evaluation_id'),
	FOREIGN KEY ('vehicle_type_id') REFERENCES VehicleType('vehicle_type_id'),
	FOREIGN KEY ('user_id') REFERENCES WebUser('user_id')
)
INSERT INTO VehicleEvaluation VALUES
	(1, 'A123-9', 'aaa', 'BMW', ???, ???, 8.5)

作品类型（作品类型ID，作品类型名称）
CREATE TABLE WorksType (
	'works_type_id' TINYINT,
	'works_type_name' VARCHAR(45),
	PRIMARY KEY ('works_type_id')
);
INSERT INTO WorksType VALUES
	(1, 'video'),
	(2, 'article')
;

作品（作品ID，用户ID，作品类型ID，作品内容）
CREATE TABLE Works (
	'works_id' VARCHAR(45),
	'user_id' VARCHAR(255),
	'works_type_id' TINYINT,
	'works_content' VARBINARY,
	PRIMARY KEY ('works_id'),
	FOREIGN KEY ('user_id') REFERENCES WebUser('user_id'),
	FOREIGN KEY ('works_type_id') REFERENCES WorksType('works_type_id')
);

作品回复（回复ID，用户ID，作品ID，回复内容）
CREATE TABLE WorksReply (
	'reply_id' VARCHAR(45),
	'user_id' VARCHAR(255),
	'works_id' VARCHAR(45),
	'reply_content' VARBINARY,
	PRIMARY KEY ('reply_id'),
	FOREIGN KEY ('user_id') REFERENCES WebUser('user_id'),
	FOREIGN KEY ('works_id') REFERENCES Works('works_id')
);
	
订单（订单ID，用户ID，经销商ID，车型ID，订单日期）
车系生产（生产商ID，车系ID）
车型生产（生产商ID，车型ID，生产数量）
车型经销（经销商ID，车型ID，售价）
用户好友（用户ID，用户ID）
车系作品（作品ID，车系ID）

车系 - vehicle style
生产商 - manufacturer
车型 - vehicle type 
颜色 - colour
时速 - speed per hour
营销状态 - sales status
生产数量 - quantity
车型评价 - vehicle evaluation
评价内容 - content of evaluation
评分 - score
经销商 - delaer
销售价 - marketing price
用户 - user
电话号码 - telephone
作品 - user works
作品类型 - type of works
作品内容 - content of works
作品回复 - comment
回复内容 - content of comment
订单 - order
订单日期 - date
