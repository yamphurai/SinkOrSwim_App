#import "FlowerModel.h"

@implementation FlowerModel

- (instancetype)initWithName:(NSString *)name
                        type:(NSString *)type
                       image:(UIImage *)image {
    self = [super init];
    if (self) {
        _name = name;
        _type = type;
        _image = image;
    }
    return self;
}

@end
