//
//  RZStaticPlotView.m
//  RZPlotView
//
//  Created by andrew mcknight on 3/21/14.
//  Copyright (c) 2014 raizlabs. All rights reserved.
//

#import "RZStaticPlotView.h"
#import "RZPlotView-Private.h"

@interface RZStaticPlotView ()

- (void)commonInit;

@end

@implementation RZStaticPlotView

#pragma mark - Init

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Private interface

- (void)commonInit
{
    [super commonInit];
    
    _lowerEnvelopeColor = 1.f;
    _upperEnvelopeColor = 1.f;
}

#pragma mark - Protected interface

- (void)drawEnvelopesWithGraphicsContext:(CGContextRef)currentContext
{
    double yVal;
    CGContextSetLineWidth(currentContext, 1);
    CGContextSetStrokeColorWithColor(currentContext, [UIColor clearColor].CGColor);
    
    // draw upper envelope
    CGContextBeginPath(currentContext);
    yVal = self.yRange / 2.f - self.yScale * self.values[0];
    CGContextMoveToPoint(currentContext, 0, yVal);
    for(int i = 1; i < self.maxNumberOfValues; i++) {
        yVal = self.yRange / 2.f - self.yScale * self.values[i];
        CGContextAddLineToPoint(currentContext, i, yVal);
    }
    CGContextAddLineToPoint(currentContext, self.maxNumberOfValues, self.frame.size.height);
    CGContextAddLineToPoint(currentContext, 0, self.frame.size.height);
    yVal = self.yRange / 2.f - self.yScale * self.values[0];
    CGContextAddLineToPoint(currentContext, 0, yVal);
    CGContextClosePath(currentContext);
    CGContextSetFillColorWithColor(currentContext, [UIColor colorWithHue:self.upperEnvelopeColor saturation:1.f brightness:1.f alpha:self.upperEnvelopeColor].CGColor);
    CGContextFillPath(currentContext);
    
    // draw lower envelope
    CGContextBeginPath(currentContext);
    yVal = self.yRange / 2.f - self.yScale * self.values[0];
    CGContextMoveToPoint(currentContext, 0, yVal);
    for(int i = 1; i < self.maxNumberOfValues; i++) {
        yVal = self.yRange / 2.f - self.yScale * self.values[i];
        CGContextAddLineToPoint(currentContext, i, yVal);
    }
    CGContextAddLineToPoint(currentContext, self.maxNumberOfValues, 0);
    CGContextAddLineToPoint(currentContext, 0, 0);
    yVal = self.yRange / 2.f - self.yScale * self.values[0];
    CGContextAddLineToPoint(currentContext, 0, yVal);
    CGContextClosePath(currentContext);
    CGContextSetFillColorWithColor(currentContext, [UIColor colorWithHue:self.lowerEnvelopeColor saturation:1.f brightness:1.f alpha:self.lowerEnvelopeColor].CGColor);
    CGContextFillPath(currentContext);
}

- (void)drawLineWithGraphicsContext:(CGContextRef)currentContext
{
    // set plot line width/color
    double yVal;
    CGContextSetLineWidth(currentContext, 1.f);
    CGContextSetStrokeColorWithColor(currentContext, [UIColor colorWithHue:self.lineColor saturation:1.f brightness:1.f alpha:self.lineAlpha].CGColor);
    CGContextSetFillColorWithColor(currentContext, [UIColor colorWithHue:self.lineColor saturation:1.f brightness:1.f alpha:self.lineAlpha].CGColor);
    
    // draw line of given thickness by actually filling a polygon
    CGMutablePathRef path = CGPathCreateMutable();
    //
    // draw top of line
    //
    
    // draw first point
    yVal = self.yRange / 2.f - self.yScale * self.values[0] - self.lineThickness / 2.f;
    CGPathMoveToPoint(path, nil, 0.f, yVal);
    
    // draw remaining points
    for(int i = 1; i < self.maxNumberOfValues; i++) {
        yVal = self.yRange / 2.f - self.yScale * self.values[i] - self.lineThickness / 2.f;
        CGPathAddLineToPoint(path, nil, i, yVal);
    }
    
    //
    // draw bottom of line
    //
    for (NSInteger i = self.maxNumberOfValues - 1; i >= 0; i--) {
        yVal = self.yRange / 2.f - self.yScale * self.values[i] + self.lineThickness / 2.f;
        CGPathAddLineToPoint(path, nil, i, yVal);
    }
    
    // close polygon
    yVal = self.yRange / 2.f - self.yScale * self.values[0] - self.lineThickness / 2.f;
    CGPathAddLineToPoint(path, nil, 0, yVal);
    
    CGContextAddPath(currentContext, path);
    CGContextFillPath(currentContext);
    
    CGPathRelease(path);
}

#pragma mark - Properties

- (void)setUpperEnvelopeColor:(CGFloat)upperEnvelopeColor
{
    _upperEnvelopeColor = upperEnvelopeColor;
    
    [self setNeedsDisplay];
}

- (void)setLowerEnvelopeColor:(CGFloat)lowerEnvelopeColor
{
    _lowerEnvelopeColor = lowerEnvelopeColor;
    
    [self setNeedsDisplay];
}

@end
