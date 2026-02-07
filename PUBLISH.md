# 发布到 GitHub 的步骤

## 步骤 1: 创建 GitHub 仓库

1. 访问 https://github.com/new
2. 仓库名称：`create-publish-skill`
3. **重要**：设置为 **Public**（必须公开才能被安装）
4. **不要**勾选 "Add a README file"（我们已经有了）
5. 点击 "Create repository"

## 步骤 2: 添加远程仓库并推送

```bash
cd /Users/fufanghao/Desktop/ai-doc/create-publish-skill

# 添加远程仓库（替换 your-username 为你的 GitHub 用户名）
git remote add origin https://github.com/your-username/create-publish-skill.git

# 推送到 GitHub
git push -u origin main
```

如果遇到认证问题，可以使用 SSH：

```bash
# 使用 SSH URL
git remote set-url origin git@github.com:your-username/create-publish-skill.git
git push -u origin main
```

## 步骤 3: 验证发布

发布后，skill 会自动出现在：
- https://skills.sh/your-username/create-publish-skill

## 步骤 4: 安装测试

```bash
# 安装你的 skill
npx skills add your-username/create-publish-skill@create-publish-skill

# 验证安装
npx skills list -g | grep create-publish-skill
```

## 步骤 5: 测试使用

在 Cursor 中测试：
- "如何创建一个新的 skill？"
- "帮我发布一个 skill 到 GitHub"
- "skill 的结构是什么？"

AI 应该会自动使用这个 skill 来回答。

## 更新 Skill

以后如果需要更新：

```bash
# 修改文件后
git add .
git commit -m "Update: 更新内容描述"
git push

# 用户更新
npx skills update
```
