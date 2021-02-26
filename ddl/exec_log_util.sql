--**************************************************************************************
--* [ファイル名]         : exec_log_util.sql
--* [システム名称]       : 欠品対策在庫連携
--* [処理名]             : 処理ログ関連ユーティリティ
--* [更新日付]           : 修正日      修正者     内容
--*                      : 2021/02/15  VINX       新規作成
--**************************************************************************************

--**************************************************************************************
--* [説明]               : 処理ログ登録
--* [パラメータ]
--*  @vc_exec_na         : 処理名
--*  @i_log_type         : ログタイプ
--*  @vc_log_text        : ログ内容
--**************************************************************************************
CREATE OR ALTER PROCEDURE dbo.insert_exec_log
(
	 @vc_exec_na NVARCHAR(800)
	,@i_log_type INT
	,@vc_log_text NVARCHAR(max)
)
AS
SET NOCOUNT ON;
BEGIN
	INSERT INTO dbo.exec_log (
		  exec_na
		, log_type
		, log_text
	) VALUES (
		  @vc_exec_na
		, @i_log_type
		, @vc_log_text
	);
END;

--**************************************************************************************
--* [説明]               : 正常処理ログ登録
--* [パラメータ]
--*  @vc_exec_na         : 処理名
--*  @vc_log_text        : ログ内容
--**************************************************************************************
CREATE OR ALTER PROCEDURE dbo.insert_normal_exec_log
(
	 @vc_exec_na NVARCHAR(800)
	,@vc_log_text NVARCHAR(max)
)
AS
SET NOCOUNT ON;
BEGIN
	DECLARE
		 @I_LOG_TYPE_NORMAL INT = 1
	;
	
	EXEC dbo.insert_exec_log @vc_exec_na, @I_LOG_TYPE_NORMAL, @vc_log_text;
END;

--**************************************************************************************
--* [説明]               : 異常処理ログ登録
--* [パラメータ]
--*  @vc_exec_na         : 処理名
--*  @vc_log_text        : ログ内容
--**************************************************************************************
CREATE OR ALTER PROCEDURE dbo.insert_error_exec_log
(
	 @vc_exec_na NVARCHAR(800)
	,@vc_log_text NVARCHAR(max)
)
AS
SET NOCOUNT ON;
BEGIN
	DECLARE
		 @I_LOG_TYPE_ERROR INT = 2
	;
	
	EXEC dbo.insert_exec_log @vc_exec_na, @I_LOG_TYPE_ERROR, @vc_log_text;
END;
