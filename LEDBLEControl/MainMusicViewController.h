//
//  MainMusicViewController.h
//  LEDBLEControl
//
//  Created by hebiao on 15-6-17.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "MBProgressHUD.h"



//// 定义播放模式，顺序，随机 ，单曲循环
enum PlayMode {
    PlayModeOrder = 1,
    PlayModeRandom = 2,
    PlayModeRepeat = 3
    
    
};

typedef enum PlayMode PlayMode;

@class AudioStreamer;
@class PeripheralModel;
@class RandomColorNumber;


@interface MainMusicViewController : UIViewController<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    
    ///  播放模式， 随机， 顺序，单曲
    UIButton *button1;
    
    UIButton *button3;
    
    
    
    //// 定义播放模式
    PlayMode playMode;
    
    //// 提示框
     MBProgressHUD *HUD;
    
    
    
     //// 音乐是否在播放
    BOOL isPlaying;
    
    
     //// 列表布局
    UITableView *table;
    
     //// 列表的数据源
    NSMutableArray *arrList;
    
    
    
     //// 当前播放歌曲的资料
    NSMutableDictionary *currentPlayDic;
    
    
    
     //// 播放网络音乐的播放器
    AudioStreamer  *au;
    
     //// 声音的音量属性
    float voiceValue;
    
    
     //// 定时器，每一秒钟刷新一次进度条
    NSTimer *timer;
    
     //// 歌曲播放进度条
    UIView *progreeLine;
    
    
    
     //// 随机颜色rgb值的控制类
    RandomColorNumber *randomColorNumber;
    
    
}

 //// 单例模式
+ (MainMusicViewController *) sharedInstance;


 //// 所有的蓝牙设备（灯泡）
@property (strong,nonatomic) NSArray *permodelArray;



@property BOOL canWork;





@end
