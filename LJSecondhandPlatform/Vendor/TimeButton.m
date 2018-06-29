//
//  TimeButton.m
//  YMShareBike
//
//  Created by 董樑 on 2017/1/22.
//  Copyright © 2017年 董樑. All rights reserved.
//

#import "TimeButton.h"

@interface TimeButton ()

@property (nonatomic,assign)NSInteger sec;

@end

static const NSInteger duration = 60;

@implementation TimeButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    
    self.sec = duration;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = self.currentTitleColor.CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 3;
}

-(void)setSec:(NSInteger)sec{
    _sec = sec;
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self setTitle:[NSString stringWithFormat:@"重新获取%lds",(long)_sec] forState:UIControlStateSelected];
        [self setTitle:[NSString stringWithFormat:@"%lds",(long)_sec] forState:UIControlStateSelected];

        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];

        if (_sec < 0) {
            _sec = duration;
            self.selected = NO;
            self.userInteractionEnabled = YES;
        }
    });
    
}

-(void)setSelected:(BOOL)selected{
    super.selected = selected;
    
    if (selected) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.layer.borderColor = [UIColor clearColor].CGColor;

        self.userInteractionEnabled = NO;
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        dispatch_source_t time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
        uint64_t interval = (uint64_t)(1.0* NSEC_PER_SEC);
        dispatch_source_set_timer(time, start, interval, 0);
        
        dispatch_source_set_event_handler(time, ^{
            if(_sec <= 0){
                dispatch_source_cancel(time);
            }
            self.sec --;
        });
        
        dispatch_resume(time);
    }else{
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = self.currentTitleColor.CGColor;
    }
}

-(void)setEnabled:(BOOL)enabled{
    super.enabled = enabled;
    if (!enabled) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }else{
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = self.currentTitleColor.CGColor;
    }
}

@end
