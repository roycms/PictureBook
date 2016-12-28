//
//  IndexNetwork.h
//  PictureBook
//
//  Created by roycms on 2016/12/28.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//

#import "Header.h"
#import <Realm/Realm.h>
@interface IndexNetwork : NetworkManager

/**
 <#Description#>

 @param callBack <#callBack description#>
 */
- (void)loadBook:(callBack)callBack;
@end
