//
//  UserCell.m
//  MGAutocompletingSearch
//
//  Created by 宋海梁 on 16/7/6.
//
//

#import "UserCell.h"

@interface UserCell ()

@end

@implementation UserCell

- (void)awakeFromNib {
    // Initialization code
    self.followButton.layer.cornerRadius = 5;
    self.followButton.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
