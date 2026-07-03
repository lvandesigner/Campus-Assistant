# 手把手教你复现一个 HarmonyOS 智慧校园 App——从源码到真机运行的全流程指南

> **📢 开源仓库地址：**
> - **GitHub：** [👉 点击这里，给个 Star ⭐]（此处贴你的 GitHub 仓库链接）
> - **Gitee：** [👉 点击这里，给个 Star ⭐]（此处贴你的 Gitee 仓库链接）
>
> 如果觉得项目对你有帮助，欢迎 **Star ⭐ + Fork 🍴**，你的支持是我持续更新的动力！

---

## ⚠️ 写在最前面——请务必先阅读这 3 份文档！

在你克隆代码、打开 IDE、点击 Run 之前，**强烈建议你花 10 分钟仔细阅读以下 3 个 Markdown 文件**。它们能帮你避免 90% 的踩坑：

| 优先级 | 文件 | 说明 |
|:---:|------|------|
| 🔴 必读 | 根目录 `README.md` | 项目总览、功能模块、使用前必须知道的所有注意事项 |
| 🟡 重要 | `entry/src/main/ets/pages/README.md` | 每个页面的功能详解、跳转关系、新增页面指南 |
| 🟡 重要 | `entry/src/main/resources/base/media/README.md` | 图片资源清单、占位图替换方案、Tab 图标缺失修复 |

> ✅ **已修复：** 底部导航栏的 6 张 Tab 图标原本引用不存在的文件路径，**代码已修复**，现在统一使用 `$r('app.media.icon')`（已有的 `icon.png`）作为临时占位图，项目可正常编译运行。后续替换正式图标时参考 [media/README.md]。

---

## 一、项目简介

**智慧校园（Smart Campus）** 是一个基于 **HarmonyOS** 的一站式校园生活服务平台，使用 **ArkTS + ArkUI（Stage 模型）** 开发。

### 1.1 它能做什么？

想象一下，你打开一个 App 就能搞定校园生活的方方面面：

| 模块 | 核心功能 | 效果预览（贴图占位） |
|------|----------|:---:|
| 🏠 **主页** | 轮播图 Banner、滚动通知栏、功能入口 Grid、底部三 Tab 导航 | 【📷 此处贴主页截图】 |
| 📚 **课程表** | 按周切换查看课程详情（教师、地点、学分、教材、考核方式、作业） | 【📷 此处贴课程表截图】 |
| 📝 **请假系统** | 在线请假申请（日期选择 + 理由填写）、请假记录查看 | 【📷 此处贴请假页截图】 |
| 📢 **校园通知** | 通知列表 + 关键词搜索、已读/未读标记 | 【📷 此处贴通知页截图】 |
| 🗺️ **校园地图** | 按分类筛选校园地点、查看地点详情 | 【📷 此处贴地图页截图】 |
| 🎯 **活动中心** | 按日期浏览校园活动、在线报名/取消报名 | 【📷 此处贴活动中心截图】 |
| 🔒 **隐私锁** | 图案密码（九宫格 PatternLock）设置与验证 | 【📷 此处贴隐私锁截图】 |
| 👤 **个人中心** | 个人信息、请假记录、隐私锁、消息开关、缓存清理、关于我们 | 【📷 此处贴个人中心截图】 |

### 1.2 技术栈一览

| 项目 | 说明 |
|------|------|
| 开发语言 | **ArkTS**（HarmonyOS 的 Extended TypeScript） |
| UI 框架 | **ArkUI**（声明式 UI） |
| 应用模型 | **Stage 模型**（HarmonyOS 官方推荐） |
| 目标 SDK | **API 9** |
| 支持设备 | **Phone**（手机） |
| 开发工具 | **DevEco Studio 3.1+** |
| 最低兼容 | HarmonyOS 3.0 |

---

## 二、项目目录结构——一张图看懂每个文件夹是干嘛的

拿到项目源码后，你会看到如下目录结构。**这个表格建议收藏，改代码的时候对照着找文件：**

