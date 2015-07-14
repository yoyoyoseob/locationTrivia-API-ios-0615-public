//
//  FISLocationsDataStore.m
//  locationTrivia-dataStore
//
//  Created by Joe Burgess on 6/23/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISLocationsDataStore.h"
#import <AFNetworking/AFNetworking.h>
#import "FISLocationsAPIClient.h"
#import "FISLocation.h"

@implementation FISLocationsDataStore

+ (instancetype)sharedLocationsDataStore {
    static FISLocationsDataStore *_sharedLocationsDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLocationsDataStore = [[FISLocationsDataStore alloc] init];
    });

    return _sharedLocationsDataStore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.locations = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)getAllLocationsWithCompletion:(void (^)(BOOL))completionBlock
{
    [FISLocationsAPIClient getLocationTriviaWithCompletion:^(NSArray *results) {
        [self.locations removeAllObjects];
        for (NSDictionary *locationDictionary in results)
        {
            [self.locations addObject:[FISLocation locationFromDictionary:locationDictionary]];
        }
        completionBlock(YES);
    }];
}

-(void)addNewLocationWithName:(NSString *)name latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude withCompletion:(void (^)(BOOL))completionBlock
{
    [FISLocationsAPIClient addLocationWithName:name latitude:latitude longitude:longitude withCompletion:^(BOOL added) {
        NSLog(@"Successfully added");
        completionBlock(YES);
    }];
}

-(void)deleteLocationWithID:(NSNumber *)locationID withCompletion:(void (^)(BOOL))completionBlock
{
    [FISLocationsAPIClient deleteLocationWithID:locationID withCompletion:^(BOOL deleted) {
        if (deleted)
        completionBlock(YES);
    }];
}

@end
