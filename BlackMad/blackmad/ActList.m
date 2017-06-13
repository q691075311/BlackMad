//
//  ActList.m
//
//  Created by   on 17/6/13
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ActList.h"
#import "ActProductList.h"


NSString *const kActListId = @"id";
NSString *const kActListTypeName = @"typeName";
NSString *const kActListProductList = @"productList";
NSString *const kActListPictureAddress = @"pictureAddress";


@interface ActList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ActList

@synthesize listIdentifier = _listIdentifier;
@synthesize typeName = _typeName;
@synthesize productList = _productList;
@synthesize pictureAddress = _pictureAddress;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.listIdentifier = [[self objectOrNilForKey:kActListId fromDictionary:dict] doubleValue];
            self.typeName = [self objectOrNilForKey:kActListTypeName fromDictionary:dict];
    NSObject *receivedActProductList = [dict objectForKey:kActListProductList];
    NSMutableArray *parsedActProductList = [NSMutableArray array];
    
    if ([receivedActProductList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedActProductList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedActProductList addObject:[ActProductList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedActProductList isKindOfClass:[NSDictionary class]]) {
       [parsedActProductList addObject:[ActProductList modelObjectWithDictionary:(NSDictionary *)receivedActProductList]];
    }

    self.productList = [NSArray arrayWithArray:parsedActProductList];
            self.pictureAddress = [self objectOrNilForKey:kActListPictureAddress fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.listIdentifier] forKey:kActListId];
    [mutableDict setValue:self.typeName forKey:kActListTypeName];
    NSMutableArray *tempArrayForProductList = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.productList) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProductList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProductList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProductList] forKey:kActListProductList];
    [mutableDict setValue:self.pictureAddress forKey:kActListPictureAddress];

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

    self.listIdentifier = [aDecoder decodeDoubleForKey:kActListId];
    self.typeName = [aDecoder decodeObjectForKey:kActListTypeName];
    self.productList = [aDecoder decodeObjectForKey:kActListProductList];
    self.pictureAddress = [aDecoder decodeObjectForKey:kActListPictureAddress];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_listIdentifier forKey:kActListId];
    [aCoder encodeObject:_typeName forKey:kActListTypeName];
    [aCoder encodeObject:_productList forKey:kActListProductList];
    [aCoder encodeObject:_pictureAddress forKey:kActListPictureAddress];
}

- (id)copyWithZone:(NSZone *)zone {
    ActList *copy = [[ActList alloc] init];
    
    
    
    if (copy) {

        copy.listIdentifier = self.listIdentifier;
        copy.typeName = [self.typeName copyWithZone:zone];
        copy.productList = [self.productList copyWithZone:zone];
        copy.pictureAddress = [self.pictureAddress copyWithZone:zone];
    }
    
    return copy;
}


@end
