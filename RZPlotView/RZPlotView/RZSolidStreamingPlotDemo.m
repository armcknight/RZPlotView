//
//  RZStreamingPlotNibBasedViewController.m
//  RZPlotView
//
//  Created by Andrew McKnight on 12/13/13.
//  Copyright (c) 2013 raizlabs. All rights reserved.
//

@import CoreMotion;

#import "RZSolidStreamingPlotDemo.h"
#import "RZSolidStreamingPlotView.h"

@interface RZSolidStreamingPlotDemo ()

@property (weak, nonatomic) IBOutlet RZSolidStreamingPlotView *plotView;
@property (strong, nonatomic) IBOutlet UIScrollView *controlsScrollView;
@property (strong, nonatomic) IBOutlet UIView *controlsView;

@property (weak, nonatomic) IBOutlet UISlider *yMinSlider;
@property (strong, nonatomic) IBOutlet UILabel *yMinLabel;

@property (weak, nonatomic) IBOutlet UISlider *yMaxSlider;
@property (strong, nonatomic) IBOutlet UILabel *yMaxLabel;

@property (strong, nonatomic) IBOutlet UISlider *xMaxSlider;
@property (strong, nonatomic) IBOutlet UILabel *xMaxLabel;

@property (weak, nonatomic) IBOutlet UISlider *lineWidthSlider;
@property (strong, nonatomic) IBOutlet UILabel *lineWidthLabel;

@property (weak, nonatomic) IBOutlet UISlider *lineColorSlider;

@property (weak, nonatomic) IBOutlet UISlider *lineAlphaSlider;

@property (weak, nonatomic) IBOutlet UISlider *backgroundColorSlider;

@property (weak, nonatomic) IBOutlet UILabel *envelopeColorLabel;
@property (weak, nonatomic) IBOutlet UISlider *upperEnvelopeColorSlider;
@property (weak, nonatomic) IBOutlet UISlider *lowerEnvelopeColorSlider;

@property (weak, nonatomic) IBOutlet UISegmentedControl *drawingModeSegmentedControl;

@property (strong, nonatomic) CMMotionManager *motionManager;

@end

@implementation RZSolidStreamingPlotDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.motionManager = [[CMMotionManager alloc] init];
    
    [self.controlsScrollView addSubview:self.controlsView];
    self.controlsScrollView.contentSize = self.controlsView.frame.size;
    
    self.yMinSlider.minimumValue = self.plotView.frame.size.height * -2.f;
    self.yMinSlider.maximumValue = 0.f;
    
    self.yMaxSlider.minimumValue = 1.f;
    self.yMaxSlider.maximumValue = self.plotView.frame.size.height * 2.f;
    
    self.xMaxSlider.minimumValue = self.plotView.frame.size.width * 0.5f;
    self.xMaxSlider.maximumValue = self.plotView.frame.size.width * 3.f;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.lineColorSlider setValue:0.f animated:YES];
    [self.lineAlphaSlider setValue:1.f animated:YES];
    [self.lineWidthSlider setValue:1.f animated:YES];
    
    [self.upperEnvelopeColorSlider setValue:0.f animated:YES];
    [self.lowerEnvelopeColorSlider setValue:0.f animated:YES];
    self.plotView.upperEnvelopeColor = 0.f;
    self.plotView.lowerEnvelopeColor = 0.f;
    
    CGFloat startYMin = -0.5f * self.plotView.frame.size.height;
    [self.yMinSlider setValue:startYMin animated:YES];
    self.yMinLabel.text = [NSString stringWithFormat:@"yMin: %f", startYMin];
    
    CGFloat startYMax = 0.5f * self.plotView.frame.size.height;
    [self.yMaxSlider setValue:startYMax animated:YES];
    self.yMaxLabel.text = [NSString stringWithFormat:@"yMax: %f", startYMax];
    
    CGFloat startXMax = self.plotView.frame.size.width;
    [self.xMaxSlider setValue:startXMax animated:YES];
    self.xMaxLabel.text = [NSString stringWithFormat:@"xMax: %f", startXMax];
    
    [self beginSensorReporting];
}

- (void)beginSensorReporting
{
    typeof(self) __weak wself = self;
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init]
                                             withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                                 [wself.plotView addValue:accelerometerData.acceleration.x];
                                             }];
}

- (IBAction)lineColorChanged:(id)sender {
    self.plotView.lineColor = self.lineColorSlider.value;
}

- (IBAction)lineAlphaChanged:(id)sender {
    self.plotView.lineAlpha = self.lineAlphaSlider.value;
}

- (IBAction)lineThicknessChanged:(id)sender {
    CGFloat lineWidth = self.lineWidthSlider.value;
    self.plotView.lineThickness = lineWidth;
    self.lineWidthLabel.text = [NSString stringWithFormat:@"line width: %f", lineWidth];
}

- (IBAction)backgroundColorChanged:(id)sender {
    self.plotView.backgroundColor = [UIColor colorWithHue:self.backgroundColorSlider.value saturation:1.f brightness:1.f alpha:1.f];
}

- (IBAction)upperEnvelopeColorChanged:(id)sender {
    self.plotView.upperEnvelopeColor = self.upperEnvelopeColorSlider.value;
}

- (IBAction)lowerEnvelopeColorChanged:(id)sender {
    self.plotView.lowerEnvelopeColor = self.lowerEnvelopeColorSlider.value;
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

- (IBAction)drawingModeChanged:(id)sender {
    self.plotView.drawingMode = self.drawingModeSegmentedControl.selectedSegmentIndex;
}

- (IBAction)xMaxChanged:(id)sender {
    CGFloat xMax = self.xMaxSlider.value;
    self.plotView.xMax = xMax;
    self.xMaxLabel.text = [NSString stringWithFormat:@"xMax: %f", xMax];
}


@end
