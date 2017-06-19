//
//  TicketAttribute.m
//
//  Created by   on 17/6/19
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "TicketAttribute.h"
#import "TicketList.h"


NSString *const kTicketAttributeList = @"list";


@interface TicketAttribute ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TicketAttribute

@synthesize list = _list;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedTicketList = [dict objectForKey:kTicketAttributeList];
    NSMutableArray *parsedTicketList = [NSMutableArray array];
    
    if ([receivedTicketList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTicketList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTicketList addObject:[TicketList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTicketList isKindOfClass:[NSDictionary class]]) {
       [parsedTicketList addObject:[TicketList modelObjectWithDictionary:(NSDictionary *)receivedTicketList]];
    }

    self.list = [NSArray arrayWithArray:parsedTicketList];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kTicketAttributeList];

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

    self.list = [aDecoder decodeObjectForKey:kTicketAttributeList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_list forKey:kTicketAttributeList];
}

- (id)copyWithZone:(NSZone *)zone {
    TicketAttribute *copy = [[TicketAttribute alloc] init];
    
    
    
    if (copy) {

        copy.list = [self.list copyWithZone:zone];
    }
    
    return copy;
}


@end
