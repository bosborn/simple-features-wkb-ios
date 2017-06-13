//
//  WKBGeometryUtilsTestCase.m
//  wkb-ios
//
//  Created by Brian Osborn on 4/17/17.
//  Copyright © 2017 NGA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WKBTestUtils.h"
#import "WKBGeometryTestUtils.h"
#import "WKBGeometryUtils.h"
#import "WKBGeometryEnvelopeBuilder.h"

@interface WKBGeometryUtilsTestCase : XCTestCase

@end

@implementation WKBGeometryUtilsTestCase

static NSUInteger GEOMETRIES_PER_TEST = 10;

-(void) setUp {
    [super setUp];
}

-(void) tearDown {
    [super tearDown];
}

-(void) testPointCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a point
        WKBPoint * point = [WKBGeometryTestUtils createPointWithHasZ:[WKBTestUtils coinFlip] andHasM:[WKBTestUtils coinFlip]];
        [WKBTestUtils assertEqualIntWithValue:0 andValue2:[WKBGeometryUtils dimensionOfGeometry:point]];
        [self geometryCentroidTesterWithGeometry:point];
    }
    
}

-(void) testLineStringCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a line string
        WKBLineString * lineString = [WKBGeometryTestUtils createLineStringWithHasZ:[WKBTestUtils coinFlip] andHasM:[WKBTestUtils coinFlip]];
        [WKBTestUtils assertEqualIntWithValue:1 andValue2:[WKBGeometryUtils dimensionOfGeometry:lineString]];
        [self geometryCentroidTesterWithGeometry:lineString];
    }
    
}

-(void) testPolygonCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a polygon
        WKBPolygon * polygon = [self createPolygon];
        [WKBTestUtils assertEqualIntWithValue:2 andValue2:[WKBGeometryUtils dimensionOfGeometry:polygon]];
        [self geometryCentroidTesterWithGeometry:polygon];
    }
    
}

-(void) testMultiPointCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a multi point
        WKBMultiPoint * multiPoint = [WKBGeometryTestUtils createMultiPointWithHasZ:[WKBTestUtils coinFlip] andHasM:[WKBTestUtils coinFlip]];
        [WKBTestUtils assertEqualIntWithValue:0 andValue2:[WKBGeometryUtils dimensionOfGeometry:multiPoint]];
        [self geometryCentroidTesterWithGeometry:multiPoint];
    }
    
}

-(void) testMultiLineStringCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a multi line string
        WKBMultiLineString * multiLineString = [WKBGeometryTestUtils createMultiLineStringWithHasZ:[WKBTestUtils coinFlip] andHasM:[WKBTestUtils coinFlip]];
        [WKBTestUtils assertEqualIntWithValue:1 andValue2:[WKBGeometryUtils dimensionOfGeometry:multiLineString]];
        [self geometryCentroidTesterWithGeometry:multiLineString];
    }
    
}

-(void) testMultiPolygonCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a multi polygon
        WKBMultiPolygon * multiPolygon = [self createMultiPolygon];
        [WKBTestUtils assertEqualIntWithValue:2 andValue2:[WKBGeometryUtils dimensionOfGeometry:multiPolygon]];
        [self geometryCentroidTesterWithGeometry:multiPolygon];
    }
    
}

-(void) testGeometryCollectionCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a geometry collection
        WKBGeometryCollection * geometryCollection = [self createGeometryCollectionWithHasZ:[WKBTestUtils coinFlip] andHasM:[WKBTestUtils coinFlip]];
        [self geometryCentroidTesterWithGeometry:geometryCollection];
    }
    
}

