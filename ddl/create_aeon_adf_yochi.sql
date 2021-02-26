CREATE TABLE company_mast
(
  bic_company_cd nvarchar(20) NOT NULL
 ,company_cd nvarchar(20) NOT NULL
 ,company_na nvarchar(100) NOT NULL
 ,sort_jun nvarchar(10) NOT NULL
 ,CONSTRAINT company_mast_pk PRIMARY KEY (company_cd)
);

CREATE TABLE contain_store_dept_mast
(
  retail_store_cd nvarchar(5) NOT NULL
 ,dept_cd nvarchar(3) NOT NULL
 ,category_cd nvarchar(2)
 ,sub_category_cd nvarchar(2)
 ,link_pattern nvarchar(1) NOT NULL
 ,containing_store_cd nvarchar(5) NOT NULL
);

CREATE TABLE dept_term
(
  company_cd nvarchar(20) NOT NULL
 ,dept_cd character varying(3) NOT NULL
 ,judge_term int
 ,CONSTRAINT dept_term_pkey PRIMARY KEY (dept_cd, company_cd)
);

CREATE TABLE intac_judge_info
(
  dept_group_cd nvarchar(20)
 ,dept_group_na nvarchar(100)
 ,dept_cd nvarchar(3) NOT NULL
 ,dept_na nvarchar(100)
 ,category_cd nvarchar(2)
 ,sub_category_cd nvarchar(2)
 ,env_id nvarchar(1) NOT NULL
 ,disp_logic nvarchar(1) NOT NULL
 ,CONSTRAINT intac_judge_info_pkey PRIMARY KEY (dept_cd)
);

CREATE TABLE ns_judge_mast
(
  odbms_stock_umu nvarchar(1) NOT NULL
 ,odbms_brakeset_umu nvarchar(1) NOT NULL
 ,intac_umu nvarchar(1) NOT NULL
 ,tlog_umu nvarchar(1) NOT NULL
 ,judge_kekka nvarchar(1) NOT NULL
 ,judge_reason nvarchar(100) NOT NULL
 ,CONSTRAINT ns_judge_mast_pkey PRIMARY KEY (odbms_stock_umu, intac_umu, odbms_brakeset_umu, tlog_umu)
);

CREATE TABLE store_mast
(
  bic_company_cd nvarchar(20) NOT NULL
 ,company_cd nvarchar(20) NOT NULL
 ,store_cd nvarchar(5) NOT NULL
 ,store_na nvarchar(100) NOT NULL
 ,sort_jun nvarchar(10) NOT NULL
 ,md_start_umu nvarchar(1) NOT NULL
 ,gm_start_umu nvarchar(1) NOT NULL
 ,gr_start_umu nvarchar(1) NOT NULL
 ,CONSTRAINT store_mast_pkey PRIMARY KEY (store_cd)
);

