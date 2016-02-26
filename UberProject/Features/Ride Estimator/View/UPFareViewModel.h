//
//  UPFareViewModel.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import Foundation;

@interface UPFareViewModel : NSObject

NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSString *cost;

- (instancetype)initWithTitle:(NSString *)title time:(NSInteger)time cost:(NSString *)cost NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

NS_ASSUME_NONNULL_END


@end
