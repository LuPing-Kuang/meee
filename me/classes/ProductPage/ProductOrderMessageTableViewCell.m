//
//  ProductOrderMessageTableViewCell.m
//  me
//
//  Created by jam on 2018/1/9.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ProductOrderMessageTableViewCell.h"

@interface ProductOrderMessageTableViewCell()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeHolder;

@end

@implementation ProductOrderMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textView.delegate=self;
    self.textView.textColor=gray_2;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(productOrderMessageTableViewCell:textViewTextDidChanged:)]) {
        [self.delegate productOrderMessageTableViewCell:self textViewTextDidChanged:textView];
    }
    [self hidePlaceHolderIfNeed];
    
}

-(void)setMessage:(NSString *)message
{
    _message=message;
    _textView.text=message;
    [self hidePlaceHolderIfNeed];
}

-(void)hidePlaceHolderIfNeed
{
    self.placeHolder.hidden=_textView.text.length>0;
    
    self.textView.textColor=self.textView.text.length>50?[UIColor redColor]:gray_2;
}

@end
