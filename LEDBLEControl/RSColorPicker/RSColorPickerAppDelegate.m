//
//  RSColorPickerAppDelegate.m
//  RSColorPicker
//
//  Created by Ryan Sullivan on 8/12/11.
//  Copyright 2011 Freelance Web Developer. All rights reserved.
//

#import "RSColorPickerAppDelegate.h"
#define DEFAULT_VOID_COLOR [UIColor whiteColor]

@implementation RSColorPickerAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    colorPicker = [[RSColorPickerView alloc] initWithFrame:CGRectMake(10.0, 40.0, 300.0, 300.0)];
    [colorPicker setDelegate:self];
    
    
    
    [colorPicker setBrightness:1.0];
    [colorPicker setCropToCircle:NO]; // Defaults to YES (and you can set BG color)
    [colorPicker setBackgroundColor:[UIColor clearColor]];
    
    brightnessSlider = [[RSBrightnessSlider alloc] initWithFrame:CGRectMake(10.0, 360.0, 300.0, 30.0)];
    [brightnessSlider setColorPicker:colorPicker];
    [brightnessSlider setUseCustomSlider:YES]; // Defaults to NO
    
    colorPatch = [[UIView alloc] initWithFrame:CGRectMake(10.0, 400.0, 300.0, 30.0)];
    
    // example of preloading a color
    //UIColor * aColor = [UIColor colorWithRed:0.803 green:0.4 blue:0.144 alpha:1];
    //[colorPicker setSelectionColor:aColor];
    //[brightnessSlider setValue:[colorPicker brightness]];
    
    [self.window addSubview:colorPicker];
    [self.window addSubview:brightnessSlider];
    [self.window addSubview:colorPatch];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)colorPickerDidChangeSelection:(RSColorPickerView *)cp {
    colorPatch.backgroundColor = [cp selectionColor];
    
    //NSString *colorString =[self changeUIColorToRGB:cp.selectionColor];
    //NSString *r = [colorString substringWithRange:NSMakeRange(1,2)];
    //NSString *g = [colorString substringWithRange:NSMakeRange(3,2)];
    //NSString *b = [colorString substringWithRange:NSMakeRange(5,2)];
    
    
    //NSLog(@"Red: %d Green: %d Blue: %d Bright: %d",[self colorStringToInt:colorString colorNo:0],[self colorStringToInt:colorString colorNo:1],[self colorStringToInt:colorString colorNo:2],[[NSString stringWithFormat:@"%f",[brightnessSlider value]*100 ] intValue]);
}


//字符串转颜色
- (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//颜色转字符串
- (NSString *) changeUIColorToRGB:(UIColor *)color{
    
    
    const CGFloat *cs=CGColorGetComponents(color.CGColor);
    
    
    NSString *r = [NSString stringWithFormat:@"%@",[self  ToHex:cs[0]*255]];
    NSString *g = [NSString stringWithFormat:@"%@",[self  ToHex:cs[1]*255]];
    NSString *b = [NSString stringWithFormat:@"%@",[self  ToHex:cs[2]*255]];
    return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
    
    
}

-(int)colorStringToInt:(NSString *)colorString colorNo:(int)colorNo
{
    const char *cstr;
    int iPosition=0;
    int nColor=0;
    cstr=[colorString UTF8String];
    
    //判断是否有＃号
    if(cstr[0]=='#') iPosition=1;
    else iPosition=0;
    
    //第1位颜色值
    iPosition = iPosition+colorNo*2;
    if(cstr[iPosition]>='0'&&cstr[iPosition]<'9')nColor=(cstr[iPosition]-'0')*16;
    else nColor=(cstr[iPosition]-'A'+10)*16;
    
    //第2位颜色值
    iPosition ++;
    if(cstr[iPosition]>='0'&&cstr[iPosition]<'9')nColor=(cstr[iPosition]-'0');
    else nColor=nColor+(cstr[iPosition]-'A'+10);
    
    return nColor;
}

//十进制转十六进制
-(NSString *)ToHex:(int)tmpid
{
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig=tmpid%16;
    int tmp=tmpid/16;
    switch (ttmpig)
    {
        case 10:
            nLetterValue =@"A";break;
        case 11:
            nLetterValue =@"B";break;
        case 12:
            nLetterValue =@"C";break;
        case 13:
            nLetterValue =@"D";break;
        case 14:
            nLetterValue =@"E";break;
        case 15:
            nLetterValue =@"F";break;
        default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
            
    }
    switch (tmp)
    {
        case 10:
            nStrat =@"A";break;
        case 11:
            nStrat =@"B";break;
        case 12:
            nStrat =@"C";break;
        case 13:
            nStrat =@"D";break;
        case 14:
            nStrat =@"E";break;
        case 15:
            nStrat =@"F";break;
        default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
            
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    return endtmp;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background,optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    
}

@end
