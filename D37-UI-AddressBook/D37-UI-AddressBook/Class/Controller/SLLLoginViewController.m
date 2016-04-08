//
//  SLLLoginViewController.m
//  D37-UI-AddressBook
//
//  Created by 孙磊 on 16/4/8.
//  Copyright © 2016年 sunlei. All rights reserved.
//

#import "SLLLoginViewController.h"
#import "SLLContactViewController.h"

@interface SLLLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTxt;
@property (weak, nonatomic) IBOutlet UITextField *passTxt;
@property (weak, nonatomic) IBOutlet UISwitch *outoLogin;
@property (weak, nonatomic) IBOutlet UISwitch *rememberPass;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation SLLLoginViewController

#pragma mark- 页面加载时
-(void)loadView
{
    [super loadView];
    //禁用登录按钮
    self.loginBtn.enabled=NO;
    
    //1.监听文本宽
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userTextChange) name:UITextFieldTextDidChangeNotification object:self.userTxt];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userTextChange) name:UITextFieldTextDidChangeNotification object:self.passTxt];
}

#pragma mark- 移除通知
-(void)dealloc
{
    NSLog(@"移除");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark- 用户名输入change
-(void)userTextChange
{
    if (self.userTxt.text.length>0&&self.passTxt.text.length>0) {
        self.loginBtn.enabled=YES;
    }else{
        self.loginBtn.enabled=NO;
    }
    
}


#pragma mark- 自动登录
- (IBAction)outoLogin:(UISwitch *)sender {
    //UISwitch
    if ([sender isOn]) {
        self.rememberPass.on=YES;
    }else{
        self.rememberPass.on=NO;
    }
}

#pragma mark- 记住密码
- (IBAction)rememberPass:(UISwitch *)sender {
    if (![sender isOn]) {
        self.outoLogin.on=NO;
    }
}

#pragma mark- 点击登录
- (IBAction)loginBtn:(UIButton *)sender {
    
    
    //判断用户名密码是否正确
    if ([self.userTxt.text isEqual:@"sl"]&&[self.passTxt.text isEqual:@"123"]) {
        NSLog(@"登录成功");
        SLLContactViewController *tableCon=[[SLLContactViewController alloc]init];
        [self.navigationController pushViewController:tableCon animated:YES];
    }else{
       NSLog(@"登录失败");
    }
    
}

#pragma mark- 导航之前准备
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   //获取目标控制器
    UIViewController *des=segue.destinationViewController;
    
    //给目标控制器的属性赋值
    des.navigationItem.title=[NSString stringWithFormat:@"%@的联系人",self.userTxt.text];
    NSLog(@"%@",sender);
    
}



@end
