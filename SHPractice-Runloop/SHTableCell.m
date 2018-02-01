//
//  SHTableCell.m
//  SHPractice-Runloop
//
//  Created by shine on 31/01/2018.
//  Copyright © 2018 shine. All rights reserved.
//

#import "SHTableCell.h"

@interface SHTableCell()
@property (nonatomic, assign) CGFloat imgViewWidth;
@property (nonatomic, strong) UIImageView *imgView0;
@property (nonatomic, strong) UIImageView *imgView1;
@property (nonatomic, strong) UIImageView *imgView2;
@end
@implementation SHTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.imgViewWidth = CGRectGetWidth([UIScreen mainScreen].bounds)/3.0;
        [self.contentView addSubview:self.imgView0];
        self.imgView0.frame = CGRectMake(0, 0, _imgViewWidth, _imgViewWidth);
        
        [self.contentView addSubview:self.imgView1];
        self.imgView1.frame = CGRectMake(_imgViewWidth, 0, _imgViewWidth, _imgViewWidth);
        
        [self.contentView addSubview:self.imgView2];
        self.imgView2.frame = CGRectMake(_imgViewWidth * 2, 0, _imgViewWidth, _imgViewWidth);
    }
    return self;
}

- (void)loadImage0{
//    self.imgView0.image = [UIImage imageNamed:@"testImage.jpg"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image  = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testImage" ofType:@"jpg"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imgView0.image = image;
        });
    });
}
- (void)loadImage1{

//    self.imgView1.image = [UIImage imageNamed:@"testImage.jpg"];
//    self.imgView1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testImage" ofType:@"jpg"]];
//    self.imgView1.image = [UIImage imageWithContentsOfFile:@"testImage.jpg"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image  = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testImage" ofType:@"jpg"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imgView1.image = image;
        });
    });
}
- (void)loadImage2{
//    self.imgView2.image = [UIImage imageNamed:@"testImage.jpg"];
//    self.imgView2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testImage" ofType:@"jpg"]];
//    self.imgView2.image = [UIImage imageWithContentsOfFile:@"testImage.jpg"];
    UIImage *image  = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testImage" ofType:@"jpg"]];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imgView2.image = image;
    });
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (UIImageView *)imgView0{
    if(!_imgView0){
        _imgView0 = [UIImageView new];
    }
    return _imgView0;
}

- (UIImageView *)imgView1{
    if(!_imgView1){
        _imgView1 = [UIImageView new];
    }
    return _imgView1;
}

- (UIImageView *)imgView2{
    if(!_imgView2){
        _imgView2 = [UIImageView new];
    }
    return _imgView2;
}

@end
