//
//  NetworkClient.h
//  CurriSchedule
//
//  Created by piner on 5/11/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "AFHTTPClient.h"

@interface NetworkClient : AFHTTPClient

+(id)sharedClient;
-(id)initWithBaseURL:(NSURL *)url;

@end
