//
//  KtBaseListModel.m
//  KtTableView
//
//  Created by bestswifter on 16/5/18.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtBaseListModel.h"

@interface KtBaseListModel ()

@property (nonatomic, assign) int currentPage;
@property (nonatomic, strong) NSCache *cache; // 目前先用系统的缓存来代替

@end

@implementation KtBaseListModel

- (id)initWithAddress:(NSString *)address {
    self = [super initWithAddress:address];
    if (self) {
        self.currentPage = 0;
        self.cache = [[NSCache alloc] init];
    }
    return self;
}

- (void)setDelegate:(id<KtBaseListModelProtocol>)delegate {
    _delegate = delegate;
    __weak typeof(self)wself = self;
    [self setCompletionBlock:^(KtBaseModel *model) {
        typeof(self)sself = wself;
        if (sself.isRefresh && [sself.delegate respondsToSelector:@selector(refreshRequestDidSuccess)]) {
            [sself.delegate refreshRequestDidSuccess];
        }
        else if (!sself.isRefresh && [sself.delegate respondsToSelector:@selector(refreshRequestDidSuccess)]) {
            [sself.delegate loadRequestDidSuccess];
        }
        [sself.delegate handleAfterRequestFinish];
        sself.isRefresh = NO;
    }];
}

- (void)handleParsedData:(KtBaseItem *)parsedData {
    if ([parsedData isKindOfClass:[KtBaseListItem class]]) {
        self.listItem = (KtBaseListItem *)parsedData;
        [self.cache setObject:self.listItem forKey:[NSString stringWithFormat:@"%d", self.currentPage]];
    }
}

- (void)loadPage:(int)pageNumber {
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:self.params];
    [newDic setObject:@(pageNumber) forKey:@"nextPage"];
    self.params = newDic;
    
    self.currentPage = pageNumber;
    KtBaseListItem *cachedItem = [self.cache objectForKey:[NSString stringWithFormat:@"%d", self.currentPage]];
    if (cachedItem) {
        [self handleParsedData:cachedItem];
        self.completionBlock(self);
    }
    else {
        [self loadWithShortConnection];
    }
}

- (void)loadNextPage {
    self.isRefresh = NO;
    if (self.currentPage < self.listItem.pageNumber) {
        ++self.currentPage;
        [self loadPage:self.currentPage];
    }
    else {
        // 没有更多了。
        [self.delegate didLoadLastPage];
    }
}

- (void)loadPreviousPage {
    self.isRefresh = NO;
    if (self.currentPage > 0) {
        --self.currentPage;
        [self loadPage:self.currentPage];
    }
    else {
        [self refresh]; // 如果现在是第一页，就只刷新
    }
}

- (void)refresh {
    self.isRefresh = YES;
    [self loadPage:0];
}

@end