CREATE TABLE batch_exec_rslt_info
(
  seq_no bigint NOT NULL identity(1,1)
 ,exec_dt nchar(8)
 ,target_list_out_rslt_cd nchar(1) DEFAULT '2'
 ,target_list_out_rslt_tm nchar(14)
 ,target_list_file_nm nvarchar(100)
 ,odbms_stock_md_in_rslt_cd nchar(1) DEFAULT '2'
 ,odbms_stock_md_in_rslt_tm nchar(14)
 ,odbms_stock_gr_in_rslt_cd nchar(1) DEFAULT '2'
 ,odbms_stock_gr_in_rslt_tm nchar(14)
 ,odbms_stock_gm_in_rslt_cd nchar(1) DEFAULT '2'
 ,odbms_stock_gm_in_rslt_tm nchar(14)
 ,odbms_arriv_md_in_rslt_cd nchar(1) DEFAULT '2'
 ,odbms_arriv_md_in_rslt_tm nchar(14)
 ,odbms_arriv_gr_in_rslt_cd nchar(1) DEFAULT '2'
 ,odbms_arriv_gr_in_rslt_tm nchar(14)
 ,odbms_arriv_gm_in_rslt_cd nchar(1) DEFAULT '2'
 ,odbms_arriv_gm_in_rslt_tm nchar(14)
 ,odbms_brakeset_in_rslt_cd nchar(1) DEFAULT '2'
 ,odbms_brakeset_in_rslt_tm nchar(14)
 ,ecbeing_goods_in_rslt_cd nchar(1) DEFAULT '2'
 ,ecbeing_goods_in_rslt_tm nchar(14)
 ,exclude_goods_upload_tm nchar(14)
 ,threshold_info_upload_tm nchar(14)
 ,remarks nvarchar(100)
 ,planogram_shop_in_rslt_cd nchar(1) DEFAULT '2'
 ,planogram_shop_in_rslt_tm nchar(14)
 ,planogram_jan_in_rslt_cd nchar(1) DEFAULT '2'
 ,planogram_jan_in_rslt_tm nchar(14)
 ,eai_tlog_in_rslt_cd nchar(1) DEFAULT '2'
 ,eai_tlog_in_rslt_tm nchar(14)
 ,odbms_mini_md_in_rslt_cd nchar(1) DEFAULT '2'
 ,odbms_mini_md_in_rslt_tm nchar(14)
 ,odbms_mini_gr_in_rslt_cd nchar(1) DEFAULT '2'
 ,odbms_mini_gr_in_rslt_tm nchar(14)
 ,odbms_mini_gm_in_rslt_cd nchar(1) DEFAULT '2'
 ,odbms_mini_gm_in_rslt_tm nchar(14)
 ,CONSTRAINT batch_exec_rslt_info_pkey PRIMARY KEY (seq_no)
);

CREATE INDEX index_batch_exec_rslt_info ON batch_exec_rslt_info (exec_dt);

CREATE TABLE exec_log
(
  seq_no bigint NOT NULL identity(1,1)
 ,exec_na nvarchar(800) NOT NULL
 ,output_tm datetime DEFAULT dbo.get_current_jst()
 ,log_type int NOT NULL
 ,log_text nvarchar(max)
 ,CONSTRAINT exec_log_pkey PRIMARY KEY (seq_no)
);

CREATE INDEX index1_exec_log ON exec_log (exec_na, output_tm);
CREATE INDEX index2_exec_log ON exec_log (output_tm);

CREATE TABLE odbms_arrival_info
(
  store_cd nchar varying(5)
 ,dept_cd nchar varying(3)
 ,jan_cd nchar varying(13)
 ,order_quantity int
 ,order_date nchar(8)
 ,arrival_date nchar(8)
 ,exec_date nchar(8)
 ,env_id nvarchar(4)
);

CREATE INDEX index_odbms_arrival_info
ON odbms_arrival_info
(
  store_cd
 ,jan_cd
 ,arrival_date
);

CREATE TABLE odbms_brakeset_info
(
  env_id nvarchar(4)
 ,parent_dept_cd nvarchar(3)
 ,parent_jan_cd nvarchar(13)
 ,child_dept_cd nvarchar(3)
 ,child_jan_cd nvarchar(13) NOT NULL
 ,number_sets int
 ,CONSTRAINT odbms_brakeset_info_pkey PRIMARY KEY (child_jan_cd)
);

CREATE TABLE odbms_mini_info
(
  store_cd nvarchar(5) NOT NULL
 ,jan_cd nvarchar(13) NOT NULL
 ,threshold_num bigint
 ,env_id nvarchar(4)
 ,CONSTRAINT odbms_mini_info_pkey PRIMARY KEY (store_cd, jan_cd)
);

CREATE TABLE odbms_stock_info
(
  calc_date nchar(8)
 ,store_cd nvarchar(12) NOT NULL
 ,jan_cd nvarchar(18) NOT NULL
 ,term_stock bigint
 ,dept_cd nvarchar(3)
 ,env_id nvarchar(4)
 ,CONSTRAINT odbms_stock_info_pkey PRIMARY KEY (store_cd, jan_cd)
);

