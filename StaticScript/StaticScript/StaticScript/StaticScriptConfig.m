//
//  StaticScriptConfig.m
//  V606_LAST
//
//  Created by V606 on 2024/5/31.
//

#import "StaticScriptConfig.h"
#include <stdlib.h>

static NSString * STATIC_CREATE_IMAGE_DEFAULT_FREFIX = @"";


static NSString *const STATIC_CREATE_CATEGROY_CLASS_H_TEMPLATE = @"\
//\n\
//  %@\n\
//  %@\n\
//\n\
//  Created by %@ on Code.\n\
//\n\
\n\
%@\n\
\n\
@interface %@ (%@)\n\
\n\
%@\n\
\n\
@end\n";
static NSString *const STATIC_CREATE_CATEGROY_CLASS_M_TEMPLATE = @"\
//\n\
//  %@\n\
//  %@\n\
//\n\
//  Created by %@ on Code.\n\
//\n\
\n\
#import \"%@+%@.h\"\n\
\n\
\n\
@implementation %@ (%@)\n\
\n\
%@\n\
\n\
@end\n";
static NSString *const STATIC_CREATE_CLASS_H_TEMPLATE = @"\
//\n\
//  %@\n\
//  %@\n\
//\n\
//  Created by %@ on Code.\n\
//\n\
\n\
\n\
#import <Foundation/Foundation.h>\n\
\n\
@interface %@: NSObject\n\
\n\
%@\n\
\n\
@end\n";
static NSString *const STATIC_CREATE_CLASS_M_TEMPLATE = @"\
//\n\
//  %@\n\
//  %@\n\
//\n\
//  Created by %@ on Code.\n\
//\n\
\n\
\n\
#import \"%@.h\"\n\
\n\
@implementation %@\n\
\n\
%@\n\
\n\
@end\n";


typedef void(^FindFileBlock)(NSString *filePath);

@implementation StaticScriptItemModel

@end

@implementation StaticScriptIgnoreItemModel

@end

@implementation StaticScriptSpamItemModel

@end

@implementation StaticScriptDeleteItemModel

@end


@implementation StaticScriptModel

- (StaticScriptItemModel *)modifyProjectName {
    if (!_modifyProjectName) {
        _modifyProjectName = [[StaticScriptItemModel alloc] init];
    }
    return _modifyProjectName;
}

- (StaticScriptItemModel *)modifyClassName {
    if (!_modifyClassName) {
        _modifyClassName = [[StaticScriptItemModel alloc] init];
    }
    return _modifyClassName;
}

- (StaticScriptItemModel *)modifyAPIName {
    if (!_modifyAPIName) {
        _modifyAPIName = [[StaticScriptItemModel alloc] init];
    }
    return _modifyAPIName;
}

- (StaticScriptItemModel *)modifyPropertyName {
    if (!_modifyPropertyName) {
        _modifyPropertyName = [[StaticScriptItemModel alloc] init];
    }
    return _modifyPropertyName;
}

- (StaticScriptIgnoreItemModel *)ignoreNames {
    if (!_ignoreNames) {
        _ignoreNames = [[StaticScriptIgnoreItemModel alloc] init];
    }
    return _ignoreNames;
}

- (StaticScriptSpamItemModel *)spamCode {
    if (!_spamCode) {
        _spamCode = [[StaticScriptSpamItemModel alloc] init];
    }
    return _spamCode;
}

- (StaticScriptDeleteItemModel *)deleteContent {
    if (!_deleteContent) {
        _deleteContent = [[StaticScriptDeleteItemModel alloc] init];
    }
    return _deleteContent;
}

@end


static const NSString * RANDOM_ALPHABET = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

static const NSArray<NSString *> * RANDOM_ALPHABET_WORD = @[@"abandon", @"ability", @"able", @"abnormal", @"aboard", @"about", @"above", @"abroad", @"absence", @"absent", @"absolute", @"absolutely", @"absorb", @"baby", @"back", @"background", @"backward", @"bacteria", @"bad", @"badly", @"badminton", @"bag", @"baggage", @"bake", @"balance", @"ball", @"balloon", @"banana", @"band", @"bank", @"banner", @"bargain", @"barrier", @"cabbage", @"cabin", @"cabinet", @"cable", @"cafe", @"cafeteria", @"cage", @"cake",@"calculate", @"calculation", @"camera", @"campus", @"Canada", @"cancer", @"candle", @"cannon", @"canteen", @"capacity", @"daily", @"dairy", @"dam", @"damage", @"damp", @"dance", @"danger", @"dangerous", @"dare", @"daring", @"dark", @"darling", @"daughter", @"dawn", @"day", @"dead", @"deal", @"debate", @"decade", @"decay", @"decent", @"deed", @"deepen", @"defect",@"democracy", @"department", @"each", @"eager", @"eagle", @"ear", @"early", @"earn", @"earnest", @"earth", @"earthquake", @"ease", @"easily", @"eastern", @"echo", @"economical", @"economy", @"eighth", @"eight", @"elaborate", @"election", @"electronics", @"electron", @"elementary", @"elevator", @"elsewhere", @"embarrass", @"emerge", @"fable", @"face", @"fact", @"factory", @"fade", @"fairly", @"faithful", @"famous", @"fancy", @"fashionable", @"fasten", @"fight", @"find", @"fabric", @"facility", @"factor", @"faculty", @"failure", @"finding", @"fireman",@"fisherman", @"flag", @"flat", @"flower", @"follow", @"foolish"];


@interface StaticScriptConfig ()
@property (strong, nonatomic) StaticScriptModel *configModel;
@end

@implementation StaticScriptConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

# pragma mark - 开始脚本

