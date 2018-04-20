//
//  ViewController.m
//  TestBlending
//
//  Created by chenweidong on 2018/4/10.
//  Copyright © 2018年 chenweidong. All rights reserved.
//

#import "ViewController.h"
#import "PananorManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    for (int i = 1; i <= 10; i++) {
        NSString *imagePath = [ViewController setImagePath:[NSString stringWithFormat:@"%d", i]];
        NSLog(@"imagePath=%@",imagePath);
        NSString *bundle = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d",i] ofType:@"JPG"];
        UIImage *image = [UIImage imageWithContentsOfFile:bundle];
        
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        if (data) {
           BOOL ret = [data writeToFile:imagePath atomically:YES];
            NSLog(@"写入图片 %d", ret);
        }
    }
    NSLog(@"存入图片");
    int count = 10;
    NSString *outputpath = [ViewController getOutImagePath:@"out"];
    PananorManager *pananorManager = [[PananorManager alloc] init];
    NSLog(@"outputpath：%@",outputpath);
    for (int i = 1; i <= count; i++) {
        NSString *imagePath = [ViewController setImagePath:[NSString stringWithFormat:@"%d", i]];
       BOOL ret = [pananorManager insertImageWithImagePath:imagePath];
        if (ret) {
            NSLog(@"****%d---成功", ret);
        }else{
             NSLog(@"****%d---失败", ret);
        }
    }
   BOOL success = [pananorManager savePanoImageToPath:outputpath];
    if (success) {
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:outputpath];
        [self.imageView setImage:image];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+(NSString *)setImagePath:(NSString *)name{
    
    NSString *imagePath = nil;
        //获取Documents文件夹目录,第一个参数是说明获取Doucments文件夹目录，第二个参数说明是在当前应用沙盒中获取，所有应用沙盒目录组成一个数组结构的数据存放
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [NSString stringWithFormat:@"%@/image", [docPath objectAtIndex:0]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsPath]) {
        NSError *error;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:documentsPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (success) {
            NSLog(@"创建文件成功");
        }
    }
    imagePath = [NSString stringWithFormat:@"%@/%@.jpg", documentsPath,name];
    return imagePath;
}


+(NSString *)getOutImagePath:(NSString *)name{
    NSString *imagePath = nil;
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [NSString stringWithFormat:@"%@/out", [docPath objectAtIndex:0]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsPath]) {
        NSError *error;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:documentsPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (success) {
            NSLog(@"创建文件成功");
        }
    }
    imagePath = [NSString stringWithFormat:@"%@/%@.jpg", documentsPath,name];
    return imagePath;
}


@end