-(void) testPolygonCentroidWithAndWithoutHole {
    
    WKBPolygon * polygon = [[WKBPolygon alloc] init];
    WKBLineString * lineString = [[WKBLineString alloc] init];
    [lineString addPoint:[[WKBPoint alloc] initWithXValue:-90 andYValue:45]];
    [lineString addPoint:[[WKBPoint alloc] initWithXValue:-90 andYValue:-45]];
    [lineString addPoint:[[WKBPoint alloc] initWithXValue:90 andYValue:-45]];
    [lineString addPoint:[[WKBPoint alloc] initWithXValue:90 andYValue:45]];
    [polygon addRing:lineString];
    
    [WKBTestUtils assertEqualIntWithValue:2 andValue2:[WKBGeometryUtils dimensionOfGeometry:polygon]];
    WKBPoint * centroid = [self geometryCentroidTesterWithGeometry:polygon];
    
    [WKBTestUtils assertEqualDoubleWithValue:0.0 andValue2:[centroid.x doubleValue]];
    [WKBTestUtils assertEqualDoubleWithValue:0.0 andValue2:[centroid.y doubleValue]];
    
    WKBLineString * holeLineString = [[WKBLineString alloc] init];
    [holeLineString addPoint:[[WKBPoint alloc] initWithXValue:0 andYValue:45]];
    [holeLineString addPoint:[[WKBPoint alloc] initWithXValue:0 andYValue:0]];
    [holeLineString addPoint:[[WKBPoint alloc] initWithXValue:90 andYValue:0]];
    [holeLineString addPoint:[[WKBPoint alloc] initWithXValue:90 andYValue:45]];
    [polygon addRing:holeLineString];
    
    [WKBTestUtils assertEqualIntWithValue:2 andValue2:[WKBGeometryUtils dimensionOfGeometry:polygon]];
    centroid = [self geometryCentroidTesterWithGeometry:polygon];
    
    [WKBTestUtils assertEqualDoubleWithValue:-15.0 andValue2:[centroid.x doubleValue]];
    [WKBTestUtils assertEqualDoubleWithValue:-7.5 andValue2:[centroid.y doubleValue]];
}

-(WKBPoint *) geometryCentroidTesterWithGeometry: (WKBGeometry *) geometry{
    
    WKBPoint * point = [WKBGeometryUtils centroidOfGeometry:geometry];
    
    WKBGeometryEnvelope * envelope = [WKBGeometryEnvelopeBuilder buildEnvelopeWithGeometry:geometry];
    
    if(geometry.geometryType == WKB_POINT){
        [WKBTestUtils assertEqualDoubleWithValue:[envelope.minX doubleValue] andValue2:[point.x doubleValue]];
        [WKBTestUtils assertEqualDoubleWithValue:[envelope.maxX doubleValue] andValue2:[point.x doubleValue]];
        [WKBTestUtils assertEqualDoubleWithValue:[envelope.minY doubleValue] andValue2:[point.y doubleValue]];
        [WKBTestUtils assertEqualDoubleWithValue:[envelope.maxY doubleValue] andValue2:[point.y doubleValue]];
    }
    
    [WKBTestUtils assertTrue:[point.x doubleValue] >= [envelope.minX doubleValue]];
    [WKBTestUtils assertTrue:[point.x doubleValue] <= [envelope.maxX doubleValue]];
    [WKBTestUtils assertTrue:[point.y doubleValue] >= [envelope.minY doubleValue]];
    [WKBTestUtils assertTrue:[point.y doubleValue] <= [envelope.maxY doubleValue]];
    
    return point;
}

-(WKBPolygon *) createPolygon{
    
    WKBPolygon * polygon = [[WKBPolygon alloc] init];
    WKBLineString * lineString = [[WKBLineString alloc] init];
    [lineString addPoint:[self createPointWithMinX:-180.0 andMinY:45.0 andXRange:90.0 andYRange:45.0]];
    [lineString addPoint:[self createPointWithMinX:-180.0 andMinY:-90.0 andXRange:90.0 andYRange:45.0]];
    [lineString addPoint:[self createPointWithMinX:90.0 andMinY:-90.0 andXRange:90.0 andYRange:45.0]];
    [lineString addPoint:[self createPointWithMinX:90.0 andMinY:45.0 andXRange:90.0 andYRange:45.0]];
    [polygon addRing:lineString];
    
    WKBLineString * holeLineString = [[WKBLineString alloc] init];
    [holeLineString addPoint:[self createPointWithMinX:-90.0 andMinY:0.0 andXRange:90.0 andYRange:45.0]];
    [holeLineString addPoint:[self createPointWithMinX:-90.0 andMinY:-45.0 andXRange:90.0 andYRange:45.0]];
    [holeLineString addPoint:[self createPointWithMinX:0.0 andMinY:-45.0 andXRange:90.0 andYRange:45.0]];
    [holeLineString addPoint:[self createPointWithMinX:0.0 andMinY:0.0 andXRange:90.0 andYRange:45.0]];
    [polygon addRing:holeLineString];
    
    return polygon;
}

-(WKBPoint *) createPointWithMinX: (double) minX andMinY: (double) minY andXRange: (double) xRange andYRange: (double) yRange{
    
    double x = minX + ([WKBTestUtils randomDouble] * xRange);
    double y = minY + ([WKBTestUtils randomDouble] * yRange);
    
    WKBPoint * point = [[WKBPoint alloc] initWithXValue:x andYValue:y];
    
    return point;
}

-(WKBMultiPolygon *) createMultiPolygon{
    
    WKBMultiPolygon * multiPolygon = [[WKBMultiPolygon alloc] init];
    
    int num = 1 + ((int) ([WKBTestUtils randomDouble] * 5));
    
    for (int i = 0; i < num; i++) {
        [multiPolygon addPolygon:[self createPolygon]];
    }
    
    return multiPolygon;
}

