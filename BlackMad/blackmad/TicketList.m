//
//  TicketList.m
//
//  Created by   on 17/6/19
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "TicketList.h"
#import "TicketCardVolumeList.h"


NSString *const kTicketListCardVolumeList = @"cardVolumeList";
NSString *const kTicketListId = @"id";
NSString *const kTicketListTypeName = @"typeName";
NSString *const kTicketListPictureAddress = @"pictureAddress";


@interface TicketList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TicketList

@synthesize cardVolumeList = _cardVolumeList;
@synthesize listIdentifier = _listIdentifier;
@synthesize typeName = _typeName;
@synthesize pictureAddress = _pictureAddress;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedTicketCardVolumeList = [dict objectForKey:kTicketListCardVolumeList];
    NSMutableArray *parsedTicketCardVolumeList = [NSMutableArray array];
    
    if ([receivedTicketCardVolumeList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTicketCardVolumeList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTicketCardVolumeList addObject:[TicketCardVolumeList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTicketCardVolumeList isKindOfClass:[NSDictionary class]]) {
       [parsedTicketCardVolumeList addObject:[TicketCardVolumeList modelObjectWithDictionary:(NSDictionary *)receivedTicketCardVolumeList]];
    }

    self.cardVolumeList = [NSArray arrayWithArray:parsedTicketCardVolumeList];
            self.listIdentifier = [[self objectOrNilForKey:kTicketListId fromDictionary:dict] doubleValue];
            self.typeName = [self objectOrNilForKey:kTicketListTypeName fromDictionary:dict];
            self.pictureAddress = [self objectOrNilForKey:kTicketListPictureAddress fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForCardVolumeList = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.cardVolumeList) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCardVolumeList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCardVolumeList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCardVolumeList] forKey:kTicketListCardVolumeList];
    [mutableDict setValue:[NSNumber numberWithDouble:self.listIdentifier] forKey:kTicketListId];
    [mutableDict setValue:self.typeName forKey:kTicketListTypeName];
    [mutableDict setValue:self.pictureAddress forKey:kTicketListPictureAddress];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    self.cardVolumeList = [aDecoder decodeObjectForKey:kTicketListCardVolumeList];
    self.listIdentifier = [aDecoder decodeDoubleForKey:kTicketListId];
    self.typeName = [aDecoder decodeObjectForKey:kTicketListTypeName];
    self.pictureAddress = [aDecoder decodeObjectForKey:kTicketListPictureAddress];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cardVolumeList forKey:kTicketListCardVolumeList];
    [aCoder encodeDouble:_listIdentifier forKey:kTicketListId];
    [aCoder encodeObject:_typeName forKey:kTicketListTypeName];
    [aCoder encodeObject:_pictureAddress forKey:kTicketListPictureAddress];
}

- (id)copyWithZone:(NSZone *)zone {
    TicketList *copy = [[TicketList alloc] init];
    
    
    
    if (copy) {

        copy.cardVolumeList = [self.cardVolumeList copyWithZone:zone];
        copy.listIdentifier = self.listIdentifier;
        copy.typeName = [self.typeName copyWithZone:zone];
        copy.pictureAddress = [self.pictureAddress copyWithZone:zone];
    }
    
    return copy;
}


@end
