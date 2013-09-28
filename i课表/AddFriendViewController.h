//
//  AddFriendViewController.h
//  CurriSchedule
//
//  Created by Donne on 5/27/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriendViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@end
