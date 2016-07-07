//
//  UIButton+Block.h
//  50+sh
//
//  Created by 宋海梁 on 15/12/3.
//  Copyright © 2015年 jicaas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)();

@interface UIButton (Block)

/**
 *  UIButton+Block
 *
 *  @param controlEvent
 *  @param action
 */
- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;


@end
