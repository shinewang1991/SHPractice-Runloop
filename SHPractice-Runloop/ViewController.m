//
//  ViewController.m
//  SHPractice-Runloop
//
//  Created by shine on 31/01/2018.
//  Copyright © 2018 shine. All rights reserved.
//

#import "ViewController.h"
#import "SHTableCell.h"

static NSString *kcellIdentifier = @"kCellIdentifier";
typedef void(^LoadImageBlock)(void);
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<LoadImageBlock> *tasks;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRunloopObserver];
    self.tasks = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SHTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellIdentifier forIndexPath:indexPath];
    [self addTask:^{
        [cell loadImage0];
    }];
    
    [self addTask:^{
        [cell loadImage1];
    }];
    
    [self addTask:^{
        [cell loadImage2];
    }];
    
    return cell;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) style:UITableViewStylePlain];
        _tableView.rowHeight = CGRectGetWidth([UIScreen mainScreen].bounds)/3.0;
        [_tableView registerClass:[SHTableCell class] forCellReuseIdentifier:kcellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)addTask:(LoadImageBlock)block{
    if(self.tasks.count > 18){
        [self.tasks removeObjectAtIndex:0];
    }
    
    [self.tasks addObject:block];
}

- (void)addRunloopObserver{
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)self,
        &CFRetain,
        &CFRelease,
        NULL
    };
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopBeforeWaiting, YES, 0, &observerCallBack, &context);
    CFRunLoopAddObserver(runloop, observer, kCFRunLoopCommonModes);
    CFRelease(observer);
}

void observerCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    ViewController *viewController = (__bridge ViewController *)info;
    if(viewController.tasks.count > 0){
        LoadImageBlock block =  [viewController.tasks firstObject];
        if(block){
            block();
            NSLog(@"开始加载图片了。一共有%ld张图片",viewController.tasks.count);
        }
        [viewController.tasks removeObjectAtIndex:0];
    }
}
@end
