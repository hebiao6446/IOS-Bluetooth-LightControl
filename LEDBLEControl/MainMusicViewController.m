//
//  MainMusicViewController.m
//  LEDBLEControl
//
//  Created by hebiao on 15-6-17.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import "MainMusicViewController.h"

#import "AudioStreamer.h"
#import "MusicControViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"

#import "UtilFunction.h"
#import "PerModel.h"

#import "HeadFile.h"


#import "RandomColorNumber.h"



#define PLAY_MODE @"play_mode"


@interface MainMusicViewController ()

@end

@implementation MainMusicViewController


static MainMusicViewController *sharedObj = nil;

+ (MainMusicViewController *) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedObj=[[MainMusicViewController alloc] init];
        
        
    });
    
    return sharedObj;
}


+ (id) allocWithZone:(NSZone *)zone //第三步：重写allocWithZone方法
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedObj=[super allocWithZone:zone];
        
        
    });
    
    return sharedObj;
}
- (id) copyWithZone:(NSZone *)zone //第四步
{
    return self;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed=YES;
        
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
       //  设置定时器 每秒更新一次
    timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:self repeats:YES];
    [timer setFireDate:[NSDate distantPast]];

    //  设置 当前没有播放音乐
    isPlaying=NO;
    
    
     randomColorNumber=[[RandomColorNumber alloc] init];
    
    
    
    
    arrList=[[NSMutableArray alloc] init];
    
    currentPlayDic=[[NSMutableDictionary alloc] init];
    
    
    
    [self createRightBar];
    self.view.backgroundColor=[UIColor blackColor];
    [self createBackImage];
    [self createFooterView];
    [self createTableView];
    //初始化提示框
    [self initHUD];

    self.title=@"我的音乐";
    
    
    [self getDataFromUrl];
    
    
    
    
    
    
   

}

/// 控制 颜色主要部分
-(void)startLightRandom{
    
    if (!self.canWork) {
        
        if (au!=nil) {
            [au stop];
            au=nil;
            
            
            isPlaying=NO;
            [button3 setImage:[UIImage imageNamed:@"playbutton5"] forState:UIControlStateNormal];
            
        }
        
        
        
        return;
    }
    
    
    NSDictionary *dic=[randomColorNumber getRandomColor];
    
    int r=[dic[@"r"] intValue];
    int g=[dic[@"g"] intValue];
     int b=[dic[@"b"] intValue];
    
    NSLog(@"%@ - - - -",dic);
    
    Byte _b[] ={r
        ,g
        ,b
        ,0x00
        ,0x64};
    
    NSData *d = [[NSData alloc] initWithBytes:_b length:sizeof(_b)];
    
    
    for (PeripheralModel *p in self.permodelArray) {
        if (p.switchNumber==0&&p.isOnOff&&light1Status) {
            [p.peripheral writeValue:d forCharacteristic:p.characteristic1 type:CBCharacteristicWriteWithResponse];
        }
        
        
        if (p.switchNumber==1&&p.isOnOff&&light2Status) {
            [p.peripheral writeValue:d forCharacteristic:p.characteristic1 type:CBCharacteristicWriteWithResponse];
        }
        
        if (p.switchNumber==2&&p.isOnOff&&light3Status) {
            [p.peripheral writeValue:d forCharacteristic:p.characteristic1 type:CBCharacteristicWriteWithResponse];
        }
        
        if (p.switchNumber==3&&p.isOnOff&&light4Status) {
            [p.peripheral writeValue:d forCharacteristic:p.characteristic1 type:CBCharacteristicWriteWithResponse];
        }
        
        if (p.switchNumber==4&&p.isOnOff&&light5Status) {
            [p.peripheral writeValue:d forCharacteristic:p.characteristic1 type:CBCharacteristicWriteWithResponse];
        }
        
        if (p.switchNumber==5&&p.isOnOff&&light6Status) {
            [p.peripheral writeValue:d forCharacteristic:p.characteristic1 type:CBCharacteristicWriteWithResponse];
        }
        

    }
    
//    [self.permodel1.peripheral writeValue:d forCharacteristic:self.permodel1.characteristic1 type:CBCharacteristicWriteWithResponse];
}


