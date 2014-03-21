//
//  RZStreamingPlotNibBasedViewController.m
//  RZPlotView
//
//  Created by Andrew McKnight on 12/13/13.
//  Copyright (c) 2013 raizlabs. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

#import "RZStreamingPlotNibBasedViewController.h"
#import "RZBaseStreamingPlotView.h"

@interface RZStreamingPlotNibBasedViewController ()

@property (weak, nonatomic) IBOutlet RZBaseStreamingPlotView *plotView;

@property (weak, nonatomic) IBOutlet UISlider *yMinSlider;
@property (weak, nonatomic) IBOutlet UISlider *yMaxSlider;
@property (weak, nonatomic) IBOutlet UISlider *lineWidthSlider;
@property (weak, nonatomic) IBOutlet UISlider *lineColorSlider;
@property (weak, nonatomic) IBOutlet UISlider *lineAlphaSlider;
@property (weak, nonatomic) IBOutlet UISlider *backgroundColorSlider;

@property (weak, nonatomic) IBOutlet UILabel *envelopeColorLabel;
@property (weak, nonatomic) IBOutlet UISlider *upperEnvelopeColorSlider;
@property (weak, nonatomic) IBOutlet UISlider *lowerEnvelopeColorSlider;

@property (weak, nonatomic) IBOutlet UILabel *tailLengthLabel;
@property (weak, nonatomic) IBOutlet UISlider *tailLengthSlider;

@property (weak, nonatomic) IBOutlet UISegmentedControl *drawingModeSegmentedControl;

@property (strong, nonatomic) CMMotionManager *motionManager;

@end

@implementation RZStreamingPlotNibBasedViewController

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
    
    [self.lineColorSlider setValue:0.f animated:YES];
    [self.lineAlphaSlider setValue:1.f animated:YES];
    [self.lineWidthSlider setValue:1.f animated:YES];
    
    [self.tailLengthSlider setValue:80.f animated:YES];
    self.plotView.tailLength = 80.f;
    
    [self.upperEnvelopeColorSlider setValue:0.f animated:YES];
    [self.lowerEnvelopeColorSlider setValue:0.f animated:YES];
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

- (IBAction)upperEnvelopeColorChanged:(id)sender {
    self.plotView.upperEnvelopeColor = self.upperEnvelopeColorSlider.value;
}

- (IBAction)lowerEnvelopeColorChanged:(id)sender {
    self.plotView.lowerEnvelopeColor = self.lowerEnvelopeColorSlider.value;
}

- (IBAction)yMinChanged:(id)sender {
    self.plotView.yMin = self.yMinSlider.value;
}

- (IBAction)yMaxChanged:(id)sender {
    self.plotView.yMax = self.yMaxSlider.value;
}

- (IBAction)tailLengthChanged:(id)sender {
    self.plotView.tailLength = self.tailLengthSlider.value;
}

- (IBAction)drawingModeChanged:(id)sender {
    self.envelopeColorLabel.hidden = self.drawingModeSegmentedControl.selectedSegmentIndex != RZStreamingPlotDrawingModeStream;
    self.upperEnvelopeColorSlider.hidden = self.drawingModeSegmentedControl.selectedSegmentIndex != RZStreamingPlotDrawingModeStream;
    self.lowerEnvelopeColorSlider.hidden = self.drawingModeSegmentedControl.selectedSegmentIndex != RZStreamingPlotDrawingModeStream;
    
    self.tailLengthLabel.hidden = self.drawingModeSegmentedControl.selectedSegmentIndex != RZStreamingPlotDrawingModePulse;
    self.tailLengthSlider.hidden = self.drawingModeSegmentedControl.selectedSegmentIndex != RZStreamingPlotDrawingModePulse;
    
    self.plotView.drawingMode = self.drawingModeSegmentedControl.selectedSegmentIndex;
}

@end
