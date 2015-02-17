//
//  DetectorWrapper.m
//  Mocha
//
//  Created by AG on 17/2/15.
//  Copyright (c) 2015 AG. All rights reserved.
//

#import "DetectorWrapper.h"
#import "Detector.h"

@implementation DetectorWrapper
+ (void) generateMockup {
    Detector::generateMockup();
}
@end
