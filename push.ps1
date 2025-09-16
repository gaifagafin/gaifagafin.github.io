# 设置编码为UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "正在执行Git提交和推送..." -ForegroundColor Green
Write-Host ""

# 检查是否在git仓库中
if (-not (Test-Path ".git")) {
    Write-Host "错误：当前目录不是Git仓库！" -ForegroundColor Red
    Read-Host "按任意键退出"
    exit 1
}

try {
    Write-Host "[1/3] 添加所有文件到暂存区..." -ForegroundColor Yellow
    git add .
    if ($LASTEXITCODE -ne 0) {
        throw "添加文件失败"
    }
    Write-Host "✓ 文件添加成功" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "[2/3] 提交更改..." -ForegroundColor Yellow
    git commit -m "setup github actions deployment"
    if ($LASTEXITCODE -ne 0) {
        throw "提交失败，可能没有需要提交的更改"
    }
    Write-Host "✓ 提交成功" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "[3/3] 推送到远程仓库..." -ForegroundColor Yellow
    git push origin main
    if ($LASTEXITCODE -ne 0) {
        throw "推送失败，请检查网络连接和权限"
    }
    Write-Host "✓ 推送成功" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "🎉 所有操作完成！GitHub Actions将自动开始部署。" -ForegroundColor Cyan
    Write-Host "可以在GitHub仓库的Actions标签页查看部署进度。" -ForegroundColor Cyan
    
} catch {
    Write-Host ""
    Write-Host "错误：$($_.Exception.Message)" -ForegroundColor Red
    Write-Host "操作已终止。" -ForegroundColor Red
}

Read-Host "按任意键退出"