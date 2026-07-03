# 智慧校园 (Smart Campus)

基于 **HarmonyOS** 的一站式校园生活服务平台，使用 ArkTS + ArkUI（Stage 模型）开发。

## 项目信息

| 项目 | 说明 |
|------|------|
| 应用名称 | 智慧校园 |
| Bundle Name | `com.example.app` |
| 版本号 | 1.0.0 (versionCode: 1000000) |
| 目标 SDK | API 9 (HarmonyOS) |
| 开发模式 | Stage 模型 |
| 编程语言 | ArkTS (Extended TypeScript) |
| 支持设备 | Phone |

## 功能模块

- 🏠 **主页** — 轮播图、滚动通知、功能入口 Grid、底部三 Tab 导航（主页/消息/我的）
- 📚 **课程表** — 按周切换查看课程详情（含教师、地点、学分、教材、考核方式、作业等）
- 📝 **请假系统** — 在线请假申请（日期选择 + 理由填写）、请假记录查看
- 📢 **校园通知** — 通知列表 + 关键词搜索、已读/未读标记
- 🗺️ **校园地图** — 按分类筛选校园地点、查看地点详情
- 🎯 **活动中心** — 按日期浏览校园活动、活动报名/取消
- 🔒 **隐私锁** — 图案密码（PatternLock）设置与验证
- 👤 **个人中心** — 个人信息展示、请假记录、隐私锁设置、消息通知开关、评分、清除缓存、关于我们

## 项目结构

```
Harmony/
├── AppScope/
│   └── app.json5                  # 应用全局配置
├── entry/
│   └── src/main/
│       ├── ets/
│       │   ├── entryability/
│       │   │   └── EntryAbility.ts # 应用入口 Ability
│       │   └── pages/              # 📂 所有页面代码（详见该目录 README）
│       ├── resources/
│       │   └── base/
│       │       ├── media/          # 📂 图片资源（详见该目录 README）
│       │       ├── profile/
│       │       │   └── main_pages.json  # 页面路由配置
│       │       ├── element/        # 字符串/颜色资源
│       │       └── ...
│       └── module.json5            # 模块配置
├── build-profile.json5             # 构建配置
├── oh-package.json5                # 依赖管理
└── hvigor/                         # 构建工具配置
```

## 页面代码位置

> **所有页面代码位于：`E:\Harmony\Harmony\Harmony\entry\src\main\ets\pages`**

该目录下的 10 个页面文件及功能说明，请查看 [pages/README.md](entry/src/main/ets/pages/README.md)。

## 媒体资源位置

> **所有图片/图标资源位于：`E:\Harmony\Harmony\Harmony\entry\src\main\resources\base\media`**

如需替换应用图标、功能图标等，请在该目录下操作。详情请查看 [media/README.md](entry/src/main/resources/base/media/README.md)。

---

## ⚠️ 使用前必读 — 需要补充和注意的事项

### 1. 替换占位图片资源

当前多处图标和图片使用 `course.png` 作为占位图，**部分已临时修复**（标记 ✅），剩余需替换为正式资源：

| 引用位置 | 用途 | 需替换为 | 状态 |
|----------|------|----------|------|
| 主页功能入口 Grid | 课程表、请假申请等 5 个功能图标 | 各功能对应的独立图标 | 🔄 待替换 |
| 主页轮播图 | Banner 图片（4 张） | 校园宣传图/活动海报 | 🔄 待替换 |
| 个人中心头像 | 用户头像（Index/MinePage/AboutPage） | 默认头像图 | ✅ 已改用 icon.png |
| 校园地图 | 地图图片 | 实际校园地图/平面图 | 🔄 待替换 |
| 底部 Tab 图标 | 主页/消息/我的 三 Tab 图标 | `ic_home_normal.png` 等 6 张 | ✅ 已改用 icon.png 占位 |
| 关于页面 | 应用图标 (120x120) | 正式 App 图标 | ✅ 已改用 icon.png |
| 活动中心列表 | 活动项小图标 | 时间/地点/主办方对应图标 | ✅ 已改用 emoji 文字 |
| 空状态图 | NoticeListPage / CoursePage | 空状态插画 | 🔄 待替换 |

> **已修复：** 2025-07-04 修复了底部 Tab 图标引用（原为不存在的 `/images/` 字符串路径，现已改用 `$r('app.media.icon')` 占位）、用户头像（改用 `icon.png`）、活动中心小图标（改用 emoji）、关于页面图标（改用 `icon.png`），项目可正常编译运行。

具体媒体资源清单和替换说明见 [media/README.md](entry/src/main/resources/base/media/README.md)。

