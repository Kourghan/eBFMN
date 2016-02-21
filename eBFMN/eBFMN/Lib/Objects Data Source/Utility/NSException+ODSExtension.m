
#import "NSException+ODSExtension.h"

@implementation NSException (ODSExtension)

+ (instancetype)ods_class:(Class)classException selectorImpRequired:(SEL)selector {
	NSParameterAssert(classException);
	NSParameterAssert(selector);

	NSString *reason = [[NSString alloc] initWithFormat:
		@"Missing implementation for %@ selector: %@",
		NSStringFromClass(classException),
		NSStringFromSelector(selector)];

	return [NSException exceptionWithName:@"ImplementationRequiredException" reason:reason userInfo:nil];
}

@end