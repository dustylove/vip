//
//  ViewController.m
//  旋转
//
//  Created by 张昆龙 on 2018/7/5.
//  Copyright © 2018年 优品互联网. All rights reserved.
//

#import "ArcView.h"
#import "ArcItem.h"

#define AngleToRadian(angle) (M_PI/180.0f)*angle

@interface ArcView () <UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIView *bgCircleView;
@property(nonatomic, strong) NSArray *imgs;
@property(nonatomic, assign) CGFloat maxScale;
@property(nonatomic, assign) UIEdgeInsets margin;
@property(nonatomic, assign) CGFloat radius;
@property(nonatomic, assign) CGFloat bgR;
@property(nonatomic, assign) NSInteger defultIndex;
@property(nonatomic, copy) ActionBlock block;

@property(nonatomic, assign) CGFloat KW;
@property(nonatomic, assign) CGFloat KH;
@property(nonatomic, assign) CGFloat angle;
@property(nonatomic, assign) CGSize itemSize;
@property(nonatomic, strong) NSMutableArray *items;
@property(nonatomic, strong) NSArray *titles;
@end

@implementation ArcView
- (instancetype)initWithFrame:(CGRect)frame imgs:(NSArray *)imgs titles:(NSArray *)titles maxScale:(CGFloat)maxScale margin:(UIEdgeInsets)margin defultIndex:(NSInteger)defultIndex actionBlock:(ActionBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgs = imgs;
        self.titles = titles;
        self.maxScale = maxScale;
        self.margin = margin;
        NSAssert(margin.left == margin.right, @"左右间距必须相等!");
        self.defultIndex = defultIndex;
        self.block = block;
        self.KW = CGRectGetWidth(frame);
        self.KH = CGRectGetHeight(frame);
        self.angle = 30;
        NSAssert(self.angle*(imgs.count-1)<=270, @"度数✖️间隔不能大于270度!");
        self.itemSize = CGSizeMake(60, 70);
        self.radius = (self.KW/2 - margin.left)/sinf(AngleToRadian(self.angle));
        self.bgR = self.radius + self.itemSize.height*maxScale/2 + margin.bottom;
        self.items = [NSMutableArray array];
        
        [self createUI];
    }
    return self;
}


- (void)createUI{
    self.backgroundColor = UIColor.yellowColor;
    //底部的承载视图
   _bgCircleView  = [[UIView alloc]initWithFrame:CGRectMake(self.KW/2-self.bgR,self.KH - self.bgR*2 , self.bgR*2, self.bgR*2)];
    _bgCircleView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bgCircleView];
    //用于手势的scrollview
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width*self.imgs.count, self.bounds.size.height);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    //底层灰色的线
    UIBezierPath* bottomPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bgR,self.bgR) radius:self.radius startAngle:M_PI_2 - AngleToRadian(self.angle*(self.imgs.count -1)) endAngle:M_PI_2-AngleToRadian(self.angle*_defultIndex) clockwise:YES];
    CAShapeLayer *bottomLayer   = [CAShapeLayer layer];
    bottomLayer.path = bottomPath.CGPath;
    bottomLayer.fillColor = [UIColor clearColor].CGColor;
    bottomLayer.strokeColor = [UIColor grayColor].CGColor;
    bottomLayer.lineWidth = 3;
    //上层白色的线
    UIBezierPath* topPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bgR,self.bgR) radius:self.radius startAngle:M_PI_2-AngleToRadian(self.angle*_defultIndex) endAngle:M_PI_2 clockwise:YES];
    CAShapeLayer* topLayer = [CAShapeLayer layer];
    topLayer.path = topPath.CGPath;
    topLayer.fillColor = [UIColor clearColor].CGColor;
    topLayer.strokeColor = [[UIColor whiteColor] CGColor];
    topLayer.lineWidth = 3;
    
    [_bgCircleView.layer addSublayer:bottomLayer];
    [_bgCircleView.layer addSublayer:topLayer];
    
    for (int k = 0; k < 6; k++) {
        ArcItem *item = [ArcItem getView];
        item.imgV.image = _imgs[k];
        item.titleLabel.text = _titles[k];
        item.center  = CGPointMake(self.bgR - sinf(AngleToRadian((-k) * _angle))*self.radius, self.bgR + cosf(AngleToRadian((-k) * _angle))*self.radius);
        [self.bgCircleView addSubview:item];
        [self.items addObject:item];
    }
    //TODO: 设置开始显示哪一个
    _scrollView.contentOffset = CGPointMake(self.KW*self.defultIndex, 0);
    
}

#pragma mark - scrolldelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offSetX = scrollView.contentOffset.x;
    _bgCircleView.transform = CGAffineTransformMakeRotation(offSetX/(self.KW)*AngleToRadian(_angle));
    [_items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __weak __typeof(self)weakSelf = self;
        ArcItem *item = weakSelf.items[idx];
        CGFloat scale = 0;
        CGFloat distance = fabs(offSetX - weakSelf.KW *idx);
        CGFloat distanceForMinimumScale = weakSelf.KW;
        CGFloat distanceForMaximumScale = 0.0;
        if (distance >= distanceForMinimumScale) {
            scale = 1;
        } else if (distance == distanceForMaximumScale) {
            scale = weakSelf.maxScale;
        } else {
            scale = 1 + (distanceForMinimumScale - distance) * (weakSelf.maxScale - 1) / (distanceForMinimumScale - distanceForMaximumScale);
        }
        CGAffineTransform transform = CGAffineTransformMakeRotation(AngleToRadian(weakSelf.angle* ( - offSetX/weakSelf.KW)));
        item.transform = CGAffineTransformScale(transform,scale, scale);
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.block(scrollView.contentOffset.x/self.KW);
}

@end
