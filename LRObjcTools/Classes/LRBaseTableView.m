
#import "LRBaseTableView.h"

@interface LRBaseTableView ()
@property (nonatomic, strong) NSMutableArray<UIView *> *sectionBacks;
@end

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

- (void)registerNibClassCell:(Class)cellClass {
    NSString *identifier = [NSStringFromClass(cellClass) componentsSeparatedByString:@"."].lastObject;
    [self registerNib:[UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
}

- (void)reloadData {
    [super reloadData];
    [self checkSectionBackgroundSetting];
}

- (void)checkSectionBackgroundSetting {
    NSInteger number = self.numberOfSections;
    BOOL show = self.showSectionBackground > 0 && number > 0;
    for (UIView *sub in self.sectionBacks) {
        sub.hidden = !show;
    }
    if (!show) { return; }
    if (number == 0) { return; }
    for (NSInteger index = 0; index < number; index++) {
        CGRect headerRect = [self rectForHeaderInSection:index];
        CGRect sectionRect = [self rectForSection:index];
        CGRect foortRect = [self rectForFooterInSection:index];
        CGFloat backOriginY = CGRectGetMaxY(headerRect);
        CGFloat backHeight = sectionRect.size.height - headerRect.size.height - foortRect.size.height;
        if (self.sectionBackgroundContainsHeader > 0) {
            backOriginY = CGRectGetMinY(headerRect);
            backHeight += headerRect.size.height;
        }
        if (self.sectionBackgroundContainsFooter> 0) {
            backHeight += foortRect.size.height;
        }
        CGRect backFrame = CGRectMake(self.sectionBackgroundEdgePaddding, backOriginY, sectionRect.size.width - (self.sectionBackgroundEdgePaddding * 2), backHeight);
        if (index < self.sectionBacks.count) {
            UIView *view = [self.sectionBacks objectAtIndex:index];
            view.frame = backFrame;
            view.backgroundColor = self.sectionBackgroundColor;
            view.layer.cornerRadius = self.sectionBackgroundCornerRadius;
            view.clipsToBounds = self.sectionBackgroundCornerRadius > 0;
        } else {
            UIView *view = [[UIView alloc] initWithFrame:backFrame];
            view.backgroundColor = self.sectionBackgroundColor;
            view.layer.cornerRadius = self.sectionBackgroundCornerRadius;
            view.clipsToBounds = self.sectionBackgroundCornerRadius > 0;
            [self insertSubview:view atIndex:0];
            [self.sectionBacks addObject:view];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *sub in self.sectionBacks) {
        [self insertSubview:sub atIndex:0];
    }
}

- (NSMutableArray<UIView *> *)sectionBacks {
    if (!_sectionBacks) {
        _sectionBacks = [NSMutableArray array];
    }
    return _sectionBacks;
}
@end
