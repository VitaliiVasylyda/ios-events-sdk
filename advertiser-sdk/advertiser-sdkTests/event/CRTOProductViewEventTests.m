//
//  CRTOProductViewEventTests.m
//  advertiser-sdk
//
//  Created by Paul Davis on 7/2/15.
//  Copyright (c) 2015 Criteo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CRTOProduct.h"
#import "CRTOProductViewEvent.h"

@interface CRTOProductViewEventTests : XCTestCase

@end

@implementation CRTOProductViewEventTests
{
    NSString* productId;
    double price;
    NSString* currency;
    NSDate* startDate;
    NSDate* endDate;
}

- (void)setUp
{
    [super setUp];

    productId = @"foo";
    price     = 999.85;
    currency  = @"EUR";
    startDate = [NSDate dateWithTimeIntervalSince1970:1000000000];
    endDate   = [NSDate dateWithTimeIntervalSince1970:1000086401];
}

- (void)tearDown
{

    [super tearDown];
}

- (void) testInit
{
    CRTOProductViewEvent* event = [[CRTOProductViewEvent alloc] init];

    XCTAssertNotNil(event);

    XCTAssertNil(event.currency);
    XCTAssertNil(event.product);
}

- (void) testInitWithProduct
{
    CRTOProduct* product = [[CRTOProduct alloc] initWithProductId:productId price:price];

    CRTOProductViewEvent* event = [[CRTOProductViewEvent alloc] initWithProduct:product];

    XCTAssertNotNil(event);

    XCTAssertNil(event.currency);

    XCTAssertEqual(event.product, product);
    XCTAssert([event.product isKindOfClass:[CRTOProduct class]]);
    XCTAssertEqualObjects(event.product.productId, productId);
    XCTAssertEqual(event.product.price, price);
}

- (void) testInitWithProductCurrency
{
    CRTOProduct* product = [[CRTOProduct alloc] initWithProductId:productId price:price];

    CRTOProductViewEvent* event = [[CRTOProductViewEvent alloc] initWithProduct:product currency:currency];

    XCTAssertNotNil(event);

    XCTAssertEqualObjects(currency, event.currency);

    XCTAssertEqual(event.product, product);
    XCTAssert([event.product isKindOfClass:[CRTOProduct class]]);
    XCTAssertEqualObjects(event.product.productId, productId);
    XCTAssertEqual(event.product.price, price);
}

- (void) testInitWithProductCurrencyDates
{
    CRTOProduct* product = [[CRTOProduct alloc] initWithProductId:productId price:price];

    CRTOProductViewEvent* event = [[CRTOProductViewEvent alloc] initWithProduct:product
                                                                       currency:currency
                                                                      startDate:startDate
                                                                        endDate:endDate];

    XCTAssertNotNil(event);

    XCTAssertEqualObjects(currency, event.currency);

    XCTAssertEqual(event.product, product);
    XCTAssert([event.product isKindOfClass:[CRTOProduct class]]);
    XCTAssertEqualObjects(event.product.productId, productId);
    XCTAssertEqual(event.product.price, price);

    XCTAssertEqualObjects(event.startDate, startDate);
    XCTAssertEqualObjects(event.endDate, endDate);
}

- (void) testProductViewEventCopy
{
    CRTOProduct* product = [[CRTOProduct alloc] initWithProductId:productId price:price];

    CRTOProductViewEvent* event = [[CRTOProductViewEvent alloc] initWithProduct:product
                                                                       currency:currency
                                                                      startDate:startDate
                                                                        endDate:endDate];

    CRTOProductViewEvent* eventCopy = [event copy];

    XCTAssertEqualObjects(event.product.productId, eventCopy.product.productId);
    XCTAssertEqual(event.product.price, eventCopy.product.price);
    XCTAssertEqualObjects(event.currency, eventCopy.currency);
    XCTAssertEqualObjects(event.startDate, eventCopy.startDate);
    XCTAssertEqualObjects(event.endDate, eventCopy.endDate);
}

@end