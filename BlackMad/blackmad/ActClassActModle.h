//
//  ActClassActModle.h
//
//  Created by   on 17/6/13
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ActAttribute;

@interface ActClassActModle : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *statusMessage;
@property (nonatomic, strong) ActAttribute *attribute;
@property (nonatomic, strong) NSString *statusCode;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
