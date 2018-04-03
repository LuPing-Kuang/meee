/*
 NSDateFormatter+timeIntervalFormatter.m
 
 The MIT License (MIT)
 
 Copyright (c) 2013 Clement CN Tsang
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import "NSDateFormatter+timeIntervalFormatter.h"
#import "NSBundle+CTAssetsPickerController.h"



@implementation NSDateFormatter (timeIntervalFormatter)

- (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval
{
    NSDateComponents *components = [self dateComponetsWithTimeInterval:timeInterval];
    NSInteger roundedSeconds = lround(timeInterval - (components.hour * 60 * 60) - (components.minute * 60));
    
    if (components.hour > 0)
        return [NSString stringWithFormat:@"%ld:%02ld:%02ld", (long)components.hour, (long)components.minute, (long)roundedSeconds];
    
    else
        return [NSString stringWithFormat:@"%ld:%02ld", (long)components.minute, (long)roundedSeconds];
}

- (NSString *)spellOutStringFromTimeInterval:(NSTimeInterval)timeInterval
{
    NSString *string = @"";
    
    NSDateComponents *components = [self dateComponetsWithTimeInterval:timeInterval];
    
    if (components.hour > 0)
        string = [string stringByAppendingFormat:@"%ld %@",
                  (long)components.hour,
                  (components.hour > 1) ?
                  (@"hours") :
                  (@"hour")];
    
    if (components.minute > 0)
        string = [string stringByAppendingFormat:@"%ld %@",
                  (long)components.minute,
                  (components.minute > 1) ?
                  (@"minutes") :
                  (@"minute")];
    
    if (components.second > 0)
        string = [string stringByAppendingFormat:@"%ld %@",
                  (long)components.second,
                  (components.second > 1) ?
                  (@"seconds") :
                  (@"second")];
    
    return string;
}

- (NSDateComponents *)dateComponetsWithTimeInterval:(NSTimeInterval)timeInterval
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:timeInterval sinceDate:date1];
    
    unsigned int unitFlags =
    NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour |
    NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    return [calendar components:unitFlags
                       fromDate:date1
                         toDate:date2
                        options:0];
}

@end
