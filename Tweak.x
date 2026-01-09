#import <UIKit/UIKit.h>

%hook UIWindow
- (void)makeKeyAndVisible {
    %orig;
    if (@available(iOS 13.0, *)) {
        UIWindowScene *scene = self.windowScene;
        if (scene) {
            NSLog(@"[Talal Falcon] الأداة تعمل بنجاح");
        }
    }
}
%end

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application {
    %orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{

        UIWindow *window = nil;

        if (@available(iOS 13.0, *)) {
            for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    for (UIWindow *w in scene.windows) {
                        if (w.isKeyWindow) {
                            window = w;
                            break;
                        }
                    }
                }
                if (window) break;
            }
        } else {
            window = [UIApplication sharedApplication].keyWindow;
        }

        if (window && window.rootViewController) {
            UIAlertController *alert =
            [UIAlertController alertControllerWithTitle:@"Talal Falcon"
                                                message:@"مبروك يا طلال، اشتغلت الأداة!"
                                         preferredStyle:UIAlertControllerStyleAlert];

            [alert addAction:
             [UIAlertAction actionWithTitle:@"كفو"
                                      style:UIAlertActionStyleDefault
                                    handler:nil]];

            [window.rootViewController presentViewController:alert
                                                    animated:YES
                                                  completion:nil];
        }
    });
}
%end
