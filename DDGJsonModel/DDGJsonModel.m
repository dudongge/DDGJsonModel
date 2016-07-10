//
//  DDGJsonModel.m
//  DDGJsonModel
//
//  Created by kaka on 16/7/10.
//  Copyright © 2016年 dudonggeTeam. All rights reserved.
//

#import "DDGJsonModel.h"
#import <objc/runtime.h>
#include <assert.h>
typedef NS_ENUM(NSInteger, DDG_ValueType) {
    DDG_ARRAY = 0,
    DDG_STRING,
    DDG_DIC,
    DDG_OBJ,
    
};
@implementation DDGJsonModel
static char mappingDicKey;
+(NSDictionary*)propertyModelMapping {
    return @{};
}
+(NSDictionary*)propertyMapping {
    return @{};
}
+(id)ddg_objectWithValue:(id)dic {
    //得到所有属性
    NSMutableArray *allNames = [[NSMutableArray alloc] init];
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertys);
    
    //得到JSON的所有key
    NSArray *allKeys = [NSArray array];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        allKeys = [((NSDictionary *)dic) allKeys];
    }
    
    Class cla = [self class];
    id model = [[cla alloc] init];
    for (NSString *p in allKeys) {
        
        //        NSAssert([allNames containsObject:p], @"没有对应的属性");
        
        id pValue = [((NSDictionary *)dic) valueForKey:p];
        id mappingPerprotyName = [[self propertyMapping] valueForKey:p];
        DDG_ValueType valueType = [self DDG_getValueTypeBy:pValue];
        id propertyValue;
        switch (valueType) {
            case DDG_ARRAY:{
                propertyValue = [self  DDG_getArrayModelBy:pValue andKey:p];
            }
                break;
            case DDG_DIC: {
                propertyValue = [self  DDG_getObjectPropertyBy:pValue andKey:p];
            }
                break;
            case DDG_STRING:
                propertyValue = pValue;
                break;
            default:
                break;
        }
        if (mappingPerprotyName) {
            [model setValue:propertyValue forKey:mappingPerprotyName];
        } else {
            [model setValue:propertyValue forKey:p];
            
        }
    }
    return model;
    
}
+(DDG_ValueType)DDG_getValueTypeBy:(id)value {
    if ([value isKindOfClass:[NSArray class]]) {
        return DDG_ARRAY;
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        return DDG_DIC;
    } else if ([value isKindOfClass:[NSString class]]) {
        return DDG_STRING;
    } else {
        return DDG_OBJ;
    }
}
+(id)DDG_getArrayModelBy:(id)valueArr andKey:(NSString*)key {
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *mappingDic = objc_getAssociatedObject(self, &mappingDicKey);
    NSString *className = [mappingDic valueForKey:key];
    Class cla = NSClassFromString(className);
    if ([valueArr isKindOfClass:[NSArray class]]) {
        for (id value in valueArr) {
            id propertValue = [cla ddg_objectWithValue:value];
            [arr addObject:propertValue];
        }
    }
    return arr;
}
+(id)DDG_getObjectPropertyBy:(NSDictionary*)dic andKey:(NSString*)key
{
    NSDictionary *mappingDic = [self propertyModelMapping];
    NSString *className = [mappingDic valueForKey:key];
    Class cls = NSClassFromString(className);
    id propertyValue = [cls ddg_objectWithValue:dic];
    return propertyValue;
}

@end
