//
//  RZStaticPlotView-Private.h
//  RZPlotView
//
//  Created by andrew mcknight on 3/21/14.
//  Copyright (c) 2014 raizlabs. All rights reserved.
//

#ifndef RZPlotView_RZStaticPlotView_Private_h
#define RZPlotView_RZStaticPlotView_Private_h

@interface RZStaticPlotView ()

- (void)drawEnvelopesWithGraphicsContext:(CGContextRef)currentContext;
- (void)drawLineWithGraphicsContext:(CGContextRef)currentContext;

@end

#endif
