//
//  HKTextStoage.m
//  BulletLists
//
//  Created by Hubert Kunnemeyer on 3/29/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import "HKTextStoage.h"

@interface HKTextStoage ()
@property (nonatomic) CGPoint location;
@property (nonatomic) NSInteger nestCount;
@end

@implementation HKTextStoage

NSMutableAttributedString *_content;


#pragma mark- Initializers
- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    _content = [NSMutableAttributedString new];
    _nestCount = 0;
    return self;
}


#pragma mark - NSTextStorage required
- (NSString *)string{
    return _content.string;
}
- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range{
    return [_content attributesAtIndex:location effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str{
    [_content replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:(NSInteger)str.length - (NSInteger)range.length];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range{
    [_content setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
}



#pragma mark- Styling

- (void)addBulletPointStyle{
    _nestCount++;
    [self addAttribute:NSParagraphStyleAttributeName value:[self getBullet1ParagraphStyle] range:NSMakeRange(_content.length-2, 2)];
}

- (NSDictionary *)bulletAttributes{
    return @{NSFontAttributeName: [self defaultFont],
         NSParagraphStyleAttributeName : [self getBullet1ParagraphStyle],
         NSForegroundColorAttributeName : [UIColor blackColor]};
}
- (NSParagraphStyle*)getBullet1ParagraphStyle{
    NSMutableParagraphStyle *bulletStyle = [[NSMutableParagraphStyle alloc]init];
    NSMutableArray *tabStops = [[NSMutableArray alloc] init];
    [tabStops addObject:[[NSTextTab alloc] initWithTextAlignment:NSTextAlignmentLeft location:30*_nestCount options:nil]];
    [bulletStyle setTabStops:tabStops];
    [bulletStyle setDefaultTabInterval:1];
    [bulletStyle setFirstLineHeadIndent:30 * _nestCount];
    [bulletStyle setHeadIndent:0];
    [bulletStyle setParagraphSpacing:2];
    [bulletStyle setParagraphSpacingBefore:2];
    return bulletStyle;
}



#pragma mark- Default attributes
- (NSDictionary *)defaultAttributes{
    return @{NSFontAttributeName: [self defaultFont],
             NSForegroundColorAttributeName : [self defaultTextColor],
             NSParagraphStyleAttributeName : [self defaultParagraphStyle]};
}
- (UIFont *)defaultFont{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
}
- (UIColor *)defaultTextColor{
    return [UIColor blackColor];
}
- (NSParagraphStyle *)defaultParagraphStyle{
    return [NSParagraphStyle defaultParagraphStyle];
}









@end
