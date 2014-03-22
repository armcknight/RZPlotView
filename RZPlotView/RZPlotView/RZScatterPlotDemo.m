//
//  RZScatterPlotDemo.m
//  RZPlotView
//
//  Created by andrew mcknight on 3/21/14.
//  Copyright (c) 2014 raizlabs. All rights reserved.
//

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

@end

@implementation RZScatterPlotDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.controlsScrollView addSubview:self.controlsView];
    self.controlsScrollView.contentSize = self.controlsView.frame.size;
    
    [self.plotView addPoint:CGPointMake(50.f, 50.f)];
    [self.plotView addPoint:CGPointMake(100.f, 100.f)];
    [self.plotView addPoint:CGPointMake(150.f, 150.f)];
    [self.plotView addPoint:CGPointMake(200.f, 200.f)];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.xMinSlider.minimumValue = 0.f;
    self.xMinSlider.maximumValue = 100.f;
    
    self.xMaxSlider.minimumValue = 100.f;
    self.xMaxSlider.maximumValue = 300.f;
    
    self.yMinSlider.minimumValue = 0.f;
    self.yMinSlider.maximumValue = 100.f;
    
    self.yMaxSlider.minimumValue = 100.f;
    self.yMaxSlider.maximumValue = 300.f;
    
    [self.xMinSlider setValue:self.plotView.xMin animated:YES];
    [self.xMaxSlider setValue:self.plotView.xMax animated:YES];
    [self.yMinSlider setValue:self.plotView.yMin animated:YES];
    [self.yMaxSlider setValue:self.plotView.yMax animated:YES];
    
    self.xMinLabel.text = [NSString stringWithFormat:@"xMin: %f", self.plotView.xMin];
    self.xMaxLabel.text = [NSString stringWithFormat:@"xMax: %f", self.plotView.xMax];
    self.yMinLabel.text = [NSString stringWithFormat:@"yMin: %f", self.plotView.yMin];
    self.yMaxLabel.text = [NSString stringWithFormat:@"yMax: %f", self.plotView.yMax];
}

- (IBAction)xMinChanged:(id)sender {
    CGFloat xMin = self.xMinSlider.value;
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