```
Harmony/                                # 📂 项目根目录
│
├── 📄 README.md                        # 🔴 必读！项目总说明、注意事项、快速开始
├── 📄 LICENSE                          # 开源协议
├── 📄 build-profile.json5              # 构建配置（SDK版本、签名、模块注册）
├── 📄 oh-package.json5                 # 依赖管理（类似 npm 的 package.json）
├── 📄 .gitignore                       # Git 忽略规则
│
├── 📂 AppScope/                        # 应用全局配置
│   ├── 📄 app.json5                    # 🔧 Bundle Name、版本号、应用图标、应用名称
│   └── 📂 resources/base/
│       ├── 📂 element/                 # 全局字符串/颜色资源
│       └── 📂 media/                   # 应用图标 app_icon.png 等
│
├── 📂 entry/                           # 🎯 主模块（你写代码 90% 时间都在这里）
│   └── 📂 src/main/
│       ├── 📂 ets/
│       │   ├── 📂 entryability/
│       │   │   └── 📄 EntryAbility.ts  # 🚀 应用入口（生命周期、全局初始化）
│       │   └── 📂 pages/              # 📄 所有页面代码（10 个 .ets 文件）
│       │       ├── 📄 README.md        # 🟡 页面功能详解 & 跳转关系
│       │       ├── 📄 Index.ets        # 主页（三 Tab 导航）
│       │       ├── 📄 PatternLock.ets  # 图案密码锁
│       │       ├── 📄 CoursePage.ets   # 课程表
│       │       ├── 📄 LeaveApplyPage.ets    # 请假申请
│       │       ├── 📄 LeaveRecordPage.ets   # 请假记录
│       │       ├── 📄 NoticeListPage.ets    # 校园通知
│       │       ├── 📄 CampusMapPage.ets     # 校园地图
│       │       ├── 📄 ActivityCalendarPage.ets  # 活动中心
│       │       ├── 📄 MinePage.ets     # 个人中心
│       │       └── 📄 AboutPage.ets    # 关于我们
│       │
│       ├── 📂 resources/base/
│       │   ├── 📂 media/              # 🖼️ 图片/图标资源
│       │   │   └── 📄 README.md       # 🟡 媒体资源说明 & 替换指南
│       │   ├── 📂 profile/
│       │   │   └── 📄 main_pages.json # 🔧 页面路由注册（新增页面必须在此添加！）
│       │   └── 📂 element/            # 模块级字符串/颜色资源
│       │
│       └── 📄 module.json5            # 模块配置（Ability注册、设备类型、权限）
│
├── 📂 hvigor/                          # 构建工具配置（一般不用动）
├── 📂 oh_modules/                      # 依赖包（类似 node_modules）
└── 📂 .hvigor/                         # 构建缓存 & 日志（可以删，会自动重新生成）
```

### 关键配置文件速查

| 你想做什么 | 去找哪个文件 |
|-----------|-------------|
| 改应用名称 | `AppScope/app.json5` → `label` |
| 改包名 (Bundle Name) | `AppScope/app.json5` → `bundleName` |
| 改版本号 | `AppScope/app.json5` → `versionName` / `versionCode` |
| 新增一个页面 | ① 创建 `pages/XxxPage.ets` ② 在 `main_pages.json` 中注册 |
| 替换图片 | 把新图放进 `media/`，代码中 `$r('app.media.文件名')` 引用 |
| 改 SDK 版本 | `build-profile.json5` → `compileSdkVersion` |
| 配置签名 | `build-profile.json5` → `signingConfigs` |

---

## 三、⚠️ 你必须修改/替换的地方——不改项目跑不起来！

以下是 **开工前必须处理** 的几个关键事项。不处理的话，轻则界面显示异常，重则编译报错。

### 3.1 🖼️ 占位图片替换（界面正常显示的前提）

当前项目中，**大量位置**都用了同一张 `course.png` 作为占位图。**部分已临时修复**（标记 ✅），剩余需替换为正式图片：

【📷 此处贴一张"当前占位图效果 vs 替换后预期效果"的对比图】