///主UI
-(void)createTableView{
    table=[[UITableView alloc] init];
    table.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44-20-49-1);
    table.backgroundColor=[UIColor clearColor];
    table.backgroundView=nil;
    table.separatorColor=[UIColor lightGrayColor];
    table.dataSource=self;
    table.delegate=self;
    [self.view addSubview:table];
     [table addHeaderWithTarget:self action:@selector(headerRereshing)];
    table.headerPullToRefreshText = @"继续下拉刷新数据";
    table.headerReleaseToRefreshText = @"松开重新加载数据";
    table.headerRefreshingText = @"刷新数据中...";
    
}


/// 获取数据 从网络

-(void)getDataFromUrl{
    
  NSString *urlString=NSLocalizedStringFromTable(@"URL", @"NetWorkUrl", nil);
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [AFPropertyListRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"application/xml"]];
    AFPropertyListRequestOperation *operation = [AFPropertyListRequestOperation propertyListRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id propertyList) {
//        NSLog(@" - - - - - - - - - - %@ - - —!__!_!_!_!_",[propertyList class]);
        
        [arrList removeAllObjects];
        if ([propertyList isKindOfClass:[NSArray class]]) {
            NSArray *arr=(NSArray *)propertyList;
            
            
            [arrList addObjectsFromArray:arr];
            
            if ([arrList count]>0) {
                [currentPlayDic setDictionary:arrList[0]];
                
            }
            
            [table reloadData];
            
            
            
            
        }
        
        
        [table headerEndRefreshing];
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id propertyList) {
//        NSLog(@"!!!!!     %@",error);
        
        [table headerEndRefreshing];
    }];
    
    [operation start];
}



//// 下拉刷新
-(void)headerRereshing{
    
    [self getDataFromUrl];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [arrList count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        
        
        
        UIImageView *imageView=[[UIImageView alloc] init];
        imageView.frame=CGRectMake(20, 10, 40, 40);
        imageView.tag=121;
        imageView.layer.masksToBounds=YES;
        imageView.layer.cornerRadius=20;
        imageView.layer.backgroundColor=[[UIColor clearColor]CGColor];
        imageView.backgroundColor=[UIColor clearColor];
        [cell addSubview:imageView];
        
        
        
        UILabel *labe1=[[UILabel alloc] init];
        labe1.frame=CGRectMake(70, 10, 180, 25);
        labe1.backgroundColor=[UIColor clearColor];
        labe1.textColor=[UIColor blackColor];
        labe1.font=[UIFont systemFontOfSize:20];
        labe1.tag=131;
        [cell addSubview:labe1];
        
        
        UILabel *labe2=[[UILabel alloc] init];
        labe2.frame=CGRectMake(70, 35, 180, 15);
        labe2.backgroundColor=[UIColor clearColor];
        labe2.textColor=[UIColor blackColor];
        labe2.font=[UIFont systemFontOfSize:14];
        labe2.tag=141;
        [cell addSubview:labe2];
        
        
        
        
        UILabel *labe3=[[UILabel alloc] init];
        labe3.frame=CGRectMake(self.view.frame.size.width-50, 20, 40, 20);
        labe3.backgroundColor=[UIColor clearColor];
        labe3.textColor=[UIColor blackColor];
        labe3.textAlignment=NSTextAlignmentCenter;
        labe3.font=[UIFont systemFontOfSize:11];
        labe3.tag=151;
        [cell addSubview:labe3];

        
    }
    
  
    NSDictionary *d=arrList[indexPath.row];
    
    
    UIImageView *imageView=(UIImageView *)[cell viewWithTag:121];
    [imageView setImageWithURL:[NSURL URLWithString:d[@"image"]] placeholderImage:[UIImage imageNamed:@"def"]];
    
    
    
    UILabel *l1=(UILabel *)[cell viewWithTag:131];
    l1.text=d[@"name"];
    
    
    UILabel *l2=(UILabel *)[cell viewWithTag:141];
    l2.text=d[@"context"];
    
    
    UILabel *l3=(UILabel *)[cell viewWithTag:151];
    if ([d isEqualToDictionary:currentPlayDic]&&isPlaying) {
        l3.text=@"播放中";
    }else{
        l3.text=@"";
    }
    
    
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    [currentPlayDic setDictionary:arrList[indexPath.row]];
    
    
//    NSString *url=currentPlayDic[@"url"];
   
    
    [self playMusic:currentPlayDic];
    
}


