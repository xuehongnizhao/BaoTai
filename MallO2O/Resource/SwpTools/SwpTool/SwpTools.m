//
//  SwpTools.m
//  Swp_song
//
//  Created by songweiping on 15/12/28.
//  Copyright © 2015年 songweiping. All rights reserved.
//

#import "SwpTools.h"

@class AppDelegate;

static NSString * const defaultPlistName = @"mainInterfaceData.plist";

@implementation SwpTools


#pragma mark - Get System Version & App Version Methods

/*!
 *  @author swp_song, 2015-12-28 14:43:54
 *
 *  @brief  swpToolCheckSystemVersion   ( 判断应用运行在什么系统版本上 )
 *
 *  @return 返回系统版本 ：7.0     6.0     6.1等
 *
 *  @since  1.0.4
 */
+ (CGFloat)swpToolCheckSystemVersion {
    static dispatch_once_t onceToken;
    __block float systemVersion = 0;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    return systemVersion;
}


/*!
 *  @author swp_song, 2015-12-28 14:44:47
 *
 *  @brief  swpToolCheckAppVersion      ( 判断应用的版本号 )
 *
 *  @return 返回版本号
 *
 *  @since  1.0.4
 */
+ (NSString *)swpToolCheckAppVersion {
    static dispatch_once_t onceToken;
    __block NSString *APPVersion = 0;
    dispatch_once(&onceToken, ^{
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        APPVersion             = [infoDict objectForKey:@"CFBundleVersion"];
    });
    return APPVersion;
}



#pragma mark - Hiddle TableView Excessed Cell & Setting TableView Cell Separate Wire - Methods
/*!
 *  @author swp_song, 2015-12-28 14:49:54
 *
 *  @brief  swpToolHiddleExcessedCellFromTableview  ( 隐藏 Tableivew 中多余的 Cell )
 *
 *  @param  tableview
 *
 *  @since  1.0.4
 */
+ (void)swpToolHiddleExcessedCellFromTableview:(UITableView *)tableview {
    UIView *view         = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [tableview setTableFooterView:view];
}

/*!
 *  @author swp_song, 2015-12-28 14:51:10
 *
 *  @brief  swpToolSettingTableViewAllCellWire  ( 设置 Cell 的分割线 )
 *
 *  @param  tableView
 *
 *  @param  cell
 *
 *  @since  1.0.4
 */
+ (void)swpToolSettingTableViewAllCellWire:(UITableView *)tableView andTableViewCell:(UITableViewCell *)cell {
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset :UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins  :UIEdgeInsetsZero];
    }
}


#pragma mark - WebView Load Servers URL Method
/*!
 *  @author swp_song, 2015-12-28 14:52:02
 *
 *  @brief  swpToolWebViewLoadServersURL    ( WebView 加载 服务器端 URL )
 *
 *  @param  webView
 *
 *  @param  URLstring
 *
 *  @since  1.0.4
 */
+ (void)swpToolWebViewLoadServersURL:(UIWebView *)webView serversURLString:(NSString *)URLstring {
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLstring]]];
}

/*!
 *  @author swp_song, 2016-01-31 15:20:45
 *
 *  @brief  swpToolWKWebViewLoadServersURL  ( WKWebView 加载 服务器端 URL )
 *
 *  @param  wkWebView
 *
 *  @param  URLstring
 *
 *  @since  1.0.4
 */
+ (void)swpToolWKWebViewLoadServersURL:(WKWebView *)wkWebView serversURLString:(NSString *)URLstring {
    [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLstring]]];
}

#pragma mark - Call Phone & Message - Methods
/*!
 *  @author swp_song, 2015-12-28 14:53:54
 *
 *  @brief  swpToolCallPhone    ( 拨打 电话 )
 *
 *  @param  phoneNumber         ( 电话 号码 )
 *
 *  @param  view                ( 当前 控制 view )
 *
 *  @since  1.0.4
 */
+ (void)swpToolCallPhone:(NSString *)phoneNumber superView:(UIView *)view {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSURL     *url     = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [view addSubview:webView];
}


/*!
 *  @author swp_song, 2015-12-28 14:55:16
 *
 *  @brief  swpToolSendMessage  ( 快速跳转到 发送 信息页面 <只能给固定人发送信息, 不能编辑信息内容> )
 *
 *  @param  phoneNumber
 *
 *  @since  1.0.4
 */
