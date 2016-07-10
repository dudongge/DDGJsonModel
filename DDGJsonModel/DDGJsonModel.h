//
//  DDGJsonModel.h
//  DDGJsonModel
//
//  Created by kaka on 16/7/10.
//  Copyright © 2016年 dudonggeTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDGJsonModel : NSObject
@property(nonatomic, strong)NSDictionary *propertyMapping;
//@property(nonatomic, strong)NSDictionary *propertyModelMapping;
+(id)ddg_objectWithValue:(id)dic;
+(NSDictionary*)propertyModelMapping;
+(NSDictionary*)propertyMapping;

@end
