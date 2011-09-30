//
//  BKTimer.m
//  Methods
//
//  Created by Ulrik Damm on 30/9/11.
//  Copyright (c) 2011 Ulrik Damm. All rights reserved.
//

#import "BKTimer.h"

@interface BKTimer () {
    BKTimerCompletionBlock nonRepeatBlock;
	BKTimerRepeatingCompletionBlock repeatBlock;
	BOOL repeating;
}

@property (nonatomic, retain) NSTimer *timer;

@end

@interface BKTimer (internal)


- (id)initWithDelay:(NSTimeInterval)delay completion:(id)completion repeats:(BOOL)repeats;
- (void)timerDone;

@end

@implementation BKTimer

@synthesize timer;

+ (void)timerWithDelay:(NSTimeInterval)delay completion:(BKTimerCompletionBlock)completion {
	[[[[self class] alloc] initWithDelay:delay completion:completion repeats:NO] release];
}

+ (void)repeatingTimerWithDelay:(NSTimeInterval)delay completion:(BKTimerRepeatingCompletionBlock)completion {
	[[[[self class] alloc] initWithDelay:delay completion:completion repeats:YES] release];
}

@end

@implementation BKTimer (internal)

- (id)initWithDelay:(NSTimeInterval)delay completion:(id)completion repeats:(BOOL)repeats {
	if ((self = [super init])) {
		if (repeats) {
			repeatBlock = Block_copy(completion);
		} else {
			nonRepeatBlock = Block_copy(completion);
		}
		
		repeating = repeats;
		
		self.timer = [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(timerDone) userInfo:nil repeats:repeats];
	}
	
	return [self retain];
}

- (void)timerDone {
	if (repeating) {
		BOOL cont = repeatBlock();
		
		if (!cont) {
			[self.timer invalidate];
			[self release];
		}
	} else {
		nonRepeatBlock();
		[self release];
	}
}

- (void)dealloc {
	if (repeating) {
		Block_release(repeatBlock);
	} else {
		Block_release(nonRepeatBlock);
	}
	
	[super dealloc];
}

@end
