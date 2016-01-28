//
//  ViewButton.m
//  adblockfast
//
//  Created by Brian Kennish on 10/9/15.
//  Copyright © 2015 Rocketship. All rights reserved.
//

#import "ViewButton.h"
#import "Constants.h"

@implementation ViewButton

- (ViewButton *)initWithIndex:(NSUInteger)index
                        label:(NSString *)label
                         font:(UIFont *)font
                        color:(UIColor *)color
                    frameSize:(CGSize)frameSize
        minimumFrameDimension:(CGFloat)minimumFrameDimension
{
    CGFloat frameWidth = frameSize.width;
    CGFloat width = frameWidth / TAB_BAR_BUTTON_COUNT;
    CGFloat height = minimumFrameDimension / MINIMUM_FRAME_DIMENSION_TO_TAB_BAR_HEIGHT;

    if (self = [super initWithFrame:CGRectMake(
                                               index * width,
                                               frameSize.height - height,
                                               width,
                                               height
                                               )]) {
        if (VERBOSE) self.layer.borderWidth = 1;
        [self setAttributedTitle:
            [[NSAttributedString alloc] initWithString:label
                                            attributes:@{
                                                         NSFontAttributeName: font,
                                                         NSForegroundColorAttributeName: color
                                                         }]
                        forState:UIControlStateNormal];
        self.alpha = 0;
    }

    return self;
}

@end
