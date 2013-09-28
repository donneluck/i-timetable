//
//  NetworkClient.m
//  CurriSchedule
//
//  Created by piner on 5/11/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "NetworkClient.h"


@implementation NetworkClient

+ (id)sharedClient {
    static NetworkClient *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkClient alloc] initWithBaseURL:[NSURL URLWithString:_BaseURLString]];
    });
    
    return sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self setParameterEncoding:AFJSONParameterEncoding];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"text/plain"];
    }
    
    return self;
}


@end
