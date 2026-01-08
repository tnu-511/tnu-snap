#import <UIKit/UIKit.h>

%hook SpringBoard

// هذا الكود يعمل عند اكتمال تشغيل واجهة النظام (SpringBoard)
- (void)applicationDidFinishLaunching:(id)application {
    %orig; // تنفيذ الأمر الأصلي للنظام أولاً

    // إنشاء رسالة تنبيه تظهر على الشاشة
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Talal Falcon"
                                message:@"أهلاً بك يا طلال! الأداة تعمل بنجاح ✅"
                                preferredStyle:UIAlertControllerStyleAlert];

    // إضافة زر "شكراً" لإغلاق الرسالة
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"شكراً"
                                           style:UIAlertActionStyleDefault
                                           handler:nil];

    [alert addAction:okAction];

    // إظهار الرسالة فوق كل شيء في الشاشة
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

%end