// 如果真机跑代码，脚本要放在真迹里面哈
- (void)startScript:(int)argc argv:(char *)argv {
    NSLog(@"_________【 StaticScriptConfig 】_________【 argv[0] =  %c 】", argv[0]);
    BOOL isDirectory = NO;
    if (self.configModel.rootPath.length == 0) {
        NSLog(@"_________【 StaticScriptConfig 】_________【 配置文件 】_________【 缺少根目录路径 】");
        return;
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.configModel.rootPath isDirectory:&isDirectory]) {
        NSLog(@"_________【 StaticScriptConfig 】_________【 配置文件 】_________【 不存在根目录路径 rootPath = %@ 】", self.configModel.rootPath);
        return;
    }
    
    // 修改 图片资源
    if (self.configModel.isChangeAssets) {
        NSLog(@"_________【 StaticScriptConfig 】_________【 开始修改 】_________【 图片资源 】");
        [self modifyAssets:self.configModel.rootPath];
        NSLog(@"_________【 StaticScriptConfig 】_________【 修改图片资源完成 】");
    }
    
    
    // 修改 项目名称
        
        
    // 修改 API 前缀
    if (self.configModel.modifyAPIName.isOperate) {
        NSLog(@"_________【 StaticScriptConfig 】_________【 开始修改 】_________【 API前缀 】");
        [self modifyPropertyName:self.configModel.rootPath];
        NSLog(@"_________【 StaticScriptConfig 】_________【 修改API前缀完成 】");
    }
    
    // 修改 属性前缀
    if (self.configModel.modifyPropertyName.isOperate) {
        NSLog(@"_________【 StaticScriptConfig 】_________【 开始修改 】_________【 属性前缀 】");
        [self modifyPropertyName:self.configModel.rootPath];
        NSLog(@"_________【 StaticScriptConfig 】_________【 修改属性前缀完成 】");
    }
    
    // 修改 类 前缀
    if (self.configModel.modifyClassName.isOperate) {
        NSLog(@"_________【 StaticScriptConfig 】_________【 开始修改 】_________【 类前缀 】");
        NSMutableString *projectContent = [NSMutableString string];
        NSString *projectFilePath = @"";
        NSArray<NSString *> *files = [self getPathFiles: self.configModel.rootPath];
        for (NSString *itemFilePath in files) {
            if ([itemFilePath containsString:@"xcodeproj"]) {
                projectFilePath = [[self.configModel.rootPath stringByAppendingPathComponent:itemFilePath] stringByAppendingPathComponent: @"project.pbxproj"];
                if (![[NSFileManager defaultManager] fileExistsAtPath:projectFilePath isDirectory:&isDirectory] || isDirectory) {
                    NSLog(@"_________【 StaticScriptConfig 】_________【 修改类名配置参数错误 】_________【 不是根目录 rootPath = %@ 】", self.configModel.rootPath);
                    break;
                }
            }
        }
        NSError *error = nil;
        projectContent = [NSMutableString stringWithContentsOfFile:projectFilePath encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"_________【 StaticScriptConfig 】_________【 读取文件内容失败 】_________【 不是根目录 rootPath = %@ 】", self.configModel.rootPath);
        }
        [self modifyClassName:projectContent sourceCodeDirectory:self.configModel.rootPath];
        [projectContent writeToFile:projectFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"_________【 StaticScriptConfig 】_________【 修改类前缀完成 】");
    }
    
    // 插入无用的代码
    if (self.configModel.spamCode.isOperate) {
        NSLog(@"_________【 StaticScriptConfig 】_________【 开始修改 】_________【 插入垃圾代码 】");
        NSString *outCodeDirectory = [self.configModel.productPath stringByAppendingPathComponent:self.configModel.spamCode.folder];
        // 是否有定义输出垃圾代码的文件
        if (self.configModel.spamCode.folder.length > 0) {
            if ([[NSFileManager defaultManager] fileExistsAtPath:self.configModel.spamCode.folder isDirectory:&isDirectory]) {
                if (!isDirectory) {
                    NSLog(@"_________【 StaticScriptConfig 】_________【 插入垃圾代码 】_________【 已存在文件夹，但文件夹并不是目录 】_________【 folder = %@ 】", self.configModel.spamCode.folder);
                    return;
                }
            } else {
                // 创建文件夹
                NSError *error = nil;
                if (![[NSFileManager defaultManager] createDirectoryAtPath:outCodeDirectory withIntermediateDirectories:YES attributes:nil error:&error]) {
                    NSLog(@"_________【 StaticScriptConfig 】_________【 插入垃圾代码 】_________【 创建目录失败 】_________【 folder = %@ 】", outCodeDirectory);
                    return;
                }
            }
        } else {
            // 指定生成在项目文件夹根目录
            outCodeDirectory = self.configModel.productPath;
        }
        NSMutableString *categroyImportString = [NSMutableString string];
        NSMutableString *categroyFuncString = [NSMutableString string];
        NSMutableString *newImportString = [NSMutableString string];
        NSMutableString *newFuncString = [NSMutableString string];
        [self spamCodeRecursiveDirectory:self.configModel.productPath ocFilePath:^(NSString *filePath) {
            [self generateSpamCode:outCodeDirectory filePath:filePath categroyImportString:categroyImportString categroyFuncString:categroyFuncString newImportString:newImportString newFuncString:newFuncString];
        } swiftFileBlock:^(NSString *filePath) {
            // swift 文件处理

        }];
        NSString *fileName = [self.configModel.spamCode.classParameterName stringByAppendingString:@"CallHeader.h"];
        NSString *fileContent = [NSString stringWithFormat:@"%@\n%@return ret;\n}", categroyImportString, categroyFuncString];
        [fileContent writeToFile:[outCodeDirectory stringByAppendingPathComponent:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];

        fileContent = [NSString stringWithFormat:@"%@\n%@return ret;\n}", newImportString, newFuncString];
        [fileContent writeToFile:[outCodeDirectory stringByAppendingPathComponent:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"_________【 StaticScriptConfig 】_________【 修改 插入垃圾代码 完成 】");
    }
    
    // 删除空格
    
}

# pragma mark - 公共方法

// 重新命名文件
- (BOOL)renameFile:(NSString *)source target:(NSString *)target {
    NSError *error;
    [[NSFileManager defaultManager] moveItemAtPath:source toPath:target error:&error];
    if (error) {
        NSLog(@"_________【 StaticScriptConfig 】_________【 renameFile 】_________【 source = %@ 】_________【 target = %@ 】_________【 error = %@ 】", source, target, error);
        return NO;
    }
    return YES;
}

// 遍历所有文件， 替换字符串
- (BOOL)renameStringInFile:(NSString *)filePath source:(NSString *)source target:(NSString *)target {
    BOOL isDirectory = NO;
    NSArray<NSString *> *files = [self getPathFiles: filePath];
    for (NSString *itemFileName in files) {
        NSString *itemFilePath = [filePath stringByAppendingPathComponent: itemFileName];
        if ([[NSFileManager defaultManager] fileExistsAtPath:itemFilePath isDirectory:&isDirectory] && isDirectory) {
            [self renameStringInFile:itemFilePath source:source target:target];
            continue;
        }
        if ([itemFilePath.pathExtension isEqualToString:@"m"] || [itemFilePath.pathExtension isEqualToString:@"h"]) {
            NSError *error = nil;
            NSString *fileContent = [NSString stringWithContentsOfFile:itemFilePath encoding:NSUTF8StringEncoding error:&error];
            if (error) {
                NSLog(@"_________【 StaticScriptConfig 】_________【 renameStringInFile 】_________【 source = %@ 】_________【 target = %@ 】_________【 error_0 = %@ 】", source, target, error);
            }
            if ([fileContent containsString:target]) {
                NSLog(@"_________【 StaticScriptConfig 】_________【 renameStringInFile 】_________【 source = %@ 】_________【 target = %@ 】_________【 包含目标字符串，不做处理 】", source, target);
            } else {
                NSString *newFileContent = [fileContent stringByReplacingOccurrencesOfString:source withString:target];
                error = nil;
                [newFileContent writeToFile:itemFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
                if (error) {
                    NSLog(@"_________【 StaticScriptConfig 】_________【 renameStringInFile 】_________【 source = %@ 】_________【 target = %@ 】_________【 error_1 = %@ 】", source, target, error);
                }
            }
        }
    }
    return YES;
}

// 获取某一层文件夹的所有文件
- (NSArray<NSString *> *)getPathFiles:(NSString *)filePath {
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:nil];
}

// 随机单词, 两个，符合驼峰的形式 例如：goHome
- (NSString *)randomString {
    NSUInteger randomIndex_0 = arc4random_uniform((unsigned int)[RANDOM_ALPHABET_WORD count]);
    NSString *randomWord_0 = RANDOM_ALPHABET_WORD[randomIndex_0];
    randomWord_0 = [randomWord_0 stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[randomWord_0 substringToIndex:1] lowercaseString]];
    NSUInteger randomIndex_1 = arc4random_uniform((unsigned int)[RANDOM_ALPHABET_WORD count]);
    NSString *randomWord_1 = RANDOM_ALPHABET_WORD[randomIndex_1];
    randomWord_1 = [randomWord_1 stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[randomWord_1 substringToIndex:1] uppercaseString]];
    return [NSString stringWithFormat:@"%@%@", randomWord_0, randomWord_1];
}

