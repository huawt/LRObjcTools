
#import <Foundation/Foundation.h>

#if __has_include(<LRObjcTools/LRObjcTools.h>)

FOUNDATION_EXPORT double LRObjcToolsVersionNumber;
FOUNDATION_EXPORT const unsigned char LRObjcToolsVersionString[];

#import <LRObjcTools/LRBaseTableView.h>
#import <LRObjcTools/LRBaseScrollView.h>
#import <LRObjcTools/LRBaseNavigationBar.h>
#import <LRObjcTools/LRBaseCollectionView.h>
#import <LRObjcTools/LRBaseViewController.h>
#import <LRObjcTools/LRBaseTableViewCell.h>
#import <LRObjcTools/LRBaseNavigationController.h>
#import <LRObjcTools/LRBaseCollectionViewCell.h>
#import <LRObjcTools/LRPlaceholderTextView.h>
#import <LRObjcTools/LRStepSlider.h>
#import <LRObjcTools/LRDeviceService.h>
#import <LRObjcTools/NSObject+Swizzle.h>
#import <LRObjcTools/NSObject+Extension.h>

#else

#import "LRBaseTableView.h"
#import "LRBaseScrollView.h"
#import "LRBaseNavigationBar.h"
#import "LRBaseCollectionView.h"
#import "LRBaseViewController.h"
#import "LRBaseTableViewCell.h"
#import "LRBaseNavigationController.h"
#import "LRBaseCollectionViewCell.h"
#import "LRPlaceholderTextView.h"
#import "LRStepSlider.h"
#import "LRDeviceService.h"
#import "NSObject+Swizzle.h"
#import "NSObject+Extension.h"

#endif /* __has_include */

void LRMainAfter(CGFloat time, dispatch_block_t executed);
void LRMainQueue(dispatch_block_t executed);

@interface LRObjcTools : NSObject

@end