+ (void)swpToolSendMessage:(NSString *)phoneNumber {
    NSString *sms = [NSString stringWithFormat:@"sms://%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sms]];
}


#pragma mark - Trim String Front And Back Blanker Methods
/*!
 *  @author swp_song, 2015-12-28 14:55:56
 *
 *  @brief  swpToolTrimString   ( 去除 字符串 前后 空格 )
 *
 *  @param  string
 *
 *  @return string
 *
 *  @since  1.0.4
 */
+ (NSString *)swpToolTrimString:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


#pragma mark - Setting Button Timer Method
/*!
 *  @author swp_song, 2015-12-28 14:59:11
 *
 *  @brief  在 button 设置倒计时 计时器
 *
 *  @param  button
 *
 *  @param  time
 *
 *  @since  1.0.4
 */
+ (void)swpToolSettingButtonTimer:(UIButton *)button andTime:(int)time {
    
    __block int timeout         = time;
    dispatch_queue_t queue      = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer    = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [button setTitle:@"获取验证码" forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [button setTitle:[NSString stringWithFormat:@"%@秒后重发", strTime] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - Jump ViewController Method
/*!
 *  @author swp_song, 2015-12-28 15:13:09
 *
 *  @brief  swpToolJumpContrillerWith   ( Jump ViewController <跳转控制器 根据字符串实例化 控制器> )
 *
 *  @param  navigationController
 *
 *  @param  controllerClass
 *
 *  @since  1.0.4
 */
+ (void)swpToolJumpContrillerWith:(UINavigationController *)navigationController push:(NSString *)controllerClass {
    [navigationController pushViewController:[[[NSClassFromString(controllerClass) class] alloc] init] animated:YES];
}

#pragma mark - Check Page Method
/*!
 *  @author swp_song, 2015-12-28 15:14:11
 *
 *  @brief  swpToolChekPageWithDataSource   ( Check page )
 *
 *  @param  dataSource
 *
 *  @param  page
 *
 *  @param  firstPage
 *
 *  @return NSMutableArray
 *
 *  @since  1.0.4
 */
+ (NSMutableArray *)swpToolChekPageWithDataSource:(NSMutableArray *)dataSource page:(NSInteger)page firstPage:(NSInteger)firstPage {
    
    NSMutableArray *array = [NSMutableArray array];
    if (page != firstPage) {
        array = dataSource;
    }
    return array;
}

/*!
 *  @author swp_song, 2015-12-28 15:15:26
 *
 *  @brief  swpToolSettingLabelProperty ( Setting Lable Property )
 *
 *  @param  label
 *
 *  @param  isShow
 *
 *  @param  fontSize
 *
 *  @param  fontColor
 *
 *  @since  1.0.4
 */
+ (void)swpToolSettingLabelProperty:(UILabel *)label showBorderWidth:(BOOL)isShow fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor {
    
    if (isShow) {
        label.layer.borderWidth = 1;
    }
    label.font              = [UIFont systemFontOfSize:fontSize];
    label.textColor         = fontColor;
}

#pragma mark - Setting View UITapGestureRecognizer Method
/*!
 *  @author swp_song, 2015-12-28 15:18:35
 *
 *  @brief  swpToolSettingTapGestureRecognizer  ( Setting View UITapGestureRecognizer <绑定 一个 点击事件 给一个 view> )
 *
 *  @param view
 *
 *  @param tag
 *
 *  @param count
 *
 *  @param target
 *
 *  @param action
 *
 *  @param cancels
 *
 *  @return
 *
 *  @since  1.0.4
 */
+ (UITapGestureRecognizer *)swpToolSettingTapGestureRecognizer:(UIView *)view viewTag:(NSInteger)tag clickCount:(NSInteger)count addTarget:(id)target action:(SEL)action cancelsTouchesInView:(BOOL)cancels {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired    = count;
    tap.cancelsTouchesInView    = cancels;
    view.tag                    = tag;
    [tap addTarget:target action:action];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:tap];
    return tap;
}

#pragma mark - Time Dispose Method
/*!
 *  @author swp_song, 2015-12-28 15:20:33
 *
 *  @brief  swpToolGetSystemDateWithFormat  ( Time Dispose <按照 指定 格式 时间 转换成字符串> )
 *
 *  @param  format
 *
 *  @return NSString
 *
 *  @since  1.0.4
 */
+ (NSString *)swpToolGetSystemDateWithFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *time                 = [dateFormatter stringFromDate:[NSDate date]];
    return time;
}


#pragma - mark Delete Sandbox File Method
/*!
 *  @author swp_song, 2015-12-28 15:21:27
 *
 *  @brief  swpToolDeleteFileWithFileName   ( Delete Sandbox File )
 *
 *  @param  fileName
 *
 *  @return BOOL
 *
 *  @since  1.0.4
 */
+ (BOOL)swpToolDeleteFileWithFileName:(NSString *)fileName {
    
    // File Manager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // if file exist !
    BOOL          fileBeing    = [[NSFileManager defaultManager] fileExistsAtPath:fileName];
    
    if (!fileBeing) {
        NSLog(@"file not exist !");
        return NO;
    } else {
        NSLog(@"file exist !");
        
        if ([fileManager removeItemAtPath:fileName error:nil]) {
            NSLog(@"Delete File Success !");
            return YES;
        } else {
            NSLog(@"Delete File Error !");
            return NO;
        }
    }
}

#pragma mark - Image Compress Methods
/*!
 *  @author swp_song, 2015-12-08 11:13:51
 *
 *  @brief  swpToolCompressImage    ( Image Compress Methods <图片 压缩> )
 *
 *  @param  image
 *
 *  @param  size
 *
 *  @return UIImage
 *
 *  @since  1.0.4
 */
+ (UIImage *)swpToolCompressImage:(UIImage *)image scaleToSize:(CGSize)size {
    
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGFloat     compression     = 0.5f;
    CGFloat     maxCompression  = 0.1f;
    NSUInteger  maxLength       = 1024 * 200;
    
    NSData     *imageData       = UIImageJPEGRepresentation(scaledImage, compression);
    while (imageData.length > maxLength && compression > maxCompression) {
        compression -= 0.1;
        imageData   =  UIImageJPEGRepresentation(scaledImage, compression);
    };
    
    return [UIImage imageWithData:imageData];
}

#pragma mark - Data Save Plist & Get Plist Data - Methods
/*!
 *  @author swp_song, 2015-12-28 15:23:57
 *
 *  @brief  swpToolDataWriteToPlist  ( 将 数据写入 plist 文件中 )
 *
 *  @param  writeData                写入数据
 *
 *  @param  plistName                plist 文件名称
 *
 *  @return BOOL                     写入 成功 返回 YES 写入失败 返回 NO
 *
 *  @since  1.0.4
 */
+ (BOOL)swpToolDataWriteToPlist:(NSDictionary*)writeData plistName:(nullable NSString *)plistName {

    // 建立文件管理
    NSFileManager *fm        = [NSFileManager defaultManager];

    // 找到Documents文件所在的路径
    NSArray       *path      = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"path=%@",path);

    // 取得第一个Documents文件夹的路径
    NSString      *filePath = [path objectAtIndex:0];
    
    // 默认路径
    plistName               = plistName == nil ? defaultPlistName : plistName;
   
    // 把TestPlist文件加入
    NSString      *plistPath = [filePath stringByAppendingPathComponent:plistName];
    
    if ([fm fileExistsAtPath:plistPath]) {
        NSLog(@"文件已存在,开始删除源文件");
        //修改文件内容
        if ([fm removeItemAtPath:plistPath error:nil]) {
            NSLog(@"文件删除成功");
            //开始创建文件
            if ([fm createFileAtPath:plistPath contents:nil attributes:nil]) {
                NSLog(@"文件创建成功,开始写入数据");
                if ([writeData writeToFile:plistPath atomically:YES]) {
                    return YES;
                }
            } else {
                NSLog(@"文件创建失败");
                return NO;
            }
        } else {
            NSLog(@"文件删除失败");
            return NO;
        }
        
    } else {
        //开始创建文件
        if ([fm createFileAtPath:plistPath contents:nil attributes:nil]) {
            NSLog(@"文件创建成功,开始写入数据");
            if ([writeData writeToFile:plistPath atomically:YES]) {
                return YES;
            }
        } else {
            NSLog(@"文件创建失败,尝试重新获取接口数据");
            return NO;
        }
    }
    return NO;
}

/*!
 *  @author swp_song, 2015-12-28 15:24:29
 *
 *  @brief  swpToolGetDictionaryFromPlist   ( 取出 plist 文件中数据 返回一个字典 )
 *
 *  @param  plistName                       plist 文件名称
 *
 *  @return NSDictionary                    返回 取出的数据 字典
 *
 *  @since  1.0.4
 */
+ (NSDictionary *)swpToolGetDictionaryFromPlist:(nullable NSString *)plistName {
    // 默认路径
    plistName                = plistName == nil ? defaultPlistName : plistName;
    //建立文件管理
    NSFileManager *fm        = [NSFileManager defaultManager];
    //找到Documents文件所在的路径
    NSArray       *path      = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    //取得第一个Documents文件夹的路径
//    NSString      *filePath  = [path objectAtIndex:0];
    NSString      *filePath  = [path firstObject];

    //把TestPlist文件加入
    NSString      *plistPath = [filePath stringByAppendingPathComponent:plistName];
    
    if ([fm fileExistsAtPath:plistPath]) {
        NSLog(@"plist文件已找到,返回各个文件接口");
        return [NSDictionary dictionaryWithContentsOfFile:plistPath];
    } else {
        NSLog(@"plist文件未找到");
        return nil;
    }
}

/*!
 *  @author swp_song, 2015-12-28 15:25:17
 *
 *  @brief  swpToolGetInterfaceURL  ( 取出 主接口 接口 URL )
 *
 *  @param  key                     ( url key )
 *
 *  @return NSString                ( url )
 *
 *  @since  1.0.4
 */
+ (NSString *)swpToolGetInterfaceURL:(nullable NSString *)key {
    NSString *interfaceURL = [[[[SwpTools swpToolGetDictionaryFromPlist:nil] objectForKey:@"obj"] objectForKey:@"api"] objectForKey:key];
    interfaceURL           = interfaceURL == nil ? @"" : interfaceURL;
    return interfaceURL;
}

#pragma mark - About Screen Size Tools Methods
/*!
 *  @author swp_song, 2015-12-28 16:07:24
 *
 *  @brief  swpToolScreenWidth      ( 取出 设备 实际的宽度值 )
 *
 *  @return CGFloat
 *
 *  @since  1.0.4
 */
+ (CGFloat)swpToolScreenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

/*!
 *  @author swp_song, 2015-12-28 16:10:21
 *
 *  @brief  swpToolScreenHeight     ( 取出 设备 实际的高度值 )
 *
 *  @return CGFloat
 *
 *  @since  1.0.4
 */
+ (CGFloat)swpToolScreenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

/*!
 *  @author swp_song, 2015-12-28 16:16:23
 *
 *  @brief  swpToolScreenSize   ( 取出 设备 实际的宽高 )
 *
 *  @return CGSize
 *
 *  @since  1.0.4
 */
+ (CGSize)swpToolScreenSize {
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
}

/*!
 *  @author swp_song, 2015-12-28 16:33:13
 *
 *  @brief  swpToolScreenScale  ( 计算 宽高比 )
 *
 *  @param  screenWidth         ( 固定 宽度 或 高度 )
 *
 *  @param  scaleWidth          比例值  (2:1 <2为该参数> )
 *
 *  @param  scaleHeight         比例值  (2:1 <1为该参数> )
 *
 *  @return CGFloat             计算反比的数值
 *
 *  @since  1.0.4
 */
+ (CGFloat)swpToolScreenScale:(CGFloat)screenWidth scaleWidth:(CGFloat)scaleWidth scaleHeight:(CGFloat)scaleHeight {
    return screenWidth / scaleWidth * scaleHeight;
}

/*!
 *  @author swp_song, 2015-12-31 09:21:17
 *
 *  @brief  swpToolIphone4sScreenSize  ( 获取 4 / 4s 屏幕尺寸 )
 *
 *  @return CGSize
 *
 *  @since  1.0.4
 */
+ (CGSize)swpToolIphone4sScreenSize {
    return CGSizeMake(320, 480);
}

/*!
 *  @author swp_song, 2015-12-31 09:23:37
 *
 *  @brief  swpToolIphone5sScreenSize  ( 获取 5 / 5s 屏幕尺寸 )
 *
 *  @return CGSize
 *
 *  @since  1.0.4
 */
+ (CGSize)swpToolIphone5sScreenSize {
    return CGSizeMake(320, 568);
}


/*!
 *  @author swp_song, 2015-12-31 09:27:35
 *
 *  @brief  swpToolIphone6sScreenSize  ( 获取 6 / 6s 屏幕尺寸 )
 *
 *  @return CGSize
 *
 *  @since  1.0.4
 */
+ (CGSize)swpToolIphone6sScreenSize {
    return CGSizeMake(375, 667);
}

/*!
 *  @author swp_song, 2015-12-31 09:30:56
 *
 *  @brief  swpToolIphone6pScreenSize  ( 获取 6p / 6ps 屏幕尺寸 )
 *
 *  @return CGSize
 *
 *  @since  1.0.4
 */
+ (CGSize)swpToolIphone6pScreenSize {
    return CGSizeMake(414, 736);
}

#pragma mark - Get Application Delegate Method
/*!
 *  @author swp_song, 2016-01-12 11:55:22
 *
 *  @brief  swpToolApplicationDelegate ( 获取工 AppDelegat 代理 )
 *
 *  @return AppDelegate
 *
 *  @since  1.0.4
 */
+ (AppDelegate *)swpToolApplicationDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - Check Existence Controller
/*!
 *  @author swp_song, 2016-01-12 11:58:42
 *
 *  @brief  swpToolCheckNavigationControllerExistenceController ( 验证 导航控制器 中 是否存在 指定 控制器 )
 *
 *  @param  navigationController
 *
 *  @param  checkController
 *
 *  @param  checkResult
 *
 *  @since  1.0.4
 */
+ (void)swpToolCheckNavigationControllerExistenceController:(UINavigationController *)navigationController checkController:(Class) checkController checkResult:(void(^)(id obj, UINavigationController *navigationController, BOOL * _Nonnull stop))checkResult {
    [navigationController.viewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[checkController class]]) {
            *stop = YES;
            checkResult(obj, navigationController, stop);
        }
    }];
}