// 随机一个字符
- (NSString *)randomLetter {
    return [NSString stringWithFormat:@"%C", [RANDOM_ALPHABET characterAtIndex:arc4random_uniform(52)]];
}

// 修改文件内容
- (BOOL)regularReplacement:(NSString *)regularExpression source:(NSMutableString *)sourceString target:(NSString *)targetString {
    __block BOOL isChanged = NO;
    BOOL isGroupNo1 = [targetString isEqualToString:@"\\1"];
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regularExpression options:NSRegularExpressionAnchorsMatchLines|NSRegularExpressionUseUnixLineSeparators error:nil];
    NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:sourceString options:0 range:NSMakeRange(0, sourceString.length)];
    [matches enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!isChanged) {
            isChanged = YES;
        }
        if (isGroupNo1) {
            NSString *withString = [sourceString substringWithRange:[obj rangeAtIndex:1]];
            [sourceString replaceCharactersInRange:obj.range withString:withString];
        } else {
            [sourceString replaceCharactersInRange:obj.range withString:targetString];
        }
    }];
    return isChanged;
}

// 更新字符串 - 第一个字母小写或者大写
- (NSString *)caseStringForFirstCharacters:(BOOL)isLowercase source:(NSString *)source {
    if (isLowercase) {
        return [source stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[source substringToIndex:1] lowercaseString]];
    } else {
        return [source stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[source substringToIndex:1] uppercaseString]];
    }
}

# pragma mark - 修改 图片 资源

