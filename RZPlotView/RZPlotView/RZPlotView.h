//
//  RZPlotView.h
//  RZPlotView
//
//  Created by andrew mcknight on 3/21/14.
//  Copyright (c) 2014 raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZPlotView : UIView

@property (assign, nonatomic) CGFloat yMin;
@property (assign, nonatomic) CGFloat yMax;

@property (assign, nonatomic) CGFloat xMin;
@property (assign, nonatomic) CGFloat xMax;

@property (assign, nonatomic) CGFloat lineColor;
@property (assign, nonatomic) CGFloat lineAlpha;
@property (assign, nonatomic) CGFloat lineThickness;

- (void)addValue:(CGFloat)value;
- (void)clear;

@end
