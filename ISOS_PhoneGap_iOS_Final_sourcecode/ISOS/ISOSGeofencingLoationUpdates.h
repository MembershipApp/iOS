//
//  ISOSGeofencingLoationUpdates.h
//  ISOS
//
//  Created by shishir on 18/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cordova/CDV.h>
#import <CoreLocation/CoreLocation.h>
@interface ISOSGeofencingLoationUpdates : CDVPlugin<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager; //  Location Manager object
    CLLocation *lastLocation;   // latest location of device
    CLLocation *lastLocationForCacheUpdate; //  cached location
    CLRegion *currentRegion;    //  Current Region to be monitored
    CLLocationDistance totalDistanceTravelled;  //  distance covered in meters
    
}
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (retain, readwrite) CLLocation *lastLocation;
@property (retain, readwrite) CLLocation *lastLocationForCacheUpdate;
@property (retain, nonatomic) CLRegion *currentRegion;
@property (nonatomic) CLLocationDistance totalDistanceTravelled;

/*
 * initializeLocationManager
 * Discussion:
 * Invoked to initialize location manager
 */

-(void)initializeLocationManager;

-(void)locationUpdatesGeofacing:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
/*
 * doAutoCheckIn:crossRegionMessage
 * Discussion:
 * Sends location details to server
 */
- (void)doAutoCheckIn:(NSString *)crossRegionMessage;

/*
 * getGeoLocationInJson:_latitude andLongitude:_longitude
 * Discussion:
 * Returns location details in json format
 */
- (NSString*)getGeoLocationInJson :(NSString*)_latitude andLongitude:(NSString*)_longitude;

@end
