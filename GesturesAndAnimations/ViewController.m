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
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;


@end

@implementation ViewController

static const CGSize DEFAULT_SIZE = { 40, 40 };

- (IBAction)createRectButton:(UIButton *)sender {
    
    UIView *rect = [UIView new];
    rect.frame = CGRectMake(self.playgroundView.center.x - DEFAULT_SIZE.width,
                            self.playgroundView.center.y - DEFAULT_SIZE.height,
                            DEFAULT_SIZE.width,
                            DEFAULT_SIZE.height);
    
    rect.backgroundColor = [self randomColor];
    [self.playgroundView addSubview:rect];
    [self.blocks addObject:rect];
    
    [rect addGestureRecognizer:self.panGestureRecognizer];
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
    
    self.blocks = [NSMutableArray new];
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragIt:)];
    
}

- (void)dragIt:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.playgroundView];
    //[self.blocks[index] setCenter:touchLocation];
    if ([panGestureRecognizer view] != self.view) {
        [[panGestureRecognizer view] setCenter:touchLocation];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
