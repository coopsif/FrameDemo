//
//  BaseTableViewCell.m
//  NengZhe
//
//  Created by Cher on 16/3/31.
//  Copyright © 2016年 LiuKun. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
          self.selectionStyle = UITableViewCellSelectionStyleNone;
          [self initialization];
     }
     return self;
}


- (void)initialization{
     
     
     
}


+ (void)registerCell:(UITableView *)tableView forCellReuseIdentifier:(NSString *)Identifier{
    Class class = [self class];
    [tableView registerClass:class forCellReuseIdentifier:Identifier];
}


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
