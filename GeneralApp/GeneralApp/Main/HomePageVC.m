//
//  HomePageVC.m
//  GeneralApp
//
//  Created by zkworld on 2020/12/31.
//

#import "HomePageVC.h"

@interface HomePageVC ()
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[ApiManager shardInstance] requestWithRequsetType:0 url:@"" param:nil view:nil hudType:0 resultBlock:^(NSDictionary * _Nonnull data, NSError * _Nullable error) {
//        if (error) {
//            self.msgLabel.text = data[@"message"];
//            return;
//        }
//        self.msgLabel.text = @"success";
//    }];
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
