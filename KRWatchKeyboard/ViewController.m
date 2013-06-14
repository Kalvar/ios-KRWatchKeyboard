//
//  ViewController.m
//  KRWatchKeyboard
//
//  Created by Kalvar on 13/3/17.
//  Copyright (c) 2013年 Kuo-Ming Lin. All rights reserved.
//

#import "ViewController.h"
#import "KRWatchKeyboard.h"

@interface ViewController ()<KRWatchKeyboardDelegate>

@property (nonatomic, strong) KRWatchKeyboard *_krWatchKeyboard;

@end

@implementation ViewController

@synthesize outTextView;
//
@synthesize _krWatchKeyboard;

- (void)viewDidLoad
{
    [super viewDidLoad];
	_krWatchKeyboard = [[KRWatchKeyboard alloc] initWithDelegate:self];
    [self._krWatchKeyboard startWatch];
    //When you leaved here, please remember to stop the watching event will be safe.
    //[self._krWatchKeyboard stopWatch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITextViewDelegate
//正在進行編輯時的動作
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.keyboardAppearance = UIKeyboardAppearanceAlert;
//    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//        CGFloat _movingHeight = 216.0f;
//        CGRect _frame   = self.view.frame;
//        _frame.origin.y = -( _movingHeight );
//        [self.view setFrame:_frame];
//    } completion:^(BOOL finished) {
//        //...
//    }];    
    return YES;
}

//完成編輯
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    /*
     * @ 因為要保留狀態列 ( Status Bar )
     *   - 所以要額外倒退 20.0f ( Status Bar Height )。
     *   - 在上面將 self.view 往上推的同時，狀態列會變成半透明，而 self.view 則會從狀態列底下「穿透」過去。
     */
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        //CGFloat _initialY        = self.view.frame.origin.y;
        CGFloat _statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        //CGFloat _movingHeight    =  200.0f + _initialY + _statusBarHeight;
        CGRect _frame   = self.view.frame;
        _frame.origin.y = _statusBarHeight;
        [self.view setFrame:_frame];
    } completion:^(BOOL finished) {
        //...
    }];
    return YES;
}

//正在改變文字範圍或換行時的動作
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

//進行輸入、刪除、修改文字、換行等動作時
-(void)textViewDidChange:(UITextView *)textView{
    //NSLog(@"TextView 正在變更文字內容 \n");
}

#pragma UIViewDelegate
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( self.outTextView.resignFirstResponder )
    {
        [self.outTextView resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma KRWatchKeyboardDelegate
-(void)krWatchKeyboardWillShow:(CGRect)_foundKeyboardFrame
{
    //NSLog(@"krWatchKeyboardWillShow : %f", _foundKeyboardFrame.size.height);
    //CGFloat _keyboardBaseHeight = 216.0f;
    CGFloat _foundHeight = _foundKeyboardFrame.size.height;
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        CGRect _frame   = self.view.frame;
        _frame.origin.y = -_foundHeight + [UIApplication sharedApplication].statusBarFrame.size.height;
        [self.view setFrame:_frame];
    } completion:^(BOOL finished) {
        //...
    }];
}

-(void)krWatchKeyboardWillHide
{
    //NSLog(@"krWatchKeyboardWillHide");
}


@end
