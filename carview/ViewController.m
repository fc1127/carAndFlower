//
//  ViewController.m
//  carview
//
//  Created by 方超 on 16/9/20.
//  Copyright © 2016年 FC. All rights reserved.
//

#import "ViewController.h"
#define XJScreenH [UIScreen mainScreen].bounds.size.height
#define XJScreenW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
@property(nonatomic,strong)UIImageView * giftV;
@property (nonatomic, strong) NSArray *fireworksArray;

@property (nonatomic, weak) CALayer *fireworksL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Do any additional setup the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self fireWithSeconds:3];
    [self sendGiftWith:@"porsche"];
    
   
}
-(void)sendGiftWith:(NSString *)name{
     self.giftV=[[UIImageView alloc]initWithFrame:CGRectMake(20, 50, 0, 0)];
     self.giftV.image=[UIImage imageNamed:name];
    [self.view addSubview:self.giftV];
    
    [UIView animateWithDuration:3 animations:^{
        self.giftV.frame=CGRectMake(100, 200, 150, 100);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
        [UIView animateWithDuration:0.5 animations:^{
            self.giftV.alpha=0;
        } completion:^(BOOL finished) {
            [self.giftV removeFromSuperview];
        }];
    });
    
}


//烟花
-(void)fireWithSeconds:(int)seconds{
    CALayer *fireworksL = [CALayer layer];
    fireworksL.frame = CGRectMake((XJScreenW - 250) * 0.5, 100, 250, 50);
    fireworksL.contents = (id)[UIImage imageNamed:@"gift_fireworks_0"].CGImage;
    [self.view.layer addSublayer:fireworksL];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            //没找到设置透明度的方法，有创意可以自己写
            //            fireworksL.alpha = 0;
        } completion:^(BOOL finished) {
            [fireworksL removeFromSuperlayer];
        }];
    });
    _fireworksL = fireworksL;
    
    
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 1; i < 3; i++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"gift_fireworks_%d",i]];
        [tempArray addObject:image];
    }
    _fireworksArray=[[NSArray alloc]init];
    _fireworksArray = tempArray;
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(update) userInfo:nil repeats:YES];
}
static int _fishIndex = 0;

- (void)update {
    
    _fishIndex++;
    
    if (_fishIndex > 1) {
        _fishIndex = 0;
    }
    UIImage *image = self.fireworksArray[_fishIndex];
    _fireworksL.contents = (id)image.CGImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
