//
//  RZStaticPlotNibBasedViewController.m
//  RZPlotView
//
//  Created by Andrew McKnight on 12/13/13.
//  Copyright (c) 2013 raizlabs. All rights reserved.
//

@import CoreMotion;

#import "RZPulsePlotDemo.h"

#import "RZPulsePlotView.h"

@interface RZPulsePlotDemo ()

@property (strong, nonatomic) IBOutlet RZPulsePlotView *plotView;

@property (weak, nonatomic) IBOutlet UISlider *yMinSlider;
@property (weak, nonatomic) IBOutlet UISlider *yMaxSlider;
@property (weak, nonatomic) IBOutlet UISlider *lineWidthSlider;
@property (weak, nonatomic) IBOutlet UISlider *lineColorSlider;
@property (weak, nonatomic) IBOutlet UISlider *lineAlphaSlider;
@property (weak, nonatomic) IBOutlet UISlider *backgroundColorSlider;
@property (strong, nonatomic) IBOutlet UISlider *tailLengthSlider;

@property (strong, nonatomic) CMMotionManager *motionManager;

@end

@implementation RZPulsePlotDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.motionManager = [[CMMotionManager alloc] init];
    
    //    self.yMinSlider.minimumValue = self.plotView.frame.size.height * -2.f;
    //    self.yMinSlider.maximumValue = 0.f;
    //
    //    self.yMaxSlider.minimumValue = 1.f;
    //    self.yMaxSlider.maximumValue = self.plotView.frame.size.height * 2.f;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.plotView.tailLength = 80.f;
    
    [self.lineColorSlider setValue:0.f animated:YES];
    [self.lineAlphaSlider setValue:1.f animated:YES];
    [self.lineWidthSlider setValue:1.f animated:YES];
    
    [self.tailLengthSlider setValue:80.f animated:YES];
    self.plotView.upperEnvelopeColor = 0.f;
    self.plotView.lowerEnvelopeColor = 0.f;
    
    //    [self.yMinSlider setValue:-0.5f * self.plotView.frame.size.height animated:YES];
    //    [self.yMaxSlider setValue:0.5f * self.plotView.frame.size.height animated:YES];
    
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
    self.plotView.lineThickness = self.lineWidthSlider.value;
}

- (IBAction)backgroundColorChanged:(id)sender {
    self.plotView.backgroundColor = [UIColor colorWithHue:self.backgroundColorSlider.value saturation:1.f brightness:1.f alpha:1.f];
}

- (IBAction)yMinChanged:(id)sender {
    self.plotView.yMin = self.yMinSlider.value;
}

- (IBAction)yMaxChanged:(id)sender {
    self.plotView.yMax = self.yMaxSlider.value;
}

- (IBAction)tailLengthChanged:(id)sender
{
    self.plotView.tailLength = self.tailLengthSlider.value;
}

@end
