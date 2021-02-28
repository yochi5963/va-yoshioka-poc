drop table tmp_planogram_shop_info;
CREATE TABLE tmp_planogram_shop_info
(
  seq_no bigint NOT NULL identity(1,1)
 ,validation_cd int default 1
 ,store_cd nvarchar(100)
 ,shelf_cd nvarchar(100)
);

CREATE TABLE tmp_planogram_jan_info
(
  seq_no bigint NOT NULL identity(1,1)
 ,validation_cd int default 1
 ,shelf_cd nvarchar(100)
 ,jan_cd nvarchar(100)
);
