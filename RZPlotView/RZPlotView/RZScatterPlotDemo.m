//
//  RZScatterPlotDemo.m
//  RZPlotView
//
//  Created by andrew mcknight on 3/21/14.
//  Copyright (c) 2014 raizlabs. All rights reserved.
//

@import CoreMotion;

#import "RZScatterPlotDemo.h"

#import "RZScatterPlotView.h"

@interface RZScatterPlotDemo ()

@property (strong, nonatomic) IBOutlet RZScatterPlotView *plotView;
@property (strong, nonatomic) IBOutlet UIScrollView *controlsScrollView;
@property (strong, nonatomic) IBOutlet UIView *controlsView;

@property (strong, nonatomic) IBOutlet UILabel *xMinLabel;
@property (strong, nonatomic) IBOutlet UISlider *xMinSlider;

@property (strong, nonatomic) IBOutlet UILabel *xMaxLabel;
@property (strong, nonatomic) IBOutlet UISlider *xMaxSlider;

@property (strong, nonatomic) IBOutlet UILabel *yMinLabel;
@property (strong, nonatomic) IBOutlet UISlider *yMinSlider;

@property (strong, nonatomic) IBOutlet UILabel *yMaxLabel;
@property (strong, nonatomic) IBOutlet UISlider *yMaxSlider;

@property (strong, nonatomic) IBOutlet UISlider *fillColorSlider;
@property (strong, nonatomic) IBOutlet UISlider *borderColorSlider;
@property (strong, nonatomic) IBOutlet UISlider *pointSizeSlider;
@property (strong, nonatomic) IBOutlet UISlider *borderWidthSlider;
@property (strong, nonatomic) IBOutlet UISlider *pointAlphaSlider;

@property (strong, nonatomic) CMAltimeter *altimeter;
@property (assign, nonatomic) NSMutableArray *timeToAltitudeValues;

@end

@implementation RZScatterPlotDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.controlsScrollView addSubview:self.controlsView];
    self.controlsScrollView.contentSize = self.controlsView.frame.size;
    
    self.altimeter = [CMAltimeter new];
    
    static const NSUInteger min = -1000;
    static const NSUInteger max = 2000;
    self.xMinSlider.minimumValue = 0;
    self.xMinSlider.maximumValue = max;
    
    self.xMaxSlider.minimumValue = 1;
    self.xMaxSlider.maximumValue = max;
    
    CGFloat viewYMin = self.plotView.yMin;
    CGFloat viewYMax = self.plotView.yMax;
    
    self.yMinSlider.minimumValue = viewYMin;
    self.yMinSlider.maximumValue = 0;
    
    self.yMaxSlider.minimumValue = 1;
    self.yMaxSlider.maximumValue = viewYMax;
    
    [self.xMinSlider setValue:self.plotView.xMin animated:YES];
    [self.xMaxSlider setValue:self.plotView.xMax animated:YES];
    [self.yMinSlider setValue:self.plotView.yMin animated:YES];
    [self.yMaxSlider setValue:self.plotView.yMax animated:YES];
    
    self.xMinLabel.text = [NSString stringWithFormat:@"xMin: %f", self.plotView.xMin];
    self.xMaxLabel.text = [NSString stringWithFormat:@"xMax: %f", self.plotView.xMax];
    self.yMinLabel.text = [NSString stringWithFormat:@"yMin: %f", self.plotView.yMin];
    self.yMaxLabel.text = [NSString stringWithFormat:@"yMax: %f", self.plotView.yMax];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (IBAction)startPressed:(id)sender {
    ((UIButton *)sender).enabled = NO;
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    
    self.timeToAltitudeValues = [NSMutableArray array];
    
    dispatch_async(dispatch_queue_create("altitude readings", NULL), ^{
        [self.altimeter startRelativeAltitudeUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMAltitudeData *altitudeData, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.plotView addPoint:CGPointMake([[NSDate date] timeIntervalSince1970] - startTime, altitudeData.relativeAltitude.doubleValue)];
            });
        }];
    });
    
}
- (IBAction)stopPressed:(id)sender {
    [self.altimeter stopRelativeAltitudeUpdates];
}

- (IBAction)xMinChanged:(id)sender {
    CGFloat xMin = self.xMinSlider.value;
    NSLog(@"xMin: %.9f", xMin);
    self.plotView.xMin = xMin;
    self.xMinLabel.text = [NSString stringWithFormat:@"xMin: %f", xMin];
}
- (IBAction)xMaxChanged:(id)sender {
    CGFloat xMax = self.xMaxSlider.value;
    self.plotView.xMax = xMax;
    self.xMaxLabel.text = [NSString stringWithFormat:@"xMax: %f", xMax];
}
- (IBAction)yMinChanged:(id)sender {
    CGFloat yMin = self.yMinSlider.value;
    self.plotView.yMin = yMin;
    self.yMinLabel.text = [NSString stringWithFormat:@"yMin: %f", yMin];
}
- (IBAction)yMaxChanged:(id)sender {
    CGFloat yMax = self.yMaxSlider.value;
    self.plotView.yMax = yMax;
    self.yMaxLabel.text = [NSString stringWithFormat:@"yMax: %f", yMax];
}

- (IBAction)fillColorChanged:(id)sender {
    self.plotView.pointFillColor = self.fillColorSlider.value;
}

- (IBAction)borderColorChanged:(id)sender {
    self.plotView.pointBorderColor = self.borderColorSlider.value;
}

- (IBAction)pointSizeChanged:(id)sender {
    self.plotView.pointRadius = self.pointSizeSlider.value;
}

- (IBAction)borderWidthChanged:(id)sender {
    self.plotView.pointBorderWidth = self.borderWidthSlider.value;
}

- (IBAction)pointAlphaChanged:(id)sender {
    self.plotView.pointAlpha = self.pointAlphaSlider.value;
}

@end
