//
//  NSEnumeratorLinqTests.m
//  NSEnumeratorLinqTests
//
//  Created by Антон Буков on 13.01.13.
//  Copyright (c) 2013 Happy Nation Project. All rights reserved.
//

#import "NSEnumerator+Linq.h"
#import "NSEnumeratorLinqTests.h"

@implementation NSEnumerator (ToSet)
- (NSSet *)toSetForTest
{
    return [NSSet setWithArray:[self allObjects]];
}
@end

@implementation NSEnumeratorLinqTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testCount
{
    NSArray * arr0 = @[];
    NSArray * arr1 = @[@1];
    NSArray * arr2 = @[@1,@2];
    NSArray * arr3 = @[@1,@2,@3];
    NSArray * arr4 = @[@1,@2,@3,@4];
    NSArray * arr5 = @[@1,@2,@3,@4,@5];
    
    STAssertEquals(0, [[arr0 objectEnumerator] count], @"Empty array");
    STAssertEquals(1, [[arr1 objectEnumerator] count], @"Array of size 1");
    STAssertEquals(2, [[arr2 objectEnumerator] count], @"Array of size 2");
    STAssertEquals(3, [[arr3 objectEnumerator] count], @"Array of size 3");
    STAssertEquals(4, [[arr4 objectEnumerator] count], @"Array of size 4");
    STAssertEquals(5, [[arr5 objectEnumerator] count], @"Array of size 5");
}

- (void)testDistinctWithArg
{
    NSSet * set0 = [NSSet setWithArray:@[]];
    NSSet * set1 = [NSSet setWithArray:@[@1]];
    NSSet * set2 = [NSSet setWithArray:@[@2]];
    NSSet * set3 = [NSSet setWithArray:@[@1,@2]];
    
    NSArray * arr0 = @[];
    NSArray * arr1 = @[@1];
    NSArray * arr2 = @[@1,@2];
    NSArray * arr3 = @[@1,@2,@3];
    NSArray * arr4 = @[@1,@3,@5,@7];
    NSArray * arr5 = @[@2,@4,@8,@10];
    
    id (^func)(id) = ^id(id a){return @([a intValue]%2);};
    STAssertEqualObjects(set0, [[[arr0 objectEnumerator] distinct:func] toSetForTest], @"Empty array");
    STAssertEqualObjects(set1, [[[arr1 objectEnumerator] distinct:func] toSetForTest], @"Array of size 1");
    STAssertEqualObjects(set3, [[[arr2 objectEnumerator] distinct:func] toSetForTest], @"Array of size 2");
    STAssertEqualObjects(set3, [[[arr3 objectEnumerator] distinct:func] toSetForTest], @"Array of size 3");
    STAssertEqualObjects(set1, [[[arr4 objectEnumerator] distinct:func] toSetForTest], @"Array of size 4");
    STAssertEqualObjects(set2, [[[arr5 objectEnumerator] distinct:func] toSetForTest], @"Array of size 5");
}

- (void)testDistinct
{
    NSSet * set0 = [NSSet setWithArray:@[]];
    NSSet * set1 = [NSSet setWithArray:@[@1]];
    NSSet * set2 = [NSSet setWithArray:@[@1,@2]];
    
    NSArray * arr0 = @[];
    NSArray * arr1 = @[@1];
    NSArray * arr2 = @[@1,@2];
    NSArray * arr3 = @[@1,@1,@2];
    NSArray * arr4 = @[@1,@1,@2,@2];
    NSArray * arr5 = @[@1,@1,@2,@1,@2];
    
    STAssertEqualObjects(set0, [NSSet setWithArray:[[[arr0 objectEnumerator] distinct] allObjects]], @"Empty array");
    STAssertEqualObjects(set1, [NSSet setWithArray:[[[arr1 objectEnumerator] distinct] allObjects]], @"Array of size 1");
    STAssertEqualObjects(set2, [NSSet setWithArray:[[[arr2 objectEnumerator] distinct] allObjects]], @"Array of size 2");
    STAssertEqualObjects(set2, [NSSet setWithArray:[[[arr3 objectEnumerator] distinct] allObjects]], @"Array of size 3");
    STAssertEqualObjects(set2, [NSSet setWithArray:[[[arr4 objectEnumerator] distinct] allObjects]], @"Array of size 4");
    STAssertEqualObjects(set2, [NSSet setWithArray:[[[arr5 objectEnumerator] distinct] allObjects]], @"Array of size 5");
}

