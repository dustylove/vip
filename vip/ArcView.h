//
//  ViewController.h
//  旋转
//
//  Created by 张昆龙 on 2018/7/5.
//  Copyright © 2018年 优品互联网. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ActionBlock)(NSInteger index);
@interface ArcView : UIView

/**
 创建vip滑动到view,item默认尺寸为(60,70),默认旋转度数为30

 @param frame frame
 @param imgs 图片数组
 @param titles VIP等级数组
 @param maxScale 最大放大倍数，最小默认为1
 @param margin 左右为中心点边距，下为最大形态时的下边距
 @param defultIndex 默认起始等级
 @param block 滑到对应的等级的回调
 @return ArcView
 */
- (instancetype)initWithFrame:(CGRect)frame imgs:(NSArray *)imgs titles:(NSArray *)titles maxScale:(CGFloat)maxScale margin:(UIEdgeInsets)margin defultIndex:(NSInteger)defultIndex actionBlock:(ActionBlock)block;

@end

