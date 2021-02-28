--**************************************************************************************
--* [説明]               : バッチ実行結果情報登録
--* [パラメータ]
--*  @vc_exec_na         : 処理名
--*  @vc_rslt_cd         : 処理結果 (1:OK 2:NG)
--* [呼び出し例]
--*  exec marge_exec_rslt_info 'ecbeing_goods_in', '1';
--**************************************************************************************
CREATE OR ALTER PROCEDURE dbo.marge_exec_rslt_info
(
	 @vc_exec_na NVARCHAR(800)
	,@vc_rslt_cd NCHAR(1)
)
AS
SET NOCOUNT ON;
BEGIN
	DECLARE
		 @S_EXEC_DT NCHAR(8) = dbo.get_current_exec_dt()
		,@S_EXEC_TM NCHAR(14) = dbo.get_current_exec_tm()
	;

    IF @vc_exec_na = 'exclude_goods_upload' OR @vc_exec_na = 'threshold_info_upload'
    BEGIN
        EXEC (
            'MERGE INTO dbo.batch_exec_rslt_info AS rslt' +
            ' USING (SELECT null as dmy) AS dummy' +
            '	ON (rslt.exec_dt = ' + @S_EXEC_DT + ')' +
            ' WHEN MATCHED THEN' +
            '	UPDATE SET ' + @vc_exec_na + '_rslt_tm = ' + @S_EXEC_TM + '' +
            ' WHEN NOT MATCHED THEN ' +
            '	INSERT (exec_dt, ' + @vc_exec_na + '_rslt_tm)' +
            '	VALUES (' + @S_EXEC_DT + ', ' + @S_EXEC_TM + ');'
        );
    END ELSE BEGIN
        EXEC (
            'MERGE INTO dbo.batch_exec_rslt_info AS rslt' +
            ' USING (SELECT null as dmy) AS dummy' +
            '	ON (rslt.exec_dt = ' + @S_EXEC_DT + ')' +
            ' WHEN MATCHED THEN' +
            '	UPDATE SET ' + @vc_exec_na + '_rslt_cd = ' + @vc_rslt_cd + ',' +
            '	           ' + @vc_exec_na + '_rslt_tm = ' + @S_EXEC_TM + '' +
            ' WHEN NOT MATCHED THEN ' +
            '	INSERT (exec_dt, ' + @vc_exec_na + '_rslt_cd, ' + @vc_exec_na + '_rslt_tm)' +
            '	VALUES (' + @S_EXEC_DT + ', ' + @vc_rslt_cd + ', ' + @S_EXEC_TM + ');'
        );
    END
END;

--**************************************************************************************
--* [説明]               : 正常バッチ実行結果情報登録
--* [パラメータ]
--*  @vc_exec_na         : 処理名
--**************************************************************************************
CREATE OR ALTER PROCEDURE dbo.marge_normal_exec_rslt_info
(
	 @vc_exec_na NVARCHAR(800)
)
AS
SET NOCOUNT ON;
BEGIN
	EXEC dbo.marge_exec_rslt_info @vc_exec_na, '1';
END;

--**************************************************************************************
--* [説明]               : 異常バッチ実行結果情報登録
--* [パラメータ]
--*  @vc_exec_na         : 処理名
--*  @vc_log_text        : ログ内容
--**************************************************************************************
CREATE OR ALTER PROCEDURE dbo.marge_error_exec_rslt_info
(
	 @vc_exec_na NVARCHAR(800)
	,@vc_log_text NVARCHAR(max)
)
AS
SET NOCOUNT ON;
BEGIN
	EXEC dbo.marge_exec_rslt_info @vc_exec_na, '2';
	EXEC dbo.insert_error_exec_log @vc_exec_na, @vc_log_text;
END;

--**************************************************************************************
--* [説明]               : 異常バッチ実行結果情報登録（ADF用）
--* [パラメータ]
--*  @vc_exec_na         : 処理名
--*  @vc_log_text        : ログ内容
--*  @vc_error_mode      : エラー処理モード
--*                             1:最終回以外 ＝ エラー処理スキップ
--*                             2:最終回     ＝ エラー処理実施
--**************************************************************************************
CREATE OR ALTER PROCEDURE dbo.marge_error_exec_rslt_info_adf
(
	 @vc_exec_na NVARCHAR(800)
	,@vc_log_text NVARCHAR(max)
	,@vc_error_mode NCHAR(1)
)
AS
SET NOCOUNT ON;
BEGIN
    IF @vc_error_mode = 1
    BEGIN
    	EXEC dbo.insert_normal_exec_log @vc_exec_na, @vc_log_text;
    END ELSE BEGIN
        EXEC dbo.marge_exec_rslt_info @vc_exec_na, '2';
        EXEC dbo.insert_error_exec_log @vc_exec_na, @vc_log_text;
        THROW 54000, 'marge_error_exec_rslt_info_adf THROW Error!!!', 32;
    END
END;