-(WKBGeometryCollection *) createGeometryCollectionWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{

    WKBGeometryCollection * geometryCollection = [[WKBGeometryCollection alloc] initWithHasZ:hasZ andHasM:hasM];
    
    int num = 1 + ((int) ([WKBTestUtils randomDouble] * 5));
    
    for (int i = 0; i < num; i++) {
        
        WKBGeometry * geometry = nil;
        int randomGeometry = (int) ([WKBTestUtils randomDouble] * 6);
        
        switch (randomGeometry) {
            case 0:
                geometry = [WKBGeometryTestUtils createPointWithHasZ:hasZ andHasM:hasM];
                break;
            case 1:
                geometry = [WKBGeometryTestUtils createLineStringWithHasZ:hasZ andHasM:hasM];
                break;
            case 2:
                geometry = [self createPolygon];
                break;
            case 3:
                geometry = [WKBGeometryTestUtils createMultiPointWithHasZ:hasZ andHasM:hasM];
                break;
            case 4:
                geometry = [WKBGeometryTestUtils createMultiLineStringWithHasZ:hasZ andHasM:hasM];
                break;
            case 5:
                geometry = [self createMultiPolygon];
                break;
        }
        
        [geometryCollection addGeometry:geometry];
    }
    
    return geometryCollection;
}

-(void) testCopyMinimizeAndNormalize{
    
    WKBPolygon * polygon = [[WKBPolygon alloc] init];
    WKBLineString * ring = [[WKBLineString alloc] init];
    double random = [WKBTestUtils randomDouble];
    if(random < .5){
        [ring addPoint:[self createPointWithMinX:90.0 andMinY:0.0 andXRange:90.0 andYRange:90.0]];
        [ring addPoint:[self createPointWithMinX:90.0 andMinY:-90.0 andXRange:90.0 andYRange:90.0]];
        [ring addPoint:[self createPointWithMinX:-180.0 andMinY:-90.0 andXRange:89.0 andYRange:90.0]];
        [ring addPoint:[self createPointWithMinX:-180.0 andMinY:0.0 andXRange:89.0 andYRange:90.0]];
    }else{
        [ring addPoint:[self createPointWithMinX:-180.0 andMinY:0.0 andXRange:89.0 andYRange:90.0]];
        [ring addPoint:[self createPointWithMinX:-180.0 andMinY:-90.0 andXRange:89.0 andYRange:90.0]];
        [ring addPoint:[self createPointWithMinX:90.0 andMinY:-90.0 andXRange:90.0 andYRange:90.0]];
        [ring addPoint:[self createPointWithMinX:90.0 andMinY:0.0 andXRange:90.0 andYRange:90.0]];
    }
    [polygon addRing:ring];
    
    WKBPolygon * polygon2 = [polygon mutableCopy];
    [WKBGeometryUtils minimizeGeometry:polygon2 withMaxX:180.0];
    
    WKBPolygon * polygon3 = [polygon2 mutableCopy];
    [WKBGeometryUtils normalizeGeometry:polygon3 withMaxX:180.0];
    
    NSArray *points = ring.points;
    WKBLineString *ring2 = [polygon2.rings objectAtIndex:0];
    NSArray *points2 = ring2.points;
    WKBLineString *ring3 = [polygon3.rings objectAtIndex:0];
    NSArray *points3 = ring3.points;
    
    for(int i = 0; i < points.count; i++){
        
        WKBPoint *point = [points objectAtIndex:i];
        WKBPoint *point2 = [points2 objectAtIndex:i];
        WKBPoint *point3 = [points3 objectAtIndex:i];
        
        [WKBTestUtils assertEqualDoubleWithValue:[point.y doubleValue] andValue2:[point2.y doubleValue]];
        [WKBTestUtils assertEqualDoubleWithValue:[point.y doubleValue] andValue2:[point3.y doubleValue]];
        [WKBTestUtils assertEqualDoubleWithValue:[point.x doubleValue] andValue2:[point3.x doubleValue]];
        if(i < 2){
            [WKBTestUtils assertEqualDoubleWithValue:[point.x doubleValue] andValue2:[point2.x doubleValue]];
        }else{
            double point2Value = [point2.x doubleValue];
            if(random < .5){
                point2Value -= 360.0;
            }else{
                point2Value += 360.0;
            }
            [WKBTestUtils assertEqualDoubleWithValue:[point.x doubleValue] andValue2:point2Value andDelta:.0000000001];
        }
    }
    
}

@end