//
//  CustomeAnnoPoint.m
//  me
//
//  Created by KLP on 2018/2/8.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "CustomeAnnoPoint.h"

@implementation CustomeAnnoPoint

- (void)setModel:(StoreModel *)model{
    _model = model;
    self.title = _model.storename;
    self.subtitle = _model.address;
    
    self.coordinate = CLLocationCoordinate2DMake(_model.lat.doubleValue, _model.lng.doubleValue);
}

@end
