//
//  HomePageVC.m
//  GeneralApp
//
//  Created by zkworld on 2020/12/31.
//

#import "HomePageVC.h"
#import "XHTableView.h"
#import "GoodsModel.h"
#import "TABAnimated.h"
#import "TableViewCell.h"

@interface HomePageVC ()
@property (weak, nonatomic) IBOutlet RefreshTableView *tableView;
@end

@implementation HomePageVC
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.rowHeight = 50.0f;
//    self.tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[TableViewCell class] cellHeight:50.0f];
//    self.tableView.tabAnimated.adjustBlock = ^(TABComponentManager * _Nonnull manager) {
//        //manager.animation(1).width(100);
//    };
//
//    [self.tableView tab_startAnimationWithCompletion:^{
//
//    }];

//    [self loadDisplayData];

    WS(weakSelf)
    self.tableView.refreshPageBlock = ^{
        [weakSelf loadDisplayData];
    };
}

#pragma mark - Table view dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableView.listMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    GoodsModel *model = self.tableView.listMuArray[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)loadDisplayData {
    [super loadDisplayData];
    NSString *urlString = [NSString stringWithFormat:@"list/search/v2?activity_filt=0&has_coupon=0&q=空&per_page=10&page=%d",self.tableView.correctPage];
    [[ApiManager shardInstance] requestWithRequsetType:0 url:urlString param:nil viewController:self hudType:0 resultBlock:^(NSDictionary * _Nonnull data, NSError * _Nullable error) {
        [self.tableView endRefersh];
        if (error) return;
        [self.tableView creatListDataArray:[GoodsModel mj_objectArrayWithKeyValuesArray:data[@"objects"]]];
        [self.tableView reloadData];
    }];
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
