//
//  SFWGeometryTestUtils.h
//  sf-wkb-ios
//
//  Created by Brian Osborn on 11/10/15.
//  Copyright © 2015 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFGeometryEnvelope.h"
#import "SFPoint.h"
#import "SFLineString.h"
#import "SFPolygon.h"
#import "SFMultiPoint.h"
#import "SFMultiLineString.h"
#import "SFMultiPolygon.h"
#import "SFGeometryCollection.h"
#import "SFCircularString.h"
#import "SFCompoundCurve.h"
#import "SFCurvePolygon.h"
#import "SFPolyhedralSurface.h"
#import "SFTIN.h"
#import "SFTriangle.h"


@interface SFWGeometryTestUtils : NSObject

+(void) compareEnvelopesWithExpected: (SFGeometryEnvelope *) expected andActual: (SFGeometryEnvelope *) actual;

+(void) compareGeometriesWithExpected: (SFGeometry *) expected andActual: (SFGeometry *) actual;

+(void) compareBaseGeometryAttributesWithExpected: (SFGeometry *) expected andActual: (SFGeometry *) actual;

+(void) comparePointWithExpected: (SFPoint *) expected andActual: (SFPoint *) actual;

+(void) compareLineStringWithExpected: (SFLineString *) expected andActual: (SFLineString *) actual;

+(void) comparePolygonWithExpected: (SFPolygon *) expected andActual: (SFPolygon *) actual;

+(void) compareMultiPointWithExpected: (SFMultiPoint *) expected andActual: (SFMultiPoint *) actual;

+(void) compareMultiLineStringWithExpected: (SFMultiLineString *) expected andActual: (SFMultiLineString *) actual;

+(void) compareMultiPolygonWithExpected: (SFMultiPolygon *) expected andActual: (SFMultiPolygon *) actual;

+(void) compareGeometryCollectionWithExpected: (SFGeometryCollection *) expected andActual: (SFGeometryCollection *) actual;

+(void) compareCircularStringWithExpected: (SFCircularString *) expected andActual: (SFCircularString *) actual;

+(void) compareCompoundCurveWithExpected: (SFCompoundCurve *) expected andActual: (SFCompoundCurve *) actual;

+(void) compareCurvePolygonWithExpected: (SFCurvePolygon *) expected andActual: (SFCurvePolygon *) actual;

+(void) comparePolyhedralSurfaceWithExpected: (SFPolyhedralSurface *) expected andActual: (SFPolyhedralSurface *) actual;

+(void) compareTINWithExpected: (SFTIN *) expected andActual: (SFTIN *) actual;

+(void) compareTriangleWithExpected: (SFTriangle *) expected andActual: (SFTriangle *) actual;

+(void) compareGeometryDataWithExpected: (SFGeometry *) expected andActual: (SFGeometry *) actual;

+(void) compareGeometryDataWithExpected: (SFGeometry *) expected andActual: (SFGeometry *) actual andByteOrder: (CFByteOrder) byteOrder;

+(void) compareDataGeometriesWithExpected: (NSData *) expected andActual: (NSData *) actual;

+(void) compareDataGeometriesWithExpected: (NSData *) expected andActual: (NSData *) actual andByteOrder: (CFByteOrder) byteOrder;

+(NSData *) writeDataWithGeometry: (SFGeometry *) geometry;

+(NSData *) writeDataWithGeometry: (SFGeometry *) geometry andByteOrder: (CFByteOrder) byteOrder;

+(SFGeometry *) readGeometryWithData: (NSData *) data;

+(SFGeometry *) readGeometryWithData: (NSData *) data andByteOrder: (CFByteOrder) byteOrder;

+(void) compareDataWithExpected: (NSData *) expected andActual: (NSData *) actual;

+(BOOL) equalDataWithExpected: (NSData *) expected andActual: (NSData *) actual;

+(SFPoint *) createPointWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

+(SFLineString *) createLineStringWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

+(SFLineString *) createLineStringWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM andRing: (BOOL) ring;

+(SFPolygon *) createPolygonWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

+(SFMultiPoint *) createMultiPointWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

+(SFMultiLineString *) createMultiLineStringWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

+(SFMultiPolygon *) createMultiPolygonWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

+(SFGeometryCollection *) createGeometryCollectionWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

+(SFCompoundCurve *) createCompoundCurveWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

+(SFCompoundCurve *) createCompoundCurveWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM andRing: (BOOL) ring;

+(SFCurvePolygon *) createCurvePolygonWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

+(SFGeometryCollection *) createMultiCurve;

+(SFGeometryCollection *) createMultiSurface;

@end
