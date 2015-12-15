//
//  Product.h
//  LZTaskManger
//
//  Created by comst on 15/12/16.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Product : NSManagedObject

@property (nonatomic, retain) NSNumber * productID;
@property (nonatomic, retain) NSString * productInfo;
@property (nonatomic, retain) NSNumber * productManufacterID;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSNumber * productOrignalID;
@property (nonatomic, retain) id productPhoto;
@property (nonatomic, retain) NSNumber * productPrice;
@property (nonatomic, retain) NSNumber * productQuantity;
@property (nonatomic, retain) NSManagedObject *manufacter;
@property (nonatomic, retain) NSSet *country;
@end

@interface Product (CoreDataGeneratedAccessors)

- (void)addCountryObject:(NSManagedObject *)value;
- (void)removeCountryObject:(NSManagedObject *)value;
- (void)addCountry:(NSSet *)values;
- (void)removeCountry:(NSSet *)values;

@end
