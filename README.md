# DDGJsonModel
一个用于解析JSON的库</br>
用法：</br>
所有自定义的model都必须严格继承DDGJsonModel</br>
Address.h文件：</br>
#import "DDGJsonModel.h"</br>

@interface Address : DDGJsonModel</br>
@property(nonatomic, strong)NSString *street;</br>
@property(nonatomic, strong)NSString *city;</br>

@end</br>
－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－</br>

Person.h文件</br>
#import "DDGJsonModel.h"</br>
#import "Address.h"</br>
@interface Person : DDGJsonModel</br>
@property(nonatomic, strong)NSString *pid;</br>
@property(nonatomic, strong)NSString *name;</br>
@property(nonatomic, strong)NSString *age;</br>
@property(nonatomic, strong)Address *address;</br>
@end</br>
-------------------------------------------------------------------------－－－－－－－－－－－－－－－－－－－－－－－－</br>
Person.m文件</br>
#import "Person.h"</br>

@implementation Person</br>
+(NSDictionary *)propertyMapping {</br>
return @{@"id":@"pid"};</br>
}</br>
+(NSDictionary *)propertyModelMapping {</br>
return @{@"address":@"Address"};</br>
}</br>
@end</br>
－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－</br>
json字典：</br>
NSDictionary *dic = @{@"id":@"0001",</br>
@"name":@"ZJM",</br>
@"age":@"24",</br>
@"address":@{</br>
@"street":@"浦东大道",</br>
@"city":@"上海"</br>
}};</br>
－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－</br>
json转model：</br>
Person *p = [Person zjm_objectWithValue:dic];</br>
－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－</br>
代码解析：</br>
+(NSDictionary *)propertyMapping此方法用来mappingmodel中的属性名和json字典的key名不相同的状况，只需重写此方法返回一个用来mapping的字典即可：</br>
+(NSDictionary *)propertyMapping {</br>
return @{@"id":@"pid"};</br>
}</br>
id是json字典中的key，pid为想mapping到model中的属性名。</br>
－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－</br>
+(NSDictionary *)propertyModelMapping {</br>
return @{@"address":@"Address"};</br>
}</br>
重写此方法用来解决model中含有model，或者model中含有数组的状况：</br>
model中含有model：只需返回一个用来mapping的字典即可，其中key表示model的属性名，value表示属性要对应的类名，此例中即是Address类。</br>
model中含有数组：只需返回一个用来mapping的字典即可，其中key表示model的属性名，value表示数组中要包含的元素的类型的名字。</br>