-(void)playMusic:(NSDictionary *)d{
    if (au!=nil) {
        [au stop];
        au=nil;
        
    }
    
    self.title=d[@"name"];
    
    au= [[AudioStreamer alloc] initWithURL:[NSURL URLWithString:d[@"url"]]];
    [au start];
    [au volume:voiceValue];
    isPlaying=YES;
    
    [button3 setImage:[UIImage imageNamed:@"pausebutton6"] forState:UIControlStateNormal];
    
    
    [table reloadData];
    
    
    BOOL allLightIsOff=NO;
    
    for (PeripheralModel *p  in self.permodelArray) {
        allLightIsOff = p.isOnOff||allLightIsOff;
    }
    
    if (!allLightIsOff) {
        HUD.labelText = @"请至少连接一个蓝牙灯泡";
        HUD.mode = MBProgressHUDModeText;
        
        HUD.delegate = self;
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:3];
    }
 
    
    [randomColorNumber resetRandom];
    [randomColorNumber resetStep];
    
}

-(void)playMusicPause{
    
    if (au!=nil) {
        [au pause];
      
        
    }
    
}
-(void)playMusicCountinue{
    if (au!=nil) {
        [au start];
    }
}



/// 定时器更新时间
-(void)timerAction:(NSTimer *)sender{
//    NSLog(@"%@  !!!  --%d  ==++++ %d", [NSDate date],[au progressInt],[au durationInt]);
    
    
    if ([au durationInt]>0) {
          progreeLine.frame=CGRectMake(0, 0, self.view.frame.size.width*[au progressInt]/[au durationInt], 1);
        
        
        if (isPlaying) {
            
            if ([au progressInt]%15==0) {
                [randomColorNumber resetStep];
                [randomColorNumber resetRandom];
            }
            
            [self startLightRandom];
        }
        
    }
    
    
    
    
  
    if (abs([au progressInt]-[au durationInt])<10&&au.isFinishing) {
        
        if ([arrList count]==0||[currentPlayDic count]==0) {
            return;
        }
        
        
        
        
        if (playMode==PlayModeOrder) {
            
            NSDictionary *d =[UtilFunction getNextDic:currentPlayDic inArray:arrList];
            [currentPlayDic setDictionary:d];
            
        }else if (playMode==PlayModeRandom){
            NSDictionary *d=[UtilFunction getRandomDic:arrList];
            [currentPlayDic setDictionary:d];
            
        }else if (playMode==PlayModeRepeat){
            
        }
        
        
        
 
        
        
        [self playMusic:currentPlayDic];
    }
    
    
    
}



