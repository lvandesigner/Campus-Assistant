# Pages — 页面代码目录

> **路径：** `E:\Harmony\Harmony\Harmony\entry\src\main\ets\pages`

本目录包含智慧校园应用的所有页面组件，使用 ArkTS + ArkUI 编写。

## 页面清单

### 1. [PatternLock.ets](PatternLock.ets) — 图案密码锁

- **功能：** 图案密码（九宫格连线）的设置与验证
- **模式：** 
  - `setup` — 设置新密码（输入两次确认）
  - `verify` — 验证已有密码
- **入口：** 由 `MinePage.ets` 中"隐私锁设置"跳转进入
- **数据存储：** 通过 `AppStorage` 存取 `userPassword` 和 `isPasswordSet`
- **⚠️ 注意：** 当前密码仅保存在内存中，应用重启后丢失

### 2. [Index.ets](Index.ets) — 主页

- **功能：** 应用主入口，三 Tab 导航结构
- **Tab 1 - 主页：** 
  - 轮播图（Swiper，4 张占位图）
  - 滚动通知栏（Marquee）
  - 功能入口 Grid（课程表 / 请假申请 / 校园通知 / 校园地图 / 活动中心）
- **Tab 2 - 消息：** 
  - 未读/已读消息列表
  - ⚠️ 大量跳转目标页面尚未创建（详见根 README）
- **Tab 3 - 我的：** 
  - 个人中心入口卡片（跳转 MinePage）
  - 个人信息简版展示 + 快捷功能入口
  - ⚠️ Tab 图标引用了不存在的 `/images/home_normal.png` 等路径
- **⚠️ 注意：** 
  - 功能入口图标全部使用 `$r('app.media.course')` 占位
  - 轮播图全部使用同一张占位图
  - 未实现的跳转页面列表见根 README 第 2 节

### 3. [MinePage.ets](MinePage.ets) — 个人中心

- **功能：** 完整个人中心（设置页）
- **菜单项：** 个人信息编辑 / 请假记录 / 隐私锁设置 / 消息通知开关 / 评分 / 清除缓存 / 关于我们
- **⚠️ 注意：** 
  - 用户信息（头像、姓名、学号）为硬编码占位
  - "个人信息编辑"仅弹出 Toast，未实现编辑页

### 4. [AboutPage.ets](AboutPage.ets) — 关于我们

- **功能：** 展示应用版本、功能介绍、联系方式、版权信息
- **⚠️ 注意：** 
  - 客服电话 (`66666666666`)、邮箱 (`support@xxx.com`)、网址 (`www.xxx.com`) 均为占位数据
  - "检查更新"仅弹出 Toast，未实现真正的更新检测

### 5. [LeaveApplyPage.ets](LeaveApplyPage.ets) — 请假申请

- **功能：** 填写并提交请假申请
- **表单字段：** 开始日期、结束日期（DatePicker）、请假理由（TextInput）
- **⚠️ 注意：** 
  - 日期范围固定为 2024-2025 年
  - 仅前端校验（理由非空），无后端提交逻辑

### 6. [LeaveRecordPage.ets](LeaveRecordPage.ets) — 请假记录

- **功能：** 查看历史请假记录列表
- **数据：** 5 条硬编码模拟记录（含事假/病假/实习假、已批准/未批准状态）
- **⚠️ 注意：** 点击"查看详情"仅弹出 Toast，实际需接入后端

### 7. [CoursePage.ets](CoursePage.ets) — 课程表

- **功能：** 按周查看课程详细信息
- **数据：** 2 周的完整课程数据（含课名、时间、地点、教师、学分、考核方式、教材、作业要求等）
- **交互：** 左右箭头切换周次 / Swiper 滑动选周 / 课程卡片点击查看摘要
- **⚠️ 注意：** 所有课程数据硬编码在 `courseData` 数组中，仅包含 2 周数据。实际使用需从后端拉取

### 8. [NoticeListPage.ets](NoticeListPage.ets) — 校园通知

- **功能：** 查看校园通知列表、关键词搜索、标记已读
- **⚠️ 注意：** 
  - 仅 2 条硬编码通知
  - 点击通知详情仅弹出 Toast，未实现详情页

### 9. [CampusMapPage.ets](CampusMapPage.ets) — 校园地图

- **功能：** 按分类（全部/教学楼/图书馆/食堂/运动场地）查看校园地点
- **交互：** 左侧分类侧边栏 + 右侧地点列表 + 详情弹窗
- **⚠️ 注意：** 地图图片使用 `$r('app.media.course')` 占位，需替换为实际校园地图

### 10. [ActivityCalendarPage.ets](ActivityCalendarPage.ets) — 活动中心

- **功能：** 按日期浏览校园活动、活动报名/取消报名
- **交互：** DatePicker 选择日期 → 展示当天活动列表 → 点击报名/取消
- **⚠️ 注意：** 
  - 活动数据范围 2025-10-28 至 2025-11-05（共 24 个活动）
  - 数据全部硬编码，报名状态仅保存在内存中

---

## 新增页面指南

1. 在本目录创建 `YourPage.ets` 文件
2. 使用 `@Entry` 和 `@Component` 装饰器定义页面：
   ```ts
   import router from '@ohos.router';
   
   @Entry
   @Component
   struct YourPage {
     build() {
       // 页面 UI
     }
   }
   ```
3. 在 [entry/src/main/resources/base/profile/main_pages.json](../resources/base/profile/main_pages.json) 的 `src` 数组中添加 `"pages/YourPage"`
4. 在调用处使用 `router.pushUrl({ url: 'pages/YourPage' })` 跳转

## 页面间跳转关系

```
PatternLock ──→ Index ──→ CoursePage
                    │──→ LeaveApplyPage
                    │──→ NoticeListPage
                    │──→ CampusMapPage
                    │──→ ActivityCalendarPage
                    │──→ MinePage ──→ LeaveRecordPage
                    │              ──→ PatternLockPage (设置模式)
                    │              ──→ AboutPage
                    └──→ [多个未实现的页面]
```
