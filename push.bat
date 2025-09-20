@echo off
chcp 65001 >nul
echo 正在执行Git提交和推送...
echo.

echo [1/3] 添加所有文件到暂存区...
git add .
if %errorlevel% neq 0 (
    echo 错误：添加文件失败！
    pause
    exit /b 1
)
echo ✓ 文件添加成功

echo.
echo [2/3] 提交更改...
git commit -m "setup github actions deployment"
if %errorlevel% neq 0 (
    echo 错误：提交失败！可能没有需要提交的更改。
    pause
    exit /b 1
)
echo ✓ 提交成功

echo.
echo [3/3] 推送到远程仓库...
git push origin main
if %errorlevel% neq 0 (
    echo 错误：推送失败！请检查网络连接和权限。
    pause
    exit /b 1
)
echo ✓ 推送成功

echo.
echo 🎉 所有操作完成！GitHub Actions将自动开始部署。
echo 可以在GitHub仓库的Actions标签页查看部署进度。
pause