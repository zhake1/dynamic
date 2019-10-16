//
//  TitleButton.m
//  滑动
//
//  Created by 123 on 2019/10/14.
//  Copyright © 2019 123. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

//重写set方法,按钮就无法进入highlighted状态
- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
