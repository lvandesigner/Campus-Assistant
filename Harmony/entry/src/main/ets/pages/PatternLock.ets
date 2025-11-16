// PatternLockPage.ets
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';

@Entry
@Component
struct PatternLockPage {
  @State passwords: number[] = []
  @State message: string = '请输入密码'
  @State mode: string = 'setup' // 'setup' 或 'verify'
  private patternLockController: PatternLockController = new PatternLockController()

  aboutToAppear() {
    // 获取传递的模式参数
    const params = router.getParams() as Record<string, string>;
    this.mode = params?.mode || 'setup';
    this.message = this.mode === 'setup' ? '请设置新密码' : '请输入密码';
  }

  build() {
    Column() {
      // 标题
      Text(this.mode === 'setup' ? '设置密码锁' : '验证密码')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 50, bottom: 20 })

      // 提示信息
      Text(this.message)
        .fontSize(18)
        .margin({ bottom: 30 })
        .fontColor(this.message.includes('成功') ? Color.Green :
          this.message.includes('错误') ? Color.Red : Color.Black)

      // 图案密码锁
      PatternLock(this.patternLockController)
        .sideLength(300)
        .circleRadius(12)
        .regularColor(Color.Gray)
        .selectedColor(Color.Blue)
        .activeColor(Color.Red)
        .pathStrokeWidth(20)
        .pathColor(Color.Green)
        .autoReset(true)
        .onPatternComplete((input: Array<number>) => {
          this.handlePatternComplete(input);
        })

      // 操作按钮
      Row() {
        Button('重置')
          .fontSize(16)
          .backgroundColor(Color.Gray)
          .fontColor(Color.White)
          .padding(10)
          .onClick(() => {
            this.patternLockController.reset();
            this.passwords = [];
            this.message = this.mode === 'setup' ? '请设置新密码' : '请输入密码';
          })

        Button('返回')
          .fontSize(16)
          .backgroundColor(Color.Gray)
          .fontColor(Color.White)
          .padding(10)
          .margin({ left: 20 })
          .onClick(() => {
            router.back();
          })
      }
      .margin({ top: 30 })
      .justifyContent(FlexAlign.Center)

    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F5F5F5')
  }

  // 处理图案完成事件
  private handlePatternComplete(input: Array<number>) {
    if (this.mode === 'setup') {
      // 设置密码模式
      if (this.passwords.length === 0) {
        // 第一次输入
        this.passwords = input;
        this.message = '请再次输入密码确认';
      } else {
        // 第二次输入，验证一致性
        if (this.passwords.toString() === input.toString()) {
          // 密码设置成功
          AppStorage.SetOrCreate('userPassword', input.toString());
          AppStorage.SetOrCreate('isPasswordSet', true);
          this.message = '密码设置成功！';
          promptAction.showToast({ message: '密码设置成功' });

          // 2秒后返回
          setTimeout(() => {
            router.back();
          }, 2000);
        } else {
          // 两次输入不一致
          this.message = '两次输入密码不一致，请重新设置';
          this.passwords = [];
          promptAction.showToast({ message: '密码不一致' });
        }
      }
    } else {
      // 验证密码模式
      const savedPassword = AppStorage.Get<string>('userPassword');
      if (savedPassword === input.toString()) {
        // 密码正确，跳转到个人中心
        this.message = '密码正确';
        promptAction.showToast({ message: '验证成功' });

        setTimeout(() => {
          router.pushUrl({ url: 'pages/MinePage' });
        }, 1000);
      } else {
        // 密码错误
        this.message = '密码错误，请重试';
        promptAction.showToast({ message: '密码错误' });
      }
    }
  }
}