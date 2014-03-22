//
//  RZScatterPlotView.h
//  RZPlotView
//
//  Created by andrew mcknight on 3/21/14.
//  Copyright (c) 2014 raizlabs. All rights reserved.
//

#import "RZStaticPlotView.h"

@interface RZScatterPlotView : RZStaticPlotView

@property (assign, nonatomic) CGFloat pointRadius;

@property (assign, nonatomic) CGFloat pointBorderColor;

@property (assign, nonatomic) CGFloat pointBorderWidth;

@property (assign, nonatomic) CGFloat pointFillColor;

@property (assign, nonatomic) CGFloat pointAlpha;

- (void)addPoint:(CGPoint)point;

@end
