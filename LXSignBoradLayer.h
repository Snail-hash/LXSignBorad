//
//  LXSignBoradLayer.h
//  bearrental
//
//  Created by 刘新 on 2019/12/18.
//  Copyright © 2019 ShenZhen Linxiong Tchonology CO,.Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXSignBoradLayer : CAShapeLayer

/// 区分划线和擦拭
@property (nonatomic, assign) BOOL isPen;

@end

NS_ASSUME_NONNULL_END
