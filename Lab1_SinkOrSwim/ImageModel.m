#import "ImageModel.h"

@implementation ImageModel

//singleton class "sharedInstance": use block of code only once
+(ImageModel*) sharedInstance{
    static ImageModel* _sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[ImageModel alloc] init];
    });
    
    
    return _sharedInstance;
}

@end
