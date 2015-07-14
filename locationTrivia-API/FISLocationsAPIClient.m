//
//  FISLocationAPIClient.m
//  locationTrivia-API
//
//  Created by Yoseob Lee on 7/14/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import "FISLocationsAPIClient.h"
#import <AFNetworking/AFNetworking.h>

@implementation FISLocationsAPIClient

NSString *const HEROKU_API_URL = @"http://locationtrivia.herokuapp.com";
NSString *const API_KEY = @"1e7d00b154ca28f716d99f376947195d47f7ad0a";

+(void)getLocationTriviaWithCompletion:(void (^)(NSArray *results))completionBlock
{
    NSString *urlString = [NSString stringWithFormat:@"%@/locations.json?key=%@", HEROKU_API_URL, API_KEY];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        completionBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Looks like you got an error? %@", error.localizedDescription);
    }];
}

+(void)addLocationWithName:(NSString *)name latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude withCompletion:(void (^)(BOOL))completionBlock
{
    NSString *urlString = [NSString stringWithFormat:@"%@/locations.json?key=%@", HEROKU_API_URL, API_KEY];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{ @"location[name]" : name,
                              @"location[latitude]" : latitude,
                              @"location[longitude]" : longitude };
    
    [manager POST:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Success!");
        completionBlock(YES);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error in addLocation: %@", error.localizedDescription);
        completionBlock(NO);
    }];
}

+(void)deleteLocationWithID:(NSNumber *)locationID withCompletion:(void (^)(BOOL))completionBlock
{
    NSString *urlString = [NSString stringWithFormat:@"%@/locations/%@.json?key=%@", HEROKU_API_URL, locationID, API_KEY];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager DELETE:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Successfully Deleted!");
        completionBlock(YES);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"You seriously have an error when deleting: %@", error.localizedDescription);
        completionBlock(NO);
    }];
}


@end
