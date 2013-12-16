//
//  GraphView.h
//  AccelerometerPlot
//
//  Created by andrew mcknight on 10/25/13.
//  Copyright (c) 2013 andrew mcknight. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    RZStreamingPlotDrawingModeStream,
    RZStreamingPlotDrawingModeWrap,
    RZStreamingPlotDrawingModePulse
} RZStreamingPlotDrawingMode;

@interface RZStreamingPlotView : UIView

@property (assign, nonatomic) RZStreamingPlotDrawingMode drawingMode;

@property (assign, nonatomic) CGFloat yMin;
@property (assign, nonatomic) CGFloat yMax;

@property (assign, nonatomic) CGFloat lineColor;
@property (assign, nonatomic) CGFloat lineAlpha;
@property (assign, nonatomic) CGFloat lineThickness;

@property (assign, nonatomic) CGFloat lowerEnvelopeColor;
@property (assign, nonatomic) CGFloat upperEnvelopeColor;

@property (assign, nonatomic) CGFloat tailLength;

- (void)addValue:(CGFloat)value;
- (void)clear;

@end