-(void)createFooterView{
    
    UIView *footer=[[UIView alloc] init];
    footer.frame=CGRectMake(0, self.view.frame.size.height-49-44-20+1, self.view.frame.size.width, 50);
    footer.backgroundColor=[UIColor blackColor];
    [self.view addSubview:footer];
    
//     CGFloat yFooter=CGRectGetMaxY(footer.frame);
    
    /// 进度条
    progreeLine=[[UIView alloc]init];
//    progreeLine.frame=CGRectMake(0, 0, 1, 1);
    progreeLine.backgroundColor=[UIColor colorWithRed:0 green:122.0/255.0 blue:255.0/255.0 alpha:1];
    [footer addSubview:progreeLine];
    
    
    
    float h=self.view.frame.size.height-49-44-20;
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PLAY_MODE]==nil) {
        playMode=PlayModeOrder;
    }else{
        
        playMode=[[[NSUserDefaults standardUserDefaults] objectForKey:PLAY_MODE] intValue];
    }
    
    
    
    button1=[[UIButton alloc] init];
    button1.frame=CGRectMake(20, 8+h, 32, 32);
    if (playMode==PlayModeOrder) {
         [button1 setImage:[UIImage imageNamed:@"sequentialbutton10"] forState:UIControlStateNormal];
    }else if (playMode==PlayModeRandom){
        [button1 setImage:[UIImage imageNamed:@"randombutton8"] forState:UIControlStateNormal];
    }else if (playMode==PlayModeRepeat){
        [button1 setImage:[UIImage imageNamed:@"repeatedbutton9"] forState:UIControlStateNormal];
    }
   
    [button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    
    
    UIButton *button2=[[UIButton alloc] init];
    button2.frame=CGRectMake(62, 3+h, 42, 42);
    [button2 setImage:[UIImage imageNamed:@"prevbutton4"] forState:UIControlStateNormal];
     [button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
    button3=[[UIButton alloc] init];
    button3.frame=CGRectMake(114, 10+h, 29, 29);
    [button3 setImage:[UIImage imageNamed:@"playbutton5"] forState:UIControlStateNormal];
     [button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    
    UIButton *button4=[[UIButton alloc] init];
    button4.frame=CGRectMake(153, 3+h, 42, 42);
    [button4 setImage:[UIImage imageNamed:@"nextbutton7"] forState:UIControlStateNormal];
     [button4 addTarget:self action:@selector(button4Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];

    
    UILabel *l0=[[UILabel alloc] init];
    l0.frame=CGRectMake(self.view.frame.size.width-160, 13+h, 10, 20);
    l0.backgroundColor=[UIColor clearColor];
    l0.textColor=[UIColor whiteColor];
    l0.text=@"-";
    [self.view addSubview:l0];
    
    
    
    UISlider *slider=[[UISlider alloc] init];
    slider.frame=CGRectMake(self.view.frame.size.width-150, 14+h, 100, 20);
    slider.maximumValue = 10;
    slider.value = 5;
    slider.minimumValue = 0;
    voiceValue=0.5;
    [slider addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    
    UILabel *l1=[[UILabel alloc] init];
    l1.frame=CGRectMake(self.view.frame.size.width-50, 13+h, 10, 20);
    l1.backgroundColor=[UIColor clearColor];
    l1.textColor=[UIColor whiteColor];
    l1.text=@"+";
    [self.view addSubview:l1];
    
}

///// 播放模式 选择
-(void)button1Action{
    
    
     HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] ;
    
    
    if (playMode==PlayModeOrder) {
        playMode=PlayModeRandom;
         [button1 setImage:[UIImage imageNamed:@"randombutton8"] forState:UIControlStateNormal];
       
        HUD.labelText = @"随机模式";
      
        
    }else if (playMode==PlayModeRandom){
        playMode=PlayModeRepeat;
        [button1 setImage:[UIImage imageNamed:@"repeatedbutton9"] forState:UIControlStateNormal];
        HUD.labelText = @"单曲模式";
    }else if (playMode==PlayModeRepeat){
        playMode=PlayModeOrder;
           [button1 setImage:[UIImage imageNamed:@"sequentialbutton10"] forState:UIControlStateNormal];
        HUD.labelText = @"顺序模式";

    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@(playMode) forKey:PLAY_MODE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.delegate = self;
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
    
}


//// 前一曲
-(void)button2Action{
    
    
    if ([currentPlayDic count]==0||[arrList count]==0) {
    
        
         HUD.labelText = @"找不到播放资源";
        HUD.mode = MBProgressHUDModeText;
        
        HUD.delegate = self;
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:3];

        return;
    }
    
    
    NSDictionary *d =[UtilFunction getPrevDic:currentPlayDic inArray:arrList];
    
    [currentPlayDic setDictionary:d];
    
//    NSString *url=currentPlayDic[@"url"];
    
    
    [self playMusic:currentPlayDic];
    
    
}


-(void)button3Action{
    
    if (isPlaying) {
        isPlaying=NO;
        [button3 setImage:[UIImage imageNamed:@"playbutton5"] forState:UIControlStateNormal];
        [self playMusicPause];
        
        
    }else{
        
        isPlaying=YES;
        [button3 setImage:[UIImage imageNamed:@"pausebutton6"] forState:UIControlStateNormal];
        
        if (au.isPaused) {
            
            [au start];
            
        }else{
            
            if ([currentPlayDic count]==0||[arrList count]==0) {
                
                
                HUD.labelText = @"找不到播放资源";
                HUD.mode = MBProgressHUDModeText;
                
                HUD.delegate = self;
                
                [HUD show:YES];
                [HUD hide:YES afterDelay:3];
                
                return;
            }
            
            
            NSDictionary *d =arrList[0];
            
            [currentPlayDic setDictionary:d];
            
            //    NSString *url=currentPlayDic[@"url"];
            
            
            [self playMusic:currentPlayDic];
            
        }
        
        
        
    }
    
    [table reloadData];
    
    
}

/// 后一曲
-(void)button4Action{
    
    if ([currentPlayDic count]==0||[arrList count]==0) {
        
        
        HUD.labelText = @"找不到播放资源";
        HUD.mode = MBProgressHUDModeText;
        
        HUD.delegate = self;
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:3];
        
        return;
    }
    
    
    
    NSDictionary *d =[UtilFunction getNextDic:currentPlayDic inArray:arrList];
    
    [currentPlayDic setDictionary:d];
    
//    NSString *url=currentPlayDic[@"url"];
    
    
    [self playMusic:currentPlayDic];
    
    
}
-(void)updateValue:(UISlider *)sender{
    
//    NSLog(@"%f  -----",sender.value);
    
    
    
    
    if (au) {
        
        voiceValue=sender.value/10.0;
        [au volume:sender.value/10.0];
    }
    
}



///// 背景颜色，背景图片
-(void)createBackImage{
    
    UIImageView *bg=[[UIImageView alloc] init];
    bg.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [bg setImage:[UIImage imageNamed:@"bingback3"]];
    [self.view addSubview:bg];
    
    
    
}
#pragma HBAdd


///// 右上角按钮， 到下一个界面
-(void)createRightBar{
    
    UIButton *btnb = [UIButton buttonWithType : UIButtonTypeCustom];
    btnb.frame = CGRectMake (5.5, 5.5, 33, 33);
    [btnb setBackgroundImage :[UIImage imageNamed:@"bar2"] forState:UIControlStateNormal];
    btnb.showsTouchWhenHighlighted=YES;
    [btnb addTarget:self action:@selector(showRight:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :btnb];
    self.navigationItem.rightBarButtonItem = ubar;
}
-(void)showRight:(UIButton *)sender{
    MusicControViewController *mcvc=[[MusicControViewController alloc] init];
//    mcvc.permodelArray=self.permodelArray;
    mcvc.lightStatus=light1Status||light2Status||light3Status||light4Status||light5Status||light6Status;
    [self.navigationController pushViewController:mcvc animated:YES];
    
    
    
}


//************************HUD************************
//初始化提示框
- (void)initHUD
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.delegate = self;
    [self.view addSubview:HUD];
}

- (void)myShowHUD:(MBProgressHUDMode)type :(NSString *)text {
    HUD.labelText = text;
    HUD.mode = type;
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)myTask {
    sleep(1.0);
}
//************************HUD************************

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
