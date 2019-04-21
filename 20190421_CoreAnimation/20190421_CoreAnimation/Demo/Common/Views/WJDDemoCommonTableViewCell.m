//
//  WJDDemoCommonTableViewCell.m
//  20190421_CoreAnimation
//
//  Created by 王俊东 on 2019/4/22.
//  Copyright © 2019 王俊东. All rights reserved.
//

#import "WJDDemoCommonTableViewCell.h"

#import "WJDDemoCommonCellModel.h"

#import "WJDImageProducer.h"

@interface WJDDemoCommonTableViewCell ()
/**
 *  标题
 */
@property (nonatomic, weak  ) UILabel *titleLabel;
/**
 *  箭头图标
 */
@property (nonatomic, weak  ) UIImageView *arrowImageView;
/**
 *  分割线
 */
@property (nonatomic, weak  ) UIView *lineView;

@end

@implementation WJDDemoCommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //标题
        UILabel *titleLabel  = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font      = [UIFont systemFontOfSize:15.0f];
        _titleLabel          = titleLabel;
        [self.contentView addSubview:_titleLabel];
        //箭头图标
        UIImage *arrowImage = [WJDImageProducer arrowImageWithDirection:ArrowDirection_right RenderType:RenderType_stroke Size:CGSizeMake(7.0f, 13.0f) Width:1.0f Color:[UIColor lightGrayColor] NickName:@"lightGrayColor"];
        UIImageView *arrowImageView = [[UIImageView alloc] init];
        arrowImageView.image        = arrowImage;
        _arrowImageView             = arrowImageView;
        [self.contentView addSubview:_arrowImageView];
        //分割线
        UIView *lineView         = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        _lineView                = lineView;
        [self.contentView addSubview:_lineView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat margin = 14.0f;
    CGFloat titleLabelHeight = 20.0f;
    CGSize arrowImageSize = self.arrowImageView.image.size;
    CGFloat lineHeight = 1.0f/[UIScreen mainScreen].scale;
    self.titleLabel.frame = CGRectMake(margin, (self.frame.size.height - titleLabelHeight)*0.5, self.frame.size.width - margin*2 - arrowImageSize.width, titleLabelHeight);
    self.arrowImageView.frame = CGRectMake(self.frame.size.width - margin - arrowImageSize.width, (self.frame.size.height - arrowImageSize.height)*0.5, arrowImageSize.width, arrowImageSize.height);
    self.lineView.frame = CGRectMake(0, self.frame.size.height - lineHeight, self.frame.size.width, lineHeight);
}

#pragma mark - Setter
- (void)setData:(id)data {
    [super setData:data];
    if ([self.data isKindOfClass:[WJDDemoCommonCellModel class]]) {
        WJDDemoCommonCellModel *cellModel = self.data;
        self.titleLabel.text = cellModel.title;
        [self setNeedsLayout];
    }
}
@end
