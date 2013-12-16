//
//  OBExchangePreferencesWindowController.m
//  StalkCoin
//
//  Created by Thomas Gillis on 12/13/2013.
//  Copyright (c) 2013 Thomas Gillis. All rights reserved.
//

#import "OBExchangePreferencesWindowController.h"

@interface OBExchangePreferencesWindowController ()

@end

@implementation OBExchangePreferencesWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        window.delegate = self;
    }
    return self;
}

-(void)awakeFromNib {
    [self setCheckBoxes];
}

- (void)setCheckBoxes {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    btce_ltc.state = [prefs boolForKey:@"BTCE_LTC"];
    btce_btc.state = [prefs boolForKey:@"BTCE_BTC"];
    mtgox_btc.state = [prefs boolForKey:@"MTGOX_BTC"];
    cryptsy_btc.state = [prefs boolForKey:@"CRYPTSY_BTC"];
    cryptsy_ltc.state = [prefs boolForKey:@"CRYPTSY_LTC"];
    cryptsy_qrk.state = [prefs boolForKey:@"CRYPTSY_QRK"];
    bitfinex_btc.state = [prefs boolForKey:@"BITFINEX_BTC"];
    bitfinex_ltc.state = [prefs boolForKey:@"BITFINEX_LTC"];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)showExchangeWindow {
    self.window.delegate = self;
    [NSApp runModalForWindow:self.window];
}

- (void)windowWillClose:(NSNotification *)notification {
    [NSApp stopModal];
}

-(IBAction)onSave:(id)sender {
    NSLog(@"Save prefs");
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    [prefs setBool:[self intToBool:btce_btc.state] forKey:@"BTCE_BTC"];
    [prefs setBool:[self intToBool:btce_ltc.state] forKey:@"BTCE_LTC"];
    [prefs setBool:[self intToBool:mtgox_btc.state] forKey:@"MTGOX_BTC"];
    [prefs setBool:[self intToBool:cryptsy_btc.state] forKey:@"CRYPTSY_BTC"];
    [prefs setBool:[self intToBool:cryptsy_ltc.state] forKey:@"CRYPTSY_LTC"];
    [prefs setBool:[self intToBool:cryptsy_qrk.state] forKey:@"CRYPTSY_QRK"];
    [prefs setBool:[self intToBool:bitfinex_btc.state] forKey:@"BITFINEX_BTC"];
    [prefs setBool:[self intToBool:bitfinex_ltc.state] forKey:@"BITFINEX_LTC"];
}

-(bool)intToBool:(NSInteger)integer{
    BOOL b = NO;
    if(integer == 1){
        b= YES;
    }

    return b;
}


@end