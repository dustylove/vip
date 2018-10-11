//
//  ArcItem.m
//  旋转
//
//  Created by 严凯 on 2018/7/10.
//  Copyright © 201/Users/yankai/Desktop/实践出真理/vip/vip/ArcItem.h8年 优品互联网. All rights reserved.
//

#import "ArcItem.h"

@implementation ArcItem

+ (instancetype)getView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].firstObject;
}

- (void)layoutSubviews{
    [super layoutSubviews];

}
@end
