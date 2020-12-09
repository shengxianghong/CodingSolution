//
//  MenuController.m
//  UIMenuVC
//
//  Created by zkworld on 2020/11/19.
//

#import "MenuController.h"

@interface MenuController ()

@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)menuAction:(UIButton *)sender {
    [sender becomeFirstResponder];
    // 创建菜单
    UIMenuController *menu = [UIMenuController sharedMenuController];
    // 设置菜单内容，自定义菜单项
    menu.menuItems = @[
    [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)],
    [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)],
    [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(warn:)]
    ];
    // 设置菜单箭头的方向
    menu.arrowDirection = UIMenuControllerArrowDown;
    // 菜单最终显示的位置
    [menu setTargetRect:sender.bounds inView:sender];
    // 显示菜单
    [menu setMenuVisible:YES animated:YES];
}

// 不设置这个方法,会导致无法调出menu菜单

- (BOOL)canBecomeFirstResponder {
    return true;
}

// 通过第一响应者的这个方法告诉 UIMenuController 可以显示什么内容，UIResponder 方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {

    if (action == @selector(ding:)                          ||  // 自定义菜单项
    action == @selector(reply:)                         ||
    action == @selector(warn:))
    {
        return YES;
    }
    return NO;
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
