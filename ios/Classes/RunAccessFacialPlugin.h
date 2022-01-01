#import <Flutter/Flutter.h>

@import MLKitVision;

@interface RunAccessFacialPlugin : NSObject<FlutterPlugin>
+ (void)handleError:(NSError *)error result:(FlutterResult)result;
@end

@protocol Detector
@required
- (instancetype)initWithOptions:(NSDictionary *)options;
- (void)handleDetection:(MLKVisionImage *)image result:(FlutterResult)result;
@optional
@end

@interface BarcodeDetector : NSObject <Detector>
@end

@interface FaceDetector : NSObject <Detector>
@end

@interface ImageLabeler : NSObject <Detector>
@end

@interface TextRecognizer : NSObject <Detector>
@end

