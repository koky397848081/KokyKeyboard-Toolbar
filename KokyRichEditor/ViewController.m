//
//  ViewController.m
//  KokyRichEditor
//
//  Created by xujing on 17/3/6.
//  Copyright © 2017年 xujing. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+KeyboardCorver.h"
#import "KeyBoardToolView.h"

#define screen_Height ([UIScreen mainScreen].bounds.size.height)
#define screen_Width  ([UIScreen mainScreen].bounds.size.width)

@interface ViewController ()
{
    KeyBoardToolView *_toolBarView;
  //  __weak IBOutlet UIWebView *_webVieww;
    
}
@property (weak, nonatomic) IBOutlet UITextView *_textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];//键盘遮住textfield，滚动页面

    [self interfaceToolBar];//键盘上方工具条添加

//    [self loadHtmlWithSourceFile];//加载js
}

- (void)interfaceToolBar{
    _toolBarView  = [[KeyBoardToolView alloc]initWithFrame:CGRectMake(0, screen_Height, screen_Width, 50)];
    [_toolBarView showKeyBoardToolView];
    [self.view addSubview:_toolBarView];
    //监听键盘高度来调整toolbar位置
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toolBarshow:) name:@"KeyboardShow" object:@"keyboardHeight"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toolBarHidden) name:@"Keyboardhidden" object:nil];
}

//工具条出现
- (void)toolBarshow:(NSNotification *)info{
    
    CGFloat keyboardHeight =[info.userInfo[@"keyboardHeight"] floatValue];
    [UIView animateWithDuration:0.1 animations:^{
        _toolBarView.frame = CGRectMake(0, screen_Height-keyboardHeight-50, screen_Width, 50);
    }];
}

//工具条消失
- (void)toolBarHidden{
    
    [UIView animateWithDuration:0.1 animations:^{
        
        _toolBarView.frame = CGRectMake(0, screen_Height, screen_Width, 50);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//键盘遮住textfield，滚动页面
- (void)dealloc
{
    [self clearNotificationAndGesture];
}

//- (void)loadHtmlWithSourceFile{
//    _webVieww.delegate = self;
//    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
//    NSString *filePath = [resourcePath stringByAppendingPathComponent:@"rich_editor.html"];
//    NSString *html = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    
//    [_webVieww loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//}
@end
