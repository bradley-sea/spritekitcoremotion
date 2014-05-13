//
//  MyScene.m
//  blockdrop
//
//  Created by Bradley Johnson on 5/13/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "MyScene.h"
#import <CoreMotion/CoreMotion.h>

@interface MyScene ()

@property (strong,nonatomic) CMMotionManager *manager;
@property (nonatomic) CGVector gravityVector;

@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        [self createPlatform];
        
        self.manager = [[CMMotionManager alloc]init];
        
        if ([self.manager isAccelerometerAvailable])
        {
            [self.manager setAccelerometerUpdateInterval:1/60];
            
            [self.manager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData *data, NSError *error) {
                
                NSLog(@"%f",data.acceleration.x);
                
                self.physicsWorld.gravity = CGVectorMake(data.acceleration.x *5, -5);
            }];
        }


    }
    return self;
}

-(void)createPlatform
{
    SKSpriteNode *platform = [SKSpriteNode spriteNodeWithImageNamed:@"Blue-Planet-Earth"];
    
    platform.position = CGPointMake(CGRectGetMidX(self.frame), 1);
    
    platform.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:110];
    
    platform.physicsBody.affectedByGravity =NO;
    platform.physicsBody.dynamic = NO;
    //platform.physicsBody.categoryBitMask = platformCategory;
    //platform.physicsBody.collisionBitMask = blockCategory;
    
    [self addChild:platform];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
        
        for (UITouch *touch in touches) {
            
            CGPoint location = [touch locationInNode:self];
            
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"SwagCash"];
            
            sprite.size = CGSizeMake(sprite.size.width/3, sprite.size.height/3);
            
            sprite.position = location;
            
            sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(sprite.size.width, sprite.size.height)];
            
            //sprite.physicsBody.categoryBitMask = blockCategory;
            //sprite.physicsBody.contactTestBitMask = winCategory;
            //sprite.physicsBody.collisionBitMask = platformCategory | blockCategory;
            
            [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    
    //self.physicsWorld.gravity = self.gravityVector;
    /* Called before each frame is rendered */
}

@end
