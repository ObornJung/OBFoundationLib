//
//  UIDevice+OBExtend.m
//  OBFoundationLib
//
//  Created by Oborn.Jung on 8/20/14.
//  Copyright (c) 2014 ObornJung. All rights reserved.
//

#import <mach/mach.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "OBOpenUDID.h"

@implementation UIDevice (OBExtend)

+ (NSString *)ob_UDID {
    NSString * uidString = nil;
    NSError * error = nil;
    //返回的uuid一般是长度为40的字符串
    NSString * udid = [OBOpenUDID valueWithError:&error];
    if (udid && (error.code == kOBOpenUDIDErrorNone || error.code == kOBOpenUDIDErrorCompromised)) {
        uidString = [[NSString alloc] initWithFormat:@"%@", udid.ob_md5];
    } else {
        OBLog(@"Get UDID failed!");
        uidString = [[NSString alloc] initWithFormat:@"%@", @"020000000000".ob_md5];
    }
    return uidString;
}

+ (BOOL)ob_isJailBreak {
    BOOL jailbroken = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]) {
        jailbroken = YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"]) {
        jailbroken = YES;
    }
    return jailbroken;
}

+ (double)ob_realMemory {
    return [NSProcessInfo processInfo].physicalMemory/1024.0/1024.0;
}

+ (double)ob_usedMemory {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return ((vm_page_size * vmStats.free_count) / 1024.0) / 1024.0;
}

+ (void)ob_torchTurnOn:(BOOL)on {
    static BOOL s_torchIsOn = NO;
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        
        AVCaptureDevice * avDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([avDevice hasTorch] && [avDevice hasFlash]){
            
            [avDevice lockForConfiguration:nil];
            if (on) {
                [avDevice setTorchMode:AVCaptureTorchModeOn];
                s_torchIsOn = YES;
            } else {
                [avDevice setTorchMode:AVCaptureTorchModeOff];
                s_torchIsOn = NO;
            }
            [avDevice unlockForConfiguration];
        }
    }
}

+ (BOOL)ob_dialTelephone:(NSString *)phoneNumber {
    
    if (phoneNumber.length > 0) {
        NSString * schemePhoneNumber = [phoneNumber ob_phoneNumberRegularization:phoneNumber];
        if (![phoneNumber hasPrefix:@"tel://"]) {
            schemePhoneNumber = [NSString stringWithFormat:@"tel://%@", schemePhoneNumber];
        }
        NSURL *telePhoneUrl = [NSURL URLWithString:schemePhoneNumber];
        if ([[UIApplication sharedApplication] canOpenURL:telePhoneUrl]) {
            [[UIApplication sharedApplication] openURL:telePhoneUrl];
            return YES;
        }
    }
    return NO;
}

@end
