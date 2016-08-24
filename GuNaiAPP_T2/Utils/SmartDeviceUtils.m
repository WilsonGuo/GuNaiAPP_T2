//
//  SmartDeviceUtils.m
//  SmartDeivceManager
//
//  Created by Wilson.Guo on 15/5/8.
//  Copyright (c) 2015年 Wilson.Guo. All rights reserved.
//

#import "SmartDeviceUtils.h"
#import <SystemConfiguration/CaptiveNetwork.h>
@implementation SmartDeviceUtils

static NSMutableArray * devices;
static NSMutableArray * devicesNew;
+ (SmartDeviceUtils *)sharedInstance
{
	static dispatch_once_t  onceToken;
	static SmartDeviceUtils * sSharedInstance;
	
	dispatch_once(&onceToken, ^{
		sSharedInstance = [[SmartDeviceUtils alloc] init];
        devices=[[NSMutableArray alloc]initWithCapacity:10];
        devicesNew=[[NSMutableArray alloc]initWithCapacity:10];
	});
   
	return sSharedInstance;
}



-(void)addGNDevice:(GNDevice *)dev{
    bool isExites=false;
    for (int i=0; i<devices.count; i++) {
        GNDevice *device=[devices objectAtIndex:i];
        if (device.devId==dev.devId) {
            isExites=true;
        }
    }
    if (isExites==false) {
        [devices addObject:dev];
    }
//    if (![devices containsObject:dev]) {
//        [devices addObject:dev];
//    }
}
-(void)addGNDeviceNew:(GNDevice *)dev{
    if (![devicesNew containsObject:dev]) {
        [devicesNew addObject:dev];
    }
}
-(NSMutableArray *)getGNDevices{
    return devices;
}
-(NSMutableArray *)getNewGNDevices{
    return devicesNew;
}
-(void)clearGNDevice{
    if (devices!=nil) {
        [devices removeAllObjects];
    }
}
-(void)clearGNDeviceNew{
    if (devicesNew!=nil) {
        [devicesNew removeAllObjects];
    }
}



