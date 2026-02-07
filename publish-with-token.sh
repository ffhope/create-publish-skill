#!/bin/bash

set -e

# 使用方法: GITHUB_TOKEN=your_token ./publish-with-token.sh

if [ -z "$GITHUB_TOKEN" ]; then
    echo "错误: 请设置 GITHUB_TOKEN 环境变量"
    echo ""
    echo "使用方法:"
    echo "  export GITHUB_TOKEN=your_github_token"
    echo "  ./publish-with-token.sh"
    echo ""
    echo "或者:"
    echo "  GITHUB_TOKEN=your_github_token ./publish-with-token.sh"
    exit 1
fi

REPO_NAME="create-publish-skill"

# 获取用户名
echo "获取 GitHub 用户名..."
REPO_OWNER=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/user | grep -o '"login":"[^"]*' | cut -d'"' -f4)

if [ -z "$REPO_OWNER" ]; then
    echo "错误: 无法获取 GitHub 用户名，请检查 token 是否有效"
    exit 1
fi

echo "仓库所有者: $REPO_OWNER"
echo "仓库名称: $REPO_NAME"

# 检查仓库是否已存在
echo "检查仓库是否已存在..."
if curl -s -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME" | grep -q '"name"'; then
    echo "⚠️  仓库已存在，将直接推送代码..."
    git remote remove origin 2>/dev/null || true
else
    # 创建仓库
    echo "创建 GitHub 仓库..."
    curl -s -X POST \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        -d "{\"name\":\"$REPO_NAME\",\"public\":true,\"description\":\"Guide for creating and publishing agent skills\"}" \
        https://api.github.com/user/repos > /dev/null
    
    if [ $? -eq 0 ]; then
        echo "✅ 仓库创建成功"
    else
        echo "❌ 仓库创建失败"
        exit 1
    fi
fi

# 添加远程仓库
echo "添加远程仓库..."
git remote remove origin 2>/dev/null || true
git remote add origin "https://$GITHUB_TOKEN@github.com/$REPO_OWNER/$REPO_NAME.git"

# 推送代码
echo "推送代码到 GitHub..."
git push -u origin main

echo ""
echo "✅ 发布成功！"
echo ""
echo "📍 仓库地址: https://github.com/$REPO_OWNER/$REPO_NAME"
echo "📍 Skill 地址: https://skills.sh/$REPO_OWNER/$REPO_NAME"
echo ""
echo "安装命令:"
echo "  npx skills add $REPO_OWNER/$REPO_NAME@create-publish-skill"
echo ""
echo "测试安装:"
echo "  npx skills add $REPO_OWNER/$REPO_NAME@create-publish-skill"
