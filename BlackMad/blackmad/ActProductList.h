//
//  ActProductList.h
//
//  Created by   on 17/6/13
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ActProductList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *promotionalPicturePath;
@property (nonatomic, assign) double productListIdentifier;
@property (nonatomic, strong) NSString *activityEndDate;
@property (nonatomic, strong) NSString *activityStartDate;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productSubject;
@property (nonatomic, strong) NSString *promotionalWapLink;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
