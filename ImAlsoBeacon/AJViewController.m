//
//  AJViewController.m
//  ImAlsoBeacon
//
//  Created by Alexandre Joly on 25.09.13.
//  Copyright (c) 2013 Alexandre Joly. All rights reserved.
//

#import "AJViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface AJViewController ()

@property (nonatomic, retain) NSUUID *uuid;

@property (nonatomic, retain) CLBeaconRegion *beaconRegion;
@property (nonatomic, retain) CBPeripheralManager *manager;

@end

@implementation AJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    _uuid = [[NSUUID alloc] initWithUUIDString:@"60D481BE-D401-42F0-9760-B8296EE2CC5F"];
    NSString *identifier = [[UIDevice currentDevice] name];

    _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:_uuid identifier:identifier];
    _manager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CBPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state != CBPeripheralManagerStatePoweredOn) {
        return;
    }

    NSDictionary *payload = [_beaconRegion peripheralDataWithMeasuredPower:nil];

    [_manager startAdvertising:payload];
}

@end
