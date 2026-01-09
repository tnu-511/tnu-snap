#import <UIKit/UIKit.h>

%hook UIWindow

- (void)makeKeyAndVisible {
    %orig;

    // التأكد من دعم iOS 13 وما فوق واستخدام اسم متغير صحيح (scene)
    if (@available(iOS 13.0, *)) {
        UIWindowScene *scene = self.windowScene;
        if (scene) {
            NSLog(@"[Talal Falcon] الأداة تعمل بنجاح مع المشهد الحالي.");
        }
    }
}

%end

// إضافة تنبيه بسيط يظهر عند فتح أي تطبيق للتأكد من عمل الأداة
%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Talal Falcon" 
                                                                       message:@"مبروك يا طلال، الأداة اشتغلت!" 
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"تم" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    });
}

%end
