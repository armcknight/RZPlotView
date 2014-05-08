//
//  RZPlotView.m
//  RZPlotView
//
//  Created by andrew mcknight on 3/21/14.
//  Copyright (c) 2014 raizlabs. All rights reserved.
//

#import "RZPlotView.h"
#import "RZPlotView-Private.h"

@interface RZPlotView ()

- (void)commonInit;

@end

@implementation RZPlotView

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
    // initialize yMin to 0 and yMax to height of frame
    _yMin = 0.f;
    _yMax = self.frame.size.height;
    self.yRange = self.yMax - self.yMin;
    self.yScale = self.frame.size.height / self.yRange;
    
    _xMin = 0.f;
    _xMax = self.frame.size.width;
    self.xRange = self.xMax - self.xMin;
    self.xScale = self.frame.size.width / self.xRange;
    
    _lineColor = 0.f;
    _lineAlpha = 1.f;
    _lineThickness = 1.0;
    
    self.valuesAssigned = 0;
    self.values = malloc((NSUInteger)self.xRange * sizeof(double));
}

#pragma mark - Public interface

- (void)clear
{
    self.valuesAssigned = 0;
    self.values = malloc((NSUInteger)self.xRange * sizeof(double));
}

- (void)addValue:(CGFloat)value
{
    @throw [NSException exceptionWithName:@"Abstract method invocation" reason:@"Should only be called by instance of subclass." userInfo:nil];
}

#pragma mark - Protected interface

- (void)setupPlotWithGrahicsContext:(CGContextRef)currentContext
{
    // draw time axis
//    CGContextSetLineWidth(currentContext, 1.0f);
//    CGContextMoveToPoint(currentContext, 0.f, self.frame.size.height / 2.f);
//    CGContextAddLineToPoint(currentContext, self.frame.size.width, self.frame.size.height / 2.f);
//    CGContextSetStrokeColorWithColor(currentContext, [UIColor colorWithWhite:0.9f alpha:1.f].CGColor);
//    CGContextStrokePath(currentContext);
}

#pragma mark - Properties

- (void)setYMax:(CGFloat)yMax
{
    _yMax = yMax;
    self.yRange = yMax - self.yMin;
    self.yScale = self.frame.size.height / self.yRange;
    
    [self setNeedsDisplay];
}

- (void)setYMin:(CGFloat)yMin
{
    _yMin = yMin;
    self.yRange = self.yMax - yMin;
    self.yScale = self.frame.size.height / self.yRange;
    
    [self setNeedsDisplay];
}

- (void)setXMax:(CGFloat)xMax
{
    _xMax = xMax;
    self.xRange = xMax - self.xMin;
    self.xScale = self.frame.size.width / self.xRange;
    
    [self setNeedsDisplay];
}

- (void)setXMin:(CGFloat)xMin
{
    _xMin = xMin;
    self.xRange = self.xMax - xMin;
    self.xScale = self.frame.size.width / self.xRange;
    
    [self setNeedsDisplay];
}

- (void)setLineColor:(CGFloat)lineColor
{
    _lineColor = lineColor;
    
    [self setNeedsDisplay];
}

- (void)setLineAlpha:(CGFloat)lineAlpha
{
    _lineAlpha = lineAlpha;
    
    [self setNeedsDisplay];
}

- (void)setLineThickness:(CGFloat)lineThickness
{
    _lineThickness = lineThickness;
    
    [self setNeedsDisplay];
}

@end
