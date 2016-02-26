//
//  ViewController.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import MapKit;

#import "UIButton+BlockBased.h"
#import "UIView+JLAdditions.h"
#import "UPMapTargetView.h"
#import "UPProduct.h"
#import "UPFaresTableViewController.h"
#import "UPSeeFaresButton.h"
#import "UPUberAPI.h"
#import "UPUberMapViewController.h"
#import "UPUberMapViewDelegate.h"

@interface UPUberMapViewController ()

@property (nonatomic) UPUberMapViewDelegate *mapViewDelegate;
@property (nonatomic, readonly) UPUberAPI *uberAPI;
@property (nonatomic) UPFaresTableViewController *productsTableViewController;
@property (atomic) NSArray<UPFareEstimate *> *currentFareEstimates;

// UI
@property (nonatomic) UPSeeFaresButton *faresButton;
@property (nonatomic) MKMapView *mapView;
// End UI (not enough to get me to want to encapsulate in a subclass or separate nib yet)

@end

@implementation UPUberMapViewController

- (instancetype)initWithUberAPI:(UPUberAPI *)uberAPI
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _uberAPI = uberAPI;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadMapView];
}

- (void)loadFaresButton
{
    __weak typeof(self) weakSelf = self;
    UPSeeFaresButton *seeFaresButton = [[UPSeeFaresButton alloc] initWithFrame:CGRectZero clickHandler:^(UPSeeFaresButtonState state) {
        typeof(self)strongSelf = weakSelf;
        if (strongSelf) {
            switch (state) {
                case UPSeeFaresButtonStateNoFaresAvailable: {
                    //ignore, here for completeness
                    break;
                }
                case UPSeeFaresButtonStateFaresAvailable: {
                    [strongSelf presentFaresTable];
                    break;
                }
            }
        }
    }];
    [seeFaresButton sizeToFit];
    CGRect buttonFrame = seeFaresButton.bounds;
    buttonFrame = [self.view jl_frameHorizontallyCenteredForChildFrame:buttonFrame];
    buttonFrame = [self.view jl_frameAlignedBottom:buttonFrame bottomMargin:35.0];
    seeFaresButton.frame = buttonFrame;
    _faresButton = seeFaresButton;
    [self.mapView addSubview:self.faresButton];

}

- (void)loadMapView
{
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(37.7759856,-122.418248);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
    [self loadMapViewWithStartingRegion:region];
}

- (void)configureMapViewDelegate
{
    __weak typeof(self) weakSelf = self;
    self.mapViewDelegate.faresFoundCompletion = ^(NSArray<UPFareEstimate *> *fareEstimates) {
        typeof(self)strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf newFareEstimatesReceived:fareEstimates];
        }
    };

    self.mapViewDelegate.mapMovingCallback = ^{
        typeof(self)strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.faresButton.faresState = UPSeeFaresButtonStateNoFaresAvailable;
            [strongSelf dismissFaresTable];
        }
    };
}

// Ick, yeah, I know. Extract this out to a UIView, time pressure.
- (void)loadStartAndEndLabels
{
    UILabel *start = [[UILabel alloc] init];
    start.text = @"start";
    start.textColor = [UIColor blackColor];
    start.backgroundColor = [UIColor colorWithWhite:1.0 alpha:.8];
    [start sizeToFit];

    UILabel *end = [[UILabel alloc] init];
    end.text = @"end";
    end.textColor = [UIColor blackColor];
    end.backgroundColor = [UIColor colorWithWhite:1.0 alpha:.8];
    [end sizeToFit];

    CGRect startFrame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - CGRectGetHeight(start.frame), CGRectGetWidth(start.frame), CGRectGetHeight(start.frame));
    start.frame = startFrame;
    [self.mapView addSubview:start];

    CGRect endFrame = CGRectMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(end.frame), 20, CGRectGetWidth(end.frame), CGRectGetHeight(end.frame));
    end.frame = endFrame;
    [self.mapView addSubview:end];
}


- (void)dismissFaresTable
{
    [UIView animateWithDuration:.400 delay:0 options:0 animations:^{
        CGRect newFrame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) / 2);
        self.productsTableViewController.view.frame = newFrame;
    } completion:^(BOOL finished) {
        [self.productsTableViewController.view removeFromSuperview];
        [self.productsTableViewController removeFromParentViewController];
        self.productsTableViewController = nil;
    }];

}

- (void)presentFaresTable
{
    UPFaresTableViewController *productsTableViewController = [[UPFaresTableViewController alloc] initWithFares:self.currentFareEstimates];
    productsTableViewController.view.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) / 2);
    [self.view addSubview:productsTableViewController.view];
    [self addChildViewController:productsTableViewController];
    [productsTableViewController didMoveToParentViewController:self];
    self.productsTableViewController = productsTableViewController;
    [self.mapView setUserInteractionEnabled:NO];
    [UIView animateWithDuration:.400 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        CGRect newFrame = CGRectMake(0, CGRectGetHeight(self.view.bounds)/2, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) / 2);
        self.productsTableViewController.view.frame = newFrame;
    } completion:^(BOOL finished) {
        [self.mapView setUserInteractionEnabled:YES];
    }];

}

- (void)newFareEstimatesReceived:(NSArray<UPFareEstimate *> *)fareEstimates
{
    self.currentFareEstimates = fareEstimates;
    [self.faresButton setFaresState:(fareEstimates.count > 0)? UPSeeFaresButtonStateFaresAvailable: UPSeeFaresButtonStateNoFaresAvailable];
}

- (void)loadMapViewWithStartingRegion:(MKCoordinateRegion)region
{
    CGRect selfBounds = self.view.bounds;
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(selfBounds), CGRectGetHeight(selfBounds))];
    _mapViewDelegate = [[UPUberMapViewDelegate alloc] initWithUberAPI:self.uberAPI mapView:self.mapView];
    _mapView.delegate = self.mapViewDelegate;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.zoomEnabled = YES;
    _mapView.scrollEnabled = YES;
    _mapView.region = region;
    [self.view addSubview:_mapView];
    [self loadTargetView];
    [self configureMapViewDelegate];
    [self loadFaresButton];
    [self loadStartAndEndLabels];
}

- (void)loadTargetView
{
    UPMapTargetView *target = [[UPMapTargetView alloc] init];
    [self.mapView addSubview:target];
    CGRect targetFrame = [self.mapView jl_frameCenteredFrameForChildBounds:target.frame];
    target.frame = targetFrame;
}

@end
