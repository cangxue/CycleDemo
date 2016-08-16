//
//  ViewController.m
//  CycleDemo
//
//  Created by xiaoma on 16/8/16.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIButton *_firstButton;
    UIButton *_secondButton;
    
    CGRect _firstFrame;
    CGRect _secondFrame;
    
    NSTimer *_changeTimer;
    
    NSString *_currentStr;
    
    NSInteger _index;
    
    NSArray *_imageArrays;
    NSArray *_itemsArrays;
}

@property (weak, nonatomic) IBOutlet UIView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *buttonView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置广告条轮播
    [self setButtonViewData];
}

- (void)setButtonViewData {
    _index = 0;
    _itemsArrays = [NSArray array];
    _itemsArrays = [NSArray arrayWithObjects:@"人生若只如初见，何事秋风悲画扇",@"曾经沧海难为水，除却巫山不是云",
                    @"明月几时有？把酒问青天",@"山重水复疑无路，柳暗花明又一村",@"小楼昨夜又东风，故国不堪回首月明中",
                    @"问君能有几多愁？恰似一江春水向东流",@"行到水穷处，坐看云起时",@"海上生明月，天涯共此时",nil];
    
    _buttonView.clipsToBounds = YES;
    
    _firstButton = [[UIButton alloc] init];
    _firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _secondButton = [[UIButton alloc] init];
    _secondButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _firstFrame = _buttonView.bounds;
    _firstButton.frame = _firstFrame;
    _secondFrame = _buttonView.bounds;
    _secondButton.frame = _secondFrame;
    [_firstButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [_firstButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_secondButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [_secondButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    
    [_buttonView addSubview:_firstButton];
    [_buttonView addSubview:_secondButton];
    
    _changeTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(repeadFuntion) userInfo:self repeats:YES];
    [_firstButton setTitle:_itemsArrays[_index] forState:UIControlStateNormal];
    _currentStr = _itemsArrays[_index];
}

- (void)clickButton {
    NSLog(@"=================%@",_currentStr);
}

- (void)repeadFuntion {
    if (_index + 2 > _itemsArrays.count) {
        _index = 0;
    } else {
        _index ++;
    }
    
    [self setButtonTitle:_itemsArrays[_index]];
}

- (void)setButtonTitle:(NSString *)message {
    
    _currentStr = message;
    if (_firstButton.hidden == YES) {
        
        [_firstButton setTitle:message forState:UIControlStateNormal];
        
        _firstButton.hidden = NO;
        
        _firstFrame.origin.y = self.buttonView.frame.size.height;
        _firstFrame.size.height = self.buttonView.frame.size.height;
        _firstButton.frame = _firstFrame;
        
        _secondFrame.origin.y = 0;
        _secondFrame.size.height = self.buttonView.frame.size.height;
        _secondButton.frame = _secondFrame;
        [UIView animateWithDuration:0.2 animations:^{
            _firstFrame.origin.y = 0;
            _firstFrame.size.height = self.buttonView.frame.size.height;
            _firstButton.frame = _firstFrame;
            
            _secondFrame.origin.y = 0;
            _secondFrame.size.height = 0;
            _secondButton.frame = _secondFrame;
        } completion:^(BOOL finished) {
            _secondButton.hidden = YES;
        }];
    } else {
        [_secondButton setTitle:message forState:UIControlStateNormal];
        
        
        _secondButton.hidden = NO;
        
        _firstFrame.origin.y = 0;
        _firstFrame.size.height = self.buttonView.frame.size.height;
        _firstButton.frame = _firstFrame;
        
        _secondFrame.origin.y = self.buttonView.frame.size.height;
        _secondFrame.size.height = self.buttonView.frame.size.height;
        _secondButton.frame = _secondFrame;
        [UIView animateWithDuration:0.2 animations:^{
            _secondFrame.origin.y = 0;
            _secondFrame.size.height = self.buttonView.frame.size.height;
            _secondButton.frame = _secondFrame;
            
            _firstFrame.origin.y = 0;
            _firstFrame.size.height = 0;
            _firstButton.frame = _firstFrame;
        } completion:^(BOOL finished) {
            _firstButton.hidden = YES;
        }];
    }
}

@end
