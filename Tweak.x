#import <UIKit/UIKit.h>

%hook UIWindow
- (void)makeKeyAndVisible {
    %orig;
    if (@available(iOS 13.0, *)) {
        // الحروف هنا موزونة: s صغيرة في البداية و W و S في windowScene
        UIWindowScene *scene = self.windowScene; 
        if (scene) {
            NSLog(@"[Talal Falcon] Done");
        }
    }
}
%end

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // تعريف الـ window بحروف صحيحة
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (window) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Talal Falcon" 
                message:@"تم حل مشكلة الحروف والأداة جاهزة!" 
                preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"كفو" style:UIAlertActionStyleDefault handler:nil]];
            [window.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    });
}
%end
