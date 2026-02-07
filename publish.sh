#!/bin/bash

set -e

# 检查是否提供了 token
if [ -z "$GITHUB_TOKEN" ]; then
    echo "错误: 请设置 GITHUB_TOKEN 环境变量"
    echo "使用方法: GITHUB_TOKEN=your_token ./publish.sh"
    exit 1
fi

REPO_NAME="create-publish-skill"
REPO_OWNER=$(gh api user --jq .login 2>/dev/null || echo "")

if [ -z "$REPO_OWNER" ]; then
    echo "使用 token 获取用户名..."
    REPO_OWNER=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user | grep -o '"login":"[^"]*' | cut -d'"' -f4)
fi

if [ -z "$REPO_OWNER" ]; then
    echo "错误: 无法获取 GitHub 用户名，请检查 token 是否有效"
    exit 1
fi

echo "仓库所有者: $REPO_OWNER"
echo "仓库名称: $REPO_NAME"

# 设置 GitHub CLI token
export GH_TOKEN=$GITHUB_TOKEN

# 创建仓库
echo "创建 GitHub 仓库..."
gh repo create "$REPO_NAME" --public --source=. --remote=origin --push

echo ""
echo "✅ 仓库创建成功！"
echo "📍 仓库地址: https://github.com/$REPO_OWNER/$REPO_NAME"
echo "📍 Skill 地址: https://skills.sh/$REPO_OWNER/$REPO_NAME"
echo ""
echo "安装命令:"
echo "  npx skills add $REPO_OWNER/$REPO_NAME@create-publish-skill"
