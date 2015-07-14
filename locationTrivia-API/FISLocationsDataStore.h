//
//  FISLocationsDataStore.h
//  locationTrivia-dataStore
//
//  Created by Joe Burgess on 6/23/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISLocationsDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *locations;
+ (instancetype)sharedLocationsDataStore;
- (instancetype)init;
- (void)getAllLocationsWithCompletion:(void (^)(BOOL))completionBlock;
- (void)addNewLocationWithName:(NSString *)name latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude withCompletion:(void (^)(BOOL))completionBlock;
- (void)deleteLocationWithID:(NSNumber *)locationID withCompletion:(void (^)(BOOL))completionBlock;

@end
