## Screen Shot

<img src="https://dl.dropbox.com/u/83663874/GitHubs/KRWatchKeyboard-1.png" alt="KRWatchKeyboard" title="KRWatchKeyboard" style="margin: 20px;" class="center" />
。
<img src="https://dl.dropbox.com/u/83663874/GitHubs/KRWatchKeyboard-2.png" alt="KRWatchKeyboard" title="KRWatchKeyboard" style="margin: 20px;" class="center" />

## Supports

KRWatchKeyboard supports ARC ( Automatic Reference Counting ).

## How To Get Started

KRWatchKeyboard which you can use it to watch the Keyboard events if it changing anything. For example, If we need to control a UITextView slide up or slide down when the keyboard appear or disappear by itself, the sample code like the under.

``` objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    _krWatchKeyboard = [[KRWatchKeyboard alloc] initWithDelegate:self];
    [self._krWatchKeyboard startWatch];
    //When you leaved here, please remember to stop the watching event will be safe.
    //[self._krWatchKeyboard stopWatch];
}

#pragma KRWatchKeyboardDelegate
-(void)krWatchKeyboardWillShow:(CGRect)_foundKeyboardFrame
{
    //CGFloat _keyboardBaseHeight = 216.0f;
    CGFloat _foundHeight = _foundKeyboardFrame.size.height;
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        CGRect _frame   = self.view.frame;
        _frame.origin.y = -( _foundHeight );
        [self.view setFrame:_frame];
    } completion:^(BOOL finished) {
        //...
    }];
}

-(void)krWatchKeyboardWillHide
{
    //NSLog(@"krWatchKeyboardWillHide");
}
```

## Version

KRWatchKeyboard now is V1.0 beta.

## License

KRWatchKeyboard is available under the MIT license ( or Whatever you wanna do ). See the LICENSE file for more info.
