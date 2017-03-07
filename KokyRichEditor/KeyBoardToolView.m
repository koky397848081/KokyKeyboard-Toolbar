//
//  KeyBoardToolView.m
//  KokyRichEditor
//
//  Created by xujing on 17/3/6.
//  Copyright © 2017年 xujing. All rights reserved.
//

#import "KeyBoardToolView.h"

#define screen_Height ([UIScreen mainScreen].bounds.size.height)
#define screen_Width  ([UIScreen mainScreen].bounds.size.width)

@implementation KeyBoardToolView

-(void)showKeyBoardToolView{
    
    self.frame = CGRectMake(0, screen_Height, screen_Width, 50);
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self interfaceUI];
}

- (void)interfaceUI{
    UIButton *losebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    losebtn.frame = CGRectMake(20, 0, 50, 50);
    [losebtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [losebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [losebtn setTitle:@"收起" forState:UIControlStateNormal];
    [self addSubview:losebtn];
    
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageBtn setTitle:@"加粗" forState:UIControlStateNormal];
    imageBtn.frame = CGRectMake(screen_Width-100, 0, 50, 50);
    [imageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [imageBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:imageBtn];
    
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraBtn setTitle:@"链接" forState:UIControlStateNormal];
    cameraBtn.frame = CGRectMake(screen_Width-50, 0, 50, 50);
    [cameraBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cameraBtn];
    
    UIButton *canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [canclebtn setTitle:@"取消" forState:UIControlStateNormal];
    canclebtn.frame = CGRectMake(screen_Width-150, 0, 50, 50);
    [canclebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [canclebtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:canclebtn];
}

- (void)buttonClicked:(UIButton *)sender{
    NSLog(@"%@按钮被点击了",sender.currentTitle);
}
@end
