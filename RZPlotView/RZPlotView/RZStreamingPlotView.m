//
//  GraphView.m
//  AccelerometerPlot
//
//  Created by andrew mcknight on 10/25/13.
//  Copyright (c) 2013 andrew mcknight. All rights reserved.
//

#import "RZStreamingPlotView.h"

@interface RZStreamingPlotView ()

@property (assign, nonatomic) double * values;
@property (assign, nonatomic) NSUInteger valuesAssigned;
@property (assign, nonatomic) NSUInteger replacementIndex;
@property (assign, nonatomic) NSUInteger headPointIndex;
@property (assign, nonatomic) NSUInteger maxNumberOfValues;
@property (assign, nonatomic) CGFloat yRange;

@end

@implementation RZStreamingPlotView

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

- (void)commonInit
{
    self.valuesAssigned = 0;
    self.maxNumberOfValues = floorf(self.frame.size.width);
    self.values = malloc(self.maxNumberOfValues * sizeof(double));
    
    self.replacementIndex = 0;
    self.headPointIndex = 0;
    
    // set defaults for customizable properties
    
    // initialize yMin to 0 and yMax to height of frame
    _yMin = 0.f;
    _yMax = self.frame.size.height;
    
    _lineColor = 0.f;
    _lineAlpha = 1.f;
    _lineThickness = 1.0;
    _lowerEnvelopeColor = 1.f;
    _upperEnvelopeColor = 1.f;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    if (self.valuesAssigned > 1) {
        self.yRange = self.yMax - self.yMin;
        double yScale = self.frame.size.height / self.yRange;
        
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
//        CGContextSetLineWidth(currentContext, 1.0f);
//        
//        // draw time axis
//        CGContextMoveToPoint(currentContext, 0.f, self.frame.size.height / 2.f);
//        CGContextAddLineToPoint(currentContext, self.frame.size.width, self.frame.size.height / 2.f);
//        CGContextSetStrokeColorWithColor(currentContext, [UIColor colorWithWhite:0.9f alpha:1.f].CGColor);
//        CGContextStrokePath(currentContext);
        
        // draw values
        double yVal;
        
        if (self.drawingMode == RZStreamingPlotDrawingModeStream || self.drawingMode == RZStreamingPlotDrawingModeWrap) {
            CGContextSetLineWidth(currentContext, 1);
            CGContextSetStrokeColorWithColor(currentContext, [UIColor clearColor].CGColor);
            
            // draw upper envelope
            CGContextBeginPath(currentContext);
            yVal = self.yRange / 2.f - yScale * self.values[0];
            CGContextMoveToPoint(currentContext, 0, yVal);
            for(int i = 1; i < self.maxNumberOfValues; i++) {
                yVal = self.yRange / 2.f - yScale * self.values[i];
                CGContextAddLineToPoint(currentContext, i, yVal);
            }
            CGContextAddLineToPoint(currentContext, self.maxNumberOfValues, self.frame.size.height);
            CGContextAddLineToPoint(currentContext, 0, self.frame.size.height);
            yVal = self.yRange / 2.f - yScale * self.values[0];
            CGContextAddLineToPoint(currentContext, 0, yVal);
            CGContextClosePath(currentContext);
            CGContextSetFillColorWithColor(currentContext, [UIColor colorWithHue:self.upperEnvelopeColor saturation:1.f brightness:1.f alpha:self.upperEnvelopeColor].CGColor);
            CGContextFillPath(currentContext);
            
            // draw lower envelope
            CGContextBeginPath(currentContext);
            yVal = self.yRange / 2.f - yScale * self.values[0];
            CGContextMoveToPoint(currentContext, 0, yVal);
            for(int i = 1; i < self.maxNumberOfValues; i++) {
                yVal = self.yRange / 2.f - yScale * self.values[i];
                CGContextAddLineToPoint(currentContext, i, yVal);
            }
            CGContextAddLineToPoint(currentContext, self.maxNumberOfValues, 0);
            CGContextAddLineToPoint(currentContext, 0, 0);
            yVal = self.yRange / 2.f - yScale * self.values[0];
            CGContextAddLineToPoint(currentContext, 0, yVal);
            CGContextClosePath(currentContext);
            CGContextSetFillColorWithColor(currentContext, [UIColor colorWithHue:self.lowerEnvelopeColor saturation:1.f brightness:1.f alpha:self.lowerEnvelopeColor].CGColor);
            CGContextFillPath(currentContext);
            
            // set plot line width/color
            CGContextSetLineWidth(currentContext, 1.f);
            CGContextSetStrokeColorWithColor(currentContext, [UIColor colorWithHue:self.lineColor saturation:1.f brightness:1.f alpha:self.lineAlpha].CGColor);
            CGContextSetFillColorWithColor(currentContext, [UIColor colorWithHue:self.lineColor saturation:1.f brightness:1.f alpha:self.lineAlpha].CGColor);
            
            // draw line of given thickness by actually filling a polygon
            CGMutablePathRef path = CGPathCreateMutable();
            //
            // draw top of line
            //
            
            // draw first point
            yVal = self.yRange / 2.f - yScale * self.values[0] - self.lineThickness / 2.f;
            CGPathMoveToPoint(path, nil, 0.f, yVal);
            
            // draw remaining points
            for(int i = 1; i < self.maxNumberOfValues; i++) {
                yVal = self.yRange / 2.f - yScale * self.values[i] - self.lineThickness / 2.f;
                CGPathAddLineToPoint(path, nil, i, yVal);
            }
            
            //
            // draw bottom of line
            //
            for (NSInteger i = self.maxNumberOfValues - 1; i >= 0; i--) {
                yVal = self.yRange / 2.f - yScale * self.values[i] + self.lineThickness / 2.f;
                CGPathAddLineToPoint(path, nil, i, yVal);
            }
            
            // close polygon
            yVal = self.yRange / 2.f - yScale * self.values[0] - self.lineThickness / 2.f;
            CGPathAddLineToPoint(path, nil, 0, yVal);
            
            CGContextAddPath(currentContext, path);
            CGContextFillPath(currentContext);
            
        } else if (self.drawingMode == RZStreamingPlotDrawingModePulse) {
            // set plot line width/color
            CGContextSetLineWidth(currentContext, self.lineThickness);
            CGContextSetStrokeColorWithColor(currentContext, [UIColor colorWithHue:self.lineColor saturation:1.f brightness:1.f alpha:self.lineAlpha].CGColor);
            CGContextSetFillColorWithColor(currentContext, [UIColor colorWithHue:self.lineColor saturation:1.f brightness:1.f alpha:self.lineAlpha].CGColor);
            
            // draw first point
            if (self.headPointIndex < self.valuesAssigned) {
                yVal = self.yRange / 2.f - yScale * self.values[self.headPointIndex];
                CGContextFillEllipseInRect(currentContext, CGRectMake(self.headPointIndex - self.lineThickness / 2.f, yVal - self.lineThickness / 2.f, self.lineThickness, self.lineThickness));
                CGContextMoveToPoint(currentContext, self.headPointIndex, yVal);
            }
            
            // draw trailing points
            CGFloat currentAlpha = 255.f;
            for(int i = (int)self.headPointIndex; self.tailLength > self.headPointIndex - i && i > 0; i--) {
                if (i < self.valuesAssigned) {
                    yVal = self.yRange / 2.f - yScale * self.values[i];
                    CGContextAddLineToPoint(currentContext, i, yVal);
                    CGContextSetStrokeColorWithColor(currentContext, [UIColor colorWithHue:self.lineColor saturation:1.f brightness:1.f alpha:currentAlpha/255.f].CGColor);
                    CGContextSetFillColorWithColor(currentContext, [UIColor colorWithHue:self.lineColor saturation:1.f brightness:1.f alpha:currentAlpha/255.f].CGColor);
                    CGContextStrokePath(currentContext);
                    CGContextFillEllipseInRect(currentContext, CGRectMake(i - self.lineThickness / 2.f, yVal - self.lineThickness / 2.f, self.lineThickness, self.lineThickness));
                    CGContextMoveToPoint(currentContext, i, yVal);
                } else {
                    yVal = self.yRange / 2.f - yScale * self.values[self.valuesAssigned-1];
                    CGContextMoveToPoint(currentContext, self.valuesAssigned-1, yVal);
                }
                currentAlpha -= 255.f / self.tailLength;
            }
            self.headPointIndex = (self.headPointIndex + 1) % (self.valuesAssigned + (int)self.tailLength);
        }
    }
}

