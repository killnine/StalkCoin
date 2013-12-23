/*
 * StalkCoin v 0.2
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42+1):
 * <bardic.knowledge@gmail.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return or contribute to my beer fund
 * via Bitcoin and/or Litecoin:
 *
 * Bitcoin: 1GWGoT9r6wAgdERT7QogehPvaaUUEohcEQ
 * Litecoin: LVFwvucM5mTdFKxfgfQbMEqaC7rE3tncEM
 * ----------------------------------------------------------------------------
 */

#import <AFNetworking/AFHTTPRequestOperation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "OBCryptsyService.h"
#import "OBDefines.h"
#import "OBCoinVO.h"


@implementation OBCryptsyService {
    NSMutableDictionary *endPointDict;
}

- (id)init {
    self = [super init];
    if (self) {
        endPointDict = [NSMutableDictionary new];
        [endPointDict setObject:@"http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=3" forKey:LTC];
        [endPointDict setObject:@"http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=71" forKey:QRK]; //This is really QRK. Jsut testing crap
    }

    return self;
}

-(void)getPriceForCoin:(OBCoinVO *)coin{
    //TODO: Stuff into model
    [self requestCoinForIndex:coin];
}

-(void)requestCoinForIndex:(OBCoinVO *)coin{
    //TODO Change all this to use AFNetworking
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[endPointDict objectForKey:coin.coinName] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id ticker = [responseObject objectForKey:@"return"];
        id price = [ticker objectForKey:@"markets"];
        id price1 = [price objectForKey:coin.coinName];
        id price2 = [price1 objectForKey:@"lasttradeprice"];
        coin.coinValue = [NSString stringWithFormat:@"%@",price2];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end