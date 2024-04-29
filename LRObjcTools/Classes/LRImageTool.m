#import "LRImageTool.h"
@implementation LRImage
@end
@implementation LRImageTool
+ (LRImage *)compress:(UIImage *)image {
    CGSize targetSize = [self fixImageSize:image.size];
    if (CGSizeEqualToSize(targetSize, CGSizeZero)){
        return nil;
    }
    if (!CGSizeEqualToSize(targetSize, image.size)){
        image = [self resizeImage:image targetSize:targetSize];
    }
    NSData *data = UIImageJPEGRepresentation(image ,1);
    CGFloat size = (CGFloat)((CGFloat)data.length/1024.0/1024.0);// kb  mb
    CGFloat kbSize = (CGFloat)((CGFloat)data.length/1024.0);
    if (kbSize < 800) {
        NSString *base64Str = [data base64EncodedStringWithOptions:0];
        image = [UIImage imageWithData:data];
        LRImage * model = [LRImage new];
        model.data = data;
        model.image = image;
        model.base64 = base64Str;
        return model;
    }
    if (size > 8 && size < 20) {
        image = [self resizeImage:image targetSize: CGSizeMake(image.size.width/2, image.size.height/2)];
    }else if (size >= 20) {
        image = [self resizeImage:image targetSize: CGSizeMake(image.size.width/4, image.size.height/4)];
    }
    data = UIImageJPEGRepresentation(image, [self compressFactor:size]);
    NSString *base64Str = [data base64EncodedStringWithOptions:0];
    image = [UIImage imageWithData:data];
    LRImage * model = [LRImage new];
    model.data = data;
    model.image = image;
    model.base64 = base64Str;
    return model;
}
+ (CGSize)fixImageSize:(CGSize)originalSize{
    CGFloat imageW = originalSize.width;
    CGFloat imageH = originalSize.height;
    CGFloat targetImageW = imageW;
    CGFloat targetImageH = imageH;
    CGFloat allowMin = 256.0;
    CGFloat allowMax = 4096.0;
    CGSize targetSize = CGSizeZero;
    CGFloat min = MIN(imageW, imageH);
    CGFloat max = MAX(imageW, imageH);
    if (min >= allowMin && max <= allowMax){
        return originalSize;
    }
    if (min < allowMin){
        if (imageW <= imageH){
            targetImageW = allowMin;
            targetImageH = imageH / imageW * targetImageW;
        }else{
            targetImageH = allowMin;
            targetImageW = imageW / imageH * targetImageH;
        }
    }else if (max > allowMax){
        if (imageW >= imageH){
            targetImageW = allowMax;
            targetImageH = imageH / imageW * targetImageW;
        }else{
            targetImageH = allowMax;
            targetImageW = imageW / imageH * targetImageH;
        }
    }
    if (MIN(targetImageW, targetImageH) < allowMin || MAX(targetImageW,targetImageH) > allowMax){
        return CGSizeZero;
    }
    targetSize = CGSizeMake(targetImageW, targetImageH);
    return targetSize;
}
+ (UIImage *)resizeImage:(UIImage *)image targetSize:(CGSize)targetSize{
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 1);
    [image drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    UIGraphicsEndImageContext();
    return newImage;
}
+ (CGFloat)compressFactor:(CGFloat)size{
    if (size < 0.9){
        return 1;
    }
    return 0.9 / size;
}
@end
