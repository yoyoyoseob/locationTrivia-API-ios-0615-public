//
//  FISLocationAPIClient.h
//  locationTrivia-API
//
//  Created by Yoseob Lee on 7/14/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const HEROKU_API_URL;
extern NSString *const API_KEY;

@interface FISLocationsAPIClient : NSObject

+(void)getLocationTriviaWithCompletion:(void (^)(NSArray *results))completionBlock;
+(void)addLocationWithName:(NSString *)name latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude withCompletion:(void (^)(BOOL added))completionBlock;
+(void)deleteLocationWithID:(NSNumber *)locationID withCompletion:(void (^)(BOOL))completionBlock;

@end
