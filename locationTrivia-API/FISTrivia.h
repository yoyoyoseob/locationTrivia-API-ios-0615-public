//
//  FISTrivia.h
//  locationTrivia-Objects
//
//  Created by Joe Burgess on 5/15/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISTrivia : NSObject

@property (strong, nonatomic) NSString *content;
@property (nonatomic) NSInteger likes;

+(FISTrivia *)triviaFromDict:(NSDictionary *)trivium;
- (id)initWithContent:(NSString *)content Likes:(NSInteger)likes;
@end