| 位置 | 代码文件 | 当前状态 | 要替换成什么 |
|------|---------|:---:|------------|
| 主页轮播图 ×4 | `Index.ets` | 🔄 course.png | 校园宣传图/活动海报（建议 750×360） |
| 主页 5 个功能入口图标 | `Index.ets` | 🔄 course.png | 课程表、请假、通知、地图、活动 各自图标 |
| 用户头像（多处） | `Index.ets` / `MinePage.ets` / `AboutPage.ets` | ✅ 已改用 icon.png | 默认头像图（建议 200×200） |
| 校园地图图片 | `CampusMapPage.ets` | 🔄 course.png | 实际校园地图/平面图（建议 750×500） |
| 活动中心小图标 | `ActivityCalendarPage.ets` | ✅ 已改用 emoji 文字 | 时间⏰、地点📍、主办方🏛️ 图标 |
| 空状态图 | `NoticeListPage.ets` / `CoursePage.ets` | 🔄 course.png | 空状态插画 |
| 关于页面图标 | `AboutPage.ets` | ✅ 已改用 icon.png | 正式 App 图标（建议 200×200） |

> **📌 替换步骤：**
> 1. 准备正式图片，统一用 **PNG 格式**
> 2. 放入 `entry/src/main/resources/base/media/` 目录
> 3. 修改对应 `.ets` 文件中的 `$r('app.media.course')` → `$r('app.media.你的文件名')`（不带 `.png` 扩展名）

### 3.2 ✅ Tab 图标（已修复——用 icon.png 临时占位）

`Index.ets` 的底部导航栏原本引用了 6 张不存在的 Tab 图标文件：

```
原缺失文件（已修复）：
✅ /images/home_normal.png      ✅ /images/home_selected.png
✅ /images/message_normal.png   ✅ /images/message_selected.png
✅ /images/mine_normal.png      ✅ /images/mine_selected.png
```

> **📌 已修复方案：** 代码已将所有 Tab 图标改为 `$r('app.media.icon')`（使用已有的 `icon.png` 作为临时占位图），并将 `TabItem` Builder 的参数类型从 `string` 改为 `Resource`，项目可直接编译运行。
>
> **📌 正式替换时：** 准备 6 张 Tab 图标（建议 64×64）放入 `media/` 目录，然后在 `Index.ets` 的 `TabItem` 调用处将 `$r('app.media.icon')` 替换为各自对应的资源引用（如 `$r('app.media.ic_home_normal')`、`$r('app.media.ic_home_selected')` 等）。

### 3.3 🚧 未实现的页面（跑起来会报错！）

项目中 `Index.ets` 的消息列表和快捷功能区引用了 **11 个尚未创建的页面**，点击就会因为路由找不到页面而报错：

| 缺失页面 | 从哪里触发 |
|----------|-----------|
| `NoticeDetailPage` | 消息 Tab → "校园网络维护通知" |
| `SportEventPage` | 消息 Tab → "运动会报名" |
| `LibraryRemindPage` | 消息 Tab → "图书馆借阅到期提醒" |
| `LeaveDetailPage` | 消息 Tab → "请假审批通过" |
| `GradeQueryPage` | 消息 Tab → "成绩发布通知" / 我的 Tab 快捷功能 |
| `ClubActivityPage` | 消息 Tab → "社团活动邀请" |
| `DormitoryPage` | 消息 Tab → "宿舍卫生检查" |
| `CampusCardPage` | 消息 Tab → "校园卡消费提醒" |
| `LecturePage` | 消息 Tab → "讲座通知" |
| `VolunteerPage` | 消息 Tab → "志愿服务报名" |
| `MyBorrowPage` | 我的 Tab → 快捷功能"借阅" |

> **📌 处理方式：**
> - **如果你想完善项目：** 逐个创建这些 `.ets` 文件，并在 `main_pages.json` 中注册路由
> - **如果你只想快速跑起来：** 暂时在 `Index.ets` 中注释掉或改为 `Toast("功能开发中")`

### 3.4 🔌 硬编码数据 → 接入真实后端

以下页面目前全部使用**静态模拟数据**，实际使用时需要改为从后端 API 获取：

| 文件 | 硬编码了什么 | 需要改造成什么 |
|------|------------|--------------|
| `Index.ets` | 用户信息（姓名、学号、学院）、统计数据 | 调用 `/api/user/info` 等接口 |
| `CoursePage.ets` | 2 周的课程数据（`courseData` 数组） | 调用 `/api/courses` + 按学期/周筛选 |
| `LeaveApplyPage.ets` | 仅前端校验，无提交逻辑 | 添加 `POST /api/leave/apply` 请求 |
| `LeaveRecordPage.ets` | 5 条模拟请假记录 | 调用 `GET /api/leave/records` |
| `NoticeListPage.ets` | 2 条硬编码通知 | 调用 `GET /api/notices` + 搜索参数 |
| `ActivityCalendarPage.ets` | 24 个硬编码活动数据 | 调用 `/api/activities` + 日期参数 |
| `AboutPage.ets` | 客服电话 `66666666666`、邮箱 `support@xxx.com` | 替换为真实联系方式 |

