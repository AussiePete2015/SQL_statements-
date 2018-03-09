DROP TABLE [dbo].[esri_iis_logs]

CREATE TABLE [dbo].[esri_iis_logs] (
	[date] [date] NULL,
	[time] [time] NULL ,
	[s-ip] [varchar] (50) NULL ,
	[cs-method] [varchar] (50) NULL ,
	[cs-uri-stem] [varchar] (255) NULL ,
	[cs-uri-query] [varchar] (2048) NULL ,
	[s-port] [varchar] (50) NULL ,
	[cs-username] [varchar] (255) NULL ,
	[c-ip] [varchar] (50) NULL ,
	[cs(User-Agent)] [varchar] (255) NULL ,
	[cs(Referer)] [varchar] (2048) NULL ,
	[sc-status] [int] NULL ,
	[sc-substatus] [int] NULL ,
	[sc-win32-status] [int] NULL ,
	[time-taken] [int] NULL
	)


CREATE TABLE IISALLLOGFNS(WHICHPATH VARCHAR(1000),WHICHFILE varchar(1000))

    --some variables
    declare @filename varchar(255),
            @path     varchar(255),
            @sql      varchar(8000),
            @cmd      varchar(1000)

    --get the list of files to process:
    SET @path = 'C:\Cognos_BiSysMon\audit\iislogs\'
    SET @cmd = 'dir ' + @path + '*.log /b'
    INSERT INTO  IISALLLOGFNS(WHICHFILE)
    EXEC Master..xp_cmdShell @cmd
    UPDATE IISALLLOGFNS SET WHICHPATH = @path where WHICHPATH is null

    --cursor loop
    declare c1 cursor for SELECT WHICHPATH,WHICHFILE FROM IISALLLOGFNS where WHICHFILE like '%.log%'
    open c1
    fetch next from c1 into @path,@filename
    While @@fetch_status <> -1
      begin
      --bulk insert won't take a variable name, so make a sql and execute it instead:
       set @sql = 'BULK INSERT [dbo].[esri_iis_logs] FROM ''' + @path + @filename + ''' '
           + '     WITH (
				   FIELDTERMINATOR='' '', 
                   ROWTERMINATOR = ''\n'', 
                   FIRSTROW = 5 
                ) '
    print @sql
    exec (@sql)

      fetch next from c1 into @path,@filename
      end
    close c1
    deallocate c1

    --Extras
	Select * from IISALLLOGFNS

    delete from IISALLLOGFNS where WHICHFILE is NULL
    
    drop table IISALLLOGFNS