- (void)testSelect
{
    NSArray * arr0 = @[];
    NSArray * arr1 = @[@1];
    NSArray * arr2 = @[@1,@2];
    NSArray * arr3 = @[@1,@2,@3];
    NSArray * arr4 = @[@1,@2,@3,@4];
    NSArray * arr5 = @[@1,@2,@3,@4,@5];

    NSArray * ans0 = @[];
    NSArray * ans1 = @[@3];
    NSArray * ans2 = @[@3,@5];
    NSArray * ans3 = @[@3,@5,@7];
    NSArray * ans4 = @[@3,@5,@7,@9];
    NSArray * ans5 = @[@3,@5,@7,@9,@11];
    
    id (^transform)(id) = ^id(id a){return @([a intValue]*2 + 1);};
    STAssertEqualObjects(ans0, [[[arr0 objectEnumerator] select:transform] allObjects], @"Empty array");
    STAssertEqualObjects(ans1, [[[arr1 objectEnumerator] select:transform] allObjects], @"Array of size 1");
    STAssertEqualObjects(ans2, [[[arr2 objectEnumerator] select:transform] allObjects], @"Array of size 2");
    STAssertEqualObjects(ans3, [[[arr3 objectEnumerator] select:transform] allObjects], @"Array of size 3");
    STAssertEqualObjects(ans4, [[[arr4 objectEnumerator] select:transform] allObjects], @"Array of size 4");
    STAssertEqualObjects(ans5, [[[arr5 objectEnumerator] select:transform] allObjects], @"Array of size 5");
}

- (void)testSelect_i
{
    NSArray * arr0 = @[];
    NSArray * arr1 = @[@1];
    NSArray * arr2 = @[@1,@2];
    NSArray * arr3 = @[@1,@2,@3];
    NSArray * arr4 = @[@1,@2,@3,@4];
    NSArray * arr5 = @[@1,@2,@3,@4,@5];
    
    NSArray * ans0 = @[];
    NSArray * ans1 = @[@0];
    NSArray * ans2 = @[@0,@2];
    NSArray * ans3 = @[@0,@2,@12];
    NSArray * ans4 = @[@0,@2,@12,@36];
    NSArray * ans5 = @[@0,@2,@12,@36,@80];
    
    id (^transform)(id, NSInteger) = ^id(id a,NSInteger i){return @(i*i*[a intValue]);};
    STAssertEqualObjects(ans0, [[[arr0 objectEnumerator] select_i:transform] allObjects], @"Empty array");
    STAssertEqualObjects(ans1, [[[arr1 objectEnumerator] select_i:transform] allObjects], @"Array of size 1");
    STAssertEqualObjects(ans2, [[[arr2 objectEnumerator] select_i:transform] allObjects], @"Array of size 2");
    STAssertEqualObjects(ans3, [[[arr3 objectEnumerator] select_i:transform] allObjects], @"Array of size 3");
    STAssertEqualObjects(ans4, [[[arr4 objectEnumerator] select_i:transform] allObjects], @"Array of size 4");
    STAssertEqualObjects(ans5, [[[arr5 objectEnumerator] select_i:transform] allObjects], @"Array of size 5");
}

