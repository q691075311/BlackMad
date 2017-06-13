//
//  ActClassActModle.m
//
//  Created by   on 17/6/13
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ActClassActModle.h"
#import "ActAttribute.h"


NSString *const kActClassActModleStatusMessage = @"statusMessage";
NSString *const kActClassActModleAttribute = @"attribute";
NSString *const kActClassActModleStatusCode = @"statusCode";


@interface ActClassActModle ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ActClassActModle

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
            self.statusMessage = [self objectOrNilForKey:kActClassActModleStatusMessage fromDictionary:dict];
            self.attribute = [ActAttribute modelObjectWithDictionary:[dict objectForKey:kActClassActModleAttribute]];
            self.statusCode = [self objectOrNilForKey:kActClassActModleStatusCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.statusMessage forKey:kActClassActModleStatusMessage];
    [mutableDict setValue:[self.attribute dictionaryRepresentation] forKey:kActClassActModleAttribute];
    [mutableDict setValue:self.statusCode forKey:kActClassActModleStatusCode];

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

    self.statusMessage = [aDecoder decodeObjectForKey:kActClassActModleStatusMessage];
    self.attribute = [aDecoder decodeObjectForKey:kActClassActModleAttribute];
    self.statusCode = [aDecoder decodeObjectForKey:kActClassActModleStatusCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_statusMessage forKey:kActClassActModleStatusMessage];
    [aCoder encodeObject:_attribute forKey:kActClassActModleAttribute];
    [aCoder encodeObject:_statusCode forKey:kActClassActModleStatusCode];
}

- (id)copyWithZone:(NSZone *)zone {
    ActClassActModle *copy = [[ActClassActModle alloc] init];
    
    
    
    if (copy) {

        copy.statusMessage = [self.statusMessage copyWithZone:zone];
        copy.attribute = [self.attribute copyWithZone:zone];
        copy.statusCode = [self.statusCode copyWithZone:zone];
    }
    
    return copy;
}


@end
