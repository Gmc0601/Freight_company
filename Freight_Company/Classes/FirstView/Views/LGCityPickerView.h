//
//  LGCityPickerView.h
//  LoveGoMall
//
//  Created by LOVEGO on 16/9/29.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LGCityPickerView;

typedef void(^LGPickerComplete)(LGCityPickerView * pickerView,NSDictionary *dict);

@interface LGCityPickerView : UIControl


- (void) animationShowWithItems:(NSArray *)items selectedItemComplete:(LGPickerComplete)complete;

- (void) animationDismiss;

@end
