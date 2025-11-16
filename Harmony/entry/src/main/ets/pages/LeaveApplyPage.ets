import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct LeaveApplyPage {
  @State startDate: string = '2024-01-01';
  @State endDate: string = '2024-01-01';
  @State reason: string = '';

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Button('返回')
          .onClick(() => {
            router.back();
          })
        Text('请假申请')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding(10)
      .backgroundColor(Color.White)

      Column({ space: 20 }) {
        // 开始日期
        Column() {
          Text('开始日期')
          DatePicker({
            start: new Date('2024-01-01'),
            end: new Date('2024-12-31'),
            selected: new Date(this.startDate)
          })
            .onChange((value: DatePickerResult) => {
              this.startDate = `${value.year}-${value.month + 1}-${value.day}`;
            })
        }

        // 结束日期
        Column() {
          Text('结束日期')
          DatePicker({
            start: new Date('2025-01-01'),
            end: new Date('2025-12-31'),
            selected: new Date(this.endDate)
          })
            .onChange((value: DatePickerResult) => {
              this.endDate = `${value.year}-${value.month + 1}-${value.day}`;
            })
        }

        // 请假理由
        Column() {
          Text('请假理由')
          TextInput({ placeholder: '请输入请假理由', text: this.reason })
            .onChange((value: string) => {
              this.reason = value;
            })
        }

        // 提交按钮
        Button('提交')
          .onClick(() => {
            if (this.reason) {
              promptAction.showToast({ message: '提交成功' });
              router.back();
            } else {
              promptAction.showToast({ message: '请输入请假理由' });
            }
          })
      }
      .width('100%')
      .padding(20)
    }
    .width('100%')
    .height('100%')
  }
}