### 2. 未实现的页面（跳转会报错）

以下页面在 `Index.ets` 的消息列表和快捷功能中被引用，但 **尚未创建对应的 .ets 文件**：

| 引用页面 | 触发位置 |
|----------|----------|
| `pages/NoticeDetailPage` | 消息 Tab → 点击"校园网络维护通知" |
| `pages/SportEventPage` | 消息 Tab → 点击"运动会报名" |
| `pages/LibraryRemindPage` | 消息 Tab → 点击"图书馆借阅到期提醒" |
| `pages/LeaveDetailPage` | 消息 Tab → 点击"请假审批通过" |
| `pages/GradeQueryPage` | 消息 Tab → 点击"成绩发布通知" / 我的 Tab → 快捷功能"成绩" |
| `pages/ClubActivityPage` | 消息 Tab → 点击"社团活动邀请" |
| `pages/DormitoryPage` | 消息 Tab → 点击"宿舍卫生检查" |
| `pages/CampusCardPage` | 消息 Tab → 点击"校园卡消费提醒" |
| `pages/LecturePage` | 消息 Tab → 点击"讲座通知" |
| `pages/VolunteerPage` | 消息 Tab → 点击"志愿服务报名" |
| `pages/MyBorrowPage` | 我的 Tab → 快捷功能"借阅" |

**建议：** 要么创建这些缺失的页面文件，要么暂时注释掉对应的跳转逻辑，否则运行时会因路由找不到页面而报错。

### 3. 硬编码数据需要替换为真实接口

以下页面目前使用静态模拟数据，实际使用时需要接入后端 API：

| 文件 | 模拟数据 |
|------|----------|
| `Index.ets` | 用户信息（姓名、学号、学院）、统计数据（请假/通知/课程/借阅数量） |
| `CoursePage.ets` | `courseData` 数组中的所有课程信息 |
| `LeaveRecordPage.ets` | `leaveRecords` 数组中的请假记录 |
| `NoticeListPage.ets` | `notices` 数组中的通知列表 |
| `ActivityCalendarPage.ets` | `activityData` 对象中的所有活动数据 |
| `MinePage.ets` | 用户头像、姓名、学号、学院、班级信息 |
| `AboutPage.ets` | 客服电话 (`66666666666`)、邮箱 (`support@xxx.com`)、网址 (`www.xxx.com`) |

### 4. 路由配置

页面路由在 [entry/src/main/resources/base/profile/main_pages.json](entry/src/main/resources/base/profile/main_pages.json) 中注册。**新增页面时必须在此文件中添加对应的路径**，否则无法跳转。

当前已注册的页面：
```
pages/PatternLock → pages/Index → pages/MinePage → pages/AboutPage
→ pages/LeaveApplyPage → pages/LeaveRecordPage → pages/CoursePage
→ pages/NoticeListPage → pages/CampusMapPage → pages/ActivityCalendarPage
```

### 5. PatternLock 启动顺序

`EntryAbility.ts` 在 `onCreate` 中将 `isPasswordSet` 初始化为 `false`，并通过 `windowStage.loadContent('pages/Index')` 直接加载主页。如果需要首次启动时强制设置图案密码，需在 Index 页面的 `aboutToAppear` 中添加判断逻辑，当 `isPasswordSet === false` 时自动跳转至 `PatternLockPage`。

### 6. 其他注意事项

- **日期范围：** `LeaveApplyPage.ets` 的 DatePicker 范围为 2024-2025 年，`ActivityCalendarPage.ets` 的活动数据范围为 2025-09 至 2026-01，如实际使用年份不同需要修改。
- **编译 SDK：** `build-profile.json5` 中 `compileSdkVersion` 和 `compatibleSdkVersion` 均为 9，请确认目标设备支持的 API 版本。
- **签名配置：** `build-profile.json5` 中 `signingConfigs` 为空数组，构建发布包前需要配置签名。
- **缓存数据：** 所有数据目前仅存在于内存中（AppStorage），应用重启后会丢失。如需持久化，请接入 `@ohos.data.preferences` 或关系型数据库。

---

## 快速开始

### 环境要求

- DevEco Studio 3.1+ 
- HarmonyOS SDK API 9+
- 华为开发者账号（用于签名和调试）

### 运行步骤

1. 使用 DevEco Studio 打开本项目根目录
2. 在 `File → Project Structure` 中确认 SDK 路径
3. 连接 HarmonyOS 真机或启动模拟器
4. 点击 `Run` 按钮编译并运行

---

## 版权

© 2025 yszaygr2138 & lvan_smith 版权所有