- (void)modifyAssets:(NSString *)filePath {
    BOOL isDirectory = NO;
    NSArray<NSString *> *files = [self getPathFiles: filePath];
    for (NSString *itemFileName in files) {
        if ([self ignoreNames:itemFileName]) {
            continue;
        }
        NSString *itemFilePath = [filePath stringByAppendingPathComponent: itemFileName];
        if ([[NSFileManager defaultManager] fileExistsAtPath:itemFilePath isDirectory:&isDirectory] && isDirectory) {
            [self modifyAssets:itemFilePath];
            continue;
        }
        if (![itemFileName isEqualToString:@"Contents.json"]) {
            continue;
        }
        NSString *contentsDirectoryName = itemFilePath.stringByDeletingLastPathComponent.lastPathComponent;
        if (![contentsDirectoryName hasSuffix:@".imageset"]) {
            continue;
        }
        NSString *itemFileContent = [NSString stringWithContentsOfFile:itemFilePath encoding:NSUTF8StringEncoding error:nil];
        if (!itemFileContent) {
            continue;
        }
        // 先改image内部的“Contents”
        NSMutableArray<NSString *> *processedImageFileNameArray = @[].mutableCopy;
        static NSString * const regexString = @"\"filename\" *: *\"(.*)?\"";
        NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionUseUnicodeWordBoundaries error:nil];
        NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:itemFileContent options:0 range:NSMakeRange(0, itemFileContent.length)];
        while (matches.count > 0) {
            NSInteger index = 0;
            NSString *itemImageFileName = nil;
            do {
                if (index >= matches.count) {
                    index = -1;
                    break;
                }
                itemImageFileName = [itemFileContent substringWithRange:[matches[index] rangeAtIndex:1]];
                index++;
            } while ([processedImageFileNameArray containsObject:itemImageFileName]);
            if (index < 0) {
                break;
            }
            NSString *itemImageFilePath = [itemFilePath.stringByDeletingLastPathComponent stringByAppendingPathComponent:itemImageFileName];
            if ([[NSFileManager defaultManager] fileExistsAtPath:itemImageFilePath]) {
                NSString *newItemImageFileName = [[self randomString] stringByAppendingPathExtension:itemImageFileName.pathExtension];
                NSString *newItemImageFilePath = [itemFilePath.stringByDeletingLastPathComponent stringByAppendingPathComponent:newItemImageFileName];
                while ([[NSFileManager defaultManager] fileExistsAtPath:newItemImageFileName]) {
                    newItemImageFileName = [[self randomString] stringByAppendingPathExtension:itemImageFileName.pathExtension];
                    newItemImageFilePath = [itemFilePath.stringByDeletingLastPathComponent stringByAppendingPathComponent:newItemImageFileName];
                }
                NSLog(@"_________【 StaticScriptConfig 】_________【 modifyAssets 】_________【 dictorey = %@ 】_________【 source = %@ 】_________【 target = %@ 】_________【 filePath = %@ 】", contentsDirectoryName, itemImageFileName,newItemImageFileName, filePath);
                if (![self renameFile:itemImageFilePath target:newItemImageFilePath]) {
                    return;
                }
                itemFileContent = [itemFileContent stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"\"%@\"", itemImageFileName] withString:[NSString stringWithFormat:@"\"%@\"", newItemImageFileName]];
                [itemFileContent writeToFile:itemFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                [processedImageFileNameArray addObject:newItemImageFileName];
            } else {
                [processedImageFileNameArray addObject:itemImageFileName];
            }
            matches = [expression matchesInString:itemFileContent options:0 range:NSMakeRange(0, itemFileContent.length)];
        }
        // 替换图片文件名,把项目中的图片字符串
        NSString *newContentsDirectoryName = @"";
        if ([contentsDirectoryName containsString:@"country_image_"] || [contentsDirectoryName containsString:@"city_icon_"] || [contentsDirectoryName containsString:@"ip_icon_"] || [contentsDirectoryName containsString:@"port_icon_"]) {
            if (STATIC_CREATE_IMAGE_DEFAULT_FREFIX.length == 0 ) {
                if (arc4random() % 4 == 0) {
                    STATIC_CREATE_IMAGE_DEFAULT_FREFIX = @"city_icon_";
                } else if (arc4random() % 4 == 1) {
                    STATIC_CREATE_IMAGE_DEFAULT_FREFIX = @"ip_icon_";
                } else if (arc4random() % 4 == 2) {
                    STATIC_CREATE_IMAGE_DEFAULT_FREFIX = @"port_icon_";
                } else if (arc4random() % 4 == 3) {
                    STATIC_CREATE_IMAGE_DEFAULT_FREFIX = @"country_icon_";
                }
            }
            newContentsDirectoryName = [contentsDirectoryName stringByReplacingOccurrencesOfString:@"country_image_" withString:STATIC_CREATE_IMAGE_DEFAULT_FREFIX];
        } else {
            newContentsDirectoryName = [[NSString stringWithFormat:@"%@_icon", [self randomString]] stringByAppendingPathExtension:contentsDirectoryName.pathExtension];
        }
        NSString *newFilePath = [filePath stringByReplacingOccurrencesOfString:contentsDirectoryName withString:newContentsDirectoryName];
        if ([self renameFile:filePath target:newFilePath]) {
            [self renameStringInFile:self.configModel.rootPath source:[contentsDirectoryName componentsSeparatedByString:@"."][0] target:[newContentsDirectoryName componentsSeparatedByString:@"."][0]];
        }
    }
}


# pragma mark - 修改 项目 名称

# pragma mark - 修改 API 前缀

# pragma mark - 修改 属性 前缀

// 正则表达式匹配属性
- (NSArray <NSString *> *)parseProperties:(NSString *)content {
    NSMutableArray<NSString *> *properties = [NSMutableArray array];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"@property\\s*\\(.*" options:0 error:nil];
    [regex enumerateMatchesInString:content options:0 range:NSMakeRange(0, content.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSString *matchedString = [content substringWithRange:result.range];
        [properties addObject:matchedString];
    }];
    return properties;
}

