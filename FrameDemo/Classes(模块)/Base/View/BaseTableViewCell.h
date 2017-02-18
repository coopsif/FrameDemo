//
//  BaseTableViewCell.h
//  NengZhe
//
//  Created by Cher on 16/3/31.
//  Copyright © 2016年 LiuKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

/**
 *  初始化视图
 */
- (void)initialization;


+ (void)registerCell:(UITableView *)tableView forCellReuseIdentifier:(NSString *)Identifier;

@end
