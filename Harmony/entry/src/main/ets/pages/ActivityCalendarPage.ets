// ActivityCalendarPage.ets - 活动中心页面（修复版）
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 校园活动数据（按日期存储）
const activityData = {
  '2025-10-28': [
    { id: 1, title: '人工智能前沿讲座', time: '14:00-16:00', location: '学术报告厅', organizer: '计算机学院', isRegistered: false },
    { id: 2, title: '校园歌手大赛初赛', time: '19:00-21:00', location: '大礼堂', organizer: '学生会', isRegistered: true },
    { id: 3, title: '英语角活动', time: '16:30-18:00', location: '外语学院咖啡厅', organizer: '外语学院', isRegistered: false },
  ],
  '2025-10-29': [
    { id: 4, title: '志愿者招募宣讲会', time: '10:00-11:30', location: '教2-101', organizer: '校团委', isRegistered: false },
    { id: 5, title: '创业项目路演', time: '14:00-17:00', location: '创业园A座', organizer: '创业学院', isRegistered: false },
    { id: 6, title: '篮球友谊赛', time: '18:30-20:30', location: '体育馆主馆', organizer: '体育部', isRegistered: true },
  ],
  '2025-10-30': [
    { id: 7, title: '社团招新嘉年华', time: '09:00-17:00', location: '中心广场', organizer: '社团联合会', isRegistered: false },
    { id: 8, title: '学术论文写作指导', time: '15:00-16:30', location: '图书馆报告厅', organizer: '研究生院', isRegistered: false },
  ],
  '2025-10-31': [
    { id: 9, title: '职业生涯规划讲座', time: '15:00-17:00', location: '就业指导中心', organizer: '就业办', isRegistered: false },
    { id: 10, title: '万圣节化妆舞会', time: '19:00-22:00', location: '学生活动中心', organizer: '艺术团', isRegistered: false },
    { id: 11, title: '电影放映《心灵奇旅》', time: '18:30-20:30', location: '大礼堂', organizer: '电影协会', isRegistered: true },
  ],
  '2025-11-01': [
    { id: 12, title: '周末读书分享会', time: '10:00-12:00', location: '图书馆三楼', organizer: '读书协会', isRegistered: false },
    { id: 13, title: '校园开放日', time: '09:00-16:00', location: '全校范围', organizer: '招生办公室', isRegistered: false },
    { id: 14, title: '瑜伽体验课', time: '15:00-16:30', location: '健身房瑜伽室', organizer: '瑜伽社', isRegistered: false },
  ],
  '2025-11-02': [
    { id: 15, title: '编程竞赛培训', time: '14:00-17:00', location: '计算机实验室', organizer: 'ACM协会', isRegistered: false },
    { id: 16, title: '古典音乐会', time: '19:30-21:00', location: '音乐厅', organizer: '音乐学院', isRegistered: true },
  ],
  '2025-11-03': [
    { id: 17, title: '心理健康讲座', time: '10:00-11:30', location: '心理健康中心', organizer: '心理咨询中心', isRegistered: false },
    { id: 18, title: '创业思维工作坊', time: '14:00-16:30', location: '创业园202', organizer: '创业学院', isRegistered: false },
    { id: 19, title: '足球联赛半决赛', time: '16:00-18:00', location: '东区足球场', organizer: '体育部', isRegistered: false },
  ],
  '2025-11-04': [
    { id: 20, title: '学术期刊投稿指南', time: '15:00-16:30', location: '图书馆电子阅览室', organizer: '科研处', isRegistered: false },
    { id: 21, title: '话剧《雷雨》排练', time: '18:30-21:00', location: '学生活动中心剧场', organizer: '话剧社', isRegistered: true },
  ],
  '2025-11-05': [
    { id: 22, title: '国际文化交流展', time: '10:00-16:00', location: '国际学院广场', organizer: '国际交流处', isRegistered: false },
    { id: 23, title: '环保志愿者活动', time: '14:00-17:00', location: '校园湿地公园', organizer: '环保协会', isRegistered: false },
    { id: 24, title: '创新创业大赛决赛', time: '18:30-21:00', location: '大礼堂', organizer: '创业学院', isRegistered: false },
  ]
};

@Entry
@Component
struct ActivityCalendarPage {
  @State currentDate: string = '2025-10-28'; // 当前选中日期字符串
  @State currentActivities: any[] = []; // 当前日期的活动

  // 初始化时加载活动
  aboutToAppear() {
    this.loadActivities();
  }

  // 加载选中日期的活动
  loadActivities() {
    this.currentActivities = activityData[this.currentDate] || [];
  }

  // 日期选择器变化时的处理
  onDateChange(value: { year: number, month: number, day: number }) {
    // 直接拼接日期字符串，避免使用Date对象的问题
    const year = value.year;
    const month = String(value.month + 1).padStart(2, '0'); // month从0开始，需要+1
    const day = String(value.day).padStart(2, '0');
    this.currentDate = `${year}-${month}-${day}`;
    this.loadActivities();
  }

