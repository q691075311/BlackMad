//
//  TicketTicketList2.h
//
//  Created by   on 17/6/19
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TicketAttribute;

@interface TicketTicketList2 : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *statusMessage;
@property (nonatomic, strong) TicketAttribute *attribute;
@property (nonatomic, strong) NSString *statusCode;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
