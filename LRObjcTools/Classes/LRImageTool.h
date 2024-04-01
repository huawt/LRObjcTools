

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRImage : NSObject
@property(nonatomic, strong) NSData *data;
@property(nonatomic, copy) NSString *base64;
@property(nonatomic, strong) UIImage *image;
@end
@interface LRImageTool : NSObject
+ (LRImage *)compress:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
