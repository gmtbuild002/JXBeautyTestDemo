//
//  STStikcerLoader.m
//  PLCameraStreamingKit
//
//  Created by TaoRan on 16/6/21.
//  Copyright © 2016年 0dayZh. All rights reserved.
//

#import "STStickerLoader.h"


static Boolean s_forceCopy = false;

@interface STStickerLoader()
@property (nonatomic, strong) NSMutableArray *stickerPackges;
@end

@implementation STStickerLoader

+ (void)ForceUpdateAtInit{
    s_forceCopy = true;
}

+ (instancetype)sharedManager {
    static STStickerLoader *singleManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleManager = [[self alloc] init];
    });
    return singleManager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.stickerPackges = [[NSMutableArray alloc] initWithArray:@[]];
    }
    return self;
}

+ (NSString*) getResourceDirectory{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    return [NSString stringWithFormat:@"%@/sticker_res", resourcePath];
}


+ (void)firstCopy {
    //NSString *rabbitPath = [[NSBundle mainBundle] pathForResource:@"sticker_res/rabbit" ofType:@"zip"];
    //NSString *strewberryPath = [[NSBundle mainBundle] pathForResource:@"sticker_res/starwberry" ofType:@"zip"];
    
    
    NSFileManager *manager =  [NSFileManager defaultManager];
    NSError *error;
    NSArray<NSString *> * subPaths = [manager contentsOfDirectoryAtPath:[STStickerLoader getResourceDirectory ] error:&error];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths[0] stringByAppendingPathComponent:@"Stickers"];
    
    if (![manager fileExistsAtPath:path]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    int newCount = 0;
    for(int i=0; i<subPaths.count; i++){
        NSString *zippath = subPaths[i];
        NSRange  range = [zippath rangeOfString:@".zip"];
        if (range.location == NSNotFound)
            continue;
        newCount++;
    }
    
    NSArray *tmpList = [manager contentsOfDirectoryAtPath:path error:nil];
    if ([tmpList count] < newCount || s_forceCopy) {
        
        for(int i=0; i<subPaths.count; i++){
            NSString *zippath = subPaths[i];
            NSRange  range = [zippath rangeOfString:@".zip"];
            if (range.location == NSNotFound)
                continue;
            NSString *srcPath = [[STStickerLoader getResourceDirectory ] stringByAppendingPathComponent:zippath];
            [manager copyItemAtPath:srcPath toPath:[path stringByAppendingPathComponent:zippath] error:nil];
        }
        //[manager copyItemAtPath:rabbitPath toPath:[path stringByAppendingPathComponent:@"rabbit.zip"] error:nil];
        //[manager copyItemAtPath:strewberryPath toPath:[path stringByAppendingPathComponent:@"starwberry.zip"] error:nil];
    }
}

+ (void)updateTheStickers {
    [STStickerLoader firstCopy];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths[0] stringByAppendingPathComponent:@"Stickers"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    } else {
        // Find the zips in the Documents, and move it to the stickers.
        NSArray *tmplist0 = [manager contentsOfDirectoryAtPath:paths[0] error:nil];
        for (NSString *file in tmplist0) {
            if ([[file pathExtension] isEqualToString:@"zip"]) {
                NSString *newPath = [path stringByAppendingPathComponent:file];
                
                NSData *dataZip = [NSData dataWithContentsOfFile:[paths[0] stringByAppendingPathComponent:file]];
                [dataZip writeToFile:newPath atomically:YES];
                
                //                [manager moveItemAtPath:[paths[0] stringByAppendingPathComponent:file] toPath:newPath error:nil];
                
            }
        }
        NSMutableArray *tmplist = [NSMutableArray arrayWithArray: [manager contentsOfDirectoryAtPath:path error:nil]];
        NSLog(@"%@", tmplist);
        
        NSString *wrongPath = [path stringByAppendingPathComponent:@"__MACOSX"];
        if ([tmplist containsObject:@"__MACOSX"]) {
            [manager removeItemAtPath:wrongPath error:nil];
            [tmplist removeObject:@"__MACOSX"];
        }
        
        wrongPath = [path stringByAppendingPathComponent:@".DS_Store"];
        if ([tmplist containsObject:@".DS_Store"]) {
            [manager removeItemAtPath:wrongPath error:nil];
            [tmplist removeObject:@".DS_Store"];
        }
        for (NSString *file in tmplist) {
            NSString *packgePath = @"";
            if ([[file pathExtension] isEqualToString:@"zip"]) {
                packgePath = [path stringByAppendingPathComponent:file];
            }
            if (![[STStickerLoader sharedManager].stickerPackges containsObject:packgePath]) {
                [(NSMutableArray *)([STStickerLoader sharedManager].stickerPackges) addObject:packgePath];
            }
        }
    }
}

+ (NSArray *) getStickersPaths {
    // if ([[STStickerLoader sharedManager].stickerPackges count] > 0) {
    //    NSLog(@"%@", [STStickerLoader sharedManager].stickerPackges);
    return (NSArray *)[STStickerLoader sharedManager].stickerPackges;
    //} else {
    //    return nil;
    //}
}

@end
