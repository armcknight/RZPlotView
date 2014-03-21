//
//  GraphView.h
//  AccelerometerPlot
//
//  Created by andrew mcknight on 10/25/13.
//  Copyright (c) 2013 andrew mcknight. All rights reserved.
//

#import "RZStaticPlotView.h"

typedef enum {
    RZStreamingPlotDrawingModeShift,
    RZStreamingPlotDrawingModeWrap
} RZStreamingPlotDrawingMode;

@interface RZBaseStreamingPlotView : RZStaticPlotView

@property (assign, nonatomic) RZStreamingPlotDrawingMode drawingMode;

@end
