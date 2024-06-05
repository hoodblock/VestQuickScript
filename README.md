# VestQuickScript
MARK: - OC版本的马甲包快速制作脚本

# 脚本配置
```JSON
{
    "rootPath": "/Users/Admin/Desktop/Product/Product",
    "productPath": "/Users/Admin/Desktop/Product/Product/Product",
    "isChangeAssets": true,
    "modifyProjectName": {
        "isOperate": false,
        "config": {
            "source": "",
            "target": ""
        }
    },
    "modifyPropertyName": {
        "isOperate": true,
        "config": {
            "source": "",
            "target": "",
        }
    },
    "modifyAPIName": {
        "isOperate": false,
        "config": {
            "source": "",
            "target": "",
        }
    },
    "modifyClassName": {
        "isOperate": true,
        "config": {
            "source": "",
            "target": "V_608"
        }
    },
    "spamCode": {
        "isOperate": true,
        "config": {
            "folder": "TestCode",
            "classParameterName": "Parame",
            "categoryParameterName":"Parame",
            "methodParameterName": "Method",
            "propertyParameterName": "Property",
            "lasterClassParameterName": "LasterClass",
        }
    },
    "deleteContent": {
        "isOperate": false,
        "config": {
            "isComment": false,
            "isSpace": false
        }
    },
    "ignoreNames": {
        "isOperate": true,
        "config": {
            "folders": ["Pods", "Frameworks", "StaticScript"],
            "files": ["AppDelegate", "main", "SceneDelegate"]
        }
    },
}

```
# 项目引用

```Java
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.


        // 启用马甲配置
        StaticScriptConfig *scriptConfig = [[StaticScriptConfig alloc] init];
        [scriptConfig startScript:argc argv:argv[0]];
        
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
```

# 已实现功能

1: 修改文件类 - 前缀
```Swift
- (void)modifyClassName:(NSMutableString *)projectContent sourceCodeDirectory:(NSString *)sourceCodeDirectory { ... }
```
2: 修改图片资源和图片引用
```Swift
- (void)modifyAssets:(NSString *)filePath { ... }
```
3: 修改属性名
```Swift
- (void)modifyPropertyName:(NSString *)filePath { ... }
```
4: 插入无用代码（生成扩展类和无用类）
```Swift
- (void)generateSpamCode:(NSString *)codePath filePath:(NSString *)filePath categroyImportString:(NSMutableString *)categroyImportString categroyFuncString:(NSMutableString *)categroyFuncString newImportString:(NSMutableString*)newImportString newFuncString:(NSMutableString *)newFuncString { ... }
```


# 待实现功能

1: 修改项目文件名
2: 修改接口API名
3: 在接口API中加入无用的代码块

