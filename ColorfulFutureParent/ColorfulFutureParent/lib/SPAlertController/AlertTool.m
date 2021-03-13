//
//  AlertTool.m
//  TeacherEdu2016
//
//  Created by ADIQueen on 16/12/7.
//  Copyright © 2016年 teacher of china. All rights reserved.
//

#import "AlertTool.h"

//Toast默认停留时间
#define ToastDispalyDuration 1.2f
//Toast到顶端/底端默认距离
#define ToastSpace 100.0f
//Toast背景颜色
#define ToastBackgroundColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75]

@interface  AlertTool()
{
    UIButton *_contentView;
    UILabel *_textLabel;
    CGFloat  _duration;
    MBProgressHUD *_progressHUD;
    UIView * bgview;
}
@end
@implementation AlertTool

HFSingletonM(AlertTool);


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
}
/* 
 *
 计算字符串宽度
 */
- (CGRect)getStringRect:(NSString*)aString withFont :(CGFloat)font

{
    
    if(aString){
        
        CGRect rect = [aString boundingRectWithSize:CGSizeMake(10000000, 30) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
        
        return  rect;
        
    }
    
    return CGRectMake(0, 0, 0, 0);
    
}


- (id)initWithText:(NSString *)text{
    if (self = [super init]) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
        CGRect rect=[text boundingRectWithSize:CGSizeMake(250,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        if (_textLabel == nil) {
            _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,rect.size.width + 40, rect.size.height+ 20)];
            _textLabel.backgroundColor = [UIColor clearColor];
            _textLabel.textColor =[UIColor  whiteColor];
            _textLabel.textAlignment = NSTextAlignmentCenter;
            _textLabel.font = font;
            _textLabel.numberOfLines = 0;
        }
        _textLabel.frame = CGRectMake(0, 0,rect.size.width + 40, rect.size.height+ 20);
        if (_contentView == nil) {
            _contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _textLabel.frame.size.width, _textLabel.frame.size.height)];
            _contentView.layer.cornerRadius = 20.0f;
            _contentView.backgroundColor = ToastBackgroundColor;
            //            _contentView.backgroundColor = [UIColor redColor];
            [_contentView addSubview:_textLabel];
            _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [_contentView addTarget:self action:@selector(toastTaped:) forControlEvents:UIControlEventTouchDown];
            _contentView.alpha = 0.0f;
        }
        if (bgview==nil){
            
        }
        _textLabel.text = text;
        _contentView.frame = CGRectMake(0, 0, _textLabel.frame.size.width, _textLabel.frame.size.height);
        _duration = ToastDispalyDuration;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
    }
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)notify{
    [self hideAnimation];
}

-(void)dismissToast{
    [_contentView removeFromSuperview];
}

-(void)toastTaped:(UIButton *)sender{
    [self hideAnimation];
}

- (void)setDuration:(CGFloat)duration{
    _duration = duration;
}

-(void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    _contentView.alpha = 1.0f;
    [UIView commitAnimations];
}

-(void)hideAnimation{
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
//    bgview.alpha = 0.0f;
    _contentView.alpha=0.0f;
    [UIView commitAnimations];
}

