:: Composer ��װ���½ű�
@echo off
title ComposerPlugs Update & Optimize
echo.
echo ========= 1. �����Ѱ�װ��� =========
@rmdir /s/q vendor thinkphp
echo.
echo ========= 2. ���ز���װ��� =========
composer update --profile --prefer-dist --optimize-autoloader
echo.
echo ========= 3. ѹ����������� =========
composer dump-autoload --optimize
exit