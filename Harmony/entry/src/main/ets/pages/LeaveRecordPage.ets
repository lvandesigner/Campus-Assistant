import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct LeaveRecordPage {
  @State leaveRecords: LeaveRecord[] = [
    {
      id: 1,
      type: '事假',
      startTime: '2024-01-15 08:00',
      endTime: '2024-01-15 18:00',
      reason: '家中有急事需要处理',
      status: 'approved',
      duration: '1天',
      applyTime: '2024-01-14 10:30'
    },
    {
      id: 2,
      type: '病假',
      startTime: '2024-01-12 09:00',
      endTime: '2024-01-14 18:00',
      reason: '感冒发烧，需要休息治疗',
      status: 'approved',
      duration: '3天',
      applyTime: '2024-01-11 14:20'
    },
    {
      id: 3,
      type: '事假',
      startTime: '2024-01-08 14:00',
      endTime: '2024-01-08 16:00',
      reason: '参加重要家庭聚会',
      status: 'rejected',
      duration: '2小时',
      applyTime: '2024-01-07 16:45'
    },
    {
      id: 4,
      type: '实习假',
      startTime: '2024-01-05 08:00',
      endTime: '2024-01-05 17:00',
      reason: '参加企业实习面试',
      status: 'approved',
      duration: '1天',
      applyTime: '2024-01-04 09:15'
    },
    {
      id: 5,
      type: '病假',
      startTime: '2024-01-02 08:00',
      endTime: '2024-01-03 18:00',
      reason: '肠胃不适，需要就医',
      status: 'approved',
      duration: '2天',
      applyTime: '2024-01-01 20:30'
    }
  ];

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Image($r('app.media.arrow_left'))
          .size({ width: 24, height: 24 })
          .fillColor(Color.Black)
          .onClick(() => {
            router.back();
          })

        Text('我的请假记录')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // 占位，保持对称
        Image($r('app.media.arrow_left'))
          .size({ width: 24, height: 24 })
          .opacity(0)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(Color.White)
      .border({ width: { bottom: 1 }, color: '#F0F0F0' })

      // 统计信息卡片
      Row() {
        Column() {
          Text('5')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#007DFF')
          Text('总申请')
            .fontSize(12)
            .fontColor('#666666')
        }
        .padding(15)
        .layoutWeight(1)

        Column() {
          Text('4')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#34C759')
          Text('已批准')
            .fontSize(12)
            .fontColor('#666666')
        }
        .padding(15)
        .layoutWeight(1)

        Column() {
          Text('1')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF3B30')
          Text('未批准')
            .fontSize(12)
            .fontColor('#666666')
        }
        .padding(15)
        .layoutWeight(1)
      }
      .width('90%')
      .margin({ top: 15, bottom: 10 })
      .backgroundColor(Color.White)
      .borderRadius(12)
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })

      // 请假记录列表
      List({ space: 10 }) {
        ForEach(this.leaveRecords, (record: LeaveRecord) => {
          ListItem() {
            this.buildLeaveRecordItem(record)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .margin({ top: 10 })
      .divider({ strokeWidth: 1, color: '#F5F5F5' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder buildLeaveRecordItem(record: LeaveRecord) {
    Column() {
      // 顶部：请假类型和状态
      Row() {
        Text(record.type)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        // 状态标签
        Text(this.getStatusText(record.status))
          .fontSize(12)
          .fontColor(Color.White)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(this.getStatusColor(record.status))
          .borderRadius(10)
          .margin({ left: 10 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({ bottom: 12 })

      // 请假时间
      Row() {
        Column() {
          Text('开始时间')
            .fontSize(12)
            .fontColor('#666666')
            .margin({ bottom: 2 })
          Text(record.startTime)
            .fontSize(14)
            .fontColor('#333333')
        }
        .layoutWeight(1)

        Column() {
          Text('结束时间')
            .fontSize(12)
            .fontColor('#666666')
            .margin({ bottom: 2 })
          Text(record.endTime)
            .fontSize(14)
            .fontColor('#333333')
        }
        .layoutWeight(1)

        Column() {
          Text('时长')
            .fontSize(12)
            .fontColor('#666666')
            .margin({ bottom: 2 })
          Text(record.duration)
            .fontSize(14)
            .fontColor('#333333')
        }
      }
      .width('100%')
      .margin({ bottom: 10 })

      // 请假缘由
      Column() {
        Text('请假缘由')
          .fontSize(12)
          .fontColor('#666666')
          .margin({ bottom: 4 })
          .alignSelf(ItemAlign.Start)
        Text(record.reason)
          .fontSize(14)
          .fontColor('#333333')
          .textAlign(TextAlign.Start)
          .width('100%')
          .padding(10)
          .backgroundColor('#F8F8F8')
          .borderRadius(8)
      }
      .width('100%')
      .margin({ bottom: 10 })

      // 底部：申请时间和操作
      Row() {
        Text(`申请时间: ${record.applyTime}`)
          .fontSize(12)
          .fontColor('#999999')

        // 操作按钮
        Row() {
          Text('查看详情')
            .fontSize(12)
            .fontColor('#007DFF')
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .backgroundColor('#E6F2FF')
            .borderRadius(4)
            .onClick(() => {
              this.viewRecordDetail(record);
            })
        }
        .margin({ left: 'auto' })
      }
      .width('100%')
    }
    .padding(16)
    .backgroundColor(Color.White)
    .width('100%')
    .onClick(() => {
      this.viewRecordDetail(record);
    })
  }

  // 获取状态显示文本
  getStatusText(status: string): string {
    switch (status) {
      case 'approved':
        return '已批准';
      case 'rejected':
        return '未批准';
      case 'pending':
        return '审核中';
      default:
        return '未知';
    }
  }

  // 获取状态颜色
  getStatusColor(status: string): string {
    switch (status) {
      case 'approved':
        return '#34C759';
      case 'rejected':
        return '#FF3B30';
      case 'pending':
        return '#FF9500';
      default:
        return '#666666';
    }
  }

  // 查看详情
  viewRecordDetail(record: LeaveRecord) {
    promptAction.showToast({
      message: `查看${record.type}详情 - ${record.startTime}至${record.endTime}`
    });

    // 这里可以跳转到更详细的页面
    // router.pushUrl({
    //   url: 'pages/LeaveDetailPage',
    //   params: { recordId: record.id }
    // });
  }
}

// 请假记录数据类型
interface LeaveRecord {
  id: number;
  type: string;
  startTime: string;
  endTime: string;
  reason: string;
  status: string; // 'approved' | 'rejected' | 'pending'
  duration: string;
  applyTime: string;
}