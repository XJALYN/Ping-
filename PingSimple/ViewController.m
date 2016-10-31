//
//  ViewController.m
//  PingSimple
//
//  Created by xu jie on 2016/10/31.
//  Copyright © 2016年 xujie. All rights reserved.
//

#import "ViewController.h"
#import "SimplePing.h"
#import <spawn.h>
#import <Foundation/Foundation.h>


@interface ViewController ()<SimplePingDelegate>
@property(nonatomic,strong)SimplePing *simplePing;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.simplePing = [[SimplePing alloc]initWithHostName:@"192.168.110.223"];
    
    [self.simplePing start];
    
    self.simplePing.delegate = self;

 
  
    
   
    
   
}
-(void)simplePing:(SimplePing *)pinger didStartWithAddress:(NSData *)address{
    NSLog(@"开始ping%@",address);
   
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:true block:^(NSTimer * _Nonnull timer) {
        NSData *data = [@"ping" dataUsingEncoding:NSUTF8StringEncoding];
        [self.simplePing sendPingWithData:data];
    }];
}

-(void)simplePing:(SimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet{
    NSLog(@"接收到不期望的数据包%@",packet);
}
-(void)simplePing:(SimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber{
    
    NSLog(@"累积接受到ping的响应数据包%d",sequenceNumber);
}

-(void)simplePing:(SimplePing *)pinger didFailWithError:(NSError *)error{
    NSLog(@"ping失败了");
}




@end
