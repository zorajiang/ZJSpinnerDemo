//
//  VideoPlayerSpinner.m
//  ZJSpinnerDemo
//
//  Created by zorajiang on 2018/5/16.
//  Copyright © 2018年 zorajiang. All rights reserved.
//

#import "ZJSpinner.h"


#define ZJSpinnerWidth (25.0f)

#define kRotationAnimationDuration (2.0f)
#define kIncreasingAngleAnimationDuration (1.2f)
#define kDecreasingAngleAnimationDuration (0.4f)

@interface ZJSpinner ()
@property (nonatomic, strong) CAShapeLayer *animLayer;
@end

@implementation ZJSpinner

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, ZJSpinnerWidth, ZJSpinnerWidth)];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)addArcLayer
{
    CGFloat lineWidth = 2.0f;
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.bounds = CGRectMake(0, 0, ZJSpinnerWidth, ZJSpinnerWidth);
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    layer.lineWidth = lineWidth;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    UIBezierPath *bPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(ZJSpinnerWidth/2, ZJSpinnerWidth/2)
                                                         radius:(ZJSpinnerWidth - lineWidth)/2
                                                     startAngle: 0
                                                       endAngle: (M_PI * 13/6)
                                                      clockwise:YES];
    layer.path = bPath.CGPath;
    layer.position = CGPointMake(self.bounds.size.width/2, ZJSpinnerWidth/2);
    self.animLayer = layer;
    [self.layer addSublayer:layer];
}

- (CAAnimationGroup *)animationGroup
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.fromValue = [NSNumber numberWithFloat:.0f];;
    rotationAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    
    self.animLayer.strokeStart = 0.0;
    self.animLayer.strokeEnd = 30.0f/390.f;
    
    CAKeyframeAnimation *keyframeAnimationEnd = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    keyframeAnimationEnd.values = @[@(30.0f/390.f)
                                    ,@(300.0/390.f)
                                    ,@(300.0/390.f)
                                    ,@(1.0)
                                    ];
    keyframeAnimationEnd.keyTimes = @[@(0.0), @(1.2/2.0), @(1.6/2.0), @(1.0)];
    keyframeAnimationEnd.removedOnCompletion = NO;
    
    CAKeyframeAnimation *keyframeAnimationStart = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    keyframeAnimationStart.values = @[@(0.0)
                                      ,@(0.0)
                                      ,@(270.0f/390.f)
                                      ,@(360.0f/390.f)
                                      ];
    keyframeAnimationStart.keyTimes = @[@(0.0), @(1.2/2.0), @(1.6/2.0), @(1.0)];
    keyframeAnimationStart.removedOnCompletion = NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotationAnimation, keyframeAnimationEnd, keyframeAnimationStart];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.duration = kRotationAnimationDuration;
    group.repeatCount = HUGE_VALF;
    return group;
}

#pragma mark - QMVLoadingViewDelegate
- (void)startLoading
{
    [self stopLoading];
    if (nil == self.animLayer)
    {
        [self addArcLayer];
    }
    [self.animLayer addAnimation:[self animationGroup] forKey:@"animate"];
}

- (void)stopLoading
{
    [self.animLayer removeAllAnimations];
    [self.layer removeAllAnimations];
    [self.animLayer removeFromSuperlayer];
    self.animLayer = nil;
}
@end

