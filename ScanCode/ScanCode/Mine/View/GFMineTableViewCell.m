//
//  GFMineTableViewCell.m
//  ScanCode
//
//  Created by lzq-psylife on 2017/12/11.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import "GFMineTableViewCell.h"

@implementation GFMineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).with.offset(20);
        }];
    }
    return self;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [GFGeneralView createLabelFont:[UIFont systemFontOfSize:16] labelColor:[UIColor blackColor]];
    }
    return _nameLabel;
}

@end
