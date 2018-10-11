//
//  ArcItem.h
//  旋转
//
//  Created by 严凯 on 2018/7/10.
//  Copyright © 2018年 优品互联网. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArcItem : UIView
+(instancetype)getView;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
