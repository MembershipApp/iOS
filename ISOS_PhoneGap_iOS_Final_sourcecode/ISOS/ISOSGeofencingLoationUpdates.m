//
//  ISOSGeofencingLoationUpdates.m
//  ISOS
//
//  Created by shishir on 18/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ISOSGeofencingLoationUpdates.h"
#import "JSONClasses/JSON.h"

@implementation ISOSGeofencingLoationUpdates
@synthesize locationManager,lastLocation,currentRegion,totalDistanceTravelled;
@synthesize lastLocationForCacheUpdate;

- (void)locationUpdatesGeofacing:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    //Handle Geofencing for location updates
    [self initializeLocationManager];

}

#pragma mark - Initialize Location Manager
-(void)initializeLocationManager
{
    locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate=self;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    if ([CLLocationManager locationServicesEnabled]) {
        [locationManager startUpdatingLocation];
    }
    
    if (![CLLocationManager regionMonitoringAvailable]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Region monitoring is not available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    //  Creates a region with 300 meters of radius and location coordinates as center of the region
    self.currentRegion = [[[CLRegion alloc]initCircularRegionWithCenter:locationManager.location.coordinate radius:300 identifier:@"RegionMonitoringDistanceBased"]autorelease];
    [locationManager startMonitoringForRegion:currentRegion];   // available since iOS 5.0

}
#pragma mark - Location Manager Delegates

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
        
    if (oldLocation==nil || newLocation == nil)
        return;

    if(lastLocation == nil)
    {
        self.lastLocation = newLocation;
        self.lastLocationForCacheUpdate = newLocation;
    }

    NSString *currentLatitude = [NSString stringWithFormat:@"%lf",newLocation.coordinate.latitude];
    NSString *currentLongitude = [NSString stringWithFormat:@"%lf",newLocation.coordinate.longitude];
    
    //  update location coordinates in local storage every 10 seconds
    if (abs([lastLocationForCacheUpdate.timestamp timeIntervalSinceDate:newLocation.timestamp]) > 10){
        
        self.lastLocationForCacheUpdate = newLocation;
        NSString *geoLocationDictWithString = [self getGeoLocationInJson:currentLatitude andLongitude:currentLongitude];
    
        NSString *jsStatement = [NSString stringWithFormat:@"setGeoLocation('%@')",geoLocationDictWithString];
        [self writeJavascript:jsStatement];
    }
    
    
    // Distance based auto check-in in iOS 4.x
    
    if (floorf([[[UIDevice currentDevice]systemVersion]floatValue])<=10) {

        CLLocationDistance distanceBetween;
        
        if(fabs(lastLocation.altitude - newLocation.altitude) > 1.0)
        {
            double hDistance = [newLocation distanceFromLocation:lastLocation];
            double vDistance = fabs(lastLocation.altitude - newLocation.altitude);
            double temp = (hDistance * hDistance) + (vDistance * vDistance);
            
            distanceBetween = sqrt(temp);
        }
        else
        {
            distanceBetween  = [newLocation distanceFromLocation:lastLocation];
        }
        
        self.totalDistanceTravelled += distanceBetween;
        
        if(self.totalDistanceTravelled>300){
            self.totalDistanceTravelled = 0;
            NSString *geoLocationDictWithString = [self getGeoLocationInJson:currentLatitude andLongitude:currentLongitude];
            [self doAutoCheckIn:geoLocationDictWithString];
        }
    }
    
    //auto checkin after 900 seconds
    if(abs([lastLocation.timestamp timeIntervalSinceDate:newLocation.timestamp]) > 900)
    {
        self.lastLocation = newLocation;
        [manager stopMonitoringForRegion:self.currentRegion];
        
        //  Creates a region with 300 meters of radius and location coordinates as center of the region
        self.currentRegion = [[[CLRegion alloc]initCircularRegionWithCenter:self.lastLocation.coordinate radius:300 identifier:@"RegionMonitoringTimeBased"]autorelease];
        [locationManager startMonitoringForRegion:self.currentRegion];
                
        NSString *geoLocationDictWithString = [self getGeoLocationInJson:currentLatitude andLongitude:currentLongitude];
        
        [self doAutoCheckIn:geoLocationDictWithString];
        
    }
    else if([lastLocation.timestamp timeIntervalSinceDate:newLocation.timestamp] < 0)
    {
        self.lastLocation = newLocation;
    }    
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
       // Show some error message to user
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
}

- (void)locationManager:(CLLocationManager *)manager
         didExitRegion:(CLRegion *)region{
    //Auto checkin after crossing definite region boundary
    
    NSString *currentLatitude = [NSString stringWithFormat:@"%lf",manager.location.coordinate.latitude];
    NSString *currentLongitude = [NSString stringWithFormat:@"%lf",manager.location.coordinate.longitude];
    
    NSString *geoLocationDictWithString = [self getGeoLocationInJson:currentLatitude andLongitude:currentLongitude];
        
    [self doAutoCheckIn:geoLocationDictWithString];
    [manager stopMonitoringForRegion:region];
    
    
    //  Creates a region with 300 meters of radius and location coordinates as center of the region
    self.currentRegion = [[[CLRegion alloc]initCircularRegionWithCenter:manager.location.coordinate radius:300 identifier:@"RegionMonitoringDistanceBased"]autorelease];
    [locationManager startMonitoringForRegion:self.currentRegion];
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{

}

//received userinfo from app delegate
- (void)doAutoCheckIn:(NSString *)crossRegionMessage{
    
    NSString *jsStatement = [NSString stringWithFormat:@"regionNotificationCallback('%@')",crossRegionMessage];
    [self writeJavascript:jsStatement];
}

- (NSString*)getGeoLocationInJson :(NSString*)_latitude andLongitude:(NSString*)_longitude{
    NSMutableDictionary *locationDict = [NSMutableDictionary dictionary];
    [locationDict setObject:_latitude forKey:@"Latitude"];
    [locationDict setObject:_longitude forKey:@"Longitude"];
    
    return [locationDict JSONRepresentation];
}

- (void) dealloc
{
    [self.locationManager stopUpdatingLocation];
    [self.locationManager release],self.locationManager=nil;
    self.lastLocation = nil;
    self.currentRegion = nil;
	[super dealloc];
}
@end