- (void)modifyPropertyName:(NSString *)filePath {
    BOOL isDirectory = NO;
    NSArray<NSString *> *files = [self getPathFiles: filePath];
    for (NSString *itemFileName in files) {
        if ([self ignoreNames:itemFileName]) {
            continue;
        }
        NSString *itemFilePath = [filePath stringByAppendingPathComponent: itemFileName];
        if ([[NSFileManager defaultManager] fileExistsAtPath:itemFilePath isDirectory:&isDirectory] && isDirectory) {
            [self modifyPropertyName:itemFilePath];
            continue;
        }
        NSString *itemFileName = itemFilePath.lastPathComponent;
        if ([itemFileName hasSuffix:@".h"] || [itemFileName hasSuffix:@".m"] || [itemFileName hasSuffix:@".swift"]) {
            NSError *error = nil;
            NSString *itemFileContent = [NSString stringWithContentsOfFile:itemFilePath encoding:NSUTF8StringEncoding error:&error];
            if (error) {
                NSLog(@"_________【 StaticScriptConfig 】_________【 modifyPropertyName 】_________【 filePath = %@ 】_________【 itemFileName = %@ 】", filePath, itemFileName);
            } else {
                // 解析属性名
                NSArray<NSString *> *properties = [self parseProperties:itemFileContent];
                for (NSString *property in properties) {
                    NSString *currentPropertyName = [property componentsSeparatedByString:@" "].lastObject;
                    if ([currentPropertyName containsString:@"*"]) {
                        currentPropertyName = [currentPropertyName stringByReplacingOccurrencesOfString:@"*" withString:@""];
                    }
                    if ([currentPropertyName containsString:@";"]) {
                        currentPropertyName = [currentPropertyName stringByReplacingOccurrencesOfString:@";" withString:@""];
                    }
                    NSString *newPropertyName = [currentPropertyName stringByAppendingString:[self caseStringForFirstCharacters:NO source:[self randomString]]];
                    // 替换属性名
                    itemFileContent = [itemFileContent stringByReplacingOccurrencesOfString:currentPropertyName withString:newPropertyName];
                    [itemFileContent writeToFile:itemFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
                    if (error) {
                        NSLog(@"_________【 StaticScriptConfig 】_________【 modifyPropertyName 】_________【 修改属性名，写入文件失败 】");
                    } else {
                        // 遍历所有文件
                        [self renameStringInFile:self.configModel.productPath source:currentPropertyName target:newPropertyName];
                    }
                }
            }
        }
    }
}


// 123456
// 123456qw


// 123456

# pragma mark - 修改 类 前缀

- (void)modifyClassName:(NSMutableString *)projectContent sourceCodeDirectory:(NSString *)sourceCodeDirectory {
    NSArray<NSString *> *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourceCodeDirectory error:nil];
    BOOL isDirectory = NO;
    for (NSString *itemFilePath in files) {
        if ([self ignoreNames:itemFilePath]) {
            continue;
        }
        NSString *itemPath = [sourceCodeDirectory stringByAppendingPathComponent:itemFilePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:itemPath isDirectory:&isDirectory] && isDirectory) {
            [self modifyClassName:projectContent sourceCodeDirectory:itemPath];
            continue;
        }
        NSString *itemFileName = itemFilePath.lastPathComponent.stringByDeletingPathExtension;
        NSString *newClassName = @"";
        if ([itemFileName hasPrefix:self.configModel.modifyClassName.source]) {
            // 普通文件
            newClassName = [self.configModel.modifyClassName.target stringByAppendingString:[itemFileName substringFromIndex:self.configModel.modifyClassName.source.length]];
        } else {
            // 分类文件
            NSString *oldNameCategray = [NSString stringWithFormat:@"+%@", self.configModel.modifyClassName.source];
            if ([itemFileName containsString:oldNameCategray]) {
                NSMutableString *itemFileCategrayName = [[NSMutableString alloc] initWithString:itemFileName];
                [itemFileCategrayName replaceCharactersInRange:[itemFileName rangeOfString:oldNameCategray] withString:[NSString stringWithFormat:@"+%@",self.configModel.modifyClassName.target]];
                newClassName = itemFileCategrayName;
            } else {
                newClassName = [self.configModel.modifyClassName.target stringByAppendingString:itemFileName];
            }
        }
        // 遍历.h文件，然后找对应的.m文件
        if ([itemFilePath.pathExtension isEqualToString:@"m"]) {
            continue;
        } else if ([itemFilePath.pathExtension isEqualToString:@"h"]) {
            NSString *itemFileName_m = [itemFileName stringByAppendingPathExtension:@"m"];
            if (![files containsObject:itemFileName_m]) {
                continue;
            }
            [self renameFile:[[sourceCodeDirectory stringByAppendingPathComponent:itemFileName] stringByAppendingPathExtension:@"h"] target:[[sourceCodeDirectory stringByAppendingPathComponent:newClassName] stringByAppendingPathExtension:@"h"]];
            [self renameFile:[[sourceCodeDirectory stringByAppendingPathComponent:itemFileName] stringByAppendingPathExtension:@"m"] target:[[sourceCodeDirectory stringByAppendingPathComponent:newClassName] stringByAppendingPathExtension:@"m"]];
            if ([[NSFileManager defaultManager] fileExistsAtPath:[[sourceCodeDirectory stringByAppendingPathComponent:itemFileName] stringByAppendingPathExtension:@"xib"]]) {
                [self renameFile:[[sourceCodeDirectory stringByAppendingPathComponent:itemFileName] stringByAppendingPathExtension:@"xib"] target:[[sourceCodeDirectory stringByAppendingPathComponent:newClassName] stringByAppendingPathExtension:@"xib"]];
            }
            [self modifyFilesClassName:sourceCodeDirectory sourceClassName:itemFileName targetClassName:newClassName];
        } else if ([itemFilePath.pathExtension isEqualToString:@"swift"]) {
            [self renameFile:[[sourceCodeDirectory stringByAppendingPathComponent:itemFileName] stringByAppendingPathExtension:@"swift"] target:[[sourceCodeDirectory stringByAppendingPathComponent:newClassName] stringByAppendingPathExtension:@"swift"]];
            if ([[NSFileManager defaultManager] fileExistsAtPath:[[sourceCodeDirectory stringByAppendingPathComponent:itemFileName] stringByAppendingPathExtension:@"xib"]]) {
                [self renameFile:[[sourceCodeDirectory stringByAppendingPathComponent:itemFileName] stringByAppendingPathExtension:@"xib"] target:[[sourceCodeDirectory stringByAppendingPathComponent:newClassName] stringByAppendingPathExtension:@"xib"]];
            }
            [self modifyFilesClassName:sourceCodeDirectory sourceClassName:itemFileName.stringByDeletingPathExtension targetClassName:newClassName];
        } else {
            continue;
        }
        // 修改工程文件中的文件名
        NSString *regularExpression = [NSString stringWithFormat:@"\\b%@\\b", itemFileName];
        [self regularReplacement:regularExpression source:projectContent target:newClassName];
    }
}

- (void)modifyFilesClassName:(NSString *)sourceCodeDirectory sourceClassName:(NSString *)sourceClassName targetClassName:(NSString *)targetClassName {
    // 遍历每一个文件，包括忽略的文件，修改指定内容
    NSArray<NSString *> *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourceCodeDirectory error:nil];
    BOOL isDirectory = NO;
    for (NSString *itemFilePath in files) {
        NSString *itemPath = [sourceCodeDirectory stringByAppendingPathComponent:itemFilePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:itemPath isDirectory:&isDirectory] && isDirectory) {
            [self modifyFilesClassName:itemPath sourceClassName:sourceClassName targetClassName:targetClassName];
            continue;
        }
        NSString *itemFileName = itemFilePath.lastPathComponent;
        if ([itemFileName hasSuffix:@".h"] || [itemFileName hasSuffix:@".m"] || [itemFileName hasSuffix:@".pch"] || [itemFileName hasSuffix:@".swift"] || [itemFileName hasSuffix:@".xib"] || [itemFileName hasSuffix:@".storyboard"]) {
            NSError *error = nil;
            NSMutableString *itemFileContent = [NSMutableString stringWithContentsOfFile:itemPath encoding:NSUTF8StringEncoding error:&error];
            if (error) {
                NSLog(@"_________【 StaticScriptConfig 】_________【 modifyFilesClassName_0 】_________【 dictorey = %@ 】_________【 source = %@ 】_________【 target = %@ 】_________【 filePath = %@ 】", sourceCodeDirectory, sourceClassName, targetClassName, itemPath);
            } else {
                NSString *regularExpression = [NSString stringWithFormat:@"\\b%@\\b", sourceClassName];
                [self regularReplacement:regularExpression source:itemFileContent target:targetClassName];
                error = nil;
                [itemFileContent writeToFile:itemPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
                if (error) {
                    NSLog(@"_________【 StaticScriptConfig 】_________【 modifyFilesClassName_1 】_________【 dictorey = %@ 】_________【 source = %@ 】_________【 target = %@ 】_________【 filePath = %@ 】", sourceCodeDirectory, sourceClassName, targetClassName, itemPath);
                }
            }
        }
    }
}


