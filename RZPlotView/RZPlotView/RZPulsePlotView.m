//
//  RZPulsePlotView.m
//  RZPlotView
//
//  Created by andrew mcknight on 3/21/14.
//  Copyright (c) 2014 raizlabs. All rights reserved.
//

#import "RZPulsePlotView.h"
#import "RZPlotView-Private.h"
#import "RZBaseStreamingPlotView-Private.h"

@interface RZPulsePlotView ()

@end

@implementation RZPulsePlotView

- (void)drawRect:(CGRect)rect
{
    if (self.valuesAssigned > 1) {
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        
        [self setupPlotWithGrahicsContext:currentContext];
        
        double yVal;
        
        // set plot line width/color
        CGContextSetLineWidth(currentContext, self.lineThickness);
        CGContextSetStrokeColorWithColor(currentContext, [UIColor colorWithHue:self.lineColor saturation:1.f brightness:1.f alpha:self.lineAlpha].CGColor);
        CGContextSetFillColorWithColor(currentContext, [UIColor colorWithHue:self.lineColor saturation:1.f brightness:1.f alpha:self.lineAlpha].CGColor);
        
        // draw first point
        if (self.headPointIndex < self.valuesAssigned) {
            yVal = self.yRange / 2.f - self.yScale * self.values[self.headPointIndex];
            CGContextFillEllipseInRect(currentContext, CGRectMake(self.headPointIndex - self.lineThickness / 2.f, yVal - self.lineThickness / 2.f, self.lineThickness, self.lineThickness));
            CGContextMoveToPoint(currentContext, self.headPointIndex, yVal);
        }
        
        // draw trailing points
        CGFloat currentAlpha = 255.f;
        for(int i = (int)self.headPointIndex; self.tailLength > self.headPointIndex - i && i > 0; i--) {
            if (i < self.valuesAssigned) {
                yVal = self.yRange / 2.f - self.yScale * self.values[i];
                CGContextAddLineToPoint(currentContext, i, yVal);
                CGContextSetStrokeColorWithColor(currentContext, [UIColor colorWithHue:self.lineColor saturation:1.f brightness:1.f alpha:currentAlpha/255.f].CGColor);
                CGContextSetFillColorWithColor(currentContext, [UIColor colorWithHue:self.lineColor saturation:1.f brightness:1.f alpha:currentAlpha/255.f].CGColor);
                CGContextStrokePath(currentContext);
                CGContextFillEllipseInRect(currentContext, CGRectMake(i - self.lineThickness / 2.f, yVal - self.lineThickness / 2.f, self.lineThickness, self.lineThickness));
                CGContextMoveToPoint(currentContext, i, yVal);
            } else {
                yVal = self.yRange / 2.f - self.yScale * self.values[self.valuesAssigned-1];
                CGContextMoveToPoint(currentContext, self.valuesAssigned-1, yVal);
            }
            currentAlpha -= 255.f / self.tailLength;
        }
        self.headPointIndex = (self.headPointIndex + 1) % (self.valuesAssigned + (int)self.tailLength);
    }
}

#pragma mark - Public interface

- (void)addValue:(CGFloat)value
{
    if (self.valuesAssigned == self.maxNumberOfValues) {
        if (self.replacementIndex >= self.maxNumberOfValues) {
            self.replacementIndex = 0;
        }
        self.values[self.replacementIndex++] = value;
        self.headPointIndex = self.replacementIndex;
    } else {
        self.values[self.valuesAssigned++] = value;
        self.headPointIndex = self.valuesAssigned;
    }
    [self performSelectorOnMainThread:@selector(setNeedsDisplay) withObject:self waitUntilDone:NO];
}

#pragma mark - Properties

- (void)setTailLength:(CGFloat)tailLength
{
    _tailLength = tailLength;
    
    [self setNeedsDisplay];
}

@end
