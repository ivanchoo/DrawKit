/**
 @author Graham Cox, Apptree.net
 @author Graham Miln, miln.eu
 @author Contributions from the community
 @date 2005-2014
 @copyright This software is released subject to licensing conditions as detailed in DRAWKIT-LICENSING.TXT, which must accompany this source file.
 */

#import "GCThreadQueue.h"

@implementation GCThreadQueue

/**  */
- (void)enqueue:(id)object
{
    [mLock lock];
    [mQueue addObject:object];
    [mLock unlockWithCondition:1];
}

- (id)dequeue
{
    [mLock lockWhenCondition:1];
    id element = [mQueue objectAtIndex:0];
    [mQueue removeObjectAtIndex:0];
    NSInteger count = [mQueue count];
    [mLock unlockWithCondition:(count > 0) ? 1 : 0];

    return element;
}

- (id)tryDequeue
{
    id element = NULL;
    if ([mLock tryLock]) {
        if ([mLock condition] == 1) {
            element = [mQueue objectAtIndex:0];
            [mQueue removeObjectAtIndex:0];
        }
        NSInteger count = [mQueue count];
        [mLock unlockWithCondition:(count > 0) ? 1 : 0];
    }
    return element;
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        mQueue = [[NSMutableArray alloc] init];
        mLock = [[NSConditionLock alloc] initWithCondition:0];
    }
    return self;
}


@end
