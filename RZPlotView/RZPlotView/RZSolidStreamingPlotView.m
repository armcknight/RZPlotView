//
//  RZStaticStreamingPlotView.m
//  RZPlotView
//
//  Created by andrew mcknight on 3/21/14.
//  Copyright (c) 2014 raizlabs. All rights reserved.
//

#import "RZSolidStreamingPlotView.h"
#import "RZPlotView-Private.h"
#import "RZStaticPlotView-Private.h"
#import "RZBaseStreamingPlotView-Private.h"

@implementation RZSolidStreamingPlotView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

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
    NSUInteger valueAmountLimit = (NSUInteger)self.xRange;
    if (self.valuesAssigned == valueAmountLimit) {
        if (self.drawingMode == RZStreamingPlotDrawingModeShift) {
            //shift all values one to the left
            for (int i = 1; i < valueAmountLimit; i++) {
                self.values[i-1] = self.values[i];
            }
            self.values[valueAmountLimit - 1] = value;
        } else if (self.drawingMode == RZStreamingPlotDrawingModeWrap) {
            if (self.replacementIndex >= valueAmountLimit) {
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
