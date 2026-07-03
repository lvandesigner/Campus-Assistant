import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct AboutPage {
  @State currentVersion: string = 'V2.1.0';
  @State buildNumber: string = '20241215001';
  @State appSize: string = '86.5 MB';

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

        Text('关于我们')
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

      Scroll() {
        Column() {
          // 应用图标和基本信息
          Column() {
            Image($r('app.media.icon'))
              .size({ width: 120, height: 120 })
              .borderRadius(20)
              .margin({ bottom: 20 })

            Text('智慧校园')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .margin({ bottom: 8 })

            Text('一站式校园生活服务平台')
              .fontSize(16)
              .fontColor('#666666')
              .margin({ bottom: 15 })

            Text(`版本 ${this.currentVersion}`)
              .fontSize(14)
              .fontColor('#999999')
          }
          .padding(30)
          .backgroundColor(Color.White)
          .width('100%')
          .alignItems(HorizontalAlign.Center)

          // 功能介绍卡片
          Column() {
            Text('功能介绍')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .margin({ bottom: 15 })
              .alignSelf(ItemAlign.Start)

            Column() {
              this.buildFeatureItem('📚 课程管理', '查看课程表、上课地点、教师信息')
              this.buildFeatureItem('📝 请假系统', '在线请假申请、审批进度查询')
              this.buildFeatureItem('📢 消息通知', '实时接收校园通知和重要公告')
              this.buildFeatureItem('🗺️ 校园导览', '3D校园地图、建筑位置导航')
              this.buildFeatureItem('🎯 活动中心', '校园活动报名、社团信息')
              this.buildFeatureItem('🔒 隐私保护', '多重安全验证，保护个人信息')
            }
            .width('100%')
          }
          .padding(20)
          .backgroundColor(Color.White)
          .width('100%')
          .margin({ top: 10 })

          // 版本信息卡片
          Column() {
            Text('版本信息')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .margin({ bottom: 15 })
              .alignSelf(ItemAlign.Start)

            Row() {
              Text('当前版本')
                .fontSize(14)
                .fontColor('#666666')
                .layoutWeight(1)
              Text(this.currentVersion)
                .fontSize(14)
                .fontColor('#333333')
                .fontWeight(FontWeight.Medium)
            }
            .width('100%')
            .padding({ top: 8, bottom: 8 })

            Row() {
              Text('构建版本')
                .fontSize(14)
                .fontColor('#666666')
                .layoutWeight(1)
              Text(this.buildNumber)
                .fontSize(14)
                .fontColor('#333333')
            }
            .width('100%')
            .padding({ top: 8, bottom: 8 })

            Row() {
              Text('应用大小')
                .fontSize(14)
                .fontColor('#666666')
                .layoutWeight(1)
              Text(this.appSize)
                .fontSize(14)
                .fontColor('#333333')
            }
            .width('100%')
            .padding({ top: 8, bottom: 8 })

            Row() {
              Text('更新时间')
                .fontSize(14)
                .fontColor('#666666')
                .layoutWeight(1)
              Text('2024-12-15')
                .fontSize(14)
                .fontColor('#333333')
            }
            .width('100%')
            .padding({ top: 8, bottom: 8 })

            // 检查更新按钮
            Button('检查更新')
              .width('100%')
              .height(45)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .backgroundColor('#007DFF')
              .fontColor(Color.White)
              .borderRadius(8)
              .margin({ top: 15 })
              .onClick(() => {
                promptAction.showToast({ message: '已是最新版本' });
              })
          }
          .padding(20)
          .backgroundColor(Color.White)
          .width('100%')
          .margin({ top: 10 })

          .padding(20)
          .backgroundColor(Color.White)
          .width('100%')
          .margin({ top: 10 })

          // 联系我们卡片
          Column() {
            Text('联系我们')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .margin({ bottom: 15 })
              .alignSelf(ItemAlign.Start)

            Row() {
              Column() {
                Text('客服电话')
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ bottom: 4 })
                Text('66666666666')
                  .fontSize(16)
                  .fontColor('#007DFF')
                  .fontWeight(FontWeight.Medium)
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text('服务时间')
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ bottom: 4 })
                Text('暂定')
                  .fontSize(14)
                  .fontColor('#333333')
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .margin({ bottom: 15 })

            Row() {
              Column() {
                Text('邮箱支持')
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ bottom: 4 })
                Text('support@xxx.com')
                  .fontSize(14)
                  .fontColor('#007DFF')
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text('官方网站')
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ bottom: 4 })
                Text('www.xxx.com')
                  .fontSize(14)
                  .fontColor('#007DFF')
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')

            // 反馈按钮
            Button('意见反馈')
              .width('100%')
              .height(45)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .backgroundColor('#34C759')
              .fontColor(Color.White)
              .borderRadius(8)
              .margin({ top: 15 })
              .onClick(() => {
                promptAction.showToast({ message: '跳转到意见反馈页面' });
                // router.pushUrl({ url: 'pages/FeedbackPage' });
              })
          }
          .padding(20)
          .backgroundColor(Color.White)
          .width('100%')
          .margin({ top: 10, bottom: 20 })

          // 版权信息
          Column() {
            Text('© 2025 nb666 版权所有')
              .fontSize(12)
              .fontColor('#999999')
              .margin({ bottom: 5 })

            Text('HarmonyOS 校园助手APP')
              .fontSize(12)
              .fontColor('#999999')
          }
          .padding(20)
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder buildFeatureItem(title: string, desc: string) {
    Row() {
      Column() {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .margin({ bottom: 4 })
        Text(desc)
          .fontSize(14)
          .fontColor('#666666')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .padding({ top: 12, bottom: 12 })
    .width('100%')
    .border({ width: { bottom: 1 }, color: '#F5F5F5' })
  }

  @Builder buildTeamMember(name: string, role: string) {
    Row() {
      // 头像占位
      Column() {
        Text(name.substring(0, 1))
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .size({ width: 40, height: 40 })
      .backgroundColor('#007DFF')
      .borderRadius(20)
      .justifyContent(FlexAlign.Center)

      Column() {
        Text(name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .margin({ bottom: 2 })
        Text(role)
          .fontSize(14)
          .fontColor('#666666')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 12 })
    }
    .padding({ top: 10, bottom: 10 })
    .width('100%')
  }
}