- (void)show{
//    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    _contentView.center = kKeyWindow.center;
    [kKeyWindow  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

- (void)showFromTopOffset:(CGFloat)top{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    _contentView.center = CGPointMake(window.center.x, top + _contentView.frame.size.height/2);
    [kKeyWindow  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

- (void)showFromBottomOffset:(CGFloat)bottom{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    
//    bgview=[[UIView alloc]initWithFrame:window.bounds];
    bgview.backgroundColor =[UIColor clearColor];
    
    _contentView.center = CGPointMake(window.center.x, window.frame.size.height-(bottom + _contentView.frame.size.height/2));
//    [bgview  addSubview:_contentView];
    
    [kKeyWindow addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

#pragma mark-中间显示
+ (void)showCenterWithText:(NSString *)text{
    [AlertTool showCenterWithText:text duration:ToastDispalyDuration];
}

+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration{
    AlertTool *toast = [[AlertTool alloc] initWithText:text];
    [toast setDuration:duration];
    [toast show];
}
#pragma mark-上方显示
+ (void)showTopWithText:(NSString *)text{
    
    [AlertTool showTopWithText:text  topOffset:ToastSpace duration:ToastDispalyDuration];
}
+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration
{
    [AlertTool showTopWithText:text  topOffset:ToastSpace duration:duration];
}
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset{
    [AlertTool showTopWithText:text  topOffset:topOffset duration:ToastDispalyDuration];
}

+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration{
    AlertTool *toast = [[AlertTool alloc] initWithText:text];
    [toast setDuration:duration];
    [toast showFromTopOffset:topOffset];
}
#pragma mark-下方显示
+ (void)showBottomWithText:(NSString *)text{
    
    [AlertTool showBottomWithText:text  bottomOffset:ToastSpace duration:ToastDispalyDuration];
}
+ (void)showBottomWithText:(NSString *)text duration:(CGFloat)duration
{
    [AlertTool showBottomWithText:text  bottomOffset:ToastSpace duration:duration];
}
+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset{
    [AlertTool showBottomWithText:text  bottomOffset:bottomOffset duration:ToastDispalyDuration];
}

+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration{
    AlertTool *toast = [[AlertTool alloc] initWithText:text];
    [toast setDuration:duration];
    [toast showFromBottomOffset:bottomOffset];
}



- (void)initMBProgressHUD:(NSString *)str inView:(UIView *)view
{
    if (_progressHUD == nil) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:view];
        _progressHUD.frame = CGRectMake(view.frame.size.width/2 - 50, 100, 100, 100);
//        _progressHUD.label.font = [UIFont systemFontOfSize:14.0];
        _progressHUD.labelFont = [UIFont systemFontOfSize:14.0];
        _progressHUD.mode = MBProgressHUDModeText;
        _progressHUD.minSize = CGSizeMake(100, 50);
    }
    [view addSubview:_progressHUD];
//    _progressHUD.label.text = str;
    _progressHUD.labelText = str;
//    [_progressHUD showAnimated:YES];//开始显示
    [_progressHUD show:YES];
    [self performSelector:@selector(_progressHUDDisAppear) withObject:nil afterDelay:1.0];
}
- (void)_progressHUDDisAppear
{
//    [_progressHUD hideAnimated:YES];
    [_progressHUD hide:YES];
}



+ (void)amendDicValueIsNSString:(NSMutableDictionary *)dic
{
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop)
     {
         //不是NSString
         if (![value isKindOfClass:[NSString class]])
         {
             if ([value isKindOfClass:[NSArray class]])
             {
                 NSMutableArray *muArr = [NSMutableArray arrayWithArray:value];
                 [dic setValue:muArr forKey:key];
                 [self amendArrValueIsNSString:muArr];
             }
             else if ([value isKindOfClass:[NSDictionary class]])
             {
                 NSMutableDictionary *smallDic = [NSMutableDictionary dictionaryWithDictionary:value];
                 [dic setValue:smallDic forKey:key];
                 [self amendDicValueIsNSString:smallDic];
             }
             else if ([value isKindOfClass:[NSNumber class]])
             {
                 //NSNumber 转 NSString
                 [dic setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
             }
             else if ([value isKindOfClass:[NSNull class]])
             {
                 //NSNull 转 NSString
                 [dic setValue:@"" forKey:key];
             }
             else
             {
                 //不是string && 不是arr && 不是Null
                 NSLog(@"检测结果：%@的值无法修正,真实类型为：%@",key,[value class]);
             }
         }
     }];
}

+ (void)amendArrValueIsNSString:(NSMutableArray *)arr
{
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if (![obj isKindOfClass:[NSString class]])
         {
             //不是NSString
             if ([obj isKindOfClass:[NSArray class]])
             {
                 NSMutableArray *smallArr = [NSMutableArray arrayWithArray:obj];
                 [arr replaceObjectAtIndex:idx withObject:smallArr];
                 [self amendArrValueIsNSString:smallArr];
             }
             else if ([obj isKindOfClass:[NSDictionary class]])
             {
                 NSMutableDictionary *smallDic = [NSMutableDictionary dictionaryWithDictionary:obj];
                 [arr replaceObjectAtIndex:idx withObject:smallDic];
                 [self amendDicValueIsNSString:smallDic];
             }
             else if ([obj isKindOfClass:[NSNumber class]])
             {
                 //NSNumber 转 NSString
                 [arr replaceObjectAtIndex:idx withObject:[NSString stringWithFormat:@"%@",obj]];
             }
             else if ([obj isKindOfClass:[NSNull class]])
             {
                 //NSNull 转 NSString
                 [arr replaceObjectAtIndex:idx withObject:@""];
             }
             else
             {
                 //不是string && 不是arr && 不是dic && 不是Null
                 NSLog(@"检测结果：值%@无法修正,真实类型为：%@",obj,[obj class]);
             }
         }
     }];
}

/** 检测dic中类型是否为string*/
+ (void)checkDicValueIsNSString:(NSDictionary *)dic
{
    for (NSString *key in dic)
    {
        id value = dic[key];
        
        if (![value isKindOfClass:[NSString class]])
        {
            //不是NSString
            if ([value isKindOfClass:[NSArray class]])
            {
                [self checkArrValueIsNSString:value];
            }
            else if ([value isKindOfClass:[NSDictionary class]])
            {
                [self checkDicValueIsNSString:value];
            }
            else
            {
                //不是string && 不是arr && 不是dic
                NSLog(@"检测结果：%@的值不是NSString,真实类型为：%@",key,[value class]);
            }
        }
    }
}

/** 检测arr中类型是否为string*/
+ (void)checkArrValueIsNSString:(NSArray *)arr
{
    for (id obj in arr)
    {
        if (![obj isKindOfClass:[NSString class]])
        {
            //不是NSString
            if ([obj isKindOfClass:[NSArray class]])
            {
                [self checkArrValueIsNSString:obj];
            }
            else if ([obj isKindOfClass:[NSDictionary class]])
            {
                [self checkDicValueIsNSString:obj];
            }
            else
            {
                //不是string && 不是arr && 不是dic
                NSLog(@"检测结果：值%@不是NSString,真实类型为：%@",obj,[obj class]);
            }
        }
    }
}


+ (NSString *)flattenHTML:(NSString *)html {
    
    //  过滤html标签
    NSScanner *theScanner;
    NSString *text = @"p";
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //  过滤html中的\n\r\t换行空格等特殊符号
    NSMutableString *str1 = [NSMutableString stringWithString:html];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        
        //  要过滤的特殊符号
        if ( c == '\r' || c == '\n' || c == '\t' ) {
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    html  = [NSString stringWithString:str1];
    return html;
}
@end
