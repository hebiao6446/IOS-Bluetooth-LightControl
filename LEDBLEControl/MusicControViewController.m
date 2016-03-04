//
//  MusicControViewController.m
//  LEDBLEControl
//
//  Created by hebiao on 15-6-17.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import "MusicControViewController.h"
#import "HeadFile.h"

#import "MainMusicViewController.h"

#import "PerModel.h"


@interface MusicControViewController ()

@end

@implementation MusicControViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor blackColor];
    [self createBackImage];
    self.title=@"灯具音乐控制";
    
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    table.backgroundColor=[UIColor clearColor];
    table.backgroundView=nil;
    table.delegate=self;
    table.dataSource=self;
    table.separatorColor=[UIColor lightGrayColor];
    [self.view addSubview:table];
    
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70, 42, 60, 30)];
    switchView.on = self.lightStatus;
    [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [table addSubview:switchView];
    
    
    switchList=[[NSMutableArray alloc] init];
    
    
    mainPower=switchView.on;
    
    
    /*
    for (int i=0; i<6; i++) {
        
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70, 132+44*i, 60, 30)];
        switchView.on = YES;
        
        [table addSubview:switchView];
        
        [switchList addObject:switchView];
        
        switchView.hidden=YES;
        
    }
     */
    
    switchView1=[[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70, 132+44*0, 60, 30)];
    switchView1.on = light1Status;
    switchView1.tag=100;
    [switchView1 addTarget:self action:@selector(switchActionTag:) forControlEvents:UIControlEventValueChanged];
    [table addSubview:switchView1];
    [switchList addObject:switchView1];
    switchView1.hidden=!mainPower;
    switchView1.enabled=NO;
    
    
    
    switchView2=[[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70, 132+44*1, 60, 30)];
    switchView2.on = light2Status;
    switchView2.tag=101;
    [switchView2 addTarget:self action:@selector(switchActionTag:) forControlEvents:UIControlEventValueChanged];
    [table addSubview:switchView2];
    [switchList addObject:switchView2];
    switchView2.hidden=!mainPower;
    switchView2.enabled=NO;
    
    
    switchView3=[[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70, 132+44*2, 60, 30)];
    switchView3.on = light3Status;
    [table addSubview:switchView3];
    switchView3.tag=102;
    [switchView3 addTarget:self action:@selector(switchActionTag:) forControlEvents:UIControlEventValueChanged];
    [switchList addObject:switchView3];
    switchView3.hidden=!mainPower;
    switchView3.enabled=NO;
    
    
    
    
    switchView4=[[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70, 132+44*3, 60, 30)];
    switchView4.on = light4Status;
    switchView4.tag=103;
    [switchView4 addTarget:self action:@selector(switchActionTag:) forControlEvents:UIControlEventValueChanged];
    [table addSubview:switchView4];
    [switchList addObject:switchView4];
    switchView4.hidden=!mainPower;
    switchView4.enabled=NO;
    
    
    
    switchView5=[[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70, 132+44*4, 60, 30)];
    switchView5.on = light5Status;
    switchView5.tag=104;
    [switchView5 addTarget:self action:@selector(switchActionTag:) forControlEvents:UIControlEventValueChanged];
    [table addSubview:switchView5];
    [switchList addObject:switchView5];
    switchView5.hidden=!mainPower;
    switchView5.enabled=NO;
    
    
    switchView6=[[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70, 132+44*5, 60, 30)];
    switchView6.on = light6Status;
    switchView6.tag=105;
    [switchView6 addTarget:self action:@selector(switchActionTag:) forControlEvents:UIControlEventValueChanged];
    [table addSubview:switchView6];
    [switchList addObject:switchView6];
    switchView6.hidden=!mainPower;
    switchView6.enabled=NO;
    
   


    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    for (PeripheralModel *p in [MainMusicViewController sharedInstance].permodelArray) {
        
        if (p.switchNumber==0) {
            switchView1.enabled=YES;
        }else if (p.switchNumber==1){
             switchView2.enabled=YES;
        }else if (p.switchNumber==2){
             switchView3.enabled=YES;
        }else if (p.switchNumber==3){
             switchView4.enabled=YES;
        }else if (p.switchNumber==4){
             switchView5.enabled=YES;
        }else if (p.switchNumber==5){
             switchView6.enabled=YES;
        }
    }
    
    
}


-(void)switchActionTag:(UISwitch *)sender{
    NSInteger tag=sender.tag-100;
    
    
    
    PeripheralModel *p = [MainMusicViewController sharedInstance].permodelArray[tag];
    
    
    
    if (tag==0) {
        if (!p.isOnOff) {
            light1Status=NO;
        }else{
            light1Status=sender.isOn;
        }
        
        
    }else if (tag==1){
        
        if (!p.isOnOff) {
            light2Status=NO;
        }else{
            light2Status=sender.isOn;
        }
        
        
    }else if (tag==2){
        
        if (!p.isOnOff) {
            light3Status=NO;
        }else{
            light3Status=sender.isOn;
        }
        
        
    }else if (tag==3){
        
        if (!p.isOnOff) {
            light4Status=NO;
        }else{
            light4Status=sender.isOn;
        }
        
        
    }else if (tag==4){
        
        if (!p.isOnOff) {
            light5Status=NO;
        }else{
            light5Status=sender.isOn;
        }
        
        
    }else if (tag==5){
        
        if (!p.isOnOff) {
            light6Status=NO;
        }else{
            light6Status=sender.isOn;
        }
        
        
    }
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    if (section==0) {
        
        return @"音乐开关打开时,可以控制灯光";
    }
    
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    if (mainPower) {
        return 2;
    }else{
        return 1;
    }
//    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else if (section==1){
        return 6;
    }
    
    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  static NSString *CellWithIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:21];
    if (indexPath.section==0) {
        cell.detailTextLabel.text = @"音乐开关";
        
        
        
    }else if (indexPath.section==1){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"BLE Light %ld",indexPath.row+1];
        
      
    }
    
    
    
 
    return cell;
}
-(void)switchAction:(UISwitch *)sender{
    
//    NSLog(@"%d  ...",sender.on);
    
    
    mainPower=sender.isOn;
    
    
 
    
    [table reloadData];
    
    for (UISwitch *s in switchList) {
        s.hidden=!mainPower;
    }
    
    if (!sender.isOn) {
        light1Status=NO;
         light2Status=NO;
         light3Status=NO;
         light4Status=NO;
         light5Status=NO;
         light6Status=NO;
        
    }
    
    
}
-(void)createBackImage{
    
    UIImageView *bg=[[UIImageView alloc] init];
    bg.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [bg setImage:[UIImage imageNamed:@"bingback3"]];
    [self.view addSubview:bg];
    
    
    
}
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
