/**
 * Ti.GoogleMaps
 * Copyright (c) 2009-Present by Hans Knoechel, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiGooglemapsModule.h"
#import "TiGooglemapsClusterItemProxy.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation TiGooglemapsModule

#pragma mark Internal

- (id)moduleGUID
{
	return @"81fe0326-e874-4843-b902-51bbd46f9283";
}

- (NSString *)moduleId
{
	return @"ti.googlemaps";
}

#pragma mark Lifecycle

- (void)startup
{
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

#pragma Public APIs

- (void)setAPIKey:(id)value
{
    [GMSServices provideAPIKey:[TiUtils stringValue:value]];
}

- (NSString *)openSourceLicenseInfo
{
    return [GMSServices openSourceLicenseInfo];
}

- (NSNumber *)version
{
    return NUMINTEGER([GMSServices version]);
}

- (TiGooglemapsClusterItemProxy *)createClusterItem:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    id latitude = [args objectForKey:@"latitude"];
    ENSURE_TYPE(latitude, NSNumber);
    
    id longitude = [args objectForKey:@"longitude"];
    ENSURE_TYPE(longitude, NSNumber);
    
    id title = [args objectForKey:@"title"];
    ENSURE_TYPE_OR_NIL(title, NSString);

    id subtitle = [args objectForKey:@"subtitle"];
    ENSURE_TYPE_OR_NIL(subtitle, NSString);

    id icon = [args objectForKey:@"icon"];

    id userData = [args objectForKey:@"userData"];
    ENSURE_TYPE_OR_NIL(userData, NSDictionary);
    
    return [[[TiGooglemapsClusterItemProxy alloc] _initWithPageContext:[self pageContext]
                                                          andPosition:CLLocationCoordinate2DMake([TiUtils doubleValue:latitude], [TiUtils doubleValue:longitude])
                                                                title:title
                                                             subtitle:subtitle
                                                                 icon:icon
                                                             userData:userData] autorelease];
}

#pragma mark Constants

MAKE_SYSTEM_PROP(MAP_TYPE_HYBRID, kGMSTypeHybrid);
MAKE_SYSTEM_PROP(MAP_TYPE_NONE, kGMSTypeNone);
MAKE_SYSTEM_PROP(MAP_TYPE_NORMAL, kGMSTypeNormal);
MAKE_SYSTEM_PROP(MAP_TYPE_SATELLITE, kGMSTypeSatellite);
MAKE_SYSTEM_PROP(MAP_TYPE_TERRAIN, kGMSTypeTerrain);

MAKE_SYSTEM_PROP(APPEAR_ANIMATION_NONE, kGMSMarkerAnimationNone);
MAKE_SYSTEM_PROP(APPEAR_ANIMATION_POP, kGMSMarkerAnimationPop);

@end
