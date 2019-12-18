//
//  LXSignBorad.m
//  bearrental
//
//  Created by 刘新 on 2019/12/18.
//  Copyright © 2019 ShenZhen Linxiong Tchonology CO,.Ltd. All rights reserved.
//

#import "LXSignBorad.h"
#import "LXSignBoradLayer.h"

@interface LXSignBorad ()

@property (nonatomic, strong) NSMutableArray *layerArray;

@property (nonatomic, strong) LXSignBoradLayer *drawLayer;

@property (nonatomic, strong) UIBezierPath *beganPath;

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeLineWidth;

@end

@implementation LXSignBorad

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configBasicSetup];
    }
    
    return self;
}

- (void)configBasicSetup {
    
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    
    self.lineWidth = 2.f;
    self.lineColor = [UIColor redColor];
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint beganPoint = [touch locationInView:self];
    [self drawBeganPoint:beganPoint];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
//    NSLog(@"self.frame = %@,currentPoint.x = %f,currentPoint.y = %f",self,currentPoint.x,currentPoint.y);
    //防止签名超出self的范围
    if (currentPoint.x < 0 || currentPoint.y < 0 || currentPoint.x > self.bounds.size.width || currentPoint.y > self.bounds.size.height) {
        return;
    }
    
    //上一个点的坐标
    CGPoint prePoint = [touch previousLocationInView:self];
    CGPoint middlePoint = midPoint(currentPoint, prePoint);
    [self drawControlPoint:middlePoint endPoint:currentPoint];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    //防止签名超出self的范围
    if (currentPoint.x < 0 || currentPoint.y < 0 || currentPoint.x > self.bounds.size.width || currentPoint.y > self.bounds.size.height) {
        return;
    }
    
    CGPoint prePoint = [touch previousLocationInView:self];
    CGPoint middlePoint = midPoint(currentPoint, prePoint);
    [self drawControlPoint:middlePoint endPoint:currentPoint];
}

#pragma mark - draw line
- (void)drawBeganPoint:(CGPoint)point {
    
    self.drawLayer = [LXSignBoradLayer layer];
    self.drawLayer.lineWidth = self.strokeLineWidth;
    self.drawLayer.fillColor = [UIColor clearColor].CGColor;
    self.drawLayer.strokeColor = self.strokeColor.CGColor;
    self.drawLayer.isPen = YES;
    [self.layer addSublayer:self.drawLayer];
    
    [self.layerArray addObject:self.drawLayer];
    UIBezierPath *beganPath = [UIBezierPath bezierPath];
    [beganPath moveToPoint:point];
    self.beganPath = beganPath;
}

- (void)drawControlPoint:(CGPoint)controlPoint endPoint:(CGPoint)endPoint {
    [self.beganPath addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    self.drawLayer.path = self.beganPath.CGPath;
}

//计算中间点
CGPoint midPoint(CGPoint p1, CGPoint p2) {
    
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

#pragma mark - Public Method
/// 擦拭
- (void)rubberSignBorad {
    self.strokeLineWidth = 20.f;
    self.strokeColor = self.backgroundColor;
    self.drawLayer.isPen = NO;
}

/// 画笔
- (void)writeSignBorad {
    self.strokeLineWidth = 2.f;
    self.strokeColor = self.lineColor;
    self.drawLayer.isPen = YES;
}

/// 清除
- (void)clearSignBorad {
    
    self.lineWidth = 2.f;
    self.strokeColor = self.lineColor;
    self.drawLayer.isPen = YES;
    
    [self.layerArray enumerateObjectsUsingBlock:^(LXSignBoradLayer *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperlayer];
    }];
    
    [self.layerArray removeAllObjects];
}

/// 拿到签名Image
- (UIImage *)getSignImage {
    
    return [self getImageWithView:self];
}

- (UIImage *)getImageWithView:(UIView *)view {
    
    //创建一个基于位图的图形上下文并指定大小
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    //renderInContext 呈现接受者及其子范围到指定的上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //返回一个基于当前图形上下文的图片
    UIImage *extractImage = UIGraphicsGetImageFromCurrentImageContext();
    //移除栈顶的基于当前位图的图形上下文
    UIGraphicsEndImageContext();
    
    //以png格式返回指定图片的数据
    NSData *imageData = UIImagePNGRepresentation(extractImage);
    
    return [UIImage imageWithData:imageData];
}

#pragma mark - setter
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    self.strokeColor = lineColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.strokeLineWidth = lineWidth;
}

#pragma mark - getter
- (NSMutableArray *)layerArray {
    if (!_layerArray) {
        _layerArray = [NSMutableArray new];
    }
    
    return _layerArray;
}
@end
