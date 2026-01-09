#import <UIKit/UIKit.h>

%hook UIWindow
- (void)makeKeyAndVisible {
    %orig;
    
    if (@available(iOS 13.0, *)) {
        // لاحظ هنا: الـ w صغيره والـ S كبيرة.. كذا النظام يبيها
        UIWindowScene *scene = self.windowScene; 
        if (scene) {
            NSLog(@"[Talal] Success");
        }
    }
}
%end

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // هنا الـ k صغيرة والـ W كبيرة
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (window) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Talal Falcon" 
                message:@"تم حل مشكلة الحروف!" 
                preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"كفو" style:UIAlertActionStyleDefault handler:nil]];
            [window.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    });
}
%end
