#import "AppDelegate.h"
#import "SpeechSynthesizer.h"
#import "Sampler.h"
#import "Input.h"
#import "Output.h"
#import "TestSampleData.h"

@interface AppDelegate ()
@property (nonatomic, strong) SpeechSynthesizer *speechSynthesizer;
@property (nonatomic, strong) Sampler *sampler;
@property (nonatomic, strong) Input *input;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self.speechSynthesizer speak:@"blue_wizard"];
//    [self openFileBrowser];
//    
//    NSMutableArray *samples = [NSMutableArray array];
//    for (NSNumber *num in [TestSampleData samples]) {
//        float f = ((float)[num intValue]) / (1 << 15);
//        [samples addObject:[NSNumber numberWithFloat:f]];
//    }
//    [Output save:samples];
//    [self.sampler stream:[i samples] sampleRate:48000];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [self.speechSynthesizer stop];
}

-(SpeechSynthesizer *)speechSynthesizer {
    if (!_speechSynthesizer) {
        _speechSynthesizer = [[SpeechSynthesizer alloc] initWithSampleRate:8000 sampler:self.sampler];
    }
    return _speechSynthesizer;
}

-(Sampler *)sampler {
    if (!_sampler) {
        _sampler = [[Sampler alloc] init];
    }
    return _sampler;
}

-(void)openFileBrowser {
    NSOpenPanel* dialog = [NSOpenPanel openPanel];
    [dialog setCanChooseFiles:YES];
    [dialog setCanChooseDirectories:YES];
    
    if ([dialog runModal] == NSModalResponseOK) {
        for (NSURL* url in [dialog URLs]) {
            self.input = [[Input alloc] initWithSampler:self.sampler URL:url];
        }
    }
}

@end
