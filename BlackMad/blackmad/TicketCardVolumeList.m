//
//  TicketCardVolumeList.m
//
//  Created by   on 17/6/19
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "TicketCardVolumeList.h"


NSString *const kTicketCardVolumeListCardType = @"cardType";
NSString *const kTicketCardVolumeListCardVolumeOriginalPrice = @"cardVolumeOriginalPrice";
NSString *const kTicketCardVolumeListId = @"id";
NSString *const kTicketCardVolumeListCardPictureAddress = @"cardPictureAddress";
NSString *const kTicketCardVolumeListCollection = @"collection";
NSString *const kTicketCardVolumeListCardName = @"cardName";
NSString *const kTicketCardVolumeListCardContent = @"cardContent";
NSString *const kTicketCardVolumeListCardVolumePresentPrice = @"cardVolumePresentPrice";
NSString *const kTicketCardVolumeListCardRemark = @"cardRemark";


@interface TicketCardVolumeList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TicketCardVolumeList

@synthesize cardType = _cardType;
@synthesize cardVolumeOriginalPrice = _cardVolumeOriginalPrice;
@synthesize cardVolumeListIdentifier = _cardVolumeListIdentifier;
@synthesize cardPictureAddress = _cardPictureAddress;
@synthesize collection = _collection;
@synthesize cardName = _cardName;
@synthesize cardContent = _cardContent;
@synthesize cardVolumePresentPrice = _cardVolumePresentPrice;
@synthesize cardRemark = _cardRemark;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.cardType = [self objectOrNilForKey:kTicketCardVolumeListCardType fromDictionary:dict];
            self.cardVolumeOriginalPrice = [[self objectOrNilForKey:kTicketCardVolumeListCardVolumeOriginalPrice fromDictionary:dict] doubleValue];
            self.cardVolumeListIdentifier = [[self objectOrNilForKey:kTicketCardVolumeListId fromDictionary:dict] doubleValue];
            self.cardPictureAddress = [self objectOrNilForKey:kTicketCardVolumeListCardPictureAddress fromDictionary:dict];
            self.collection = [[self objectOrNilForKey:kTicketCardVolumeListCollection fromDictionary:dict] boolValue];
            self.cardName = [self objectOrNilForKey:kTicketCardVolumeListCardName fromDictionary:dict];
            self.cardContent = [self objectOrNilForKey:kTicketCardVolumeListCardContent fromDictionary:dict];
            self.cardVolumePresentPrice = [[self objectOrNilForKey:kTicketCardVolumeListCardVolumePresentPrice fromDictionary:dict] doubleValue];
            self.cardRemark = [self objectOrNilForKey:kTicketCardVolumeListCardRemark fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cardType forKey:kTicketCardVolumeListCardType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cardVolumeOriginalPrice] forKey:kTicketCardVolumeListCardVolumeOriginalPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cardVolumeListIdentifier] forKey:kTicketCardVolumeListId];
    [mutableDict setValue:self.cardPictureAddress forKey:kTicketCardVolumeListCardPictureAddress];
    [mutableDict setValue:[NSNumber numberWithBool:self.collection] forKey:kTicketCardVolumeListCollection];
    [mutableDict setValue:self.cardName forKey:kTicketCardVolumeListCardName];
    [mutableDict setValue:self.cardContent forKey:kTicketCardVolumeListCardContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cardVolumePresentPrice] forKey:kTicketCardVolumeListCardVolumePresentPrice];
    [mutableDict setValue:self.cardRemark forKey:kTicketCardVolumeListCardRemark];

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

    self.cardType = [aDecoder decodeObjectForKey:kTicketCardVolumeListCardType];
    self.cardVolumeOriginalPrice = [aDecoder decodeDoubleForKey:kTicketCardVolumeListCardVolumeOriginalPrice];
    self.cardVolumeListIdentifier = [aDecoder decodeDoubleForKey:kTicketCardVolumeListId];
    self.cardPictureAddress = [aDecoder decodeObjectForKey:kTicketCardVolumeListCardPictureAddress];
    self.collection = [aDecoder decodeBoolForKey:kTicketCardVolumeListCollection];
    self.cardName = [aDecoder decodeObjectForKey:kTicketCardVolumeListCardName];
    self.cardContent = [aDecoder decodeObjectForKey:kTicketCardVolumeListCardContent];
    self.cardVolumePresentPrice = [aDecoder decodeDoubleForKey:kTicketCardVolumeListCardVolumePresentPrice];
    self.cardRemark = [aDecoder decodeObjectForKey:kTicketCardVolumeListCardRemark];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cardType forKey:kTicketCardVolumeListCardType];
    [aCoder encodeDouble:_cardVolumeOriginalPrice forKey:kTicketCardVolumeListCardVolumeOriginalPrice];
    [aCoder encodeDouble:_cardVolumeListIdentifier forKey:kTicketCardVolumeListId];
    [aCoder encodeObject:_cardPictureAddress forKey:kTicketCardVolumeListCardPictureAddress];
    [aCoder encodeBool:_collection forKey:kTicketCardVolumeListCollection];
    [aCoder encodeObject:_cardName forKey:kTicketCardVolumeListCardName];
    [aCoder encodeObject:_cardContent forKey:kTicketCardVolumeListCardContent];
    [aCoder encodeDouble:_cardVolumePresentPrice forKey:kTicketCardVolumeListCardVolumePresentPrice];
    [aCoder encodeObject:_cardRemark forKey:kTicketCardVolumeListCardRemark];
}

- (id)copyWithZone:(NSZone *)zone {
    TicketCardVolumeList *copy = [[TicketCardVolumeList alloc] init];
    
    
    
    if (copy) {

        copy.cardType = [self.cardType copyWithZone:zone];
        copy.cardVolumeOriginalPrice = self.cardVolumeOriginalPrice;
        copy.cardVolumeListIdentifier = self.cardVolumeListIdentifier;
        copy.cardPictureAddress = [self.cardPictureAddress copyWithZone:zone];
        copy.collection = self.collection;
        copy.cardName = [self.cardName copyWithZone:zone];
        copy.cardContent = [self.cardContent copyWithZone:zone];
        copy.cardVolumePresentPrice = self.cardVolumePresentPrice;
        copy.cardRemark = [self.cardRemark copyWithZone:zone];
    }
    
    return copy;
}


@end