#pragma mark - Order Error & Order Test - Method
/*!
 *  设置导航控制器 搜索条
 *
 *  @param  searchBarWidth searchBar 宽度
 *  @param  searchBarColor searchBar 背景颜色
 *  @param  tag            searchBar tag
 *  @param  imageX         searchBar 图片的X的值
 *  @param  image          searchBar 显示的图片
 *  @param  titleWidth     searchBar 文字的宽度
 *  @param  fontSize       searchBar 文字的大小
 *  @param  fontColor      searchBar 文字的颜色
 *  @param  title          searchBar 显示的文字
 *
 *  @return UIView
 */
+ (UIView *) settingNavSearchBarWidth:(CGFloat)searchBarWidth backgroundColor:(UIColor *)searchBarColor searchBarTag:(NSInteger)tag searchImageX:(CGFloat)imageX searchImage:(NSString *)image  searchTitleWidth:(CGFloat)titleWidth searchTitleFontSize:(CGFloat)fontSize searchTitleFontColor:(UIColor *)fontColor searchTitle:(NSString *)title  {
    
    
    UIView  *searchBar              = [[UIView alloc] init];
    searchBar.frame                 = CGRectMake(0, 0, searchBarWidth, 30);
    searchBar.backgroundColor       = searchBarColor;
    searchBar.tag                   = tag;
    searchBar.layer.cornerRadius    = 5.0;
    searchBar.layer.masksToBounds   = YES;
    
    UIImageView *searchImageView    = [[UIImageView alloc] init];
    CGFloat searchImageViewX        = imageX;
    CGFloat searchImageViewW        = searchBar.frame.size.height;
    CGFloat searchImageViewH        = searchBar.frame.size.height;
    searchImageView.frame           = CGRectMake(searchImageViewX, 0, searchImageViewW, searchImageViewH);
    searchImageView.image              = [UIImage imageNamed:image];
    searchImageView.layer.borderColor  = [UIColor redColor].CGColor;
    //    searchImageView.layer.borderWidth  = 1;
    //    searchImageView.contentMode        = UIViewContentModeCenter;
    [searchBar addSubview:searchImageView];
    
    
    UILabel *searchTitleView        = [[UILabel alloc] init];
    CGFloat searchTitleViewX        = CGRectGetMaxX(searchImageView.frame) + 3;
    CGFloat searchTitleViewW        = titleWidth;
    CGFloat searchTitleViewH        = searchImageViewH;
    searchTitleView.frame           = CGRectMake(searchTitleViewX, 0, searchTitleViewW, searchTitleViewH);
    searchTitleView.backgroundColor = [UIColor clearColor];
    searchTitleView.text            = title;
    searchTitleView.font            = [UIFont systemFontOfSize:fontSize];
    searchTitleView.textColor       = fontColor;
    [searchBar addSubview:searchTitleView];
    
    return searchBar;
}

+ (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize {
    
    // Create a graphics image context
    
    UIGraphicsBeginImageContext (newSize);
    
    // Tell the old image to draw in this new context, with the desired
    
    // new size
    
    [image drawInRect : CGRectMake (0 , 0, newSize.width, newSize.height)];
    // Get the new image from the context
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext ();
    // End the context
    
    UIGraphicsEndImageContext ();
    
    // Return the new image.
    return newImage;
    
}

//    NSDictionary *dict1 = @{
//                            @"aaa" : @"111",
//                            @"bbb" : @"222",
//                            };
//    //
//    NSData      *jsonData1 = [NSJSONSerialization dataWithJSONObject:dict1 options:NSJSONWritingPrettyPrinted error:nil];
//    NSString    *json1     =  [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", json1);


@end
