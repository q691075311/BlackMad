//
//  ActProductList.m
//
//  Created by   on 17/6/13
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ActProductList.h"


NSString *const kActProductListPromotionalPicturePath = @"promotionalPicturePath";
NSString *const kActProductListId = @"id";
NSString *const kActProductListActivityEndDate = @"activityEndDate";
NSString *const kActProductListActivityStartDate = @"activityStartDate";
NSString *const kActProductListProductName = @"productName";
NSString *const kActProductListProductSubject = @"productSubject";
NSString *const kActProductListPromotionalWapLink = @"promotionalWapLink";


@interface ActProductList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ActProductList

@synthesize promotionalPicturePath = _promotionalPicturePath;
@synthesize productListIdentifier = _productListIdentifier;
@synthesize activityEndDate = _activityEndDate;
@synthesize activityStartDate = _activityStartDate;
@synthesize productName = _productName;
@synthesize productSubject = _productSubject;
@synthesize promotionalWapLink = _promotionalWapLink;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.promotionalPicturePath = [self objectOrNilForKey:kActProductListPromotionalPicturePath fromDictionary:dict];
            self.productListIdentifier = [[self objectOrNilForKey:kActProductListId fromDictionary:dict] doubleValue];
            self.activityEndDate = [self objectOrNilForKey:kActProductListActivityEndDate fromDictionary:dict];
            self.activityStartDate = [self objectOrNilForKey:kActProductListActivityStartDate fromDictionary:dict];
            self.productName = [self objectOrNilForKey:kActProductListProductName fromDictionary:dict];
            self.productSubject = [self objectOrNilForKey:kActProductListProductSubject fromDictionary:dict];
            self.promotionalWapLink = [self objectOrNilForKey:kActProductListPromotionalWapLink fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.promotionalPicturePath forKey:kActProductListPromotionalPicturePath];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productListIdentifier] forKey:kActProductListId];
    [mutableDict setValue:self.activityEndDate forKey:kActProductListActivityEndDate];
    [mutableDict setValue:self.activityStartDate forKey:kActProductListActivityStartDate];
    [mutableDict setValue:self.productName forKey:kActProductListProductName];
    [mutableDict setValue:self.productSubject forKey:kActProductListProductSubject];
    [mutableDict setValue:self.promotionalWapLink forKey:kActProductListPromotionalWapLink];

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

    self.promotionalPicturePath = [aDecoder decodeObjectForKey:kActProductListPromotionalPicturePath];
    self.productListIdentifier = [aDecoder decodeDoubleForKey:kActProductListId];
    self.activityEndDate = [aDecoder decodeObjectForKey:kActProductListActivityEndDate];
    self.activityStartDate = [aDecoder decodeObjectForKey:kActProductListActivityStartDate];
    self.productName = [aDecoder decodeObjectForKey:kActProductListProductName];
    self.productSubject = [aDecoder decodeObjectForKey:kActProductListProductSubject];
    self.promotionalWapLink = [aDecoder decodeObjectForKey:kActProductListPromotionalWapLink];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_promotionalPicturePath forKey:kActProductListPromotionalPicturePath];
    [aCoder encodeDouble:_productListIdentifier forKey:kActProductListId];
    [aCoder encodeObject:_activityEndDate forKey:kActProductListActivityEndDate];
    [aCoder encodeObject:_activityStartDate forKey:kActProductListActivityStartDate];
    [aCoder encodeObject:_productName forKey:kActProductListProductName];
    [aCoder encodeObject:_productSubject forKey:kActProductListProductSubject];
    [aCoder encodeObject:_promotionalWapLink forKey:kActProductListPromotionalWapLink];
}

- (id)copyWithZone:(NSZone *)zone {
    ActProductList *copy = [[ActProductList alloc] init];
    
    
    
    if (copy) {

        copy.promotionalPicturePath = [self.promotionalPicturePath copyWithZone:zone];
        copy.productListIdentifier = self.productListIdentifier;
        copy.activityEndDate = [self.activityEndDate copyWithZone:zone];
        copy.activityStartDate = [self.activityStartDate copyWithZone:zone];
        copy.productName = [self.productName copyWithZone:zone];
        copy.productSubject = [self.productSubject copyWithZone:zone];
        copy.promotionalWapLink = [self.promotionalWapLink copyWithZone:zone];
    }
    
    return copy;
}


@end
