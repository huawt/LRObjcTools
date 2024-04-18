
#import "LRBaseTableView.h"

@implementation LRBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return  self;
}

- (void)setUp {
    self.backgroundColor = [UIColor clearColor];
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.contentInset = UIEdgeInsetsZero;
    
    self.estimatedRowHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.clipsToBounds = YES;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 15.0, *)) {
        self.sectionHeaderTopPadding = 0;
        self.fillerRowHeight = 0;
    }
    if (@available(iOS 13.0, *)) {
        self.automaticallyAdjustsScrollIndicatorInsets = NO;
    }
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, CGFLOAT_MIN)];
}

- (void)registerClassCell:(Class)cellClass {
    NSString *identifier = [NSStringFromClass(cellClass) componentsSeparatedByString:@"."].lastObject;
    [self registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)registerNibCell:(Class)cellClass {
    NSString *identifier = [NSStringFromClass(cellClass) componentsSeparatedByString:@"."].lastObject;
    [self registerNib:[UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
}

@end
