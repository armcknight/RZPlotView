//
//  RZScatterPlotView.m
//  RZPlotView
//
//  Created by andrew mcknight on 3/21/14.
//  Copyright (c) 2014 raizlabs. All rights reserved.
//

#import "RZScatterPlotView.h"
#import "RZPlotView-Private.h"
#import "RZStaticPlotView-Private.h"

@interface RZScatterPlotView ()

@property (strong, nonatomic) NSMutableArray *points; // NSMutableArray of CGPoints

@end

@implementation RZScatterPlotView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.points = [NSMutableArray array];
        
        _pointFillColor = 0.f;
        _pointBorderColor = 0.f;
        _pointRadius = 5.f;
        _pointBorderWidth = 2.f;
        _pointAlpha = 1.f;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.valuesAssigned > 1) {
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        
        [self setupPlotWithGrahicsContext:currentContext];
        
        CGContextSetLineWidth(currentContext, self.pointBorderWidth);
        CGContextSetStrokeColorWithColor(currentContext, [UIColor colorWithHue:self.pointBorderColor saturation:1.f brightness:1.f alpha:self.pointAlpha].CGColor);
        CGContextSetFillColorWithColor(currentContext, [UIColor colorWithHue:self.pointFillColor saturation:1.f brightness:1.f alpha:self.pointAlpha].CGColor);
        
        for (NSValue *pointValue in self.points) {
            CGPoint point = [pointValue CGPointValue];
            
            CGFloat xVal = (point.x - self.xMin) * self.xScale;
            CGFloat yVal = self.frame.size.height - ((point.y - self.yMin) * self.yScale);
            
            CGRect pointRect = CGRectMake(xVal - self.pointRadius, yVal - self.pointRadius, 2 * self.pointRadius, 2 * self.pointRadius);
            CGContextFillEllipseInRect(currentContext, pointRect);
            
            CGRect borderRect = CGRectMake(pointRect.origin.x - 0.5f * self.pointBorderWidth, pointRect.origin.y - 0.5f * self.pointBorderWidth, pointRect.size.width + self.pointBorderWidth, pointRect.size.width + self.pointBorderWidth);
            CGContextStrokeEllipseInRect(currentContext, borderRect);
        }
        
    }
}

#pragma mark - Public interface

- (void)addPoint:(CGPoint)point
{
    self.valuesAssigned++;
    [self.points addObject:[NSValue valueWithCGPoint:point]];
    
    [self setNeedsDisplay];
}

- (void)clear
{
    [self.points removeAllObjects];
    
    [self setNeedsDisplay];
}

#pragma mark - Properties

- (void)setPointAlpha:(CGFloat)pointAlpha
{
    _pointAlpha = pointAlpha;
    
    [self setNeedsDisplay];
}

- (void)setPointFillColor:(CGFloat)pointFillColor
{
    _pointFillColor = pointFillColor;
    
    [self setNeedsDisplay];
}

- (void)setPointBorderColor:(CGFloat)pointBorderColor
{
    _pointBorderColor = pointBorderColor;
    
    [self setNeedsDisplay];
}

- (void)setPointBorderWidth:(CGFloat)pointBorderWidth
{
    _pointBorderWidth = pointBorderWidth;
    
    [self setNeedsDisplay];
}

- (void)setPointRadius:(CGFloat)pointRadius
{
    _pointRadius = pointRadius;
    
    [self setNeedsDisplay];
}

@end