# pragma mark - 插入无用的代码

- (void)generateSpamCode:(NSString *)codePath filePath:(NSString *)filePath categroyImportString:(NSMutableString *)categroyImportString categroyFuncString:(NSMutableString *)categroyFuncString newImportString:(NSMutableString*)newImportString newFuncString:(NSMutableString *)newFuncString {
    NSString *fileContent_m = [NSString stringWithContentsOfFile:filePath encoding: NSUTF8StringEncoding error:nil];
    NSString *regexString = @" *@implementation +(\\w+)[^(]*\\n(?:.|\\n)+?@end";
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionUseUnicodeWordBoundaries error:nil];
    NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:fileContent_m options:0 range:NSMakeRange(0, fileContent_m.length)];
    if (matches.count <= 0) {
        return;
    }
    NSString *filePath_h = [filePath.stringByDeletingPathExtension stringByAppendingPathExtension:@"h"];
    NSString *fileContent_h = [NSString stringWithContentsOfFile:filePath_h encoding:NSUTF8StringEncoding error:nil];
    // 要引入的文件
    NSString *fileImportString = [self importCodeString:fileContent_h fileContent_m:fileContent_m];
    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull importResult, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *className = [fileContent_m substringWithRange:[importResult rangeAtIndex:1]];
        NSString *categoryName = @"";
        NSString *newClassName = [NSString stringWithFormat:@"%@%@%@", self.configModel.spamCode.classParameterName, className, [self caseStringForFirstCharacters:NO source:[self randomString]]];
        if (importResult.numberOfRanges >= 3) {
            categoryName = [fileContent_m substringWithRange:[importResult rangeAtIndex:2]];
        }
        //  如果该类型没有公开，只在 .m 文件中使用，则不处理
        NSString *regexString = [NSString stringWithFormat:@"\\b%@\\b", className];
        if ([fileContent_h rangeOfString:regexString options:NSRegularExpressionSearch].location == NSNotFound) {
            return;
        }
        // 查找
        NSString *implementation = [fileContent_m substringWithRange:importResult.range];
        NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"^ *([-+])[^)]+\\)([^;{]+)" options:NSRegularExpressionAnchorsMatchLines|NSRegularExpressionUseUnicodeWordBoundaries error:nil];
        NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:implementation options:0 range:NSMakeRange(0, implementation.length)];
        if (matches.count <= 0) {
            return;
        }
        // 新增类
        NSMutableString *hNewClassFileMethodsString = [NSMutableString string];
        NSMutableString *mNewClassFileMethodsString = [NSMutableString string];
        NSMutableString *hFileMethodsString = [NSMutableString string];
        NSMutableString *mFileMethodsString = [NSMutableString string];
        
        [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull matche, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *tempSymbol = @"+";
            if (arc4random() % 2 == 0) {
                tempSymbol = @"-";
            }
            NSString *methodName = [[implementation substringWithRange:[matche rangeAtIndex:2]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *newClassMethodName = nil;
            NSString *methodCallName = nil;
            NSString *newClassMethodCallName = nil;
            
            if ([methodName containsString:@":"]) {
                // 去掉参数，生成无参数的新名称
                NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"\\b([\\w]+) *:" options:0 error:nil];
                NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:methodName options:0 range:NSMakeRange(0, methodName.length)];
                if (matches.count > 0) {
                    NSMutableString *newMethodName = [NSMutableString string];
                    NSMutableString *newClassNewMethodName = [NSMutableString string];
                    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull matche, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSString *str = [methodName substringWithRange:[matche rangeAtIndex:1]];
                        [newMethodName appendString:(newMethodName.length > 0 ? str : str)];
                        [newClassNewMethodName appendFormat:@"%@%@", [self randomString], str];
                    }];
                    methodCallName = [NSString stringWithFormat:@"%@%@", newMethodName, [self caseStringForFirstCharacters:NO source:self.configModel.spamCode.classParameterName]];
                    [newMethodName appendFormat:@"%@:(NSInteger)%@", [self caseStringForFirstCharacters:NO source:self.configModel.spamCode.classParameterName], [self caseStringForFirstCharacters:YES source:self.configModel.spamCode.classParameterName]];
                    methodName = newMethodName;
                    newClassMethodCallName = [NSString stringWithFormat:@"%@", newClassNewMethodName];
                    newClassMethodName = [NSString stringWithFormat:@"%@:(NSInteger)%@", newClassMethodCallName, [self caseStringForFirstCharacters:YES source:self.configModel.spamCode.classParameterName]];
                } else {
                    methodName = [methodName stringByAppendingFormat:@" %@:(NSInteger)%@", [self caseStringForFirstCharacters:NO source:self.configModel.spamCode.classParameterName], [self caseStringForFirstCharacters:YES source:self.configModel.spamCode.classParameterName]];
                }
            } else {
                newClassMethodCallName = [NSString stringWithFormat:@"%@%@", [self randomString], methodName];
                newClassMethodName = [NSString stringWithFormat:@"%@:(NSInteger)%@", newClassMethodCallName, [self caseStringForFirstCharacters:YES source:self.configModel.spamCode.classParameterName]];
                methodCallName = [NSString stringWithFormat:@"%@%@", methodName, [self caseStringForFirstCharacters:NO source:self.configModel.spamCode.classParameterName]];
                methodName = [methodName stringByAppendingFormat:@"%@:(NSInteger)%@", [self caseStringForFirstCharacters:NO source:self.configModel.spamCode.classParameterName], [self caseStringForFirstCharacters:YES source:self.configModel.spamCode.classParameterName]];
            }

            [hFileMethodsString appendFormat:@"%@ (BOOL)%@;\n", tempSymbol, methodName];
            [hFileMethodsString appendFormat:@"\n"];

            [mFileMethodsString appendFormat:@"%@ (BOOL)%@ {\n", tempSymbol, methodName];
            [mFileMethodsString appendFormat:@"    return %@ %% %u == 0;\n", [self caseStringForFirstCharacters:YES source:self.configModel.spamCode.classParameterName], arc4random_uniform(50) + 1];
            [mFileMethodsString appendString:@"}\n"];
            [mFileMethodsString appendString:@"\n"];
            
            if (methodCallName.length > 0) {
                if (self.configModel.spamCode.methodParameterName && categroyFuncString.length <= 0) {
                    [categroyFuncString appendFormat:@"static inline NSInteger %@() {\nNSInteger ret = 0;\n", [self caseStringForFirstCharacters:YES source:self.configModel.spamCode.classParameterName]];
                }
                [categroyFuncString appendFormat:@"ret += [%@ %@:%u] ? 1 : 0;\n", className, methodCallName, arc4random_uniform(100)];
            }
            if (newClassMethodName.length > 0) {
                [hNewClassFileMethodsString appendFormat:@"%@ (BOOL)%@;\n", tempSymbol, newClassMethodName];
                [hNewClassFileMethodsString appendFormat:@"\n"];

                [mNewClassFileMethodsString appendFormat:@"%@ (BOOL)%@ {\n", tempSymbol, newClassMethodName];
                [mNewClassFileMethodsString appendFormat:@"    return %@ %% %u == 0;\n", [self caseStringForFirstCharacters:YES source:self.configModel.spamCode.classParameterName], arc4random_uniform(50) + 1];
                [mNewClassFileMethodsString appendString:@"}\n"];
                [mNewClassFileMethodsString appendString:@"\n"];
            }

            if (newClassMethodCallName.length > 0) {
                if (self.configModel.spamCode.lasterClassParameterName && newFuncString.length <= 0) {
                    [newFuncString appendFormat:@"static inline NSInteger %@() {\nNSInteger ret = 0;\n", [self caseStringForFirstCharacters:YES source:self.configModel.spamCode.classParameterName]];
                }
                [newFuncString appendFormat:@"ret += [%@ %@:%u] ? 1 : 0;\n", newClassName, newClassMethodCallName, arc4random_uniform(100)];
            }
        }];
        
        //
        NSString *newCategoryName = [NSString stringWithFormat:@"%@%@", categoryName, [self caseStringForFirstCharacters:NO source:self.configModel.spamCode.classParameterName]];
        // category m
        NSString *fileName = [NSString stringWithFormat:@"%@+%@.m", className, newCategoryName];
        NSString *fileContent = [NSString stringWithFormat:STATIC_CREATE_CATEGROY_CLASS_M_TEMPLATE, fileName, self.configModel.spamCode.folder, [self randomString], className, newCategoryName, className, newCategoryName, mFileMethodsString];
        [fileContent writeToFile:[codePath stringByAppendingPathComponent:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        // category h
        fileName = [NSString stringWithFormat:@"%@+%@.h", className, newCategoryName];
        fileContent = [NSString stringWithFormat:STATIC_CREATE_CATEGROY_CLASS_H_TEMPLATE, fileName, self.configModel.spamCode.folder, [self randomString], fileImportString, className, newCategoryName, hFileMethodsString];
        [fileContent writeToFile:[codePath stringByAppendingPathComponent:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [categroyImportString appendFormat:@"#import \"%@\"\n", fileName];

        // new class m
        fileName = [NSString stringWithFormat:@"%@.m", newClassName];
        fileContent = [NSString stringWithFormat:STATIC_CREATE_CLASS_M_TEMPLATE, fileName, self.configModel.spamCode.folder, [self randomString], newClassName, newClassName, mNewClassFileMethodsString];
        [fileContent writeToFile:[codePath stringByAppendingPathComponent:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        // new class h
        fileName = [NSString stringWithFormat:@"%@.h", newClassName];
        fileContent = [NSString stringWithFormat:STATIC_CREATE_CLASS_H_TEMPLATE, fileName, self.configModel.spamCode.folder, [self randomString], newClassName, hNewClassFileMethodsString];
        [fileContent writeToFile:[codePath stringByAppendingPathComponent:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];

        [newImportString appendFormat:@"#import \"%@\"\n", fileName];
        
    }];
}

- (void)spamCodeRecursiveDirectory:(NSString *)filePath ocFilePath:(FindFileBlock)ocFileBlock swiftFileBlock:(FindFileBlock)swiftFileBlock {
    NSArray<NSString *> *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:nil];
    BOOL isDirectory = NO;
    for (NSString *itemFilePath in files) {
        if ([self ignoreNames:itemFilePath]) {
            continue;
        }
        NSString *itemPath = [filePath stringByAppendingPathComponent:itemFilePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:itemPath isDirectory:&isDirectory] && isDirectory) {
            [self spamCodeRecursiveDirectory:itemPath ocFilePath:ocFileBlock swiftFileBlock:swiftFileBlock];
            continue;
        }
        NSString *itemFileName = itemFilePath.lastPathComponent;
        if ([itemFileName hasSuffix:@".h"]) {
            itemFileName = [itemFileName stringByDeletingPathExtension];
            NSString *mFileName = [itemFileName stringByAppendingPathExtension:@"m"];
            if ([files containsObject:mFileName]) {
                ocFileBlock([filePath stringByAppendingPathComponent:mFileName]);
            }
        } else if ([itemFileName hasSuffix:@".swift"]) {
            swiftFileBlock([filePath stringByAppendingPathComponent:itemFileName]);
        }
    }
}

- (NSString *)importCodeString:(NSString *)fileContent_h fileContent_m:(NSString *)fileContent_m {
    // 获取 .h和.m的头文件，
    NSMutableString *mutabString = [NSMutableString string];
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"^ *[@#]import *.+" options:NSRegularExpressionAnchorsMatchLines|NSRegularExpressionUseUnicodeWordBoundaries error:nil];
    NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:fileContent_h options:0 range:NSMakeRange(0, fileContent_h.length)];
    // 获取到.h文件的头文件 （#import <UIKit/UIKit.h>）
    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *importRow = [fileContent_h substringWithRange:[obj rangeAtIndex:0]];
        [mutabString appendString:importRow];
        [mutabString appendString:@"\n"];
    }];
    matches = [expression matchesInString:fileContent_m options:0 range:NSMakeRange(0, fileContent_m.length)];
    // 获取到.m文件的头文件 （当前类的类名）
    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *importRow = [fileContent_m substringWithRange:[obj rangeAtIndex:0]];
        [mutabString appendString:importRow];
        [mutabString appendString:@"\n"];
    }];
    return mutabString;
}