- (void)testSkip
{
    NSArray * arr0 = @[];
    NSArray * arr1 = @[@1];
    NSArray * arr2 = @[@1,@2];
    NSArray * arr3 = @[@1,@2,@3];
    NSArray * arr4 = @[@1,@2,@3,@4];
    NSArray * arr5 = @[@1,@2,@3,@4,@5];
    
    NSArray * ans00 = @[];
    NSArray * ans11 = @[@1];
    NSArray * ans12 = @[@1,@2];
    NSArray * ans13 = @[@1,@2,@3];
    NSArray * ans14 = @[@1,@2,@3,@4];
    NSArray * ans15 = @[@1,@2,@3,@4,@5];
    NSArray * ans22 = @[@2];
    NSArray * ans23 = @[@2,@3];
    NSArray * ans24 = @[@2,@3,@4];
    NSArray * ans25 = @[@2,@3,@4,@5];
    NSArray * ans33 = @[@3];
    NSArray * ans34 = @[@3,@4];
    NSArray * ans35 = @[@3,@4,@5];
    NSArray * ans44 = @[@4];
    NSArray * ans45 = @[@4,@5];
    NSArray * ans55 = @[@5];

    STAssertEqualObjects(ans00, [[[arr0 objectEnumerator] skip:0] allObjects], @"Empty array");
    STAssertEqualObjects(ans00, [[[arr0 objectEnumerator] skip:1] allObjects], @"Empty array");

    STAssertEqualObjects(ans11, [[[arr1 objectEnumerator] skip:0] allObjects], @"Array of size 1");
    STAssertEqualObjects(ans00, [[[arr1 objectEnumerator] skip:1] allObjects], @"Array of size 1");
    STAssertEqualObjects(ans00, [[[arr1 objectEnumerator] skip:2] allObjects], @"Array of size 1");

    STAssertEqualObjects(ans12, [[[arr2 objectEnumerator] skip:0] allObjects], @"Array of size 2");
    STAssertEqualObjects(ans22, [[[arr2 objectEnumerator] skip:1] allObjects], @"Array of size 2");
    STAssertEqualObjects(ans00, [[[arr2 objectEnumerator] skip:2] allObjects], @"Array of size 2");
    STAssertEqualObjects(ans00, [[[arr2 objectEnumerator] skip:3] allObjects], @"Array of size 2");

    STAssertEqualObjects(ans13, [[[arr3 objectEnumerator] skip:0] allObjects], @"Array of size 3");
    STAssertEqualObjects(ans23, [[[arr3 objectEnumerator] skip:1] allObjects], @"Array of size 3");
    STAssertEqualObjects(ans33, [[[arr3 objectEnumerator] skip:2] allObjects], @"Array of size 3");
    STAssertEqualObjects(ans00, [[[arr3 objectEnumerator] skip:3] allObjects], @"Array of size 3");
    STAssertEqualObjects(ans00, [[[arr3 objectEnumerator] skip:4] allObjects], @"Array of size 3");
    
    STAssertEqualObjects(ans14, [[[arr4 objectEnumerator] skip:0] allObjects], @"Array of size 4");
    STAssertEqualObjects(ans24, [[[arr4 objectEnumerator] skip:1] allObjects], @"Array of size 4");
    STAssertEqualObjects(ans34, [[[arr4 objectEnumerator] skip:2] allObjects], @"Array of size 4");
    STAssertEqualObjects(ans44, [[[arr4 objectEnumerator] skip:3] allObjects], @"Array of size 4");
    STAssertEqualObjects(ans00, [[[arr4 objectEnumerator] skip:4] allObjects], @"Array of size 4");
    STAssertEqualObjects(ans00, [[[arr4 objectEnumerator] skip:5] allObjects], @"Array of size 4");

    STAssertEqualObjects(ans15, [[[arr5 objectEnumerator] skip:0] allObjects], @"Array of size 5");
    STAssertEqualObjects(ans25, [[[arr5 objectEnumerator] skip:1] allObjects], @"Array of size 5");
    STAssertEqualObjects(ans35, [[[arr5 objectEnumerator] skip:2] allObjects], @"Array of size 5");
    STAssertEqualObjects(ans45, [[[arr5 objectEnumerator] skip:3] allObjects], @"Array of size 5");
    STAssertEqualObjects(ans55, [[[arr5 objectEnumerator] skip:4] allObjects], @"Array of size 5");
    STAssertEqualObjects(ans00, [[[arr5 objectEnumerator] skip:5] allObjects], @"Array of size 5");
    STAssertEqualObjects(ans00, [[[arr5 objectEnumerator] skip:6] allObjects], @"Array of size 5");
}

