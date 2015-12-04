//
//  NSArray+OBExtend.h
//  OBFoundationLib
//
//  Created by Oborn.Jung on 12/2/15.
//  Copyright © 2015 Oborn.Jung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (OBExtend)

- (NSArray *)ob_deepCopy;

- (NSMutableArray *)ob_mutableDeepCopy;

@end