  // 获取当前日期对应的Date对象（用于DatePicker的selected属性）
  getSelectedDate(): Date {
    const [year, month, day] = this.currentDate.split('-').map(Number);
    return new Date(year, month - 1, day); // month-1因为Date构造函数中月份从0开始
  }

  // 活动报名/取消报名
  toggleRegistration(index: number) {
    if (this.currentActivities[index]) {
      this.currentActivities[index].isRegistered = !this.currentActivities[index].isRegistered;
      promptAction.showToast({
        message: this.currentActivities[index].isRegistered ? '报名成功！' : '已取消报名'
      });

      // 更新数据源
      this.updateActivityData();
    }
  }

  // 更新活动数据
  updateActivityData() {
    // 这里可以添加数据持久化逻辑
    console.log('活动数据已更新:', this.currentActivities);
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('校园活动中心')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      .padding(15)
      .backgroundColor(Color.White)
      .width('100%')
      .justifyContent(FlexAlign.Center)

      // 主要内容区域
      Column() {
        // 日期选择器 - 使用修复后的逻辑
        DatePicker({
          start: new Date('2025-09-01'),
          end: new Date('2026-01-31'),
          selected: this.getSelectedDate()
        })
          .onChange((value: { year: number, month: number, day: number }) => {
            this.onDateChange(value);
          })
          .height(200)
          .width('90%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .margin({ top: 10, bottom: 20 })

        // 当天活动标题
        Row() {
          Text(`${this.currentDate} 校园活动`)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Text(`共${this.currentActivities.length}个活动`)
            .fontSize(14)
            .fontColor(Color.Gray)
            .margin({ left: 10 })
        }
        .width('90%')
        .margin({ bottom: 15 })

        // 活动列表
        List() {
          if (this.currentActivities.length === 0) {
            ListItem() {
              Column() {
                Text('当天暂无活动')
                  .fontSize(16)
                  .fontColor('#999')
                Text('请选择其他日期查看')
                  .fontSize(14)
                  .fontColor('#CCC')
                  .margin({ top: 5 })
              }
              .padding(40)
              .width('100%')
              .alignItems(HorizontalAlign.Center)
            }
          } else {
            ForEach(this.currentActivities, (item, index) => {
              ListItem() {
                this.buildActivityItem(item, index)
              }
            })
          }
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#F9F9F9')
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      // 底部操作栏
      Row() {
        Button('返回首页')
          .width('40%')
          .height(45)
          .fontSize(16)
          .backgroundColor('#4A90E2')
          .fontColor(Color.White)
          .borderRadius(22)
          .onClick(() => {
            router.back();
          })

        Button('刷新活动')
          .width('40%')
          .height(45)
          .fontSize(16)
          .backgroundColor(Color.White)
          .fontColor('#4A90E2')
          .borderRadius(22)
          .margin({ left: 15 })
          .onClick(() => {
            this.loadActivities();
            promptAction.showToast({ message: '活动列表已刷新' });
          })
      }
      .margin({ top: 15, bottom: 25 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder buildActivityItem(item: any, index: number) {
    Column() {
      // 活动标题行
      Row() {
        Text(item.title)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)

        // 报名状态
        Row() {
          Text(item.isRegistered ? '已报名' : '未报名')
            .fontSize(12)
            .fontColor(item.isRegistered ? '#34C759' : '#FF3B30')
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .backgroundColor(item.isRegistered ? '#E8F5E8' : '#FFE8E8')
            .borderRadius(10)
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 活动详情
      Column() {
        // 时间
        Row() {
          Text('⏰')
            .fontSize(16)
            .margin({ right: 6 })
          Text(`时间：${item.time}`)
            .fontSize(14)
            .fontColor('#666')
        }
        .width('100%')
        .margin({ bottom: 6 })

        // 地点
        Row() {
          Text('📍')
            .fontSize(16)
            .margin({ right: 6 })
          Text(`地点：${item.location}`)
            .fontSize(14)
            .fontColor('#666')
        }
        .width('100%')
        .margin({ bottom: 6 })

        // 主办方
        Row() {
          Text('🏛️')
            .fontSize(16)
            .margin({ right: 6 })
          Text(`主办：${item.organizer}`)
            .fontSize(14)
            .fontColor('#666')
        }
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)

      // 报名按钮
      Button(item.isRegistered ? '取消报名' : '立即报名')
        .width('100%')
        .height(36)
        .fontSize(14)
        .backgroundColor(item.isRegistered ? '#FF3B30' : '#4A90E2')
        .fontColor(Color.White)
        .borderRadius(18)
        .margin({ top: 12 })
        .onClick(() => {
          this.toggleRegistration(index);
        })
    }
    .padding(15)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .width('90%')
    .margin({ top: 8, bottom: 8 })
  }
}