- (void)testUnion
{
    NSArray * arr0 = @[];
    NSArray * arr1 = @[@1];
    NSArray * arr2 = @[@1,@2];
    NSArray * arr3 = @[@1,@2,@3];

    NSArray * arrZ = @[];
    NSArray * arrA = @[@100];
    NSArray * arrB = @[@100,@200];
    NSArray * arrC = @[@100,@200,@300];

    NSArray * ans0Z = @[];
    NSArray * ans0A = @[@100];
    NSArray * ans0B = @[@100,@200];
    NSArray * ans0C = @[@100,@200,@300];
    NSArray * ans1Z = @[@1];
    NSArray * ans1A = @[@1,@100];
    NSArray * ans1B = @[@1,@100,@200];
    NSArray * ans1C = @[@1,@100,@200,@300];
    NSArray * ans2Z = @[@1,@2];
    NSArray * ans2A = @[@1,@2,@100];
    NSArray * ans2B = @[@1,@2,@100,@200];
    NSArray * ans2C = @[@1,@2,@100,@200,@300];
    NSArray * ans3Z = @[@1,@2,@3];
    NSArray * ans3A = @[@1,@2,@3,@100];
    NSArray * ans3B = @[@1,@2,@3,@100,@200];
    NSArray * ans3C = @[@1,@2,@3,@100,@200,@300];
    
    STAssertEqualObjects(ans0Z, [[[arr0 objectEnumerator] unionAll:[arrZ objectEnumerator]] allObjects], @"0+Z");
    STAssertEqualObjects(ans0A, [[[arr0 objectEnumerator] unionAll:[arrA objectEnumerator]] allObjects], @"0+A");
    STAssertEqualObjects(ans0B, [[[arr0 objectEnumerator] unionAll:[arrB objectEnumerator]] allObjects], @"0+B");
    STAssertEqualObjects(ans0C, [[[arr0 objectEnumerator] unionAll:[arrC objectEnumerator]] allObjects], @"0+C");
    
    STAssertEqualObjects(ans1Z, [[[arr1 objectEnumerator] unionAll:[arrZ objectEnumerator]] allObjects], @"1+Z");
    STAssertEqualObjects(ans1A, [[[arr1 objectEnumerator] unionAll:[arrA objectEnumerator]] allObjects], @"1+A");
    STAssertEqualObjects(ans1B, [[[arr1 objectEnumerator] unionAll:[arrB objectEnumerator]] allObjects], @"1+B");
    STAssertEqualObjects(ans1C, [[[arr1 objectEnumerator] unionAll:[arrC objectEnumerator]] allObjects], @"1+C");
    
    STAssertEqualObjects(ans2Z, [[[arr2 objectEnumerator] unionAll:[arrZ objectEnumerator]] allObjects], @"2+Z");
    STAssertEqualObjects(ans2A, [[[arr2 objectEnumerator] unionAll:[arrA objectEnumerator]] allObjects], @"2+A");
    STAssertEqualObjects(ans2B, [[[arr2 objectEnumerator] unionAll:[arrB objectEnumerator]] allObjects], @"2+B");
    STAssertEqualObjects(ans2C, [[[arr2 objectEnumerator] unionAll:[arrC objectEnumerator]] allObjects], @"2+C");
    
    STAssertEqualObjects(ans3Z, [[[arr3 objectEnumerator] unionAll:[arrZ objectEnumerator]] allObjects], @"3+Z");
    STAssertEqualObjects(ans3A, [[[arr3 objectEnumerator] unionAll:[arrA objectEnumerator]] allObjects], @"3+A");
    STAssertEqualObjects(ans3B, [[[arr3 objectEnumerator] unionAll:[arrB objectEnumerator]] allObjects], @"3+B");
    STAssertEqualObjects(ans3C, [[[arr3 objectEnumerator] unionAll:[arrC objectEnumerator]] allObjects], @"3+C");
}

- (void)testWhere
{
    NSArray * arr = @[@1,@2,@3,@4,@5,@6,@7,@8];
    
    NSArray * ans1 = @[@1,@3,@5,@7];
    NSArray * ans2 = @[@3,@4,@5];
    NSArray * ans3 = @[@2,@5,@8];
    
    STAssertEqualObjects(ans1, [[[arr objectEnumerator] where:^BOOL(id a) {return [a intValue]%2 == 1;}] allObjects], @"Odd values");
    STAssertEqualObjects(ans2, [[[arr objectEnumerator] where:^BOOL(id a) {return [a intValue]>2 && [a intValue]<=5;}] allObjects], @"Values in range (2,5]");
    STAssertEqualObjects(ans3, [[[arr objectEnumerator] where:^BOOL(id a) {return [a intValue]%3 == 2;}] allObjects], @"Values x%3==2");
}

- (void)testWhere_i
{
    NSArray * arr = @[@100,@200,@300,@400,@500,@600,@700,@800];
    
    NSArray * ans1 = @[@200,@400,@600,@800];
    NSArray * ans2 = @[@400,@500,@600];
    NSArray * ans3 = @[@300,@600];
    
    STAssertEqualObjects(ans1, [[[arr objectEnumerator] where_i:^BOOL(id a, NSInteger i) {return i%2 == 1;}] allObjects], @"Odd indexes");
    STAssertEqualObjects(ans2, [[[arr objectEnumerator] where_i:^BOOL(id a, NSInteger i) {return i>2 && i<=5;}] allObjects], @"Indexes in range (2,5]");
    STAssertEqualObjects(ans3, [[[arr objectEnumerator] where_i:^BOOL(id a, NSInteger i) {return i%3 == 2;}] allObjects], @"Values x%3==2");
}

@end