CREATE TABLE exclude_goods_info
(
  company_cd nvarchar(20)
 ,store_cd nvarchar(5)
 ,store_nm nvarchar(80)
 ,jan_cd nvarchar(13)
 ,godds_name nvarchar(400)
 ,remarks nvarchar(400)
 ,dept_cd nvarchar(3)
 ,category_cd nvarchar(2)
 ,sub_category_cd nvarchar(2)
);

CREATE INDEX index1_exclude_goods_info ON exclude_goods_info (company_cd, dept_cd);
CREATE INDEX index2_exclude_goods_info ON exclude_goods_info (company_cd, dept_cd, category_cd);
CREATE INDEX index3_exclude_goods_info ON exclude_goods_info (company_cd, dept_cd, category_cd, sub_category_cd);
CREATE INDEX index4_exclude_goods_info ON exclude_goods_info (company_cd, jan_cd);
CREATE INDEX index5_exclude_goods_info ON exclude_goods_info (store_cd, dept_cd);
CREATE INDEX index6_exclude_goods_info ON exclude_goods_info (store_cd, dept_cd, category_cd);
CREATE INDEX index7_exclude_goods_info ON exclude_goods_info (store_cd, dept_cd, category_cd, sub_category_cd);
CREATE INDEX index8_exclude_goods_info ON exclude_goods_info (store_cd, jan_cd);

CREATE TABLE threshold_info
(
  company_cd nvarchar(20)
 ,store_cd nvarchar(5)
 ,store_nm nvarchar(80)
 ,dept_cd nvarchar(3)
 ,category_cd nvarchar(2)
 ,sub_category_cd nvarchar(2)
 ,threshold_name nvarchar(400)
 ,threshold_num int
 ,remarks nvarchar(400)
 ,jan_cd nvarchar(13)
 ,threshold_cd nvarchar(1)
 ,min_coeffecient float
);

CREATE INDEX index1_threshold_info ON threshold_info (company_cd, dept_cd);
CREATE INDEX index2_threshold_info ON threshold_info (company_cd, dept_cd, category_cd);
CREATE INDEX index3_threshold_info ON threshold_info (company_cd, dept_cd, category_cd, sub_category_cd);
CREATE INDEX index4_threshold_info ON threshold_info (company_cd, jan_cd);
CREATE INDEX index5_threshold_info ON threshold_info (store_cd, dept_cd);
CREATE INDEX index6_threshold_info ON threshold_info (store_cd, dept_cd, category_cd);
CREATE INDEX index7_threshold_info ON threshold_info (store_cd, dept_cd, category_cd, sub_category_cd);
CREATE INDEX index8_threshold_info ON threshold_info (store_cd, jan_cd);

CREATE TABLE ecbeing_after_goods_info
(
  company_cd nvarchar(20) NOT NULL
 ,shop_cd nvarchar(14) NOT NULL
 ,dept_cd nvarchar(3) NOT NULL
 ,category_cd nvarchar(2)
 ,sub_category_cd nvarchar(2)
 ,jan_cd nvarchar(13) NOT NULL
 ,sales_promotion_cd nchar(1) NOT NULL
 ,disp_status_cd nchar(1) NOT NULL
 ,store_cd nvarchar(5)
 ,CONSTRAINT ecbeing_after_goods_info_pkey PRIMARY KEY (
   shop_cd
  ,jan_cd
 )
);

CREATE TABLE ecbeing_after_goods_info_summary
(
  company_cd nvarchar(20) NOT NULL
 ,shop_cd nvarchar(14) NOT NULL
 ,dept_cd nvarchar(3) NOT NULL
 ,category_cd nvarchar(2)
 ,sub_category_cd nvarchar(2)
 ,jan_cd nvarchar(13) NOT NULL
 ,sales_promotion_cd nchar(1) NOT NULL
 ,disp_status_cd nchar(1) NOT NULL
 ,store_cd nvarchar(5) NOT NULL
 ,ref_company_cd nvarchar(20)
 ,ref_store_cd nvarchar(5)
 ,merge_ref_company_cd nvarchar(20)
 ,merge_ref_store_cd nvarchar(5)
 ,judge_kekka nchar(1)
 ,judge_reason nvarchar(max)
 ,is_target_flag int
 ,env_id nvarchar(4)
 ,logic_old_new nchar(1)
 ,exclude_goods_info_umu nchar(1)
 ,min_threshold_num bigint
 ,threshold_cd nvarchar(1)
 ,min_coeffecient real
 ,threshold_num bigint
 ,judge_threshold_num real
 ,judge_stock_arrive bigint
 ,odbms_stock_umu nchar(1)
 ,judge_breakset bigint
 ,odbms_brakeset_umu nchar(1)
 ,intac_umu nchar(1)
 ,tlog_umu nchar(1)
 ,parent_jan_cd_list nvarchar(max)
 ,CONSTRAINT ecbeing_after_goods_info_summary_pkey PRIMARY KEY (
   shop_cd
  ,jan_cd
 )
);

