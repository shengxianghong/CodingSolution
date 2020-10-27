//
//  ChoosePersonController.m
//  ZhuBan
//
//  Created by zkworld on 2020/10/21.
//

#import "ChoosePersonController.h"
#import "ChooseSectionView.h"
#import "ChoosePersonCell.h"
#import "CPModel.h"
#import "MJExtension.h"

@interface ChoosePersonController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
@property (nonatomic, strong) NSMutableArray *listMuArray;

@property (nonatomic, copy) NSString *zhubanId;
@property (nonatomic, copy) NSString *zhubanName;

@end

@implementation ChoosePersonController
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = 70.0f;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.listMuArray = [CPModel mj_objectArrayWithKeyValuesArray:dict[@"items"]];
    [self.tableView reloadData];
}

- (IBAction)chooseAllAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    for (CPModel *cpList in self.listMuArray) {
        cpList.choose = sender.isSelected;
        for (CPItemModel *item in cpList.items) {
            item.choose = sender.isSelected;;
        }
    }
    [self.tableView reloadData];
}

- (void)displayAllButtonStatus {
    NSInteger chooseCount = 0;
    for (CPModel *cpList in self.listMuArray) {
        if (cpList.isChoose) {
            chooseCount++;
        }
    }
    self.chooseButton.selected = (self.listMuArray.count == chooseCount);
}

//完成
- (IBAction)complishChooseAction:(id)sender {
        
    NSMutableArray *muArray1 = [[NSMutableArray alloc] init];
    NSMutableArray *muArray2 = [[NSMutableArray alloc] init];
    for (CPModel *cpList in self.listMuArray) {
        for (CPItemModel *item in cpList.items) {
            if (item.isChoose) {
                [muArray1 addObject:item.rybh];
                [muArray2 addObject:item.yhry];
            }
        }
    }
    
    if (self.zhubanId.length == 0 || self.zhubanName.length == 0) {
        [self showAlertWithTitle:@"请选择主办人员"];
        return;
    }
    
    NSLog(@"%@==%@==主办ID:%@,主办Name:%@",[muArray1 componentsJoinedByString:@","],[muArray2 componentsJoinedByString:@","],self.zhubanId,self.zhubanName);
}

- (void)showAlertWithTitle:(NSString *)titleString {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titleString message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertController dismissViewControllerAnimated:YES completion:nil];
    });
}

#pragma mark - Table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listMuArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CPModel *model = self.listMuArray[section];
    return model.isZhankai ?  model.items.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChoosePersonCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    CPModel *list = self.listMuArray[indexPath.section];
    CPItemModel *model = list.items[indexPath.row];
    cell.titleLabel.text = model.yhry;
    cell.schoolLabel.text = model.bm;
    cell.codeLabel.text = [NSString stringWithFormat:@"(%@)",model.rybh];
    cell.zhubanButton.selected = model.isZhuban;
    cell.chooseButton.selected = model.isChoose;
    //主办
    cell.clickZhuBanBlock = ^(BOOL choose) {
        //清除所有的
        for (CPModel *cpList in self.listMuArray) {
            for (CPItemModel *item in cpList.items) {
                item.zhuban = NO;
            }
        }
        model.zhuban = choose;
        model.choose = model.isZhuban ? YES : model.isChoose;
        [self.tableView reloadData];
        
        if (model.isZhuban) {
            self.zhubanId = model.rybh;
            self.zhubanName = model.yhry;
        }else {
            self.zhubanId = @"";
            self.zhubanName = @"";
        }
    };
    //选择学生
    cell.clickPersonBlock = ^(BOOL choose) {
        model.choose = choose;
        NSInteger chooseCount = 0;
        for (CPItemModel *item in list.items) {
            if (item.isChoose) {
                chooseCount++;
            }
        }
        list.choose = (list.items.count == chooseCount);
        [self.tableView reloadData];
        [self displayAllButtonStatus];
    };
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ChooseSectionView *view = [[ChooseSectionView alloc] init];
    CPModel *model = self.listMuArray[section];
    view.titleLabel.text = model.mc;
    view.arrowButton.selected = model.isZhankai;
    view.chooseButton.selected = model.isChoose;
    view.arrowSentionBlock = ^(BOOL choose) {
        model.zhankai = choose;
        [self.tableView reloadData];
    };
    view.chooseGroupBlock = ^(BOOL choose) {
        for (CPItemModel *item in model.items) {
            item.choose = choose;
        }
        model.choose = choose;
        [self.tableView reloadData];
        [self displayAllButtonStatus];
    };
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
