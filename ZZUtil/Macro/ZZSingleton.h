
// ## : 连接字符串和参数
#define zz_singleton_h(name) + (instancetype)shared##name;



#if __has_feature(obj_arc) // ARC


#define zz_singleton_m(name) \
static id _instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (oneway void)release \
{ \
\
} \
\
- (id)autorelease \
{ \
return _instance; \
} \
\
- (id)retain \
{ \
return _instance; \
} \
\
- (NSUInteger)retainCount \
{ \
return 1; \
} \
\
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
}



#else  // MRC


#define zz_singleton_m(name) \
static id _instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}\
\
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
}



#endif




