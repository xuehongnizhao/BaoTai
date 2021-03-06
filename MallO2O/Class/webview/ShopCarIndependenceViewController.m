//
//  ShopCarIndependenceViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/26.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import "ShopCarIndependenceViewController.h"
#import "PushOrderViewController.h"
#import "LoginViewController.h"
#import "GoodsWebViewController.h"
#import "Base64.h"
#import "OrderGradingViewController.h"
#import <Base64nl/Base64.h>

@interface ShopCarIndependenceViewController ()<UIWebViewDelegate>

@property (strong ,nonatomic) UIView *statusView;

@property (strong ,nonatomic) UIWebView *webView;

@end

@implementation ShopCarIndependenceViewController

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self initUI];
    
    //    [SVProgressHUD showWithStatus:@"正在加载中" maskType:SVProgressHUDMaskTypeBlack];
}

/**
 *  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  将要加载出视图 调用
 *
 *  @param animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    NSString *str = GetUserDefault(U_ID);
    NSString *str = [PersonInfoModel shareInstance].uID;
    if ([str isKindOfClass:[NSNull class]] || str == nil) {
        str = @"0";
    }
    NSURL *url            = [NSURL URLWithString:[[NSString stringWithFormat:@"http://%@/action/ac_order/shopping_cart_change", baseUrl] stringByAppendingFormat:@"?u_id=%@",str]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [self getDataFromUrl];
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    
}

#pragma mark - 设置UI控件
/**
 *  初始化UI控件
 */
- (void) initUI {
    
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"shoppingCartNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.webView];
    [self.view addSubview:self.statusView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
    
    [_statusView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_statusView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_statusView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_statusView autoSetDimension:ALDimensionHeight toSize:20];
    _statusView.backgroundColor = UIColorFromRGB(DefaultColor);
}

/**
 控件的懒加载
 */
- (UIView *)statusView{
    if (!_statusView) {
        _statusView = [[UIView alloc] initForAutoLayout];
    }
    return _statusView;
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initForAutoLayout];
        _webView.delegate = self;
        _webView.scrollView.bounces = NO;
    }
    return _webView;
}

/**
 webview委托 用于与web页交互
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *url = [request URL];
    
    NSLog(@"%@",url);
    
    if ([[url scheme] isEqualToString:@"gopay"]) {
        if ([GetUserDefault(IsLogin) boolValue]) {
            PushOrderViewController *viewController = [[PushOrderViewController alloc] init];
            NSString *str = [NSString stringWithFormat:@"%@",url];
            str = [str substringFromIndex:8];
            NSLog(@"%@",str);
            NSArray *array = [str componentsSeparatedByString:@"-"];
            viewController.shopCarArray = array;
            NSLog(@"%@",array);
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
    if ([[url scheme] isEqualToString:@"goback"]) {
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    if ([[url scheme] isEqualToString:@"login"]) {
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [viewController setBackButton];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[url scheme] isEqualToString:@"orderdetail"]) {
        NSString *str = [NSString stringWithFormat:@"%@",url];
        str = [str substringFromIndex:14];
        NSArray *array = [str componentsSeparatedByString:@"-"];
        GoodsWebViewController *viewController = [[GoodsWebViewController alloc] init];
        viewController.shopName = NSLocalizedString(@"productDetailsNavigationTitle", nil);
//        NSString *subStr = [Base64 decodeBase64String:array[0]];
        NSString *subStr = array[0];
        subStr = [subStr base64DecodedString];
        NSLog(@"%@",array[1]);
        viewController.webTitle = NSLocalizedString(@"productDetailsNavigationTitle", nil);
        NSString *subUrl = [array[1] substringFromIndex:4];
        if (IOS9) {
            viewController.webViewUrl = [@"http" stringByAppendingString:subUrl];
        }else{
            viewController.webViewUrl = [@"http:" stringByAppendingString:subUrl];
        }
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    return YES;
}

- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"my_address"];//connect_url(@"my_address");
    NSDictionary *dic = @{
                          @"app_key" : url,
//                          @"u_id"    : GetUserDefault(U_ID),
                          @"u_id"    : [PersonInfoModel shareInstance].uID
                          //                          @"page"    : [NSString stringWithFormat:@"%d",page]
                          };
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        
        NSMutableArray *array = (NSMutableArray *)resultObject[@"obj"];
        for (int i = 0; i < array.count; i++) {
            if ([[array[i] objectForKey:@"type"] integerValue] == 1) {
                SetUserDefault(array[i], Address);
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }
        }
        if ([(NSArray *)resultObject[@"obj"] count] == 0) {
            SetUserDefault(nil, Address);
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

@end
