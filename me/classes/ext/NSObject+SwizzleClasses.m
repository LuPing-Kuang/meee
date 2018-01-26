//
//  NSObject+SwizzleClasses.m
//  yangsheng
//
//  Created by Macx on 2017/8/22.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "NSObject+SwizzleClasses.h"
#import "ZZUrlTool.h"

@implementation NSObject (SwizzleClasses)

@end



@implementation UIImageView(SwizzleClasses)

+(void)load
{
    NSLog(@"UIImageView Class Load");
    NSLog(@"swizzle sd_setImageWithURL");
    [[self class]jr_swizzleMethod:@selector(setImageUrl:) withMethod:@selector(my_setImageUrl:) error:nil];
    [[self class]jr_swizzleMethod:@selector(setImageUrl:placeHolder:completed:) withMethod:@selector(my_setImageUrl:placeHolder:completed:) error:nil];
}

-(void)my_setImageUrl:(NSString*)url
{
//    NSString* urlstr=[url absoluteString];
//    NSLog(@"load image: %@",urlstr);
    UIImage* defaultImage=[UIImage imageNamed:@"loading"];
    //    CGFloat rate=self.frame.size.width/self.frame.size.height;
    //    if (rate>1.5) {
    //        defaultImage=[UIImage imageNamed:@"default_16_9"];
    //    }
    //    else if(rate<0.75){
    //        defaultImage=[UIImage imageNamed:@"default_9_16"];
    //    }
    [self setImageUrl:url placeHolder:defaultImage];
}

-(void)my_setImageUrl:(NSString*)url placeHolder:(UIImage*)placeHolder completed:(void (^)(UIImage *, NSError *, NSString *))completion
{
    NSString* oldUrl=url;
    if ((![oldUrl containsString:@"http://"])&&(![oldUrl containsString:@"https://"])) {
        oldUrl=[NSString stringWithFormat:@"%@/attachment/%@",[ZZUrlTool main],url];
    }
    [self my_setImageUrl:oldUrl placeHolder:placeHolder completed:completion];
}

@end


