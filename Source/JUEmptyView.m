//
// JUEmptyView.m
//
// Copyright (c) 2012 Sidney Just.
//
// License:
//
//   Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//   documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
//   rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
//   permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//   The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
//   Software.
//
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//   WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
//   OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
//   OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// Modifications by Tyler Berry.
// Copyright (c) 2013 3James Software.
//

#import "JUEmptyView.h"

@implementation JUEmptyView

- (id) initWithFrame: (NSRect) frameRect
               title: (NSString *) title
                font: (NSFont *) font
               color: (NSColor *) color
     backgroundColor: (NSColor *) backgroundColor
{
  if (!(self = [super initWithFrame: frameRect]))
    return nil;
  
  _title = title ? [title copy] : @"Untitled";
  _titleFont = font ? font : [NSFont boldSystemFontOfSize: [NSFont smallSystemFontSize]];
  _titleColor = color ? color : [NSColor colorWithCalibratedRed: 0.890 green: 0.890 blue: 0.890 alpha: 1.0];
  _backgroundColor = backgroundColor ? backgroundColor : [NSColor colorWithCalibratedRed: 0.588
                                                                                   green: 0.588
                                                                                    blue: 0.588
                                                                                   alpha: 1.000];
  
  return self;
}

- (id) initWithFrame: (NSRect) frameRect
{
  return [self initWithFrame: frameRect title: nil font: nil color: nil backgroundColor: nil];
}

#pragma mark - Property method implementations

- (void) setTitle: (NSString *) title
{
  _title = [title copy];
  
  [self setNeedsDisplay: YES];
}

- (void) setTitleFont: (NSFont *) titleFont
{
  _titleFont = titleFont;
  
  [self setNeedsDisplay: YES];
}

- (void) setTitleColor: (NSColor *) titleColor
{
  _titleColor = titleColor;
  
  [self setNeedsDisplay:YES];
}

- (void) setBackgroundColor: (NSColor *) backgroundColor
{
  _backgroundColor = backgroundColor;
  
  [self setNeedsDisplay: YES];
}

- (void) setForceShow: (BOOL) forceShow
{
  _forceShow = forceShow;
  
  [self setNeedsDisplay: YES];
}

#pragma mark - NSView overrides (Drawing)

- (void) drawRect: (NSRect) dirtyRect
{
  if (_forceShow || self.subviews.count == 0)
  {
    NSRect rect = self.bounds;
    NSSize size = [_title sizeWithAttributes: @{NSFontAttributeName: _titleFont}];
    NSSize bezierSize = NSMakeSize (size.width + 40.0, size.height + 20.0);
    NSRect drawRect;
    
    // Background
    drawRect = NSMakeRect (0.0, 0.0, bezierSize.width, bezierSize.height);
    drawRect.origin.x = round ((rect.size.width * 0.5) - (bezierSize.width * 0.5));
    drawRect.origin.y = round ((rect.size.height * 0.5) - (bezierSize.height * 0.5));
    
    [_backgroundColor setFill];
    [[NSBezierPath bezierPathWithRoundedRect: drawRect xRadius: 8.0 yRadius: 8.0] fill];
    
    // String
    drawRect = NSMakeRect (0.0, 0.0, size.width, size.height);
    drawRect.origin.x = round ((rect.size.width * 0.5) - (size.width * 0.5));
    drawRect.origin.y = round ((rect.size.height * 0.5) - (size.height * 0.5));
    
    [_title drawInRect: drawRect
        withAttributes: @{NSForegroundColorAttributeName: _titleColor, NSFontAttributeName: _titleFont}];
  }
}

- (void) willRemoveSubview: (NSView *) subview
{
  [super willRemoveSubview: subview];
  [self setNeedsDisplay: YES];
}

- (void) didAddSubview: (NSView *) subview
{
  [super didAddSubview: subview];
  [self setNeedsDisplay: YES];
}

#pragma mark - NSCoding protocol

- (void) encodeWithCoder: (NSCoder *) encoder
{
  [super encodeWithCoder: encoder];
  
  [encoder encodeObject: _title];
  [encoder encodeObject: _titleFont];
  [encoder encodeObject: _titleColor];
  [encoder encodeObject: _backgroundColor];
}

- (id) initWithCoder: (NSCoder *) decoder
{
  if (!(self = [super initWithCoder: decoder]))
    return nil;
  
  _title = [decoder decodeObject];
  _titleFont = [decoder decodeObject];
  _titleColor = [decoder decodeObject];
  _backgroundColor = [decoder decodeObject];
  
  return self;
}

@end
