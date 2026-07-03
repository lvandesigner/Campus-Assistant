// MinePage.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct MinePage {
  @StorageLink('isPasswordSet') isPasswordSet: boolean = false
  @State isNoticeOn: boolean = true;
  @State rating: number = 4;

  build() {
    Column() {
      // 顶部个人信息
      Column() {
        Image($r('app.media.icon'))
          .size({ width: 100, height: 100 })
          .borderRadius(50)
          .margin({ bottom: 15 })

        Text('xx')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 5 })

        Text('学号: xxx')
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ bottom: 5 })

        Text('xxx学院\n xxx班')
          .fontSize(14)
          .fontColor(Color.Gray)
          .textAlign(TextAlign.Center)
          .maxLines(2)
      }
      .padding(30)
      .backgroundColor(Color.White)
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      // 功能列表
      List({ space: 10 }) {
        // 个人信息编辑
        ListItem() {
          this.buildMenuItem('个人信息编辑', '查看和修改个人信息')
        }
        .onClick(() => {
          promptAction.showToast({ message: '进入个人信息编辑' });
        })

        // 我的请假记录
        ListItem() {
          this.buildMenuItem('我的请假记录', '查看请假历史')
        }
        .onClick(() => {
          router.pushUrl({ url: 'pages/LeaveRecordPage' });
        })

        // 隐私锁设置
        ListItem() {
          this.buildMenuItem('隐私锁设置', '修改图案密码')
        }
        .onClick(() => {
          router.pushUrl({
            url: 'pages/PatternLockPage',
            params: { mode: 'settings' }
          });
        })

        // 消息通知开关
        ListItem() {
          Row() {
            Column() {
              Text('消息通知')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
              Text('开启或关闭应用通知')
                .fontSize(14)
                .fontColor(Color.Gray)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Toggle({
              type: ToggleType.Switch,
              isOn: this.isNoticeOn
            })
              .onChange((isOn) => {
                this.isNoticeOn = isOn;
                promptAction.showToast({
                  message: isOn ? '已开启消息通知' : '已关闭消息通知'
                });
              })
          }
          .padding(20)
          .backgroundColor(Color.White)
          .width('100%')
        }

        // 应用评分
        ListItem() {
          Column() {
            Row() {
              Text('给应用评分')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)

              Text(`${this.rating}.0星`)
                .fontSize(14)
                .fontColor('#FFA500')
            }
            .width('100%')
            .margin({ bottom: 10 })

            Rating({
              rating: this.rating,
              indicator: false
            })
              .stars(5)
              .stepSize(1)
              .onChange((value) => {
                this.rating = value;
                promptAction.showToast({ message: `感谢您的${value}星评价` });
              })
          }
          .padding(20)
          .alignItems(HorizontalAlign.Start)
          .backgroundColor(Color.White)
          .width('100%')
        }

        // 清除缓存
        ListItem() {
          Row() {
            Column() {
              Text('清除缓存')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
              Text('清理应用缓存数据')
                .fontSize(14)
                .fontColor(Color.Gray)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Text('125.6 MB')
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ right: 10 })

            Image($r('app.media.arrow_right'))
              .size({ width: 20, height: 20 })
          }
          .padding(20)
          .backgroundColor(Color.White)
          .width('100%')
          .onClick(() => {
            promptAction.showToast({ message: '缓存已清除' });
          })
        }

        // 关于我们
        ListItem() {
          this.buildMenuItem('关于我们', '版本信息和功能介绍')
        }
        .onClick(() => {
          router.pushUrl({ url: 'pages/AboutPage' });
        })
      }
      .width('100%')
      .layoutWeight(1)
      .divider({ strokeWidth: 1, color: '#F0F0F0' })
      .margin({ top: 10 })

      // 退出按钮
      Button('退出登录')
        .width('90%')
        .height(50)
        .fontSize(18)
        .backgroundColor('#FF3B30')
        .fontColor(Color.White)
        .borderRadius(25)
        .margin({ top: 20, bottom: 30 })
        .onClick(() => {
          // 退出登录逻辑
          promptAction.showToast({ message: '已退出登录' });
          // 可以添加路由返回或其他清理逻辑
          router.back();
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder buildMenuItem(title: string, desc: string) {
    Row() {
      Column() {
        Text(title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
        Text(desc)
          .fontSize(14)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r('app.media.arrow_right'))
        .size({ width: 20, height: 20 })
    }
    .padding(20)
    .backgroundColor(Color.White)
    .width('100%')
  }
}