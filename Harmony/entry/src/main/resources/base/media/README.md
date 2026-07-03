# Media — 媒体资源目录

> **路径：** `E:\Harmony\Harmony\Harmony\entry\src\main\resources\base\media`

本目录存放应用所需的全部图片/图标资源。**资源修改、替换、新增都在此目录下操作。**

## 现有资源文件

| 文件名 | 尺寸 | 用途 | 状态 |
|--------|------|------|------|
| [icon.png](icon.png) | - | 应用入口图标 / Ability 图标 (`$media:icon`) | ✅ 已有 |
| [arrow_right.png](arrow_right.png) | - | 列表项右侧箭头 | ✅ 已有 |
| [arrow_left.png](arrow_left.png) | - | 返回箭头（AboutPage 导航栏使用） | ✅ 已有 |
| [back.png](back.png) | - | 备用返回图标 | ✅ 已有 |
| [ic_arrow_down.png](ic_arrow_down.png) | - | 向下箭头 | ✅ 已有 |
| [course.png](course.png) | - | ⚠️ **通用占位图** — 被多处引用 | 🔄 需替换 |

## ⚠️ 关键问题：占位图滥用

`course.png` 在当前项目中被**大量位置**当作通用占位图引用。**部分已临时修复**（详见下方状态列），剩余请按以下清单逐一替换为正式图片：

### 需要新增/替换的资源

| 引用位置 | 代码中的引用 | 建议替换为 | 建议尺寸 | 状态 |
|----------|-------------|-----------|----------|------|
| 主页 - 轮播图 ×4 | `Index.ets` 中 `bannerImages` 数组 | `banner_01.png` ~ `banner_04.png` | 750×360 | 🔄 仍用 course.png |
| 主页 - 功能图标 ×5 | `Index.ets` 中 `functionItems` | `ic_course.png`、`ic_leave.png`、`ic_notice.png`、`ic_map.png`、`ic_activity.png` | 100×100 | 🔄 仍用 course.png |
| 主页/个人中心 - 用户头像 | `Index.ets` / `MinePage.ets` / `AboutPage.ets` | `avatar_default.png` | 200×200 | ✅ 已改用 icon.png |
| 校园地图 - 地图图片 | `CampusMapPage.ets` | `campus_map.png` | 750×500 | 🔄 仍用 course.png |
| 通知列表 - 空状态图 | `NoticeListPage.ets` | `empty_notice.png` | 240×240 | 🔄 仍用 course.png |
| 活动中心 - 小图标 | `ActivityCalendarPage.ets` | `ic_time.png`、`ic_location.png`、`ic_organizer.png` | 32×32 | ✅ 已改用 emoji 文字 |
| 课程表 - 空状态图 | `CoursePage.ets` | `empty_course.png` | 240×240 | 🔄 仍用 course.png |
| 底部 Tab 图标 ×6 | `Index.ets` 中 `TabItem` Builder | `ic_home_normal.png` 等 6 张 | 64×64 | ✅ 已改用 icon.png 占位 |

### Tab 图标状态（已临时修复 ✅）

~~代码中 `Index.ets` 的 `TabItem` Builder 原本引用了不存在的 `/images/home_normal.png` 等字符串路径。~~

**已于 2025-07-04 修复：** Tab 图标已改用 `$r('app.media.icon')`（现有 `icon.png`）作为临时占位，代码可正常编译运行。

**正式替换时：** 准备 6 张 Tab 图标（建议 64×64），放入 `media/` 目录，然后在 `Index.ets` 中将 `$r('app.media.icon')` 替换为对应的资源引用：

| Tab | 未选中态 | 选中态 |
|-----|---------|--------|
| 主页 | `$r('app.media.icon')` → `$r('app.media.ic_home_normal')` | → `$r('app.media.ic_home_selected')` |
| 消息 | `$r('app.media.icon')` → `$r('app.media.ic_message_normal')` | → `$r('app.media.ic_message_selected')` |
| 我的 | `$r('app.media.icon')` → `$r('app.media.ic_mine_normal')` | → `$r('app.media.ic_mine_selected')` |

---

## 如何替换资源

### 替换现有图片（保持文件名不变）

直接将新图片覆盖同名文件即可。但 **`course.png` 除外** — 它被多处用作占位图，建议不要直接替换它，而是：

1. 新增各功能对应的图片（如 `ic_course.png`、`banner_01.png` 等）
2. 修改对应 `.ets` 文件中的 `$r('app.media.course')` 为 `$r('app.media.新文件名')`

### 新增图片

1. 将 `.png` 图片放入本目录
2. 在代码中通过 `$r('app.media.文件名')` 引用（不带扩展名）
3. 示例：放入 `my_icon.png` → 代码写 `$r('app.media.my_icon')`

### 资源引用方式

```ts
// ✅ 推荐：使用 $r() 资源引用
Image($r('app.media.icon'))

// ❌ 需避免：使用字符串路径（除非是 resources/rawfile 下的文件）
Image('/images/home_normal.png')  // 文件可能找不到
```

---

## 注意

- 所有图片建议使用 **PNG** 格式
- `$r('app.media.xxx')` 中 `xxx` 不包含 `.png` 扩展名
- 图片尺寸建议适配手机分辨率（基准 1080×2340）
- `app_icon` 在 `AppScope/app.json5` 中引用，在 `AppScope/resources/base/media/` 下存放
