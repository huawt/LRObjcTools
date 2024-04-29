#import "LRImagePicker.h"
#import "LRDeviceService.h"
@interface LRImagePicker ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *image;
@property (nonatomic, strong) UIImagePickerController *camera;
@property (nonatomic, copy) ImageHandler handler;
@end
@implementation LRImagePicker
+ (nonnull instancetype)shared {
    static id _singleInstance_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleInstance_ = [[self alloc] init];
    });
    return _singleInstance_;
}
+ (void)imagePick:(nonnull ImageHandler)handler {
    [[LRImagePicker shared] imagePick:handler];
}
- (void)imagePick:(nonnull ImageHandler)handler {
    self.handler = handler;
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:self.image animated:YES completion:nil];
}
+ (void)takePhoto:(nonnull ImageHandler)handler {
    [[LRImagePicker shared] takePhoto:handler];
}
- (void)takePhoto:(nonnull ImageHandler)handler {
    if ([LRDeviceService cameraStatus] != AVAuthorizationStatusAuthorized) {
        return;
    }
    self.handler = handler;
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:self.camera animated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:true completion:nil];
    self.handler = nil;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:true completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    !self.handler?:self.handler(image);
    self.handler = nil;
}
- (UIImagePickerController *)image {
    if (!_image) {
        _image = [UIImagePickerController new];
        _image.delegate = self;
        _image.allowsEditing = NO;
        _image.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    return _image;
}
- (UIImagePickerController *)camera {
    if (!_camera) {
        _camera = [UIImagePickerController new];
        _camera.delegate = self;
        _camera.allowsEditing = NO;
        _camera.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    return _camera;
}
@end
