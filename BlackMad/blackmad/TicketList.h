//
//  TicketList.h
//
//  Created by   on 17/6/19
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TicketList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *cardVolumeList;
@property (nonatomic, assign) double listIdentifier;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSString *pictureAddress;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
