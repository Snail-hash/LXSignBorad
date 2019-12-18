//
//  LXSignBorad.h
//  bearrental
//
//  Created by 刘新 on 2019/12/18.
//  Copyright © 2019 ShenZhen Linxiong Tchonology CO,.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXSignBorad : UIView

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong) UIColor *lineColor;

/// 擦拭
- (void)rubberSignBorad;

/// 画笔
- (void)writeSignBorad;

/// 清除
- (void)clearSignBorad;

/// 拿到签名Image
- (UIImage *)getSignImage;

@end

NS_ASSUME_NONNULL_END
