/**
 @author Graham Cox, Apptree.net
 @author Graham Miln, miln.eu
 @author Contributions from the community
 @date 2005-2014
 @copyright This software is released subject to licensing conditions as detailed in DRAWKIT-LICENSING.TXT, which must accompany this source file.
 */

#import "DKRetriggerableTimer.h"

@interface DKRetriggerableTimer (Private)

- (void)timerCallback:(NSTimer*)timer;

@end

#pragma mark -

@implementation DKRetriggerableTimer

+ (DKRetriggerableTimer*)retriggerableTimerWithPeriod:(NSTimeInterval)period target:(id)target selector:(SEL)action
{
    DKRetriggerableTimer* rt = [[self alloc] initWithPeriod:period];
    [rt setAction:action];
    [rt setTarget:target];

    return rt;
}

- (id)initWithPeriod:(NSTimeInterval)period
{
    self = [super init];
    if (self) {
        mPeriod = period;
    }

    return self;
}

- (NSTimeInterval)period
{
    return mPeriod;
}

- (void)retrigger
{
    NSDate* fireDate = [NSDate dateWithTimeIntervalSinceNow:[self period]];

    if (mTimer)
        [mTimer setFireDate:fireDate];
    else
        mTimer = [NSTimer scheduledTimerWithTimeInterval:[self period]
                                                  target:self
                                                selector:@selector(timerCallback:)
                                                userInfo:nil
                                                 repeats:NO];
}

- (void)setAction:(SEL)action
{
    mAction = action;
}

- (SEL)action
{
    return mAction;
}

- (void)setTarget:(id)target
{
    mTarget = target;
}

- (id)target
{
    return mTarget;
}

#pragma mark -

- (void)timerCallback:(NSTimer*)timer
{
#pragma unused(timer)
    mTimer = nil;
    [NSApp sendAction:[self action]
                   to:[self target]
                 from:self];
}

#pragma mark -
#pragma mark - as a NSObject

- (id)init
{
    return [self initWithPeriod:1.0];
}

- (void)dealloc
{
    [mTimer invalidate];
    [super dealloc];
}

@end
