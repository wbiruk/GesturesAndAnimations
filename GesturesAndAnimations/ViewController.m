//
//  ViewController.m
//  GesturesAndAnimations
//
//  Created by Wiktor Biruk on 27/07/15.
//  Copyright (c) 2015 Wiktor Biruk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *blocks; // of UIView
@property (weak, nonatomic) IBOutlet UIView *playgroundView;


@end

@implementation ViewController

static const CGSize DEFAULT_SIZE = { 100, 100 };
static const CGSize MIN_SIZE = { 80, 80 };
static const CGSize MAX_SIZE = { 200, 200 };

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
- (IBAction)createRectButtonTapped:(UIBarButtonItem *)sender {
   
    UIView *rect = [UIView new];
    rect.frame = CGRectMake(0, //self.playgroundView.center.x - DEFAULT_SIZE.width,
                            0, //self.playgroundView.center.y - DEFAULT_SIZE.height,
                            DEFAULT_SIZE.width,
                            DEFAULT_SIZE.height);
    rect.center = self.playgroundView.center;
    
    rect.backgroundColor = [self randomColor];
    [self.playgroundView addSubview:rect];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragIt:)];
    [rect addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIt:)];
    [rect addGestureRecognizer:tapGestureRecognizer];
    
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateIt:)];
    [rect addGestureRecognizer:rotationGestureRecognizer];
    rotationGestureRecognizer.delegate = self;
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchIt:)];
    [rect addGestureRecognizer:pinchGestureRecognizer];
    pinchGestureRecognizer.delegate = self;
    
    [self gestureRecognizer:rotationGestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:pinchGestureRecognizer];
    
}

- (IBAction)removeAllSquaresButtonTapped:(UIBarButtonItem *)sender {
    
    for (UIView *view in self.playgroundView.subviews) {
        [UIView animateWithDuration:1
                         animations:^{
                             //view.transform = CGAffineTransformMakeTranslation((arc4random()%20 - 5)*pow(-1, arc4random()%2) , (arc4random()%20 - 5)*pow(-1, arc4random()%2));
                             view.alpha = 0;
                         }
         ];
        
    }
   
    
}


- (UIColor *)randomColor {
    UIColor *color;
    switch (arc4random()% 10) {
        case 0:
            color = [UIColor blackColor];
            break;
        case 1:
            color = [UIColor blueColor];
            break;
        case 2:
            color = [UIColor orangeColor];
            break;
        case 3:
            color = [UIColor yellowColor];
            break;
        case 4:
            color = [UIColor greenColor];
            break;
        case 5:
            color = [UIColor redColor];
            break;
        case 6:
            color = [UIColor cyanColor];
            break;
        case 7:
            color = [UIColor brownColor];
            break;
        case 8:
            color = [UIColor purpleColor];
            break;
        case 9:
            color = [UIColor grayColor];
            break;
            
        default:
            break;
    }
    
    return color;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //self.blocks = [NSMutableArray new];
    
    
}

- (void)pinchIt:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
    
    CGFloat scale = pinchGestureRecognizer.scale;
    
    if ([pinchGestureRecognizer view].frame.size.width * scale < MAX_SIZE.width &&
        [pinchGestureRecognizer view].frame.size.width * scale > MIN_SIZE.width) {
    
        
        [[pinchGestureRecognizer view] setTransform:CGAffineTransformScale([pinchGestureRecognizer view].transform, scale, scale)];
        pinchGestureRecognizer.scale = 1;
    }
}

- (void)rotateIt:(UIRotationGestureRecognizer *)rotationGestureRecognizer {

    CGFloat rotation = rotationGestureRecognizer.rotation;
    [[rotationGestureRecognizer view] setTransform:CGAffineTransformRotate([rotationGestureRecognizer view].transform, rotation)];
    rotationGestureRecognizer.rotation = 0;
}


- (void)tapIt:(UITapGestureRecognizer *)tapGestureRecognizer {
    
    [[tapGestureRecognizer view] setBackgroundColor:[self randomColor]];
    
}

- (void)dragIt:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.playgroundView];
    [[panGestureRecognizer view] setCenter:touchLocation];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
