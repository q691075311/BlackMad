//
//  TicketCardVolumeList.h
//
//  Created by   on 17/6/19
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TicketCardVolumeList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *cardType;
@property (nonatomic, assign) double cardVolumeOriginalPrice;
@property (nonatomic, assign) double cardVolumeListIdentifier;
@property (nonatomic, strong) NSString *cardPictureAddress;
@property (nonatomic, assign) BOOL collection;
@property (nonatomic, strong) NSString *cardName;
@property (nonatomic, strong) NSString *cardContent;
@property (nonatomic, assign) double cardVolumePresentPrice;
@property (nonatomic, strong) NSString *cardRemark;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