CREATE TABLE ecbeing_goods_info
(
  company_cd nvarchar(20)
 ,shop_cd nvarchar(14) NOT NULL
 ,dept_cd nvarchar(3)
 ,category_cd nvarchar(2)
 ,sub_category_cd nvarchar(2)
 ,jan_cd nvarchar(13) NOT NULL
 ,sales_promotion_cd nchar(1)
 ,disp_status_cd nchar(1)
 ,store_cd nvarchar(5)
);

CREATE INDEX index_ecbeing_goods_info1 ON ecbeing_goods_info (shop_cd, jan_cd);
CREATE INDEX index_ecbeing_goods_info2 ON ecbeing_goods_info (store_cd);

CREATE TABLE ecbeing_goods_tmp
(
company_cd nvarchar(20) NOT NULL
,shop_cd nvarchar(14) NOT NULL
,dept_cd nvarchar(3) NOT NULL
,category_cd nvarchar(2)
,sub_category_cd nvarchar(2)
,jan_cd nvarchar(13) NOT NULL
,sales_promotion_cd nchar(1)
,disp_status_cd nchar(1) NOT NULL
);

CREATE INDEX index1_ecbeing_goods_tmp ON ecbeing_goods_tmp (shop_cd, jan_cd);

CREATE TABLE ecbeing_stock_arrival_info
(
  store_cd nvarchar(12) NOT NULL
 ,jan_cd nvarchar(18) NOT NULL
 ,stock_arrive bigint NOT NULL
 ,CONSTRAINT ecbeing_stock_arrival_info_pkey PRIMARY KEY (store_cd, jan_cd)
);

CREATE TABLE planogram_shop_info
(
  store_cd nvarchar(5) NOT NULL
 ,shelf_cd nvarchar(9) NOT NULL
 ,CONSTRAINT planogram_shop_info_pkey PRIMARY KEY (store_cd, shelf_cd)
);

CREATE TABLE planogram_jan_info
(
  shelf_cd nvarchar(9)
 ,jan_cd nvarchar(13)
);

CREATE INDEX index_planogram_jan_info ON planogram_jan_info (shelf_cd);

CREATE TABLE eai_shop_sale_info
(
  shop_cd nvarchar(10) NOT NULL
 ,dept_cd nvarchar(3)
 ,jan_cd nvarchar(13) NOT NULL
 ,selling_date nvarchar(8) NOT NULL
 ,selling_cnt int
 ,store_cd nvarchar(5)
 ,CONSTRAINT eai_shop_sale_info_pkey PRIMARY KEY (shop_cd, jan_cd, selling_date)
);

CREATE INDEX index_eai_shop_sale_info ON eai_shop_sale_info (dept_cd, selling_date);

CREATE TABLE shop_stock
(
  shop_cd nvarchar(10) NOT NULL
 ,jan_cd nvarchar(13) NOT NULL
 ,store_cd nvarchar(5)
 ,book_qty decimal(12,4)
 ,stock_qty decimal(12,4)
 ,md_flg int
 ,planogram_flg int
 ,sales_flg int
 ,stock_date nchar(8)
 ,created_at datetime DEFAULT dbo.get_current_jst()
 ,updated_at datetime DEFAULT dbo.get_current_jst()
 ,CONSTRAINT shop_stock_pkey PRIMARY KEY (shop_cd, jan_cd)
);
