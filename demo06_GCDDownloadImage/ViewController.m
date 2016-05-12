//
//  ViewController.m
//  demo06_GCDDownloadImage
//
//  Created by LuoShimei on 16/5/12.
//  Copyright © 2016年 罗仕镁. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** 创建侠士图片的控件 */
@property(nonatomic,strong) UIImageView *imageView;
/** 显示 下载图片 按钮 */
@property(nonatomic,strong) UIButton *downloadButton;
@end

@implementation ViewController
/** 懒加载 */
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 200);
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    }
    return _imageView;
}

- (UIButton *)downloadButton{
    if (_downloadButton == nil) {
        _downloadButton = [[UIButton alloc] init];
        _downloadButton.frame = CGRectMake(10, 260, self.view.bounds.size.width - 20, 40);
        [_downloadButton setTitle:@"下载图片" forState:UIControlStateNormal];
        [_downloadButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _downloadButton.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        
        [_downloadButton addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadButton;
}

/** 下载图片操作 */
- (void)download{
    //表示已经下载过了，无需再次下载，直接停止if后面的代码运行
    if (self.imageView.image) {
        return ;
    }
    NSString *imagePath = @"http://h.hiphotos.baidu.com/image/h%3D300/sign=df57247bc4fdfc03fa78e5b8e43e87a9/8b82b9014a90f60364264ec23e12b31bb151eda5.jpg";
    
    //获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:imagePath];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        //将下载好的图片添加到图片视图上（需要使用主队列刷新图片）
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
        
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //将属兔添加到主视图上
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.downloadButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
