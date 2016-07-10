# DDGJsonModel
A third-party library to parse json.

DDGJsonModel
一个用于解析JSON的库
用法：
所有自定义的model都必须严格继承DDGJsonModel
Address.h文件：

import "DDGJsonModel.h"
@interface Address : DDGJsonModel
@property(nonatomic, strong)NSString *street;
@property(nonatomic, strong)NSString *city;

@end
－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

Person.h文件

import "DDGJsonModel.h"
import "Address.h"
@interface Person : DDGJsonModel
@property(nonatomic, strong)NSString *pid;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *age;
@property(nonatomic, strong)Address *address;
@end
-------------------------------------------------------------------------－－－－－－－－－－－－－－－－－－－－－－－－
Person.m文件

import "Person.h"
@implementation Person
+(NSDictionary *)propertyMapping {
return @{@"id":@"pid"};
}
+(NSDictionary *)propertyModelMapping {
return @{@"address":@"Address"};
}
@end
－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
json字典：
NSDictionary *dic = @{@"id":@"0001",
@"name":@"ZJM",
@"age":@"24",
@"address":@{
@"street":@"浦东大道",
@"city":@"上海"
}};
－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
json转model：
Person *p = [Person zjm_objectWithValue:dic];
－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
代码解析：
+(NSDictionary *)propertyMapping此方法用来mappingmodel中的属性名和json字典的key名不相同的状况，只需重写此方法返回一个用来mapping的字典即可：
+(NSDictionary *)propertyMapping {
return @{@"id":@"pid"};
}
id是json字典中的key，pid为想mapping到model中的属性名。
－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
+(NSDictionary *)propertyModelMapping {
return @{@"address":@"Address"};
}
重写此方法用来解决model中含有model，或者model中含有数组的状况：
model中含有model：只需返回一个用来mapping的字典即可，其中key表示model的属性名，value表示属性要对应的类名，此例中即是Address类。
model中含有数组：只需返回一个用来mapping的字典即可，其中key表示model的属性名，value表示数组中要包含的元素的类型的名字。
