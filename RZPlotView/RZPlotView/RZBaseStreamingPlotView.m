//
//  GraphView.m
//  AccelerometerPlot
//
//  Created by andrew mcknight on 10/25/13.
//  Copyright (c) 2013 andrew mcknight. All rights reserved.
//

#import "RZBaseStreamingPlotView.h"
#import "RZPlotView-Private.h"
#import "RZStaticPlotView-Private.h"
#import "RZBaseStreamingPlotView-Private.h"

@interface RZBaseStreamingPlotView ()

- (void)commonInit;

@end

@implementation RZBaseStreamingPlotView

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
    self.replacementIndex = 0;
    self.headPointIndex = 0;
}

@end
