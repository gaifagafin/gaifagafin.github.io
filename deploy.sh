#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run docs:build

# 进入生成的文件夹
cd docs/.vuepress/dist

# 添加 CNAME 文件用于自定义域名
echo 'gaifagafin.top' > CNAME

# 检查是否已经是git仓库
if [ ! -d ".git" ]; then
  git init
  git remote add origin git@github.com:gaifagafin/gaifagafin.github.io.git
else
  # 如果已经存在，确保远程仓库正确
  git remote set-url origin git@github.com:gaifagafin/gaifagafin.github.io.git
fi

git add -A

# 检查是否有变化需要提交
if git diff --staged --quiet; then
  echo "没有变化需要部署"
else
  git commit -m "deploy: $(date '+%Y-%m-%d %H:%M:%S')"
  # 推送到 main 分支（GitHub Pages 默认分支）
  git push -f origin HEAD:main
  echo "部署完成！"
fi

cd -