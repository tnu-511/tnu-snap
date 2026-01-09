#import <UIKit/UIKit.h>

%hook UIWindow

- (void)makeKeyAndVisible {
    %orig;

    // إصلاح الخطأ: التأكد من كتابة scene بحروف صغيرة وتعريفها بشكل صحيح
    if (@available(iOS 13.0, *)) {
        UIWindowScene *scene = self.windowScene;
        if (scene) {
            // هنا يمكنك إضافة الأكواد الخاصة بك التي تعتمد على الـ scene
            NSLog(@"Talal Falcon: Scene is active");
        }
    }
}

%end

// مثال لإضافة زر أو تنبيه عند تشغيل التطبيق
%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    // إشعار بسيط للتأكد أن الأداة تعمل
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Talal Falcon" 
                                                                       message:@"الأداة تعمل بنجاح يا بطل!" 
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"تم" style:UIAlertActionStyleDefault handler:nil]];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    });
}

%end
