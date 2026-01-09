#import <UIKit/UIKit.h>

%hook UIWindow

- (void)makeKeyAndVisible {
    %orig;

    // استخدام الحروف الصغيرة (scene) والتحقق من الإصدار
    if (@available(iOS 13.0, *)) {
        UIWindowScene *scene = self.windowScene;
        if (scene) {
            NSLog(@"[Talal Falcon] الأداة تعمل بنجاح.");
        }
    }
}

%end

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // تعريف الـ window بشكل صحيح لتجنب خطأ undeclared identifier
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        if (window) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Talal Falcon" 
                                                                           message:@"مبروك يا طلال، الأداة اشتغلت!" 
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"تم" style:UIAlertActionStyleDefault handler:nil]];
            [window.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    });
}

%end
