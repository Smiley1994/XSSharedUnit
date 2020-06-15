//
//  ANN9LoadingView.m
//  BabyLearnEnglish
//
//  Created by 晓松 on 2018/12/20.
//  Copyright © 2018 ann9. All rights reserved.
//

#import "XSLoadingView.h"
#import "XSUIMacro.h"

@interface XSLoadingView ()

@property (nonatomic, strong) CALayer *backLayer;

@end

@implementation XSLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
        
        CGFloat width = frame.size.width;
        
        CGFloat height = frame.size.height;
        
        self.backLayer = [CALayer layer];
        self.backLayer.frame = CGRectMake(0, 0, width, height);
        self.backLayer.backgroundColor = UIColor.clearColor.CGColor;//HEXCOLOR(0x18cdfa).CGColor;
        [self.layer addSublayer:self.backLayer];
        
        //创建圆环
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width / 2, height / 2) radius:25 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        //圆环遮罩
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.lineWidth = 5;
        shapeLayer.strokeStart = 0;
        shapeLayer.strokeEnd = 1;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineDashPhase = 0.8;
        shapeLayer.path = bezierPath.CGPath;
        [self.backLayer setMask:shapeLayer];
        
        
        //颜色渐变
        NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)HEXCOLOR(0x18cdfa).CGColor,(id)[HEXCOLOR(0x18cdfa) CGColor], nil];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.shadowPath = bezierPath.CGPath;
        gradientLayer.frame = CGRectMake(0, 0, width, height / 2);
        gradientLayer.startPoint = CGPointMake(1, 0);
        gradientLayer.endPoint = CGPointMake(0, 0);
        [gradientLayer setColors:[NSArray arrayWithArray:colors]];
        
        NSMutableArray *colors1 = [NSMutableArray arrayWithObjects:(id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0] CGColor],(id)[UIColor.clearColor CGColor], nil];
        CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.shadowPath = bezierPath.CGPath;
        gradientLayer1.frame = CGRectMake(0, height / 2, width, height / 2);
        gradientLayer1.startPoint = CGPointMake(0, 1);
        gradientLayer1.endPoint = CGPointMake(1, 1);
        [gradientLayer1 setColors:[NSArray arrayWithArray:colors1]];
        [self.backLayer addSublayer:gradientLayer]; //设置颜色渐变
        [self.backLayer addSublayer:gradientLayer1];
        
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
        rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
        rotationAnimation.repeatCount = MAXFLOAT;
        rotationAnimation.duration = 1;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [self.backLayer addAnimation:rotationAnimation forKey:@"rotationAnnimation"];
        
        
    }
    return self;
}


@end