> 数据接入使用 HarmonyOS 原生的 `@ohos.net.http` 模块发起 HTTP 请求即可。

### 3.5 🔑 其他需要注意的配置修改

| 事项 | 位置 | 说明 |
|------|------|------|
| **Bundle Name** | `AppScope/app.json5` | 当前是 `com.example.app`，发布前必须改成你自己的 |
| **签名配置** | `build-profile.json5` | `signingConfigs` 为空数组，真机调试 & 发布包必须配置 |
| **SDK 版本** | `build-profile.json5` | 当前为 API 9，确认你的设备/模拟器版本是否匹配 |
| **日期范围** | `LeaveApplyPage.ets` / `ActivityCalendarPage.ets` | 请假日期写死了 2024-2025，活动日期写死了 2025-09 ~ 2026-01 |
| **隐私锁启动逻辑** | `EntryAbility.ts` | `isPasswordSet` 初始化为 `false`，首次启动不会强制设置密码，按需修改 |

---

## 四、🔨 复现指南——从 0 到跑起来的完整步骤

### 4.1 环境准备

| 你需要的东西 | 版本要求 | 下载地址 |
|-------------|---------|---------|
| DevEco Studio | **3.1 或更高版本** | [华为开发者官网](https://developer.huawei.com/consumer/cn/deveco-studio/) |
| HarmonyOS SDK | **API 9+** | 在 DevEco Studio 中通过 SDK Manager 下载 |
| 华为开发者账号 | 实名认证 | [华为开发者联盟](https://developer.huawei.com/)（真机调试必需） |
| HarmonyOS 设备 | 真机或模拟器 | 模拟器在 DevEco Studio 内置 Device Manager 中创建 |

### 4.2 克隆项目 & 打开工程

```bash
# Step 1: 克隆仓库（二选一）
# 从 GitHub 克隆：
git clone （此处贴你的 GitHub 仓库地址）

# 或从 Gitee 克隆：
git clone （此处贴你的 Gitee 仓库地址）

# Step 2: 用 DevEco Studio 打开
# 启动 DevEco Studio → Open → 选择克隆下来的 Harmony 目录
```

【📷 此处贴一张 DevEco Studio 打开项目后的界面截图】

### 4.3 配置签名（真机调试必须）

如果你要**在真机上运行**，必须配置签名：

```
DevEco Studio → File → Project Structure → Signing Configs
→ 勾选 "Automatically generate signing"
→ 登录华为开发者账号
→ 确认签名信息自动填充
```

> 💡 如果只是用模拟器跑，可以跳过签名配置。

### 4.4 安装依赖 & 同步

项目打开后，DevEco Studio 会自动触发依赖同步。你也可以手动操作：

```
File → Sync and Refresh Project
```

同步成功后，底部状态栏会显示 "Sync completed successfully"。

【📷 此处贴一张同步成功的截图】

### 4.5 运行项目

```
1. 连接 HarmonyOS 真机（USB 调试模式）或启动模拟器
2. 确认顶部工具栏已识别到设备
3. 点击绿色 ▶️ Run 按钮（或 Shift+F10）
4. 等待编译 → 安装 → 自动启动应用
```

【📷 此处贴一张真机或模拟器上 App 首页运行截图】

### 4.6 复现常见问题排查

| 问题 | 可能原因 | 解决方法 |
|------|---------|---------|
| Tab 图标不显示 | 已修复——现用 icon.png 占位 | 准备正式 Tab 图标后，参考本文 3.2 节替换 |
| 点击消息列表某项报错 | 目标页面尚未创建 | 参考本文 3.3 节创建页面或注释跳转 |
| 编译报 `SDK version` 错误 | SDK 版本不匹配 | 检查 `build-profile.json5` 中的 SDK 版本，确认已安装 |
| 签名错误 | 未配置签名 | 参考本文 4.3 节配置签名 |
| 模拟器启动失败 | 未安装模拟器镜像 | DevEco Studio → Device Manager → 创建模拟器 |
| 界面图片都是一个样 | 全部用的占位图 | 参考本文 3.1 节替换正式图片 |

---

## 五、📂 页面跳转关系图

看懂这张图，你就知道整个 App 的导航结构了：

```
                     ┌─────────────────────────────┐
                     │      PatternLock (图案锁)      │
                     │    setup / verify 两种模式      │
                     └──────────────┬──────────────┘
                                    │
                                    ▼
                     ┌─────────────────────────────┐
                     │       Index (主页)            │
                     │  三 Tab：主页 / 消息 / 我的    │
                     └──┬────────┬────────┬────────┘
                        │        │        │
           ┌────────────┘        │        └────────────┐
           ▼                     ▼                     ▼
   ┌──────────────┐    ┌──────────────┐      ┌──────────────┐
   │  CoursePage   │    │ NoticeDetail   │      │  MinePage    │
   │  LeaveApply   │    │ SportEvent    │      │  个人中心     │
   │  NoticeList   │    │ LibraryRemind │ ────→│              │
   │  CampusMap    │    │ LeaveDetail   │      │  ┌─────────┐ │
   │  ActivityCal  │    │ GradeQuery    │      │  │LeavRecord│ │
   └──────────────┘    │ ClubActivity  │      │  │PatternLck│ │
                        │ Dormitory     │      │  │AboutPage │ │
                        │ CampusCard    │      │  └─────────┘ │
                        │ Lecture       │      └──────────────┘
                        │ Volunteer     │
                        └──────────────┘
                        (⚠️ 灰色页面均未实现)

图例：
  ✅ 实线框 = 已实现并注册路由的页面（共 10 个）
  ⚠️ 虚线框 = 代码中引用但尚未创建的页面（共 11 个）
```

---

## 六、🧭 给二次开发者的建议

如果你想基于这个项目继续开发，以下是一个推荐的开发顺序：

```
第一步 ☑️  搞定图片资源 → 替换剩余占位图 + 补充正式的 Tab 图标（当前已用 icon.png 临时占位可编译运行）
第二步 ☐  决定缺失页面的处理 → 创建 OR 注释掉
第三步 ☐  修改包名、应用名、版本号（AppScope/app.json5）
第四步 ☐  搭建后端 API → 定义接口 → 替换各页面的硬编码数据
第五步 ☐  完善隐私锁逻辑 → EntryAbility.ts 中强制设置密码
第六步 ☐  适配更多设备 → module.json5 中添加 tablet、wearable 等 deviceTypes
第七步 ☐  配置签名 → 打正式发布包
```

---

## 七、📄 开源协议 & 致谢

本项目采用开源协议发布（详见仓库根目录 `LICENSE` 文件）。

- **开发者：** yszaygr2138 & lvan_smith
- **版权：** © 2025 yszaygr2138 & lvan_smith

> 如果这个项目给了你灵感或帮助，欢迎回来点个 Star ⭐，也欢迎提 Issue 和 PR 一起完善！

---

## 📎 附录：文档索引

再次提醒，以下是仓库中所有重要的 Markdown 文档：

| 文档 | 路径 | 内容 |
|------|------|------|
| 项目总 README | 仓库根目录 `README.md` | 项目概述、功能模块、注意事项、快速开始 |
| 页面文档 | `entry/src/main/ets/pages/README.md` | 10 个页面的详细功能说明、跳转关系、新增页面教程 |
| 媒体资源文档 | `entry/src/main/resources/base/media/README.md` | 图片资源清单、替换指南、引用方式 |
| 开源协议 | 仓库根目录 `LICENSE` | 项目开源许可协议 |

---

> **🔗 开源仓库地址：**
> - **GitHub：** [👉 点击这里]（此处贴你的 GitHub 仓库链接）
> - **Gitee：** [👉 点击这里]（此处贴你的 Gitee 仓库链接）
>
> 觉得有用的话，别忘了 **Star ⭐** 支持一下！

---

*本文发布于 CSDN，作者：lvandesigner（lvan_smith）*
*转载请注明出处*
