#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^ImageHandler)(UIImage *image);
@interface LRImagePicker : NSObject
+ (instancetype)shared;
- (void)imagePick: (ImageHandler)handler;
- (void)takePhoto: (ImageHandler)handler;
+ (void)imagePick: (ImageHandler)handler;
+ (void)takePhoto: (ImageHandler)handler;
@end
NS_ASSUME_NONNULL_END
