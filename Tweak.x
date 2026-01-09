#import <UIKit/UIKit.h>

%hook UIWindow
- (void)makeKeyAndVisible {
    %orig;
    if (@available(iOS 13.0, *)) {
        // تم تصحيح الكتابة لـ scene وتفادي خطأ undeclared identifier
        UIWindowScene *scene = self.windowScene; 
        if (scene) {
            NSLog(@"[Talal Falcon] الأداة تعمل");
        }
    }
}
%end

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // تعريف الـ window بشكل صحيح لظهور التنبيه
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (window) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Talal Falcon" 
                message:@"مبروك يا طلال، اشتغلت الأداة!" 
                preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"كفو" style:UIAlertActionStyleDefault handler:nil]];
            [window.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    });
}
%end
