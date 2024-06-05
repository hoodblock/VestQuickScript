//
//  StaticScriptConfig.h
//  V606_LAST
//
//  Created by V606 on 2024/5/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


// 命令行修改工程目录下所有 png 资源 hash 值
// 使用 ImageMagick 进行图片压缩，所以需要安装 ImageMagick，安装方法 brew install imagemagick
// find . -iname "*.png" -exec echo {} \; -exec convert {} {} \;
// or
// find . -iname "*.png" -exec echo {} \; -exec convert {} -quality 95 {} \;

/// 脚本处理流程
///
/// -   argv： 获取main函数入口的app文件程序，可以得知app项目名称 例如： /Users/tt/Library/Developer/CoreSimulator/Devices/6304FE49-0FAB-43F1-AA52-E27D1EF4AF93/data/Containers/Bundle/Application/F9EEC81E-525D-4922-A64C-AE3A20858451/V606_LAST.app/V606_LAST
/// -   StaticScriptConfig.geojson -- 脚本配置方案
///
/// -   Parameters:
///    -    rootPath: 项目根目录 - 是包括Podfile & .xcodeproj & .xcworkspace 的上一层文件夹的项目路径 例如：/Users/Thomas/Desktop/V606/V606
///
/// -   Parameters:
///    -    handleXcassets: 处理资源图片 - 图片资源
///
/// -   Parameters:
///    -    modifyProjectName: 修改项目名称 - 将source前缀改成target前缀，如果没有source前缀，则自动新增成target前缀, 或者随机生成一个前缀
///
/// -   Parameters:
///    -    modifyClassName: 修改文件名称 - 将source前缀改成target前缀，如果没有source前缀，则自动新增成target前缀, 或者随机生成一个前缀
///
/// -   Parameters:
///    -    modifyAPIName: 修改API名称 - 将source前缀改成target前缀，如果没有source前缀，则自动新增成target前缀, 或者随机生成一个前缀
///
/// -   Parameters:
///    -    modifyPropertyName: 修改属性名称 - 将source前缀改成target前缀，如果没有source前缀，则自动新增成target前缀, 或者随机生成一个前缀
///
/// -   Parameters:
///    -    ignoreNames: 忽略某些文件夹或者字段 - [folders] 忽略的文件夹 [files] 忽略的文件
///
/// -   Parameters:
///    -    spamCode: 插入垃圾代码
///
/// -   Parameters:
///    -    deleteContent: 删除空格和换行等
///
///

@interface StaticScriptItemModel : NSObject
@property (assign, nonatomic) BOOL isOperate;
@property (strong, nonatomic) NSString *source;
@property (strong, nonatomic) NSString *target;
@end

@interface StaticScriptIgnoreItemModel : StaticScriptItemModel
@property (strong, nonatomic) NSArray<NSString *> *folders;
@property (strong, nonatomic) NSArray<NSString *> *files;
@end

@interface StaticScriptSpamItemModel : StaticScriptItemModel
@property (strong, nonatomic) NSString *folder;
@property (strong, nonatomic) NSString *classParameterName;
@property (strong, nonatomic) NSString *categoryParameterName;
@property (strong, nonatomic) NSString *methodParameterName;
@property (strong, nonatomic) NSString *propertyParameterName;
@property (strong, nonatomic) NSString *lasterClassParameterName;
@end

@interface StaticScriptDeleteItemModel : StaticScriptItemModel
@property (assign, nonatomic) BOOL isComment;
@property (assign, nonatomic) BOOL isSpace;
@end

@interface StaticScriptModel : NSObject
@property (strong, nonatomic) NSString *rootPath;
@property (strong, nonatomic) NSString *productPath;
@property (assign, nonatomic) BOOL isChangeAssets;
@property (strong, nonatomic) StaticScriptItemModel *modifyProjectName;
@property (strong, nonatomic) StaticScriptItemModel *modifyClassName;
@property (strong, nonatomic) StaticScriptItemModel *modifyAPIName;
@property (strong, nonatomic) StaticScriptItemModel *modifyPropertyName;
@property (strong, nonatomic) StaticScriptIgnoreItemModel *ignoreNames;
@property (strong, nonatomic) StaticScriptSpamItemModel *spamCode;
@property (strong, nonatomic) StaticScriptDeleteItemModel *deleteContent;
@end

@interface StaticScriptConfig : NSObject

- (void)startScript:(int)argc argv:(char *)argv;

@end

NS_ASSUME_NONNULL_END

