//
//  RZStaticStreamingPlotView.m
//  RZPlotView
//
//  Created by andrew mcknight on 3/21/14.
//  Copyright (c) 2014 raizlabs. All rights reserved.
//

#import "RZStaticStreamingPlotView.h"
#import "RZPlotView-Private.h"
#import "RZStaticPlotView-Private.h"
#import "RZBaseStreamingPlotView-Private.h"

@implementation RZStaticStreamingPlotView

- (void)drawRect:(CGRect)rect
{
    if (self.valuesAssigned > 1) {
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        
        [self setupPlotWithGrahicsContext:currentContext];
        
        [self drawEnvelopesWithGraphicsContext:currentContext];
        
        [self drawLineWithGraphicsContext:currentContext];
    }
}

#pragma mark - Public methods

- (void)addValue:(CGFloat)value
{
    if (self.valuesAssigned == self.maxNumberOfValues) {
        if (self.drawingMode == RZStreamingPlotDrawingModeShift) {
            //shift all values one to the left
            for (int i = 1; i < self.maxNumberOfValues; i++) {
                self.values[i-1] = self.values[i];
            }
            self.values[self.maxNumberOfValues - 1] = value;
        } else if (self.drawingMode == RZStreamingPlotDrawingModeWrap) {
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

@end
