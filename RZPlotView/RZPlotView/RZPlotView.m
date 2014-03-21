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
    self.valuesAssigned = 0;
    self.maxNumberOfValues = floorf(self.frame.size.width);
    self.values = malloc(self.maxNumberOfValues * sizeof(double));
    
    // initialize yMin to 0 and yMax to height of frame
    _yMin = 0.f;
    _yMax = self.frame.size.height;
    
    _lineColor = 0.f;
    _lineAlpha = 1.f;
    _lineThickness = 1.0;
}

#pragma mark - Public interface

- (void)clear
{
    self.valuesAssigned = 0;
    self.values = malloc(self.maxNumberOfValues * sizeof(double));
}

- (void)addValue:(CGFloat)value
{
    @throw [NSException exceptionWithName:@"Abstract method invocation" reason:@"Should only be called by instance of subclass." userInfo:nil];
}

#pragma mark - Protected interface

- (void)setupPlotWithGrahicsContext:(CGContextRef)currentContext
{
    self.yRange = self.yMax - self.yMin;
    self.yScale = self.frame.size.height / self.yRange;
    
    // draw time axis
    CGContextSetLineWidth(currentContext, 1.0f);
    CGContextMoveToPoint(currentContext, 0.f, self.frame.size.height / 2.f);
    CGContextAddLineToPoint(currentContext, self.frame.size.width, self.frame.size.height / 2.f);
    CGContextSetStrokeColorWithColor(currentContext, [UIColor colorWithWhite:0.9f alpha:1.f].CGColor);
    CGContextStrokePath(currentContext);
}

#pragma mark - Properties

- (void)setYMax:(CGFloat)yMax
{
    _yMax = yMax;
    self.yRange = yMax - self.yMin;
    
    [self setNeedsDisplay];
}

- (void)setYMin:(CGFloat)yMin
{
    _yMin = yMin;
    self.yRange = self.yMax - yMin;
    
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