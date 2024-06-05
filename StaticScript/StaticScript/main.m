//
//  main.m
//  StaticScript
//
//  Created by V606 on 2024/6/4.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "StaticScriptConfig.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        
        StaticScriptConfig *scriptConfig = [[StaticScriptConfig alloc] init];
        [scriptConfig startScript:argc argv:argv[0]];
        
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
