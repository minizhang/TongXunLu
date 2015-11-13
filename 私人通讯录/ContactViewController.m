//
//  ContactViewController.m
//  私人通讯录
//
//  Created by 张恒 on 15/10/14.
//  Copyright © 2015年 zhangheng. All rights reserved.
//

#import "ContactViewController.h"
#import "AddViewController.h"
#import "ZHContact.h"
#import "EditViewController.h"

@interface ContactViewController ()<UIActionSheetDelegate, AddViewDelegate, EditViewControllerDelegate>
- (IBAction)logout:(UIBarButtonItem *)sender;

@property (nonatomic, strong) NSMutableArray * contacts;

@end

@implementation ContactViewController

//懒加载
- (NSMutableArray *)contacts{
    if (!_contacts) {
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (IBAction)logout:(UIBarButtonItem *)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定要注销？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil];
    [sheet showInView:self.view];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UIViewController * vc = segue.destinationViewController;
    
    if ([vc isKindOfClass:[AddViewController class]]) {
        AddViewController * addvc = (AddViewController *)vc;
        addvc.delegate = self;
    }else if([vc isKindOfClass:[EditViewController class]]){
        EditViewController * editvc = (EditViewController *)vc;
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        ZHContact * contact = self.contacts[path.row];
        editvc.contact = contact;
        editvc.delegate = self;
    }
    
}

#pragma mark - EditViewControllerDelegate

- (void)editViewControllerDidClickSaveBtn:(EditViewController *)editViewController andContact:(ZHContact *)contact{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    self.contacts[path.row] = contact;
    
    [self.tableView reloadData];
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 8_3){
    if(0 == buttonIndex){
        [self.navigationController popViewControllerAnimated:YES];
    }
        
}



#pragma mark - AddViewController

- (void)AddViewControllerDidAddBtn:(AddViewController *)addViewController andContact:(ZHContact *)contact{
    [self.contacts addObject:contact];
    
    [self.tableView reloadData];
//    NSLog(@"%@ %@", contact.name, contact.phoneNumber);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier =@"contact";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.textLabel.text = [self.contacts[indexPath.row] name];
    cell.detailTextLabel.text = [self.contacts[indexPath.row] phoneNumber];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}




















@end
