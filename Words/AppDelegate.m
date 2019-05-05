//
//  AppDelegate.m
//  Words
//
//  Created by whq on 2019/4/30.
//  Copyright © 2019 whq. All rights reserved.
//

#import "AppDelegate.h"
#import "PopViewController.h"

@interface AppDelegate (){
    NSStatusItem* statusBarItem;
//    NSMenu *statusMenu;
    NSPopover *statusPop;
    id eventMonitor;
    __weak IBOutlet NSMenu *commonMenu;
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [NSApp setMainMenu:commonMenu];
    
    statusBarItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    NSImage *img = [NSImage imageNamed:@"StatusBarButtonImage"];
    //    img.template = true;
    [statusBarItem.button setImage:img];
//    statusBarItem.button.menu = statusMenu;
    [statusBarItem.button setAction:@selector(statusClicked:)];
    
//    statusMenu = [[NSMenu alloc] init];
//    [statusMenu addItemWithTitle:@"note" action:@selector(noteClicked) keyEquivalent:@"P"];
//    [statusMenu addItem:[NSMenuItem separatorItem]];
//    [statusMenu addItemWithTitle:@"exit" action:@selector(quit) keyEquivalent:@"Q"];
//    statusBarItem.menu = statusMenu;
    
    //popup
    statusPop = [[NSPopover alloc] init];
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    NSViewController *vc = [storyboard instantiateControllerWithIdentifier:@"PopViewController"];
    statusPop.contentViewController = vc;
    
    //globle event handle
    [self monitorStart];
    
}

- (void)statusClicked:(id)sender{
    NSLog(@"statusClicked");

    if (statusPop.isShown) {
        [self monitorStop];
        [statusPop performClose:sender];
        
    }
    else{
        [self monitorStart];
        [statusPop showRelativeToRect:statusBarItem.button.bounds ofView:statusBarItem.button preferredEdge:NSRectEdgeMinY];
       
    }
}

- (void)quit{
     [[NSApplication sharedApplication] terminate:self];
}

- (void)noteClicked{
    NSLog(@"noteClicked");
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [self monitorStop];
}

#pragma mark - monitor

- (void)monitorStart{
    [self monitorStop];
    
    eventMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskLeftMouseDown | NSEventMaskRightMouseDown handler:^(NSEvent * event) {
        if (self->statusPop.isShown) {
            [self->statusPop performClose:event];
            [self monitorStop];
        }
    }];
}

- (void)monitorStop{
    if (eventMonitor) {
        eventMonitor = nil;
        [NSEvent removeMonitor:eventMonitor];
    }
}

@end
