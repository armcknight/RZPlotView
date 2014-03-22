//
//  RZPlotView-Private.h
//  RZPlotView
//
//  Created by andrew mcknight on 3/21/14.
//  Copyright (c) 2014 raizlabs. All rights reserved.
//

#ifndef RZPlotView_RZPlotView_Private_h
#define RZPlotView_RZPlotView_Private_h

@interface RZPlotView ()

@property (assign, nonatomic) double * values;
@property (assign, nonatomic) NSUInteger valuesAssigned;

@property (assign, nonatomic) CGFloat yRange;
@property (assign, nonatomic) CGFloat yScale;

@property (assign, nonatomic) CGFloat xRange;
@property (assign, nonatomic) CGFloat xScale;

- (void)commonInit;
- (void)setupPlotWithGrahicsContext:(CGContextRef)currentContext;

@end


#endif
