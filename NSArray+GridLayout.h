//
//  NSArray+GridLayout.h
//  GridLayout_Example
//
//  Created by imac on 2019/7/2.
//  Copyright © 2019 547188371@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,GridAxisType){
    GridAxisTypeHorizontal,
    GridAxisTypeVertical
} ;

@interface NSArray (GridLayout)

- (void)gridViewsAxis:(GridAxisType)axis
            gridCount:(NSInteger)gridCount
         fixedSpacing:(CGFloat)fixedSpacing
          lineSpacing:(CGFloat)lineSpacing
               insets:(UIEdgeInsets)insets;

- (void)gridViewsAxis:(GridAxisType)axis
            gridCount:(NSInteger)gridCount
                 size:(CGSize)size
          insets:(UIEdgeInsets)insets;

- (void)gridViewsAxis:(GridAxisType)axis
            gridCount:(NSInteger)gridCount
         fixedSpacing:(CGFloat)fixedSpacing
          lineSpacing:(CGFloat)lineSpacing
                 size:(CGSize)size
               insets:(UIEdgeInsets)insets;


@end

NS_ASSUME_NONNULL_END
