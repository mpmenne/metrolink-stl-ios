//
//  NextMetroSwizzle.h
//  NextMetroSTL
//
//  Created by Mike Menne on 11/24/13.
//  Copyright (c) 2013 com.menne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NextMetroSwizzle : NSObject

void SwizzleInstanceMethod(Class c, SEL orig, SEL new);
void SwizzleClassMethod(Class c, SEL orig, SEL new);

@end
