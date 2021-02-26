--**************************************************************************************
--* [ファイル名]         : common_util.sql
--* [システム名称]       : 欠品対策在庫連携
--* [処理名]             : 共通ユーティリティ
--* [更新日付]           : 修正日      修正者     内容
--*                      : 2021/02/15  VINX       新規作成
--**************************************************************************************

--**************************************************************************************
--* [説明]               : 日本標準時(JST)に変換
--* [パラメータ]
--*  @dt_utc             : 協定世界時(UTC)
--* [戻り値]
--*  日本標準時(JST)
--**************************************************************************************
CREATE OR ALTER FUNCTION dbo.to_jst
(
	 @dt_utc DATETIME
)
RETURNS DATETIME
AS
BEGIN
	DECLARE
		 @dt_offset DATETIMEOFFSET
	;
	
	SET @dt_offset = CONVERT(DATETIMEOFFSET, @dt_utc) AT TIME ZONE 'Tokyo Standard Time';
	RETURN CONVERT(DATETIME, @dt_offset);
END;

--**************************************************************************************
--* [説明]               : 現在の日本標準時(JST)を取得
--* [戻り値]
--*  現在の日本標準時(JST)
--**************************************************************************************
CREATE OR ALTER FUNCTION dbo.get_current_jst
()
RETURNS DATETIME
AS
BEGIN
	RETURN dbo.to_jst(CURRENT_TIMESTAMP AT TIME ZONE 'UTC');
END;

--**************************************************************************************
--* [説明]               : 現在の実行日付を取得
--* [戻り値]
--*  現在の実行日付(yyyymmdd)
--**************************************************************************************
CREATE OR ALTER FUNCTION dbo.get_current_exec_dt
()
RETURNS NCHAR(8)
AS
BEGIN
	RETURN CONVERT(NCHAR(8), dbo.get_current_jst(), 112);
END;

--**************************************************************************************
--* [説明]               : 現在の実行日時を取得
--* [戻り値]
--*  現在の実行日時(yyyymmddhhmiss)
--**************************************************************************************
CREATE OR ALTER FUNCTION dbo.get_current_exec_tm
()
RETURNS NCHAR(14)
AS
BEGIN
	DECLARE
		 @dt_jst DATETIME = dbo.get_current_jst();
	;
	
	RETURN CONVERT(NCHAR(8), @dt_jst, 112) + REPLACE(CONVERT(NCHAR(8), @dt_jst, 108), ':', '');
END;
