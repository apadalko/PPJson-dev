//
//  PPLinedTextField.m
//  Blok
//
//  Created by Alex Padalko on 12/11/15.
//  Copyright © 2015 com.placepixel. All rights reserved.
//

#import "PPLinedTextField.h"
#import "UIFont+AppFonts.h"
#import "UIColor+HEX.h"
@interface PPLinedTextField()



@end
@implementation PPLinedTextField
-(void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    _placeHolderColor=placeHolderColor;
    self.attributedPlaceholder=[[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:placeHolderColor}];
    
}

-(void)setPlaceholder:(NSString *)placeholder{
    if (_placeHolderColor) {
        [super setPlaceholder:placeholder];
            self.attributedPlaceholder=[[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:_placeHolderColor}];
    }else{
        [super setPlaceholder:placeholder];
    }
}
+(instancetype)createWithPlaceHolder:(NSString *)placeHolder andImageName:(NSString *)imageName andImageColor:(UIColor*)imageColor{
    PPLinedTextField * field= [[self alloc] init];
    field.textInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    [field setFont:[UIFont muesoRounded500WithSize:15]];
    [field setTextColor:[UIColor blackColor]];
    field.placeholder=placeHolder;
    
    if (imageName) {
        UIImageView * imgv=[[UIImageView alloc] init];
        [imgv setContentMode:UIViewContentModeCenter];
        [imgv setFrame:CGRectMake(0, 0, 44, 44)];
        [field setLeftView:imgv];
        if (imageName.length==0) {
            [imgv setBackgroundColor:[UIColor purpleColor]];
        }else{
            [imgv setBackgroundColor:[UIColor clearColor]];
            [imgv setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            [imgv setTintColor:imageColor];
        }
        
        
        [field setLeftViewMode:UITextFieldViewModeAlways];
    }
    
    
    [field setBackgroundColor:[UIColor whiteColor]];
    
    return field;
}

+(instancetype)createWithPlaceHolder:(NSString *)placeHolder andImageName:(NSString *)imageName{
    
    PPLinedTextField * field= [[self alloc] init];
    field.textInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    [field setFont:[UIFont muesoRounded500WithSize:15]];
    [field setTextColor:[UIColor blackColor]];
    field.placeholder=placeHolder;
    
    if (imageName) {
        UIImageView * imgv=[[UIImageView alloc] init];
        [imgv setContentMode:UIViewContentModeCenter];
        [imgv setFrame:CGRectMake(0, 0, 44, 44)];
        [field setLeftView:imgv];
        if (imageName.length==0) {
            [imgv setBackgroundColor:[UIColor purpleColor]];
        }else{
            [imgv setBackgroundColor:[UIColor clearColor]];
            [imgv setImage:[UIImage imageNamed:imageName]];
        }
        
        
        [field setLeftViewMode:UITextFieldViewModeAlways];
    }
    
    
    [field setBackgroundColor:[UIColor whiteColor]];
    
    return field;
    
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    
    return CGRectInset([super textRectForBounds:bounds], self.textInsets.left+self.textInsets.right, self.textInsets.top+self.textInsets.right);
    
}
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
    
    //  return CGRectInset([super placeholderRectForBounds:bounds], self.textInsets.left+self.textInsets.right, self.textInsets.top+self.textInsets.right);
}
- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset([super editingRectForBounds:bounds], self.textInsets.left+self.textInsets.right, self.textInsets.top+self.textInsets.right);
    
}


-(CAShapeLayer *)bottomLineLayer{
    
    
    if (!_bottomLineLayer) {
        _bottomLineLayer=[CAShapeLayer layer];
        [_bottomLineLayer setStrokeColor:[UIColor colorFromHexString:@"d5d5d5"].CGColor];
        [self.layer addSublayer:_bottomLineLayer];
        _bottomLineLayer.lineWidth=1.0;
    }
    return _bottomLineLayer;
    
}
-(CAShapeLayer *)topLineLayer{
    if (!_topLineLayer) {
        _topLineLayer=[CAShapeLayer layer];
        [_topLineLayer setStrokeColor:[UIColor colorFromHexString:@"d5d5d5"].CGColor];
        [self.layer addSublayer:_topLineLayer];
        _topLineLayer.lineWidth=1.0;
    }
    return _topLineLayer;
}

//-(CAShapeLayer *)lineLayer{
//    
//    
//    if (!_lineLayer) {
//        _lineLayer=[CAShapeLayer layer];
//        [_lineLayer setStrokeColor:[UIColor colorFromHexString:@"e2e1e3"].CGColor];
//        [self.layer addSublayer:_lineLayer];
//        _lineLayer.lineWidth=1.0;
//    }
//    return _lineLayer;
//    
//}


-(void)layoutSubviews{
    
    [super layoutSubviews];

    
    if (self.shouldDrawBotLine||self.shouldDrawTopLine) {

        
//        if (self.shouldDrawTopLine) {
//            CGPathMoveToPoint(path, nil, 0, 0+self.lineLayer.lineWidth/2);
//            CGPathAddLineToPoint(path, nil,self.frame.size.width,0+self.lineLayer.lineWidth/2);
//            
//        }if (self.shouldDrawBotLine) {
//            CGPathMoveToPoint(path, nil, self.botLineOffset, self.frame.size.height - self.lineLayer.lineWidth/2);
//            CGPathAddLineToPoint(path, nil,self.frame.size.width,self.frame.size.height - self.lineLayer.lineWidth/2);
//        }
        

        if (self.shouldDrawTopLine) {
                    CGMutablePathRef path=CGPathCreateMutable();
            CGPathMoveToPoint(path, nil, 0, 0+self.topLineLayer.lineWidth/2);
            CGPathAddLineToPoint(path, nil,self.frame.size.width,0+self.topLineLayer.lineWidth/2);
            self.topLineLayer.path=path;
                    CGPathRelease(path);
            
        }
        if (self.shouldDrawBotLine) {
                    CGMutablePathRef path=CGPathCreateMutable();
            CGPathMoveToPoint(path, nil, self.botLineOffset, self.frame.size.height - self.bottomLineLayer.lineWidth/2);
            CGPathAddLineToPoint(path, nil,self.frame.size.width,self.frame.size.height - self.bottomLineLayer.lineWidth/2);
            self.bottomLineLayer.path=path;
                    CGPathRelease(path);
        }

        
  

    }
    
    
}

@end