# pragma mark - 删除空格

# pragma mark - 判断是否是忽略的文件或者文件夹

- (BOOL)ignoreNames:(NSString *)filePath {
    if ([self.configModel.ignoreNames.files containsObject:[filePath componentsSeparatedByString:@"."][0]] || [self.configModel.ignoreNames.folders containsObject:[filePath componentsSeparatedByString:@"."][0]]) {
        return YES;
    }
    return NO;
}

# pragma mark - get / set

- (StaticScriptModel *)configModel {
    if (!_configModel) {
        _configModel = [[StaticScriptModel alloc] init];
        NSString *jsonString = [[NSString alloc] initWithData:[[NSData alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"StaticScriptConfig" withExtension:@"geojson"]] encoding:NSUTF8StringEncoding];
        if (jsonString.length == 0) {
            NSLog(@"_________【 StaticScriptConfig 】_________【 本地配置文件未找到 】");
        } else {
            NSError *error;
            NSDictionary *configDictionary = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"_________【 StaticScriptConfig 】_________【 本地配置文件解析失败 】");
            } else {
                if (((NSString *)configDictionary[@"rootPath"]).length != 0) {
                    _configModel.rootPath = configDictionary[@"rootPath"];
                }
                if (((NSString *)configDictionary[@"productPath"]).length != 0) {
                    _configModel.productPath = configDictionary[@"productPath"];
                }
                if (configDictionary[@"isChangeAssets"]) {
                    _configModel.isChangeAssets = [configDictionary[@"isChangeAssets"] boolValue];
                }
                if (configDictionary[@"modifyProjectName"]) {
                    _configModel.modifyProjectName.isOperate = [configDictionary[@"modifyProjectName"][@"isOperate"] boolValue];
                    _configModel.modifyProjectName.source = configDictionary[@"modifyProjectName"][@"config"][@"source"];
                    _configModel.modifyProjectName.target = configDictionary[@"modifyProjectName"][@"config"][@"target"];
                }
                if (configDictionary[@"modifyClassName"]) {
                    _configModel.modifyClassName.isOperate = [configDictionary[@"modifyClassName"][@"isOperate"] boolValue];
                    _configModel.modifyClassName.source = configDictionary[@"modifyClassName"][@"config"][@"source"];
                    _configModel.modifyClassName.target = configDictionary[@"modifyClassName"][@"config"][@"target"];
                }
                if (configDictionary[@"modifyAPIName"]) {
                    _configModel.modifyAPIName.isOperate = [configDictionary[@"modifyAPIName"][@"isOperate"] boolValue];
                    _configModel.modifyAPIName.source = configDictionary[@"modifyAPIName"][@"config"][@"source"];
                    _configModel.modifyAPIName.target = configDictionary[@"modifyAPIName"][@"config"][@"target"];
                }
                if (configDictionary[@"modifyPropertyName"]) {
                    _configModel.modifyPropertyName.isOperate = [configDictionary[@"modifyPropertyName"][@"isOperate"] boolValue];
                    _configModel.modifyPropertyName.source = configDictionary[@"modifyPropertyName"][@"config"][@"source"];
                    _configModel.modifyPropertyName.target = configDictionary[@"modifyPropertyName"][@"config"][@"target"];
                }
                if (configDictionary[@"ignoreNames"]) {
                    _configModel.ignoreNames.isOperate = [configDictionary[@"ignoreNames"][@"isOperate"] boolValue];
                    _configModel.ignoreNames.folders = configDictionary[@"ignoreNames"][@"config"][@"folders"];
                    _configModel.ignoreNames.files = configDictionary[@"ignoreNames"][@"config"][@"files"];
                }
                if (configDictionary[@"spamCode"]) {
                    _configModel.spamCode.isOperate = [configDictionary[@"spamCode"][@"isOperate"] boolValue];
                    _configModel.spamCode.folder = configDictionary[@"spamCode"][@"config"][@"folder"];
                    _configModel.spamCode.classParameterName = configDictionary[@"spamCode"][@"config"][@"classParameterName"];
                    _configModel.spamCode.categoryParameterName = configDictionary[@"spamCode"][@"config"][@"categoryParameterName"];
                    _configModel.spamCode.methodParameterName = configDictionary[@"spamCode"][@"config"][@"methodParameterName"];
                    _configModel.spamCode.propertyParameterName = configDictionary[@"spamCode"][@"config"][@"propertyParameterName"];
                    _configModel.spamCode.lasterClassParameterName = configDictionary[@"spamCode"][@"config"][@"lasterClassParameterName"];
                }
                if (configDictionary[@"deleteContent"]) {
                    _configModel.deleteContent.isOperate = [configDictionary[@"deleteContent"][@"isOperate"] boolValue];
                    _configModel.deleteContent.isComment = [configDictionary[@"deleteContent"][@"config"][@"isComment"] boolValue];
                    _configModel.deleteContent.isSpace = [configDictionary[@"deleteContent"][@"config"][@"isSpace"] boolValue];
                }
            }
        }
    }
    return _configModel;
}


@end
