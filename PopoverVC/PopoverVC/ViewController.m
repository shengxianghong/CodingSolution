//
//  ViewController.m
//  PopoverVC
//
//  Created by s&z on 2020/11/22.
//

#import "ViewController.h"
#import "MenuVC.h"

@interface ViewController ()<UIPopoverPresentationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)popupAction:(id)sender {
    MenuVC *dvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MenuVC"];
    dvc.dismissBlock = ^{
        NSLog(@"222222");
    };
    // 设置弹出视图控制器大小
    dvc.preferredContentSize = CGSizeMake(200, 150);
    // 使用 popover 样式显示视图控制器
    dvc.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *presentationController =
    [dvc popoverPresentationController];
    presentationController.delegate = self;
    presentationController.sourceView = self.submitButton;
    presentationController.sourceRect = self.submitButton.bounds;
    presentationController.permittedArrowDirections =
    UIPopoverArrowDirectionUnknown ;
    
    // 以模态形式呈现视图
    [self presentViewController:dvc animated:YES completion:nil];

}

#pragma mark - UIPopoverPresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
  return UIModalPresentationNone;
}


@end
