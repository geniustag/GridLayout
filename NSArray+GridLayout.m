//
//  NSArray+GridLayout.m
//  GridLayout_Example
//
//  Created by imac on 2019/7/2.
//  Copyright © 2019 547188371@qq.com. All rights reserved.
//

#import "NSArray+GridLayout.h"
#import <Masonry/Masonry.h>

@implementation NSArray (GridLayout)

- (NSArray *)_polishingGridViews:(NSInteger)gridCount {
    NSInteger itemCount = self.count;
    NSMutableArray<UIView *> *new = [NSMutableArray arrayWithArray:self];
    if (itemCount % gridCount != 0) {
        NSInteger excessCount = gridCount - (itemCount % gridCount);
        for (int i=0; i<excessCount; i++) {
            UIView *view = [UIView new];
            view.hidden = YES;
            [new.firstObject.superview addSubview:view];
            [new addObject:view];
        }
    }
    return [new copy];
}

- (NSArray<NSArray *> *)_linearGroupArrayWithCount:(NSInteger)count {
    NSMutableArray *new = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx % count == 0) {
            NSMutableArray *sub_new = [NSMutableArray array];
            [new  addObject:sub_new];
        }
        NSMutableArray *sub_new = [new objectAtIndex:idx/count];
        [sub_new addObject:obj];
    }];
    return [new copy];
}

- (NSArray<NSArray *> *)_nolinearGroupArrayWithCount:(NSInteger)count {
    NSMutableArray *new = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *sub_new = new.count <= idx % count ? nil : [new objectAtIndex:idx % count];
        if (sub_new == nil) {
            sub_new = [NSMutableArray array];
            [new addObject:sub_new];
        }
        [sub_new addObject:obj];
    }];
    return new.copy;
}

- (void)gridViewsAxis:(GridAxisType)axis
            gridCount:(NSInteger)gridCount
         fixedSpacing:(CGFloat)fixedSpacing
          lineSpacing:(CGFloat)lineSpacing
               insets:(UIEdgeInsets)insets {
    NSArray *new = [self _polishingGridViews:gridCount];
    NSArray<NSArray *> *linearArray = [new _linearGroupArrayWithCount:gridCount];
    NSArray<NSArray *> *nolinearArray = [new _nolinearGroupArrayWithCount:gridCount];
    NSArray<NSArray *> *horizontalArray = axis == GridAxisTypeHorizontal ? linearArray : nolinearArray;
    NSArray<NSArray *> *verticalArray = axis == GridAxisTypeHorizontal ? nolinearArray : linearArray;
    
    [horizontalArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.count < 2) {
            [obj.firstObject mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(insets.left);
                make.right.offset(-insets.right);
            }];
        }else
            [obj mas_distributeViewsAlongAxis:MASAxisTypeHorizontal  withFixedSpacing:fixedSpacing leadSpacing:insets.left tailSpacing:insets.right];
    }];
    
    [verticalArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.count < 2) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(insets.top);
                make.bottom.offset(-insets.bottom);
            }];
        }else
            [obj mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:lineSpacing leadSpacing:insets.top tailSpacing:insets.bottom];
    }];
}

- (void)gridViewsAxis:(GridAxisType)axis
            gridCount:(NSInteger)gridCount
                 size:(CGSize)size
               insets:(UIEdgeInsets)insets {
    NSArray *new = [self _polishingGridViews:gridCount];
    NSArray<NSArray *> *linearArray = [new _linearGroupArrayWithCount:gridCount];
    NSArray<NSArray *> *nolinearArray = [new _nolinearGroupArrayWithCount:gridCount];
    NSArray<NSArray *> *horizontalArray = axis == GridAxisTypeHorizontal ? linearArray : nolinearArray;
    NSArray<NSArray *> *verticalArray = axis == GridAxisTypeHorizontal ? nolinearArray : linearArray;
    [horizontalArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.count < 2) {
            [obj.firstObject mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(insets.left);
                make.right.offset(-insets.right);
            }];
        }else
            [obj mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:size.width leadSpacing:insets.left tailSpacing:insets.right];
    }];
    
    [verticalArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.count < 2) {
            [obj.firstObject mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(insets.top);
                make.bottom.offset(-insets.bottom);
            }];
        }else
            [obj mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:size.height leadSpacing:insets.top tailSpacing:insets.bottom];
    }];
}

- (void)gridViewsAxis:(GridAxisType)axis
            gridCount:(NSInteger)gridCount
         fixedSpacing:(CGFloat)fixedSpacing
          lineSpacing:(CGFloat)lineSpacing
                 size:(CGSize)size
               insets:(UIEdgeInsets)insets {
    NSArray *new = [self _polishingGridViews:gridCount];
    [new gridViewsAxis:axis gridCount:gridCount fixedSpacing:fixedSpacing lineSpacing:lineSpacing insets:insets];
    
    [new mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size).priorityLow();
    }];
    
}

@end