#pragma mark - Public methods

- (void)addValue:(CGFloat)value
{
    if (self.valuesAssigned == self.maxNumberOfValues) {
        if (self.drawingMode == RZStreamingPlotDrawingModeStream) {
            //shift all values one to the left
            for (int i = 1; i < self.maxNumberOfValues; i++) {
                self.values[i-1] = self.values[i];
            }
            self.values[self.maxNumberOfValues - 1] = value;
        } else if (self.drawingMode == RZStreamingPlotDrawingModeWrap || self.drawingMode == RZStreamingPlotDrawingModePulse) {
            if (self.replacementIndex >= self.maxNumberOfValues) {
                self.replacementIndex = 0;
            }
            self.values[self.replacementIndex++] = value;
            self.headPointIndex = self.replacementIndex;
        }
    } else {
        self.values[self.valuesAssigned++] = value;
        self.headPointIndex = self.valuesAssigned;
    }
    [self performSelectorOnMainThread:@selector(setNeedsDisplay) withObject:self waitUntilDone:NO];
}

- (void)clear
{
    self.valuesAssigned = 0;
    self.values = malloc(self.maxNumberOfValues * sizeof(double));
}

#pragma mark - Property overrides

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

- (void)setLineThickness:(CGFloat)lineThickness
{
    _lineThickness = lineThickness;
    
    [self setNeedsDisplay];
}

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
- (void)setTailLength:(CGFloat)tailLength
{
    _tailLength = tailLength;
    
    [self setNeedsDisplay];
}

@end
