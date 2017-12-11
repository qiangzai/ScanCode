//
//  GFBaseTableViewCell.m
//  ScanCode
//
//  Created by lzq-psylife on 2017/12/11.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import "GFBaseTableViewCell.h"

@implementation GFBaseTableViewCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
@end
