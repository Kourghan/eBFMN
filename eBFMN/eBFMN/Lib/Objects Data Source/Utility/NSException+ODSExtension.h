
@import Foundation;

#define NSExceptionRaiseClassMethodIMPRequired @throw [NSException ods_class:self selectorImpRequired:_cmd]
#define NSExceptionRaiseInstanceMethodIMPRequired @throw [NSException ods_class:self.class selectorImpRequired:_cmd]

@interface NSException (ODSExtension)

+ (instancetype)ods_class:(Class)classException selectorImpRequired:(SEL)selector;

@end