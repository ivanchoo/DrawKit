/**
 @author Contributions from the community; see CONTRIBUTORS.md
 @date 2005-2015
 @copyright GNU GPL3; see LICENSE
*/

#import "DKBoundingRectHandle.h"

@implementation DKBoundingRectHandle

+ (DKKnobType)type
{
	return kDKBoundingRectKnobType;
}

+ (NSColor*)fillColour
{
	return [NSColor colorWithDeviceRed:0.5
								 green:0.9
								  blue:1.0
								 alpha:1.0];
}

+ (NSColor*)strokeColour
{
	return [NSColor blackColor];
}

+ (CGFloat)scaleFactor
{
	return 0.9;
}

@end

#pragma mark -

@implementation DKLockedBoundingRectHandle

+ (DKKnobType)type
{
	return kDKBoundingRectKnobType | kDKKnobIsDisabledFlag;
}

+ (NSColor*)fillColour
{
	return [NSColor whiteColor];
}

+ (NSColor*)strokeColour
{
	return [NSColor grayColor];
}

- (void)setColour:(NSColor*)colour
{
#pragma unused(colour)
	[super setColour:nil];
}

@end

#pragma mark -

@implementation DKInactiveBoundingRectHandle

+ (DKKnobType)type
{
	return kDKBoundingRectKnobType | kDKKnobIsInactiveFlag;
}

+ (NSColor*)fillColour
{
	return [NSColor lightGrayColor];
}

+ (NSColor*)strokeColour
{
	return [NSColor grayColor];
}

- (void)setColour:(NSColor*)colour
{
#pragma unused(colour)
	[super setColour:nil];
}

@end