- (NSString *) getDeviceSSID
{
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        
        if (info && [info count]) {
            
            break;
            
        }
    }
    
    NSDictionary *dctySSID = (NSDictionary *)info;
    
    NSString *ssid = [[dctySSID objectForKey:@"SSID"] lowercaseString];
    return ssid;
    
}
- (NSString*) doDevicePlatform
{
	
	//NSLog(@"%@   %@   %@   %@   %@   %@   %@   %@   %@",@"设备名称",[UIDevice currentDevice].name,@"设备型号", [UIDevice currentDevice].model,@"系统版本型号", [UIDevice currentDevice].systemVersion,@"系统版本名称",[UIDevice currentDevice].systemName);
	size_t size;
	int nR = sysctlbyname("hw.machine",
						  NULL, &size, NULL,
						  0);
	
	
	char*machine = (char*)malloc(size);
	
	nR =
	sysctlbyname("hw.machine", machine, &size,
				 NULL, 0);
	
	
	NSString *platform = [NSString
						  stringWithCString:machine encoding:NSUTF8StringEncoding];
	
	
	free(machine);
	
	
	
	
	
	
	if([platform isEqualToString:@"iPhone1,1"])
		
	{
		
		platform =
		@"iPhone";
		
	}
	
	
	else if([platform
			 isEqualToString:@"iPhone1,2"])
		
	{
		
		platform =
		@"iPhone 3G";
		
	}
	
	
	else if([platform
			 isEqualToString:@"iPhone2,1"])
		
	{
		
		platform =
		@"iPhone 3GS";
		
	}
	
	
	else if([platform
			 isEqualToString:@"iPhone3,1"]||[platform
											 isEqualToString:@"iPhone3,2"]||[platform
																			 isEqualToString:@"iPhone3,3"])
		
	{
		
		platform =
		@"iPhone 4";
		
	}
	
	
	else if([platform
			 isEqualToString:@"iPhone4,1"])
		
	{
		
		platform =
		@"iPhone 4S";
		
	}
	
	
	else if([platform
			 isEqualToString:@"iPhone5,1"]||[platform
											 isEqualToString:@"iPhone5,2"])
		
	{
		
		platform =
		@"iPhone 5";
		
	}
	
	
	else if([platform
			 isEqualToString:@"iPhone5,3"]||[platform
											 isEqualToString:@"iPhone5,4"])
		
	{
		
		platform =
		@"iPhone 5C";
		
	}
	
	
	else if([platform
			 isEqualToString:@"iPhone6,2"]||[platform
											 isEqualToString:@"iPhone6,1"])
		
	{
		
		platform =
		@"iPhone 5S";
		
	}
	else if ([platform isEqualToString:@"iPhone7,1"]) {
		platform =
		@"iPhone 6 Plus (A1522/A1524)";
	}
	else if ([platform isEqualToString:@"iPhone7,1"]) {
		platform =
		@"iPhone 6 (A1549/A1586)";
	}
	else if([platform
			 isEqualToString:@"iPod4,1"])
		
	{
		
		platform =
		@"iPod touch 4";
		
	}
	
	
	else if([platform
			 isEqualToString:@"iPod5,1"])
		
	{
		
		platform =
		@"iPod touch 5";
		
	}
	
	
	else if([platform
			 isEqualToString:@"iPod3,1"])
		
	{
		
		platform =
		@"iPod touch 3";
		
	}
	
	
	else if([platform
			 isEqualToString:@"iPod2,1"])
		
	{
		
		platform =
		@"iPod touch 2";
		
	}
	
	
	else if([platform
			 isEqualToString:@"iPod1,1"])
		
	{
		
		platform =
		@"iPod touch";
		
	}
	
	
	else if([platform
			 isEqualToString:@"iPad3,2"]||[platform
										   isEqualToString:@"iPad3,1"])
		
	{
		
		platform =
		@"iPad 3";
		
	}
	
	
	else if([platform
			 isEqualToString:@"iPad2,2"]||[platform
										   isEqualToString:@"iPad2,1"]||[platform
																		 isEqualToString:@"iPad2,3"]||[platform
																									   isEqualToString:@"iPad2,4"])
		
	{
		
		platform =
		@"iPad 2";
		
	}
	
	
	else if([platform
			 isEqualToString:@"iPad1,1"])
		
	{
		
		platform =
		@"iPad 1";
		
	}
	else if([platform
			 isEqualToString:@"iPad2,5"]||[platform
										   isEqualToString:@"iPad2,6"]||[platform
																		 isEqualToString:@"iPad2,7"])
	{
		
		platform =
		@"ipad mini";
		
	}
	else if([platform
			 isEqualToString:@"iPad3,3"]||[platform
										   isEqualToString:@"iPad3,4"]||[platform
																		 isEqualToString:@"iPad3,5"]||[platform
																									   isEqualToString:@"iPad3,6"])
		
	{
		
		platform =
		@"ipad 3";
		
	}else if ([platform isEqualToString:@"i386"]) {
		platform =
		@"iPhone Simulator";
	}else if ([platform isEqualToString:@"x86_64"]) {
		
		
		platform =
		@"iPhone Simulator";
	}
	
	//[self doGetScreen];
	
	return platform;
	
}






/**
 *  校验邮箱
 *
 *  @param email 邮箱字符串
 *
 *  @return bool
 */
//-(BOOL)isValidateEmail:(NSString *)email {
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:email];
//}



//[a|A]{2}[a-fA-F0-9]{24}[f|F]{1}[a|A]{1}
-(NSMutableArray *)isCompleteWithString:(NSString *) string{
     NSError *error;
	
	
    NSMutableArray *strArray=[[NSMutableArray alloc]initWithCapacity:10];
	
	if(string == nil || [string isEqualToString:@""])
	{
		return strArray;
	}
		
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[a|A]{2}[a-fA-F0-9]{24}[f|F]{1}[a|A]{1}" options:0 error:&error];
    
    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    NSString *str = nil;
    if (matches!=nil&&matches.count>0) {
        
        for (NSTextCheckingResult* b in matches)
        {
			//NSLog(@"range.location=%d  range.length=%d string.length=%d",b.range.location,b.range.length,string.length);
			
			if((b.range.location + b.range.length)>string.length)
			{
				break;
			}
            str = [string substringWithRange:b.range];
            NSLog(@" str  is %@,range.location=%lu  range.length=%lu",str,(unsigned long)b.range.location,(unsigned long)b.range.length);
            [strArray addObject:str];
        }
//        NSTextCheckingResult* bLast=[matches objectAtIndex:matches.count-1];
//		
//        NSString*strLast = [string substringFromIndex:(bLast.range.location+bLast.range.length )];
//        NSLog(@" strLast  is %@",strLast);
//        [strArray addObject:strLast];
        
    }
    
    return strArray;
}

-(NSMutableArray *)getTimers{
    
    return nil;
}
@end
