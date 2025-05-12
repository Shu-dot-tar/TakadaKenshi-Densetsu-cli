@echo off
setlocal

echo === 高田健志の伝説 CLI セットアップ ===
echo:

set SCRIPT_DIR=%~dp0
set SCRIPT_DIR=%SCRIPT_DIR:\=/%

REM PATH環境変数に恒久的に追加
echo PATH環境変数を更新しています...

REM 現在のPATHを取得
set "CURRENT_PATH="
for /f "tokens=2*" %%a in ('reg query "HKCU\Environment" /v PATH 2^>nul') do set "CURRENT_PATH=%%b"

REM 新しいPATHを設定
if not defined CURRENT_PATH (
    set "NEW_PATH=%SCRIPT_DIR%"
) else (
    set "NEW_PATH=%CURRENT_PATH%;%SCRIPT_DIR%"
)

REM PATH環境変数を更新
reg add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "%NEW_PATH%" /f
echo PATH更新完了! : %NEW_PATH%

REM densetsu.pyに実行権限を付与
echo densetsu.pyに実行権限を付与しています...
powershell -Command "Set-ItemProperty -Path '%SCRIPT_DIR%\densetsu.py' -Name IsReadOnly -Value $false"

REM densetsu.batが存在しない場合は生成
if not exist "%SCRIPT_DIR%\densetsu.bat" (
    echo densetsu.batを生成しています...
    echo @echo off > "%SCRIPT_DIR%\densetsu.bat"
    echo python "%%~dp0densetsu.py" %%* >> "%SCRIPT_DIR%\densetsu.bat"
)

echo:
echo セットアップ完了!
echo 以下のパスがシステム環境変数に追加されました: %SCRIPT_DIR%
echo 新しいコマンドプロンプトを開いて、densetsuコマンドを実行してください。
echo 注意: 設定を反映させるには、デバイスの再起動が必要な場合があります。
echo:

endlocal