//
//  TicketTicketList2.m
//
//  Created by   on 17/6/19
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "TicketTicketList2.h"
#import "TicketAttribute.h"


NSString *const kTicketTicketList2StatusMessage = @"statusMessage";
NSString *const kTicketTicketList2Attribute = @"attribute";
NSString *const kTicketTicketList2StatusCode = @"statusCode";


@interface TicketTicketList2 ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TicketTicketList2

@synthesize statusMessage = _statusMessage;
@synthesize attribute = _attribute;
@synthesize statusCode = _statusCode;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.statusMessage = [self objectOrNilForKey:kTicketTicketList2StatusMessage fromDictionary:dict];
            self.attribute = [TicketAttribute modelObjectWithDictionary:[dict objectForKey:kTicketTicketList2Attribute]];
            self.statusCode = [self objectOrNilForKey:kTicketTicketList2StatusCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.statusMessage forKey:kTicketTicketList2StatusMessage];
    [mutableDict setValue:[self.attribute dictionaryRepresentation] forKey:kTicketTicketList2Attribute];
    [mutableDict setValue:self.statusCode forKey:kTicketTicketList2StatusCode];

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

    self.statusMessage = [aDecoder decodeObjectForKey:kTicketTicketList2StatusMessage];
    self.attribute = [aDecoder decodeObjectForKey:kTicketTicketList2Attribute];
    self.statusCode = [aDecoder decodeObjectForKey:kTicketTicketList2StatusCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_statusMessage forKey:kTicketTicketList2StatusMessage];
    [aCoder encodeObject:_attribute forKey:kTicketTicketList2Attribute];
    [aCoder encodeObject:_statusCode forKey:kTicketTicketList2StatusCode];
}

- (id)copyWithZone:(NSZone *)zone {
    TicketTicketList2 *copy = [[TicketTicketList2 alloc] init];
    
    
    
    if (copy) {

        copy.statusMessage = [self.statusMessage copyWithZone:zone];
        copy.attribute = [self.attribute copyWithZone:zone];
        copy.statusCode = [self.statusCode copyWithZone:zone];
    }
    
    return copy;
}


@end
