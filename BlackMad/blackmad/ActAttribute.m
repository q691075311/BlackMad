//
//  ActAttribute.m
//
//  Created by   on 17/6/13
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ActAttribute.h"
#import "ActList.h"


NSString *const kActAttributeList = @"list";


@interface ActAttribute ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ActAttribute

@synthesize list = _list;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedActList = [dict objectForKey:kActAttributeList];
    NSMutableArray *parsedActList = [NSMutableArray array];
    
    if ([receivedActList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedActList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedActList addObject:[ActList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedActList isKindOfClass:[NSDictionary class]]) {
       [parsedActList addObject:[ActList modelObjectWithDictionary:(NSDictionary *)receivedActList]];
    }

    self.list = [NSArray arrayWithArray:parsedActList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForList = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.list) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kActAttributeList];

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

    self.list = [aDecoder decodeObjectForKey:kActAttributeList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_list forKey:kActAttributeList];
}

- (id)copyWithZone:(NSZone *)zone {
    ActAttribute *copy = [[ActAttribute alloc] init];
    
    
    
    if (copy) {

        copy.list = [self.list copyWithZone:zone];
    }
    
    return copy;
}


@end
