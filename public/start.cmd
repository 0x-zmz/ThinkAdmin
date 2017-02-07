@echo off

:: PHP���׿������������ V1.0
::
:: ���ߣ�Anyon <zoujingli@qq.com>
:: ��ַ��http://www.ctolog.com
:: ������2016/09/22 20:20

title HTTP-SERVER

set pan=%~d0
:: �ж�PHP���л����Ƿ����
if not exist %pan%\php (goto down) else (goto start)


:start
	cls

	:: ��ʱ����PHP���л���·��
	set path=%~dp0..\php;%~dp0php;%pan%\php;%path% 

	:: �������������ж˿�
	set port=%random%
	set /a port=port%%1000+2000
	title [ %port% ] HTTP-SERVER

	:: �����������
	start http://localhost:%port%

	:: ����Web�������
	@echo on
	@php -S localhost:%port% router.php
	goto end

:down
	cls 
	echo.
	echo ����δ��⵽���ػ��������ڳ������ذ�װ�����Ժ�...
	echo.

	:: ��Դ·������
	set src=http://zoujingli.oschina.io/static/php-install/php.zip
	set des=%pan%\php.zip
	
	set sof_32=http://zoujingli.oschina.io/static/php-install/vc_redist.x86.exe
	set sof_des_32=%pan%\vc_redist.x86.exe

	set sof_64=http://zoujingli.oschina.io/static/php-install/vc_redist.x64.exe
	set sof_des_64=%pan%\vc_redist.x64.exe
	
	set script=%pan%\script.vbs
	set dir=%pan%\

	:: ����VB�ű������ز�����PHP֧�ֳ���
	echo Set xPost = CreateObject("Microsoft.XMLHTTP") >%script%
	echo xPost.Open "GET","%src%",0 >>%script%
	echo xPost.Send() >>%script%
	echo Set sGet = CreateObject("ADODB.Stream") >>%script%
	echo sGet.Mode = 3 >>%script%
	echo sGet.Type = 1 >>%script%
	echo sGet.Open() >>%script%
	echo sGet.Write(xPost.responseBody) >>%script%
	echo sGet.SaveToFile "%des%",2 >>%script%
	
	if "%PROCESSOR_ARCHITECTURE%"=="x86" (		
		echo Set xPost = CreateObject("Microsoft.XMLHTTP") >>%script%	
		echo xPost.Open "GET","%sof_32%",0 >>%script%
		echo xPost.Send() >>%script%
		echo Set sGet = CreateObject("ADODB.Stream") >>%script%
		echo sGet.Mode = 3 >>%script%
		echo sGet.Type = 1 >>%script%
		echo sGet.Open() >>%script%
		echo sGet.Write(xPost.responseBody) >>%script%
		echo sGet.SaveToFile "%sof_des_32%",2 >>%script%
	) else (
		echo Set xPost = CreateObject("Microsoft.XMLHTTP") >>%script%	
		echo xPost.Open "GET","%sof_64%",0 >>%script%
		echo xPost.Send() >>%script%
		echo Set sGet = CreateObject("ADODB.Stream") >>%script%
		echo sGet.Mode = 3 >>%script%
		echo sGet.Type = 1 >>%script%
		echo sGet.Open() >>%script%
		echo sGet.Write(xPost.responseBody) >>%script%
		echo sGet.SaveToFile "%sof_des_64%",2 >>%script%
	)
	
	:: ����ZIP��������
	echo Sub UnZip(ByVal myZipFile, ByVal myTargetDir) >>%script%
	echo     Set fso = CreateObject("Scripting.FileSystemObject") >>%script%
	echo     If NOT fso.FileExists(myZipFile) Then >>%script%
	echo         Exit Sub >>%script%
	echo     ElseIf NOT fso.FolderExists(myTargetDir) Then >>%script%
	echo         fso.CreateFolder(myTargetDir) >>%script%
	echo     End If >>%script%
	echo     Set objShell = CreateObject("Shell.Application") >>%script%
	echo     Set objSource = objShell.NameSpace(myZipFile) >>%script%
	echo     Set objFolderItem = objSource.Items() >>%script%
	echo     Set objTarget = objShell.NameSpace(myTargetDir) >>%script%
	echo     intOptions = 256 >>%script%
	echo     objTarget.CopyHere objFolderItem, intOptions >>%script%
	echo End Sub >>%script%
	:: ��ѹZIP�ļ�
	echo UnZip "%des%", "%dir%" >>%script%
	:: ִ��VB�ű�
	cscript %script%
	
	cls
	echo.
	echo �����������ʾ����װVC֧�ֿ⣬�������ʾ���в�����
	echo.
	echo ������--- ���û�а�װ���������ʾ���а�װ��---
	echo.
	echo ������--- ����Ѿ���װ������Բ��ر���ʾ��---
	echo.
	
	:: ��װ������VB����ű�
	echo Set fso = CreateObject("Scripting.FileSystemObject") >%script%
	echo fso.deleteFile "%des%" >>%script%
	if "%PROCESSOR_ARCHITECTURE%"=="x86" (
		%sof_des_32%
		echo fso.deleteFile "%sof_des_32%" >>%script%
	) else (
		%sof_des_64%
		echo fso.deleteFile "%sof_des_64%" >>%script%
	)
	echo fso.deleteFile "%script%" >>%script%
	:: ִ��VB�ű�
	cscript %script%

	cls
	goto start

:end