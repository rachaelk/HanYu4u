// 
//   SmallStore.m
//   HanYu4u
// 
//   Created by Rachael Keller on 7/26/14.
//   Copyright (c) 2014 Rachael Keller. All rights reserved.
// 

#import "SmallStore.h"
#import "Base_Scene.h"
#include <iostream>



@implementation SmallStore
@synthesize aisle = _aisle;
@synthesize go_back = _go_back;
@synthesize switch_aisle = _switch_aisle;
@synthesize aisle_master;
@synthesize border_frame = _border_frame;
@synthesize input_hanyu0;
@synthesize tap = _tap;
@synthesize store_chat_window = _store_chat_window;
@synthesize border_width = _border_width;
@synthesize border_height = _border_height;
@synthesize store_chat_longer_sentence = _store_chat_longer_sentence;
@synthesize score0 = _score0;


static inline int skRand(int low, int high){
    
    return arc4random()%(high-low) + low;
}


-(void)dismissKeyboard{
    [input_hanyu0 resignFirstResponder];
}

-(int)parse_amounts:(NSString *) s1_amount{
    
    int amount = 0;
    NSArray *chinese_numbers = [[NSArray alloc] initWithObjects: @"十", @"九", @"八", @"七",@"六", @"五", @"四", @"三",@"二", @"一", nil];
    
    NSArray *chinese_amounts = [[NSArray alloc] initWithObjects:  @"十", @"九", @"八", @"七",@"六", @"五", @"四", @"三",@"两", @"一", nil];
    
    if (s1_amount.length > 0){
        // IF INPUT AN AMOUNT:
        
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        if(s1_amount.length == 1)
        {
            NSLog(@"bought <=10");
            
            for (int i = 0; i < chinese_amounts.count; ++i){
                if ([s1_amount isEqualToString:chinese_amounts[i]]){
                    amount = i+1; // 1 is mapped to 0, 2 to 1, etc.
                }
            }
            NSLog(@"%d",amount);
        }
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        else if (s1_amount.length == 2)
        {
            NSString *s1_amount_first_char = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            // ~~~~~~~~~~~~~~~~~
            // Cases eleven, twelve, ..., nineteen:
            if ([s1_amount_first_char isEqualToString: @"十"])
            {
                NSLog(@"bought 10+some");
                // map second character to integers
                amount = 10;
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_second_char isEqualToString:chinese_amounts[i]]){
                        amount += 10-i; // 1 is mapped to 9, 2 to 8, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            // ~~~~~~~~~~~~~~~~~
            // Cases ten, twenty, thirty, ..., ninety
            else if ([s1_amount_second_char isEqualToString: @"十"])
            {
                
                NSLog(@"bought some tens");
                // map first char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
            }
            // ~~~~~~~~~~~~~~~~~
            // Cases one hundred, two hundred, ..., nine hundred
            else if ([s1_amount_second_char isEqualToString: @"百"])
            {
                NSLog(@"bought some hundred");
                // map first char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                
            }
            else
            {
                NSLog(@"buy less ba");
            }
            
        }
        
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        // Cases ninety-five, thirty-two, one hundred sixty (yi bai liu), etc.
        else if (s1_amount.length == 3)
        {
            NSString *s1_amount_first_char = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_amount_third_char = [s1_amount substringWithRange:NSMakeRange(2, 1)];
            
            // ~~~~~~~~~~~~~~~~~
            // Cases fifty-six, thirty-five, etc.:
            if ([s1_amount_second_char isEqualToString: @"十"])
            {
                NSLog(@"bought some tens + some digits");
                // map first and third character to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_amounts[i]]){
                        amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
            }
            // ~~~~~~~~~~~~~~~~~
            // Cases one hundred fifty, two hundred sixty, etc
            else if ([s1_amount_second_char isEqualToString: @"百"])
            {
                if([s1_amount_third_char isEqualToString: @"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    amount += 10;
                }
                else{
                    NSLog(@"bought some hundred + some tens");
                    // map first and third char to integers
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
            }
            else
            {
                NSLog(@"buy less ba");
            }
            
        }
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        // Cases e.g. 103 yi bai ling san, can do more
        else if (s1_amount.length == 4)
        {
            NSString *s1_amount_first_char  = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_amount_third_char  = [s1_amount substringWithRange:NSMakeRange(2, 1)];
            NSString *s1_amount_fourth_char = [s1_amount substringWithRange:NSMakeRange(3, 1)];
            
            // ~~~~~~~~~~~~~~~~~
            // Cases one hundred three, two hundred four, ...,
            if ([s1_amount_second_char isEqualToString: @"百"])
            {
                if ([s1_amount_third_char isEqualToString: @"零"])
                {
                    NSLog(@"bought some hundred + some tens");
                    // map first and third char to integers
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_amounts.count; ++i){
                        if ([s1_amount_fourth_char isEqualToString:chinese_amounts[i]]){
                            amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                else if([s1_amount_third_char isEqualToString:@"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    amount += 10;
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                
                else if ([s1_amount_fourth_char isEqualToString: @"十"])
                {
                    NSLog(@"bought some hundred + some tens");
                    // map first and third char to integers
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                
            }
            else if ([s1_amount_second_char isEqualToString: @"千"]){
                if ([s1_amount_fourth_char isEqualToString: @"百"])
                {
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    
                }
                else if ([s1_amount_third_char isEqualToString: @"零"])
                {
                    if([s1_amount_fourth_char isEqualToString: @"十"]){
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                                amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                            }
                        }
                        amount += 10;
                    }
                    else{
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                                amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                            }
                        }
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                                amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                            }
                        }
                    }
                    
                }
            }
            else if ([s1_amount_second_char isEqualToString: @"万"]){
                if ([s1_amount_fourth_char isEqualToString: @"千"])
                {
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    
                }
                else if([s1_amount_third_char isEqualToString: @"零"] ){
                    if([s1_amount_fourth_char isEqualToString: @"十"]){
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                                amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                            }
                        }
                        amount += 10;
                    }
                }
            }
            else{
                NSLog(@"buy less ba");
            }
            
        }
        
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        // Cases e.g. 125, 13100, 1310
        else if (s1_amount.length == 5){
            NSString *s1_amount_first_char  = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_amount_third_char  = [s1_amount substringWithRange:NSMakeRange(2, 1)];
            NSString *s1_amount_fourth_char = [s1_amount substringWithRange:NSMakeRange(3, 1)];
            NSString *s1_amount_fifth_char  = [s1_amount substringWithRange:NSMakeRange(4, 1)];
            
            // ~~~~~~~~~~~~~~~~~
            // Cases one hundred three, two hundred four, ...,
            if ([s1_amount_second_char isEqualToString: @"百"]){
                // map first char -> number of hundreds
                // map third char -> number of tens
                // fourth -> shi
                // map fifth char -> number of singles
                
                
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                
                NSLog(@"%d",amount);
                
                
            }
            if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_fourth_char isEqualToString:@"百"]){
                
                // x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            
            
            if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_fourth_char isEqualToString:@"千"] ){
                
                
                
                // x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                
                NSLog(@"%d",amount);
                
            }
            if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_third_char isEqualToString:@"零"]){
                
                
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                if([s1_amount_fourth_char isEqualToString: @"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    amount += 10;
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                else{
                    
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                NSLog(@"%d",amount);
                
            }
            else if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_third_char isEqualToString:@"零"]){
                if([s1_amount_fourth_char isEqualToString: @"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    amount += 10;
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                else{
                    // x10000 + y1000 + z100 = 13,100 and etc.
                    NSLog(@"bought some hundred + some tens");
                    // map first and third char to integers
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
            }
            else if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_fourth_char isEqualToString:@"百"]& [s1_amount_fifth_char isEqualToString:@"十"]){
                
                // x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                amount += 10; // from the final shi
                NSLog(@"%d",amount);
            }
            else if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_third_char isEqualToString:@"零"]){
                
                // x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
            }
            else{
                NSLog(@"buy less ba");
            }
        }
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        // Cases e.g. 125, 13100, 1310 三千四百五十, 三万四千五百
        else if (s1_amount.length == 6){
            NSString *s1_amount_first_char  = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_amount_third_char  = [s1_amount substringWithRange:NSMakeRange(2, 1)];
            NSString *s1_amount_fourth_char = [s1_amount substringWithRange:NSMakeRange(3, 1)];
            NSString *s1_amount_fifth_char  = [s1_amount substringWithRange:NSMakeRange(4, 1)];
            NSString *s1_amount_sixth_char  = [s1_amount substringWithRange:NSMakeRange(5, 1)];
            
            // ~~~~~~~~~~~~~~~~~
            // Cases one hundred three, two hundred four, ...,
            if (([s1_amount_second_char isEqualToString: @"千"]) & ([s1_amount_fourth_char isEqualToString: @"百"])& ([s1_amount_sixth_char isEqualToString: @"十"])){
                // map first char -> number of hundreds
                // map third char -> number of tens
                // fourth -> shi
                // map fifth char -> number of singles
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
            }
            else if (([s1_amount_second_char isEqualToString: @"万"]) & ([s1_amount_fourth_char isEqualToString: @"千"])& ([s1_amount_sixth_char isEqualToString: @"百"])){
                // map first char -> number of hundreds
                // map third char -> number of tens
                // fourth -> shi
                // map fifth char -> number of singles
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                
                
                NSLog(@"%d",amount);
                
                
            }
            else if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_fourth_char isEqualToString:@"百"]){
                
                // x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                if([s1_amount_fifth_char isEqualToString:@"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    amount += 10; // just one shi
                    for (int i = 0; i < chinese_amounts.count; ++i){
                        if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                else{
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_amounts.count; ++i){
                        if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                NSLog(@"%d",amount);
                
            }
            
            // 1035: 一千零三十五
            else if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_third_char isEqualToString:@"零"]){
                
                // x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            else if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_fourth_char isEqualToString:@"千"]){
                
                // x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            else if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_third_char isEqualToString:@"零"]){
                
                // x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            
            else if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_fourth_char isEqualToString:@"千"]& [s1_amount_fifth_char isEqualToString:@"零"]){
                
                // x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            
            else if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_third_char isEqualToString:@"零"]){
                
                // x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            else if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_fourth_char isEqualToString:@"百"]& [s1_amount_fifth_char isEqualToString:@"零"]){
                
                // x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]] || [s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            else{
                NSLog(@"buy less ba");
            }
            
        }
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        // Cases e.g. 三千四百五十六
        else if (s1_amount.length == 7){
            NSString *s1_amount_first_char  = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_amount_third_char  = [s1_amount substringWithRange:NSMakeRange(2, 1)];
            NSString *s1_amount_fourth_char = [s1_amount substringWithRange:NSMakeRange(3, 1)];
            NSString *s1_amount_fifth_char  = [s1_amount substringWithRange:NSMakeRange(4, 1)];
            NSString *s1_amount_sixth_char = [s1_amount substringWithRange:NSMakeRange(5, 1)];
            NSString *s1_amount_seventh_char  = [s1_amount substringWithRange:NSMakeRange(6, 1)];
            
            // ~~~~~~~~~~~~~~~~~
            // Cases one hundred three, two hundred four, ...,
            if ([s1_amount_second_char isEqualToString: @"百"]){
                // map first char -> number of hundreds
                // map third char -> number of tens
                // fourth -> shi
                // map fifth char -> number of singles
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]] || [s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_amounts[i]]){
                        amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
                
            }
            // Cases e.g. 三千四百五十六
            if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_fourth_char isEqualToString:@"百"]){
                
                // x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_amounts[i]]){
                        amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                if([s1_amount_sixth_char isEqualToString:@"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_seventh_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                NSLog(@"%d",amount);
                
            }
            if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_fourth_char isEqualToString:@"千"] && [s1_amount_sixth_char isEqualToString:@"百"]){
                
                // x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                amount += 10;
                NSLog(@"%d",amount);
                
            }
            
            
            if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_fourth_char isEqualToString:@"千"]& [s1_amount_fifth_char isEqualToString:@"零"]){
                if([s1_amount_sixth_char isEqualToString: @"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    amount += 10;
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_seventh_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                else{
                    // x10000 + y1000 + z100 = 13,100 and etc.
                    NSLog(@"bought some hundred + some tens");
                    // map first and third char to integers
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                            amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_amounts[i]]){
                            amount += (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
            }
            
            else{
                NSLog(@"buy less ba");
            }
            
        }
        // Cases e.g. 三千四百五十六
        else if (s1_amount.length == 8){
            NSString *s1_amount_first_char  = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_amount_third_char  = [s1_amount substringWithRange:NSMakeRange(2, 1)];
            NSString *s1_amount_fourth_char = [s1_amount substringWithRange:NSMakeRange(3, 1)];
            NSString *s1_amount_fifth_char  = [s1_amount substringWithRange:NSMakeRange(4, 1)];
            NSString *s1_amount_sixth_char = [s1_amount substringWithRange:NSMakeRange(5, 1)];
            NSString *s1_amount_seventh_char  = [s1_amount substringWithRange:NSMakeRange(6, 1)];
            NSString *s1_amount_eighth_char  = [s1_amount substringWithRange:NSMakeRange(7, 1)];
            
            // ~~~~~~~~~~~~~~~~~
            // Cases one hundred three, two hundred four, ...,
            if ([s1_amount_second_char isEqualToString: @"万"] && [s1_amount_fourth_char isEqualToString:@"千"]){
                
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]] || [s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_amounts[i]]||[s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                if([s1_amount_fifth_char isEqualToString:@"零"] && [s1_amount_seventh_char isEqualToString:@"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_eighth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                else if([s1_amount_sixth_char isEqualToString:@"百"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    if([s1_amount_eighth_char isEqualToString:@"十"]){
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_seventh_char isEqualToString:chinese_numbers[i]]){
                                amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                            }
                        }
                    }
                    else if([s1_amount_seventh_char isEqualToString:@"零"]){
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_eighth_char isEqualToString:chinese_numbers[i]]){
                                amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                            }
                        }
                    }
                }
                NSLog(@"%d",amount);
                
            }
            if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_fourth_char isEqualToString:@"百"]){
                
                // x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_third_char isEqualToString:@"零"]&&[s1_amount_fifth_char isEqualToString:@"百"]&&[s1_amount_seventh_char isEqualToString:@"十"]){
                
                // x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_eighth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_third_char isEqualToString:@"零"]&&[s1_amount_fifth_char isEqualToString:@"百"]&&[s1_amount_seventh_char isEqualToString:@"十"]){
                
                // x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_eighth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            
            
            if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_fourth_char isEqualToString:@"千"] &&[s1_amount_sixth_char isEqualToString:@"百"] && [s1_amount_eighth_char isEqualToString:@"十"] ){
                
                // x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_seventh_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            
            if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_fourth_char isEqualToString:@"千"] &&[s1_amount_sixth_char isEqualToString:@"百"] && [s1_amount_seventh_char isEqualToString:@"零"] ){
                
                // 
                // map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_amounts[i]]){
                        amount += (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_eighth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            
            else{
                NSLog(@"buy less ba");
            }
            
        }
        else if (s1_amount.length == 9){
            NSString *s1_amount_first_char  = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_amount_third_char  = [s1_amount substringWithRange:NSMakeRange(2, 1)];
            NSString *s1_amount_fourth_char = [s1_amount substringWithRange:NSMakeRange(3, 1)];
            NSString *s1_amount_fifth_char  = [s1_amount substringWithRange:NSMakeRange(4, 1)];
            NSString *s1_amount_sixth_char = [s1_amount substringWithRange:NSMakeRange(5, 1)];
            NSString *s1_amount_seventh_char  = [s1_amount substringWithRange:NSMakeRange(6, 1)];
            NSString *s1_amount_eighth_char  = [s1_amount substringWithRange:NSMakeRange(7, 1)];
            NSString *s1_amount_ninth_char  = [s1_amount substringWithRange:NSMakeRange(8, 1)];
            
            // ~~~~~~~~~~~~~~~~~
            // Cases one hundred three, two hundred four, ...,
            if ([s1_amount_second_char isEqualToString: @"万"] && [s1_amount_fourth_char isEqualToString:@"千"]){
                
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*10000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_amounts[i]]){
                        amount += (10-i)*1000; // 1 is mapped to 0, 2 to 1, etc.
                    }
                }
                
                if([s1_amount_sixth_char isEqualToString:@"百"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*100; // 1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    if([s1_amount_eighth_char isEqualToString:@"十"]){
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_seventh_char isEqualToString:chinese_numbers[i]]){
                                amount += (10-i)*10; // 1 is mapped to 0, 2 to 1, etc.
                            }
                        }
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_ninth_char isEqualToString:chinese_numbers[i]]){
                                amount += (10-i); // 1 is mapped to 0, 2 to 1, etc.
                            }
                        }
                    }
                }
            }
        }
        else{
            NSLog(@"ok buy less");
            // ^do above in text box
        }
        
    }// if block end for length of amount > 0
    
    // if amount string is zero, user meant 1!
    
    else{
        NSLog(@"default at 1!");
        // ^do above in text box
        amount = 1;
    }
    NSLog(@"parser parsed amount:");
    NSLog(@"%d",amount);
    return amount;
}



// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(void)handle_shopping:(NSString *) purchase_request{
    NSLog(@"girls just wanna have fun~~");
    
    NSRange r= [purchase_request rangeOfString:@"个"]; // loc of measure word
    // r.location
    if (r.location != NSNotFound){
        NSString *s1 = [purchase_request substringWithRange:NSMakeRange(0, r.location)]; // second argument of NSMakeRange is length
        NSString *s2 = [purchase_request substringWithRange:NSMakeRange(r.location+1, (purchase_request.length-1)-r.location)];
        
        // no using unichar, can't handle the encoding for symbols
        NSString *s1_begin = [s1 substringWithRange:NSMakeRange(0, 1)];
        
        int amount = 0; // amount!!
        // First extract the number
        if([s1_begin isEqualToString:@"我"]){
            
            NSString *s1_second_char = [s1 substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_third_char = [s1 substringWithRange:NSMakeRange(2, 1)];
            
            
            if( // handle two-character combos before the number:
               ( ([s1_second_char isEqualToString: @"想"]) && ([s1_third_char isEqualToString: @"要"]))
                || (([s1_second_char isEqualToString: @"想"]) && ([s1_third_char isEqualToString: @"买"]))
                || (([s1_second_char  isEqualToString: @"要"]) && ([s1_third_char isEqualToString: @"买"]))
                )
            {
                NSString *s1_amount = [s1 substringWithRange:NSMakeRange(3, (s1.length)-3)];// length - 3 prev chars
                amount = [self parse_amounts:s1_amount];
                NSLog(@"out of the woooooooods~");
                NSLog(@"%d",amount);
         }
        }
        if (!([s2 rangeOfString:@"。"].location == NSNotFound)){
            
            s2 = [s2 substringToIndex:s2.length-2];
        }
        
        
        for(int i = 0; i < item_listing.words_by_image.size(); ++i){
            for (int j = 0; j < item_listing.words_by_image[i].size(); ++j){
                if (s2 == [NSString stringWithCString:item_listing.words_by_image[i][j].character .c_str()
                                             encoding:[NSString defaultCStringEncoding]]){
                    if([GameState sharedInstance].score > amount * item_listing.words_by_image[i][j].price){
                       [GameState sharedInstance].score = [GameState sharedInstance].score - item_listing.words_by_image[i][j].price;
                       [GameState sharedInstance].grocery_items = [GameState sharedInstance].grocery_items + amount;
                       [_score0 setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
                    }
                    else{
                        NSLog(@"qian bu gou");
                    }

                }
            }
        }
        
    }
        
    else{
        _store_chat_window.hidden = true;
        _store_chat_longer_sentence.hidden = false;
        }
    
   
}


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(void)show_chinese_translation:(NSString*)chinese_characters pinyin:(NSString*)pinyin price:(float)price touch_loc:(CGPoint)touchLocationInView{
    
    for (UIView *subview in [self.view subviews]) {
        //  Only remove the subviews with tag not equal to 1
        if (subview.tag == 9) {
            [subview removeFromSuperview];
        }
    }
    
    UILabel *explanationField = [[UILabel alloc] initWithFrame:self.frame];
    explanationField.tag = 9;
    [explanationField setFont:[UIFont fontWithName:@"EuphemiaUCAS-Bold" size:8.0f]];
    explanationField.textColor=[UIColor whiteColor];
    explanationField.backgroundColor=[UIColor blackColor];
    explanationField.alpha = 0.8;
    explanationField.numberOfLines = 4;
    // string of explanation~~~~~~~~~~~
    NSString *str1=chinese_characters;
    NSString *str2= pinyin;
    NSString *str3 = [NSString stringWithFormat:@"%.1f", price];
    NSString *str4 = @"快";
    NSString *explanation=[NSString stringWithFormat:@"%@\n%@\n%@%@\n",str1,str2, str3, str4];
    // ~~~~~~~~~~~~~~~~~~~end explanation
    explanationField.text = explanation;
    CGPoint mid = CGPointMake( CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    explanationField.adjustsFontSizeToFitWidth = true;
    explanationField.textAlignment = NSTextAlignmentCenter;
    CGPoint positionInScene = touchLocationInView;
    
    CGFloat xPosition = positionInScene.x - 0.15*(positionInScene.x);
    CGFloat yPosition = positionInScene.y + 0.04*(positionInScene.y + mid.y) ;
    
    CGRect labelFrame = explanationField.frame;
    [explanationField adjustsFontSizeToFitWidth ];
    explanationField.frame = labelFrame;
    [explanationField sizeToFit];
    
    CGRect frame = explanationField.frame;
    frame.origin.y= yPosition;// pass the cordinate which you want
    frame.origin.x= xPosition;// pass the cordinate which you want
    explanationField.frame= frame;
    
    
    explanationField.layer.borderColor = [UIColor redColor].CGColor;
    explanationField.layer.borderWidth = 1.0;
    
    [self.view addSubview:explanationField];

}


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:0];
        
        
        SKSpriteNode *geek_man = [SKSpriteNode spriteNodeWithImageNamed:@"geekWin_man"];
        geek_man.position = CGPointMake(CGRectGetMaxX(self.frame)-50, CGRectGetMinY(self.frame)+70);
        [geek_man setScale:0.5];

        [self addChild:geek_man];
   
    
    }
    return self;
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(void)didMoveToView:(SKView *)view {
    
    
    // SET Keyboard for the lesson:
    
    NSMutableArray *k =[[NSMutableArray alloc] initWithObjects: @" ", @" ", @" ",@"我", @"想", @"要", @"买", @"你", @" ",  @" ",  @" ", @" ", @"一", @"二", @"两", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @"百", @"个", @"零", @"在", @"喝", @"。", @" ", nil];
    
    NSMutableArray *kshift = [[NSMutableArray alloc] initWithObjects: @" ", @" ", @" ",@"咖", @"视", @"乐", @"吃", @"看", @" ",  @" ",  @" ", @" ", @" ", @"书", @"早", @"音", @"电", @"听", @"他", @"我", @" ", @" ", @" ", @"啡", @"饭", @"你", @"在", @"喝", @"。", @" ", nil];
    
    NSMutableArray *kalt = [[NSMutableArray alloc] initWithObjects: @" ", @" ", @" ",@"咖", @"视", @"乐", @"吃", @"看", @" ",  @" ",  @" ", @" ", @" ", @"书", @"早", @"音", @"电", @"听", @"他", @"我", @" ", @" ", @" ", @"啡", @"饭", @"你", @"在", @"喝", @"。", @" ", nil];
    
    [GameState sharedInstance].keyboard_characters = k;
    [GameState sharedInstance].keyboard_characters_shift = kshift;
    [GameState sharedInstance].keyboard_characters_alt = kalt;
    
    
    _customKeyboard = [[PMCustomKeyboard alloc] init];
    
    
    
    int shifted_y = 10;
    double pad = 5;
    double padding = 0.2;
    
    // scene controller~~~~~~~~~~~~
    _go_back = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
    _go_back.name = @"go_back";
    _go_back.fontSize = 12;
    _go_back.text = @"Go Back";
    _go_back.zPosition = 1;
    _go_back.fontColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1];
    _go_back.position = CGPointMake(CGRectGetMinX(self.frame)+50, CGRectGetMinY(self.frame)+20);
    SKSpriteNode *button_dialog = [SKSpriteNode spriteNodeWithImageNamed:@"return"];
    button_dialog.xScale = 0.8;
    button_dialog.yScale = 0.55;
    button_dialog.zPosition = 0.5;
    button_dialog.position = CGPointMake(_go_back.position.x,_go_back.position.y+ padding* _go_back.frame.size.height);
    
    [self addChild:button_dialog];
    [self addChild: _go_back];
    // ~~~~~~~~~~~~~~~~scene controller
    
    
    // aisle controller~~~~~~~~~~~~
    _switch_aisle= [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
    _switch_aisle.name = @"switch_aisle";
    _switch_aisle.fontSize = 12;
    _switch_aisle.text = @"换了吧～";
    _switch_aisle.zPosition = 1;
    _switch_aisle.fontColor = [SKColor colorWithRed:0 green:0 blue:1 alpha:1];
    _switch_aisle.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame)+20);
    SKSpriteNode *button_aisle = [SKSpriteNode spriteNodeWithImageNamed:@"return"];
    button_aisle.xScale = 0.8;
    button_aisle.yScale = 0.55;
    button_aisle.zPosition = 0.5;
    button_aisle.position = CGPointMake(_switch_aisle.position.x,_switch_aisle.position.y+ padding* _switch_aisle.frame.size.height);
    
    [self addChild:button_aisle];
    [self addChild: _switch_aisle];
    // ~~~~~~~~~~~~~~~~aisle controller
    
    
    _store_chat_window = [SKSpriteNode spriteNodeWithImageNamed:@"store_chat_box"];
    [_store_chat_window setScale:0.5];
    _store_chat_window.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) - (2*pad)*shifted_y);
    _store_chat_window.hidden = true;
    
    _store_chat_longer_sentence = [SKSpriteNode spriteNodeWithImageNamed:@"imagesd/chat_longer_sentence"];
    [_store_chat_longer_sentence setScale:0.5];
    _store_chat_longer_sentence.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) - (2*pad)*shifted_y);
    _store_chat_longer_sentence.hidden = true;
    
    
    
    input_hanyu0 = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width/4,0.5*(CGRectGetMinY(self.frame)+0.5*CGRectGetMaxY(self.frame) ), 150, 30)];
    input_hanyu0.borderStyle = UITextBorderStyleRoundedRect;
    input_hanyu0.textColor = [UIColor blackColor];
    input_hanyu0.font = [UIFont systemFontOfSize:12.0];
    input_hanyu0.placeholder = @"回答吧!加油";
    input_hanyu0.backgroundColor = [UIColor whiteColor];
    input_hanyu0.autocorrectionType = UITextAutocorrectionTypeNo;
    input_hanyu0.tag = 7;
    input_hanyu0.clearButtonMode = UITextFieldViewModeWhileEditing;
    [input_hanyu0 setDelegate:self];
    [input_hanyu0 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    input_hanyu0.hidden = true;
    
    [_customKeyboard setTextView:input_hanyu0];
    
    // the following block makes it such that tapping outside the textfield dismisses the keyboard~~~
    [self.view addSubview:input_hanyu0];
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    _tap.numberOfTapsRequired = 2; // if this is not specified, computer gets confused-- can't tell what is purposeful click
    [self.view addGestureRecognizer:_tap];

    [_score0 setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
    
    /*
    SKSpriteNode *sn2 = [SKSpriteNode spriteNodeWithImageNamed:@"24hour_store"];
    sn2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    sn2.xScale = 0.5;
    sn2.yScale = 0.5;
    sn2.zPosition = -0.7;
    sn2.name = @"BACKGROUND2";
    [self addChild:sn2];
    */
    
    SKSpriteNode *sn = [SKSpriteNode spriteNodeWithImageNamed:@"imagesd/beijing_street"];
    sn.position = CGPointMake(CGRectGetMinX(self.frame)+30, CGRectGetMidY(self.frame)-pad*shifted_y );
    [sn setScale:SKSceneScaleModeAspectFill];
    sn.zPosition = -1;
    sn.name = @"BACKGROUND";
    [self addChild:sn];
    
    SKSpriteNode *fruits = [SKSpriteNode spriteNodeWithImageNamed:@"imagesd/fruits"];
    [fruits setScale:0.5];
    fruits.zPosition = 0.5;
    fruits.position =  CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    fruits.name = @"fruits";
    fruits.hidden = true;
    
    _border_frame = [SKSpriteNode spriteNodeWithImageNamed:@"imagesd/frame"];
    [_border_frame setScale:0.55];
    _border_frame.zPosition = 1;
    _border_frame.name = @"frame";
    [self addChild:_border_frame];
    _border_width = _border_frame.size.width;
    _border_height = _border_frame.size.height;
    
    
    
    SKSpriteNode *stick_figure = [SKSpriteNode spriteNodeWithImageNamed:@"imagesd/stick_figure"];
    // [sn setScale:SKSceneScaleModeAspectFill * 0.2];
    [stick_figure setScale: 0.45];
    stick_figure.zPosition = 1;
    stick_figure.position = CGPointMake(CGRectGetMinX(self.frame)+30, CGRectGetMidY(self.frame)-pad*shifted_y );
    stick_figure.name = @"stick_figure";
    
    _store_chat_window.position = CGPointMake(stick_figure.position.x + 0.8*stick_figure.frame.size.width, stick_figure.position.y + 0.5*stick_figure.frame.size.height);
    _store_chat_window.zPosition = 1.2;
    _store_chat_longer_sentence.position = CGPointMake(stick_figure.position.x + 0.8*stick_figure.frame.size.width, stick_figure.position.y + 0.5*stick_figure.frame.size.height);
    _store_chat_longer_sentence.zPosition = 1.2;
    
    [self addChild:stick_figure];
    self.backgroundColor = [SKColor colorWithRed:1 green:0 blue:1 alpha:1.0];
    self.anchorPoint = CGPointZero;
    self.aisle_master = [SKNode node];
    aisle_master.name = @"aisle_master";
    
    
    

    SKSpriteNode *cucumber = [SKSpriteNode spriteNodeWithImageNamed:@"imagesd/cucumber"];
    [cucumber setScale:0.5];
    cucumber.position =  CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    cucumber.name = @"cucumber";
    cucumber.hidden = false;
    
    _border_frame.position =  CGPointMake(cucumber.position.x, cucumber.position.y);
    _border_frame.xScale = 1.8*(0.5*cucumber.frame.size.width -cucumber.frame.origin.x )  / (_border_frame.frame.size.width);
    _border_frame.yScale = 1.9*(0.5*cucumber.frame.size.height -cucumber.frame.origin.y ) / (_border_frame.frame.size.height);
    
    
    SKSpriteNode *wangfujin_sign = [SKSpriteNode spriteNodeWithImageNamed:@"imagesd/24hour_sign"];
    // [sn setScale:SKSceneScaleModeAspectFill * 0.2];
    [wangfujin_sign setScale: 0.35];
    wangfujin_sign.zPosition = -0.2;
    wangfujin_sign.position = CGPointMake(CGRectGetMidX(self.frame), 0.5*(CGRectGetMaxY(self.frame) + ( _border_frame.position.y)) );
    wangfujin_sign.name = @"wangfujin_sign";
    [self addChild:wangfujin_sign];
    
    SKSpriteNode *eggplant = [SKSpriteNode spriteNodeWithImageNamed:@"imagesd/eggplant"];
    [eggplant setScale:0.5];
    eggplant.position =  CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    eggplant.name = @"eggplant";
    eggplant.hidden = true;
    
    //  Score
    // ~~~~~~~~~~~~~~~~~~~~~
    _score0 = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    _score0.fontSize = 12;
    _score0.fontColor = [SKColor redColor];
    _score0.position = CGPointMake(self.frame.origin.x + 0.9*self.frame.size.width,self.frame.origin.y + 0.8*self.frame.size.height);
    [_score0 setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
    [self addChild:_score0];
    
    // to be put next to score
    SKLabelNode *currency = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    currency.fontSize = 14;
    currency.fontColor = [SKColor redColor];
    [currency setText:@"RMB (快/元)"];
    currency.position = CGPointMake(0.5*(_score0.position.x + _score0.frame.size.width + self.frame.size.width),_score0.position.y);
    [self addChild:currency];
    
    
    SKSpriteNode *lettuce = [SKSpriteNode spriteNodeWithImageNamed:@"imagesd/lettuce"];
    [lettuce setScale:0.5];
    lettuce.position =  CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    lettuce.name = @"lettuce";
    lettuce.hidden = true;
    
    
    
    _aisle = 1; // controller for switch between scenes, node name isn't enough because overlapping images
    
    [self addChild:_store_chat_window];
    [self addChild:_store_chat_longer_sentence];
    [aisle_master addChild:fruits];
    [aisle_master addChild:cucumber];
    [aisle_master addChild:eggplant];
    [aisle_master addChild:lettuce];
    [self addChild:aisle_master];

    
    
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        
        NSArray *nodes= [self nodesAtPoint:[touch locationInNode:self]];
        CGPoint touchLocationInView = [touch locationInView:self.scene.view];

        
        for (SKNode *node in nodes) {
            
            if( [node.name isEqualToString:@"go_back"]){
                
                for (UIView *subview in [self.view subviews]) {
                    
                    if (subview.tag == 7 || subview.tag == 9) {
                    [subview removeFromSuperview];
                     }
                }
                
                
                SKView *spriteView = (SKView *) self.view;
                Base_Scene *newScene = [Base_Scene sceneWithSize:spriteView.bounds.size];
                [spriteView presentScene:newScene];
                
            }

            
            if( [node.name isEqualToString:@"switch_aisle"]){
                
                for (UIView *subview in [self.view subviews]) {
                    
                    if (subview.tag == 7 || subview.tag == 9) {
                    [subview removeFromSuperview];
                     }
                }
                NSArray *aisles = self.aisle_master.children;
                SKSpriteNode *sprite_prev = aisles[_aisle];
                sprite_prev.hidden = true;
                int ref = skRand(0, [aisles count]);
                SKSpriteNode *sprite = aisles[ref];
                if (ref == _aisle){
                    ref = (ref + 1)%[aisles count];// go to next in 'stack' >>don't want to repeat
                }
                sprite = aisles[ref];
                sprite.hidden = false;
                
                _border_frame.position =  CGPointMake(sprite.position.x, sprite.position.y);
                _border_frame.xScale = 1.8*(0.5*sprite.frame.size.width - sprite.frame.origin.x )  /(_border_width);
                _border_frame.yScale = 1.9*(0.5*sprite.frame.size.height - sprite.frame.origin.y )/ (_border_height);

                
                _aisle = ref;
                        
            }
            
            
            if( [node.name isEqualToString:@"stick_figure"]){
                
                for (UIView *subview in [self.view subviews]) {
                    
                    if (subview.tag == 9) {
                        [subview removeFromSuperview];
                    }
                }
                
                _store_chat_window.hidden = false;
                input_hanyu0.hidden = false;
                
                
            }
            
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            if((_aisle == 0) && ([node.name isEqualToString: @"fruits"]) ){
                
                
                _store_chat_window.hidden = true;
                _store_chat_longer_sentence.hidden = true;
                std::vector<ChineseWord> frame_words = item_listing.words_by_image[_aisle];
                
                
                for (UIView *subview in [self.view subviews]) {
                    //  Only remove the subviews with tag not equal to 1
                    if (subview.tag == 9) {
                        [subview removeFromSuperview];
                    }
                }
                
                
                // want to have the picture divided up so that can give character upon touch
                // original pic's dimensions:
                CGFloat o_tw = 490.0f;
                CGFloat o_th = 368.0f;
                
                // size of pic in the view:
                CGFloat s_tw = node.frame.size.width;
                CGFloat s_th = node.frame.size.height;
                
                
                // position relative to frame of the pic:
                CGPoint positionInScene = [node.parent convertPoint:node.position
                                                          fromNode:node.parent];

                // the pic is centered by its midpoint
                //   --> synthetically changing the 'origin' if you will so that I can use coordinates based
                //       at the bottom left-hand corner of original image
                CGFloat origin_x =  positionInScene.x - 0.5*s_tw ;
                CGFloat origin_y =  positionInScene.y - 0.5*s_th;

                // PROBLEM:
                //     Based on axis with top-leftmost corner as (0,0). (In general won't matter)
                //     Sizes ORIGINAL PIC's total width o_tw, total height o_th; scaled image's s_tw, s_th
                //     Take element p:
                //         p's width p_w, height p_h
                // 
                //          /                    \  |  s_tw   0    |
                //         | p_w/o_tw , p_h/o_th  | |   0    s_th  |
                //          \                    /
                // 
                
                // flipping:
                //     take distance between point and origin, then origin - (that distance)
                // FORMAT FOR ZHONGWEN.TXT:
                //   character pinyin origin_x origin_y width height price english
                
                // pears:
                CGFloat pear_width = (110.0f/o_tw) * s_tw;
                CGFloat pear_height = (105.0f/o_th) * s_th;
                
                // limes:
                CGFloat lime_width1 =  (80.0f/o_tw) * s_tw;
                CGFloat lime_height1 = (89.0f/o_th) * s_th;
                CGFloat lime_width2 =  (104.0f/o_tw) * s_tw;
                CGFloat lime_height2 = (88.0f/o_th) * s_th;
                
                // bananas:
                CGFloat banana_width =  (208.0f/o_tw) * s_tw;
                CGFloat banana_height = (139.0f/o_th) * s_th;
                
                
                // oranges:
                CGFloat orange_width1 =  (153.0f/o_tw)* s_tw;
                CGFloat orange_height1 = (875.0f/o_th) * s_th;
                CGFloat orange_width2 =  (153.0f/o_tw)* s_tw;
                CGFloat orange_height2 = (240.0f/o_th) * s_th;
                
                // apples:
                CGFloat apple_width1 =  (46.0f/o_tw) * s_tw;
                CGFloat apple_height1 = (133.0f/o_th) * s_th;
                CGFloat apple_width2 =  (98.0f/o_tw) * s_tw;
                CGFloat apple_height2 = (139.0f/o_th) * s_th;
                
                CGFloat lemon_width = (133.0f/o_tw) * s_tw;
                CGFloat lemon_height = (133.0f/o_th) * s_th;
                
                
                
                // PROBLEM:
                //    Now locate within the frame. Then can partition grid superficially.
                //    Given corner locations in original picture, determine location.
                //      -->Same procedure. Just need origin bc have width, height.
                
                // buffer for the anomalies (don't reach bottom of frame, needed the mod to touchLocationInView.y)
                CGFloat buffer = 0.5*s_th;
                
                // pears:
                CGFloat pear_origin_x = (0/o_tw) * s_tw + origin_x;
                CGFloat pear_origin_y =  origin_y + ((0/o_th) * s_th) + buffer ;

                // limes:
                CGFloat lime_origin_x1 = (0/o_tw) * s_tw + origin_x;
                CGFloat lime_origin_y1 = origin_y +((126.0f/o_th) * s_th );
                CGFloat lime_origin_x2 = (263.0f/o_tw) * s_tw + origin_x;
                CGFloat lime_origin_y2 = origin_y +((0/o_th) * s_th) + buffer;
                
                
                // bananas:
                CGFloat banana_origin_x = (122.0f/o_tw) * s_tw + origin_x;
                CGFloat banana_origin_y = origin_y + ((190/o_th) * s_th - 0.5f*s_th);
                
                
                // oranges:
                CGFloat orange_origin_x1 =  (104/o_tw) * s_tw + origin_x;
                CGFloat orange_origin_y1 =  origin_y + ((0/o_th) * s_th );
                CGFloat orange_origin_x2 =  (214/o_tw) * s_tw + origin_x;
                CGFloat orange_origin_y2 =  origin_y + ((88/o_th) * s_th );
                
                // apples:
                CGFloat apple_origin_x1 = (49/o_tw)* s_tw + origin_x;
                CGFloat apple_origin_y1 = origin_y + ((50/o_th) * s_th );
                CGFloat apple_origin_x2 = (0/o_tw) * s_tw + origin_x;
                CGFloat apple_origin_y2 = origin_y + ((228/o_th) * s_th - 0.5*s_th);
                
                CGFloat lemon_origin_x = (367.0f/o_tw) * s_tw + origin_x;
                CGFloat lemon_origin_y = origin_y + 0+ buffer;
                
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                
                // this following CGFloat came from hours of banging my head over pears and limes
                // being flipped (for whatever reason).
                // Actually, reason:
                //      The touchLocationInView.y was way higher than the positions of the fruits within the frame.
                //      So, the x is pared down to the frame, but the y isn't.
                //           HOWEVER: This only is a problem for a few of them (pear, lime2).
                CGFloat location_in_frame_y = touchLocationInView.y - node.frame.origin.y  + 0.5*s_th;
                
                
                bool starter = false;
                if(starter == true){
                    ;
                }
                
                else if(  (touchLocationInView.x >= pear_origin_x) &&
                          (touchLocationInView.x <= (pear_origin_x + pear_width) ) &&
                          (location_in_frame_y >= pear_origin_y)
                          && (location_in_frame_y <= (pear_height +pear_origin_y) ) )
                   {
                       [self show_chinese_translation:@"梨子" pinyin:@"lízi" price:frame_words[0].price touch_loc: touchLocationInView];
                       

                }

                else if( ((touchLocationInView.x >= lime_origin_x1 )
                        && (touchLocationInView.x <= (lime_origin_x1 + lime_width1))
                        && (touchLocationInView.y >= lime_origin_y1)
                        && (touchLocationInView.y <= (lime_origin_y1 + lime_height1)) )
                        ||
                   ( (touchLocationInView.x >= lime_origin_x2) &&
                     (touchLocationInView.x <= (lime_origin_x2 + lime_width2))&&
                     (location_in_frame_y >= lime_origin_y2) &&
                     (location_in_frame_y <= (lime_origin_y2 + lime_height2)) )  )
       
                {
                    [self show_chinese_translation:@"酸橙" pinyin:@"suān chéng" price:frame_words[1].price touch_loc: touchLocationInView];

                    
                }

                else if((touchLocationInView.x >= banana_origin_x) &&
                   (touchLocationInView.x <= (banana_origin_x + banana_width)) &&
                   (touchLocationInView.y >= banana_origin_y) &&
                   (touchLocationInView.y <= (banana_origin_y+banana_height))){
                    
                    [self show_chinese_translation:@"香蕉" pinyin:@"xiāngjiāo" price:frame_words[2].price touch_loc: touchLocationInView];

 
                }

                else if(
                   (
                    (touchLocationInView.x >= orange_origin_x1 )
                    && (touchLocationInView.x <= (orange_origin_x1 + orange_width1))
                    &&(touchLocationInView.y >= orange_origin_y1)
                    && (touchLocationInView.y <= (orange_origin_y1+orange_height1))  )
                          ||
                    ( (touchLocationInView.x >= orange_origin_x2) &&
                     (touchLocationInView.x <= (orange_origin_x2 + orange_width2))&&
                     (location_in_frame_y >= orange_origin_y2) &&
                     (location_in_frame_y <= (orange_origin_y2+orange_height2))   )
                   )
                
                {
                    [self show_chinese_translation:@"橙子" pinyin:@"chéng zi" price:frame_words[3].price touch_loc: touchLocationInView];

                    
                   }

                
                else if(((touchLocationInView.x >= apple_origin_x1 )
                       && (touchLocationInView.x <= (apple_origin_x1 + apple_width1))
                       &&(touchLocationInView.y >= apple_origin_y1)
                       && (touchLocationInView.y <= (apple_origin_y1+apple_height1)))
                        ||
                   ( (touchLocationInView.x >= apple_origin_x2) &&
                     (touchLocationInView.x <= (apple_origin_x2 + apple_width2))&&
                     (touchLocationInView.y >= apple_origin_y2) &&
                     (touchLocationInView.y <= (apple_origin_y2+apple_height2))))
                {
                       
                    [self show_chinese_translation:@"苹果" pinyin:@"píngguǒ" price:frame_words[4].price touch_loc: touchLocationInView];

                }
            
            
              else if((touchLocationInView.x >= lemon_origin_x) &&
                    (touchLocationInView.x <= (lemon_origin_x + lemon_width)) &&
                    (touchLocationInView.y >= lemon_origin_y) &&
                    (touchLocationInView.y <= (lemon_origin_y+lemon_height)))
                 {
                [self show_chinese_translation:@"柠檬" pinyin:@"níngméng" price:frame_words[2].price touch_loc: touchLocationInView];
                
                }
            }
            
            
            
            if((_aisle == 1) && ([node.name isEqualToString: @"cucumber"])){
                
                _store_chat_window.hidden = true;
                _store_chat_longer_sentence.hidden = true;
                std::vector<ChineseWord> frame_words = item_listing.words_by_image[_aisle];
                
                
                for (UIView *subview in [self.view subviews]) {
                    //  Only remove the subviews with tag not equal to 1
                    if (subview.tag == 9) {
                        [subview removeFromSuperview];
                    }
                }
                
                // want to have the picture divided up so that can give character upon touch
                // original pic's dimensions:
                CGFloat o_tw = 490.0f;
                CGFloat o_th = 368.0f;
                
                // size of pic in the view:
                CGFloat s_tw = node.frame.size.width;
                CGFloat s_th = node.frame.size.height;
                
                
                // position relative to frame of the pic:
                CGPoint positionInScene = [node.parent convertPoint:node.position
                                                           fromNode:node.parent];
                
                // the pic is centered by its midpoint
                //   --> synthetically changing the 'origin' if you will so that I can use coordinates based
                //       at the bottom left-hand corner of original image
                CGFloat origin_x =  positionInScene.x - 0.5*s_tw ;
                CGFloat origin_y =  positionInScene.y - 0.5*s_th;
                
                // PROBLEM:
                //     Based on axis with top-leftmost corner as (0,0). (In general won't matter)
                //     Sizes ORIGINAL PIC's total width o_tw, total height o_th; scaled image's s_tw, s_th
                //     Take element p:
                //         p's width p_w, height p_h
                // 
                //          /                    \  |  s_tw   0    |
                //         | p_w/o_tw , p_h/o_th  | |   0    s_th  |
                //          \                    /
                // 
                
                // flipping:
                //     take distance between point and origin, then origin - (that distance)
                
                
                // cucumbers:
                CGFloat cucumber_width = (115.0f/o_tw) * s_tw;
                CGFloat cucumber_height = (148.0f/o_th) * s_th;
                
                // carrots:
                CGFloat carrot_width = (160.0f/o_tw) * s_tw;
                CGFloat carrot_height = (148.0f/o_th) * s_th;
                
                // celery:
                CGFloat celery_width1 =  (195.0f/o_tw)* s_tw;
                CGFloat celery_height1 = (87.0f/o_th) * s_th;
                CGFloat celery_width2 =  (130.0f/o_tw)* s_tw;
                CGFloat celery_height2 = (15.0f/o_th) * s_th;
                CGFloat celery_width3 =  (162.0f/o_tw)* s_tw;
                CGFloat celery_height3 = (55.0f/o_th) * s_th;
                
                // peppers:
                CGFloat pepper_width =  (195.0f/o_tw) * s_tw;
                CGFloat pepper_height = (83.0f/o_th) * s_th;
                
                // green beans:
                CGFloat green_bean_width =  (250.0f/o_tw) * s_tw;
                CGFloat green_bean_height = (55.0f/o_th) * s_th;
                
                // brussel sprout:
                CGFloat brussel_sprout_width =  (90.0f/o_tw) * s_tw;
                CGFloat brussel_sprout_height = (55.0f/o_th) * s_th;
                
                // artichoke:
                CGFloat artichoke_width =  (170.0f/o_tw) * s_tw;
                CGFloat artichoke_height = (49.0f/o_th) * s_th;
                
                // something:
                CGFloat something_width =  (195.0f/o_tw) * s_tw;
                CGFloat something_height = (50.0f/o_th) * s_th;
                
                
                // PROBLEM:
                //    Now locate within the frame. Then can partition grid superficially.
                //    Given corner locations in original picture, determine location.
                //      -->Same procedure. Just need origin bc have width, height.
                
                // buffer for the anomalies (don't reach bottom of frame, needed the mod to touchLocationInView.y)
                CGFloat buffer = 0.2*s_th;
                
                // cucumbers:
                CGFloat cucumber_origin_x = (0/o_tw) * s_tw + origin_x;
                CGFloat cucumber_origin_y =  origin_y + ((0./o_th) * s_th) + buffer ;
                
                // carrots:
                CGFloat carrot_origin_x = (125.0f/o_tw) * s_tw + origin_x;
                CGFloat carrot_origin_y = origin_y + ((0.0f/o_th) * s_th)+ buffer;
                
                
                // celery:
                CGFloat celery_origin_x1 =  (295.0f/o_tw) * s_tw + origin_x;
                CGFloat celery_origin_y1 =  origin_y + ((98.0f/o_th) * s_th );
                CGFloat celery_origin_x2 =  (295.0f/o_tw) * s_tw + origin_x;
                CGFloat celery_origin_y2 =  origin_y + ((83/o_th) * s_th );
                CGFloat celery_origin_x3 =  (256.0f/o_tw) * s_tw + origin_x;
                CGFloat celery_origin_y3 =  origin_y + ((178.0f/o_th) * s_th - 0.5f*s_th);
                
                // peppers:
                CGFloat pepper_origin_x = (295.0f/o_tw) * s_tw + origin_x;
                CGFloat pepper_origin_y = origin_y + ((0.0f/o_th) * s_th)- 0.5f*s_th;
                
                // green beans:
                CGFloat green_bean_origin_x = (0.0f/o_tw) * s_tw + origin_x;
                CGFloat green_bean_origin_y = origin_y + ((190.0f/o_th) * s_th - 0.5f*s_th);
                
                // brussel sprouts:
                CGFloat brussel_sprout_origin_x = (400.0f/o_tw) * s_tw + origin_x;
                CGFloat brussel_sprout_origin_y = origin_y + ((183.0f/o_th) * s_th - 0.5f*s_th);
                
                // artichoke:
                CGFloat artichoke_origin_x = (0.0f/o_tw) * s_tw + origin_x;
                CGFloat artichoke_origin_y = origin_y + ((243.0f/o_th) * s_th - 0.5f*s_th);
                
                // something:
                CGFloat something_origin_x = (195.0f/o_tw) * s_tw + origin_x;
                CGFloat something_origin_y = origin_y + ((243.0f/o_th) * s_th - 0.5f*s_th);
                
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                
                // this following CGFloat came from hours of banging my head over pears and limes
                // being flipped (for whatever reason).
                // Actually, reason:
                //      The touchLocationInView.y was way higher than the positions of the fruits within the frame.
                //      So, the x is pared down to the frame, but the y isn't.
                //           HOWEVER: This only is a problem for a few of them (pear, lime2).
                CGFloat location_in_frame_y = touchLocationInView.y - node.frame.origin.y  + 0.5*s_th;
                
                
                bool starter = false;
                if(starter == true){
                    ;
                }
                
                else if((touchLocationInView.x >= cucumber_origin_x) &&
                        (touchLocationInView.x <= (cucumber_origin_x + cucumber_width) ) &&
                        (location_in_frame_y >= cucumber_origin_y)
                        && (location_in_frame_y <= (cucumber_height +cucumber_origin_y) ) )
                   {
                       [self show_chinese_translation:@"黄瓜" pinyin:@"huángguā" price:frame_words[0].price touch_loc: touchLocationInView];

                    
                }
                
                else if((touchLocationInView.x >= carrot_origin_x) &&
                        (touchLocationInView.x <= (carrot_origin_x + carrot_width)) &&
                        (location_in_frame_y  >= carrot_origin_y) &&
                        (location_in_frame_y  <= (carrot_origin_y+carrot_height))){
                
                    [self show_chinese_translation:@"胡萝卜" pinyin:@"húluóbo" price:frame_words[1].price touch_loc: touchLocationInView];

                    
                }
                
                
                else if(((touchLocationInView.x >= celery_origin_x1 )
                         && (touchLocationInView.x <= (celery_origin_x1 + celery_width1))
                         &&(location_in_frame_y >= celery_origin_y1)
                         && (location_in_frame_y <= (celery_origin_y1+celery_height1)))
                        ||
                        ( (touchLocationInView.x >= celery_origin_x2) &&
                         (touchLocationInView.x <= (celery_origin_x2 + celery_width2))&&
                         (location_in_frame_y >= celery_origin_y2) &&
                         (location_in_frame_y  <= (celery_origin_y2+ celery_height2)))
                        ||
                        ( (touchLocationInView.x >= celery_origin_x3) &&
                         (touchLocationInView.x <= (celery_origin_x3 + celery_width3))&&
                         (location_in_frame_y  >= celery_origin_y3) &&
                         (location_in_frame_y  <= (celery_origin_y3+ celery_height3)))
                        )
                   {
                    
                       [self show_chinese_translation:@"芹菜" pinyin:@"qíncài" price:frame_words[2].price touch_loc: touchLocationInView];

                    }

                
                
                else if((touchLocationInView.x >= pepper_origin_x) &&
                        (touchLocationInView.x <= (pepper_origin_x + pepper_width)) &&
                        (touchLocationInView.y >= pepper_origin_y) &&
                        (touchLocationInView.y <= (pepper_origin_y+pepper_height))){
                    
                    [self show_chinese_translation:@"绿色的甜椒" pinyin:@"lǜsè de tiánjiāo" price:frame_words[3].price touch_loc: touchLocationInView];

                    
                    
                }
                
                else if((touchLocationInView.x >= green_bean_origin_x) &&
                        (touchLocationInView.x <= (green_bean_origin_x + green_bean_width)) &&
                        (location_in_frame_y >= green_bean_origin_y) &&
                        (location_in_frame_y <= (green_bean_origin_y+green_bean_height))){
                    
                    [self show_chinese_translation:@"青刀豆" pinyin:@"qīng dāo dòu" price:frame_words[4].price touch_loc: touchLocationInView];

                    
                }
                
                
                else if((touchLocationInView.x >= brussel_sprout_origin_x) &&
                        (touchLocationInView.x <= (brussel_sprout_origin_x + brussel_sprout_width)) &&
                        (location_in_frame_y >= brussel_sprout_origin_y) &&
                        (location_in_frame_y <= (brussel_sprout_origin_y+brussel_sprout_height))){
                    
                    [self show_chinese_translation:@"芽球甘蓝" pinyin:@"yá qiú gānlán" price:frame_words[5].price  touch_loc: touchLocationInView];

                    
                    
                }
                
                
                else if((touchLocationInView.x >= artichoke_origin_x) &&
                        (touchLocationInView.x <= (artichoke_origin_x + artichoke_width)) &&
                        (touchLocationInView.y >= artichoke_origin_y) &&
                        (touchLocationInView.y <= (artichoke_origin_y+artichoke_height))){
                    
                    [self show_chinese_translation:@"朝鲜蓟/洋百合" pinyin:@"cháoxiǎn jì/yáng bǎihé" price:frame_words[6].price  touch_loc: touchLocationInView];

                    
                    
                }

                else if((touchLocationInView.x >= something_origin_x) &&
                        (touchLocationInView.x <= (something_origin_x + something_width)) &&
                        (touchLocationInView.y >= something_origin_y) &&
                        (touchLocationInView.y <= (something_origin_y+something_height))){
                    
                    [self show_chinese_translation:@"羽衣甘蓝" pinyin:@"yǔyī gānlán" price:frame_words[7].price  touch_loc: touchLocationInView];

                    
                    
                }

                
                
                
            }

            
            
            if((_aisle == 2) && ([node.name isEqualToString: @"eggplant"])){
                
                _store_chat_window.hidden = true;
                _store_chat_longer_sentence.hidden = true;
                 std::vector<ChineseWord> frame_words = item_listing.words_by_image[_aisle];
                
                for (UIView *subview in [self.view subviews]) {
                    //  Only remove the subviews with tag not equal to 1
                    if (subview.tag == 9) {
                        [subview removeFromSuperview];
                    }
                }
                
                // want to have the picture divided up so that can give character upon touch
                // original pic's dimensions:
                CGFloat o_tw = 490.0f;
                CGFloat o_th = 368.0f;
                
                // size of pic in the view:
                CGFloat s_tw = node.frame.size.width;
                CGFloat s_th = node.frame.size.height;
                
                
                // position relative to frame of the pic:
                CGPoint positionInScene = [node.parent convertPoint:node.position
                                                           fromNode:node.parent];
                
                // the pic is centered by its midpoint
                //   --> synthetically changing the 'origin' if you will so that I can use coordinates based
                //       at the bottom left-hand corner of original image
                CGFloat origin_x =  positionInScene.x - 0.5*s_tw ;
                CGFloat origin_y =  positionInScene.y - 0.5*s_th;
                
                // PROBLEM:
                //     Based on axis with top-leftmost corner as (0,0). (In general won't matter)
                //     Sizes ORIGINAL PIC's total width o_tw, total height o_th; scaled image's s_tw, s_th
                //     Take element p:
                //         p's width p_w, height p_h
                // 
                //          /                    \  |  s_tw   0    |
                //         | p_w/o_tw , p_h/o_th  | |   0    s_th  |
                //          \                    /
                // 
                
                // flipping:
                //     take distance between point and origin, then origin - (that distance)
                
                
                // eggplants:
                CGFloat eggplant_width = (180.0f/o_tw) * s_tw;
                CGFloat eggplant_height = (75.0f/o_th) * s_th;
                
                // green squash:
                CGFloat green_squash_width = (190.0f/o_tw) * s_tw;
                CGFloat green_squash_height = (120.0f/o_th) * s_th;
                
                // yellow squash:
                CGFloat yellow_squash_width =  (90.0f/o_tw)* s_tw;
                CGFloat yellow_squash_height = (120.0f/o_th) * s_th;

                // baby bok choy
                CGFloat baby_bok_choy_width =  (285.0f/o_tw) * s_tw;
                CGFloat baby_bok_choy_height = (130.0f/o_th) * s_th;
                
                // carrots:
                CGFloat carrot_width =  (155.0f/o_tw) * s_tw;
                CGFloat carrot_height = (75.0f/o_th) * s_th;
                
                // cabbage:
                CGFloat cabbage_width =  (185.0f/o_tw) * s_tw;
                CGFloat cabbage_height = (153.0f/o_th) * s_th;
                
                // red cabbage:
                CGFloat red_cabbage_width =  (65.0f/o_tw) * s_tw;
                CGFloat red_cabbage_height = (153.0f/o_th) * s_th;
                
                // bok choy:
                CGFloat bok_choy_width =  (225.0f/o_tw) * s_tw;
                CGFloat bok_choy_height = (153.0f/o_th) * s_th;
                
                
                // PROBLEM:
                //    Now locate within the frame. Then can partition grid superficially.
                //    Given corner locations in original picture, determine location.
                //      -->Same procedure. Just need origin bc have width, height.
                
                // buffer for the anomalies (don't reach bottom of frame, needed the mod to touchLocationInView.y)
                CGFloat buffer = 0.2*s_th;
                
                // eggplant:
                CGFloat eggplant_origin_x = (0/o_tw) * s_tw + origin_x;
                CGFloat eggplant_origin_y =  origin_y + ((248.0f/o_th) * s_th) - 0.5f*s_th ;
                
                // green squash:
                CGFloat green_squash_origin_x = (200.0f/o_tw) * s_tw + origin_x;
                CGFloat green_squash_origin_y = origin_y + ((208.0f/o_th) * s_th) - 0.5f*s_th;
                
                
                // yellow squash:
                CGFloat yellow_squash_origin_x =  (400.0f/o_tw) * s_tw + origin_x;
                CGFloat yellow_squash_origin_y =  origin_y + ((208.0f/o_th) * s_th - 0.5f*s_th);

                // baby bok choy:
                CGFloat baby_bok_choy_origin_x = (0.0f/o_tw) * s_tw + origin_x;
                CGFloat baby_bok_choy_origin_y = origin_y + ((168.0f/o_th) * s_th)- 0.5f*s_th;
                
                // carrots:
                CGFloat carrot_origin_x = (290.0f/o_tw) * s_tw + origin_x;
                CGFloat carrot_origin_y = origin_y + ((168.0f/o_th) * s_th - 0.5f*s_th);
                
                // cabbage:
                CGFloat cabbage_origin_x = (0.0f/o_tw) * s_tw + origin_x;
                CGFloat cabbage_origin_y = origin_y + ((0.0f/o_th) * s_th) + buffer;
                
                // red cabbage:
                CGFloat red_cabbage_origin_x = (190.0f/o_tw) * s_tw + origin_x;
                CGFloat red_cabbage_origin_y = origin_y + ((0.0f/o_th) * s_th) + buffer;
                
                // bok choy:
                CGFloat bok_choy_origin_x = (265.0f/o_tw) * s_tw + origin_x;
                CGFloat bok_choy_origin_y = origin_y + ((0.0f/o_th) * s_th) + buffer;
                
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                
                // this following CGFloat came from hours of banging my head over pears and limes
                // being flipped (for whatever reason).
                // Actually, reason:
                //      The touchLocationInView.y was way higher than the positions of the fruits within the frame.
                //      So, the x is pared down to the frame, but the y isn't.
                //           HOWEVER: This only is a problem for a few of them (pear, lime2).
                CGFloat location_in_frame_y = touchLocationInView.y - node.frame.origin.y  + 0.5*s_th;
                
                
                bool starter = false;
                if(starter == true){
                    ;
                }
                
                else if((touchLocationInView.x >= eggplant_origin_x) &&
                        (touchLocationInView.x <= (eggplant_origin_x + eggplant_width) ) &&
                        (touchLocationInView.y >= eggplant_origin_y)
                        && (touchLocationInView.y <= (eggplant_height +eggplant_origin_y) ) )
                {
                    [self show_chinese_translation:@"茄子" pinyin:@"qiézi" price:frame_words[0].price touch_loc: touchLocationInView];

                    
                }
                
                
                else if((touchLocationInView.x >= carrot_origin_x) &&
                        (touchLocationInView.x <= (carrot_origin_x + carrot_width)) &&
                        (location_in_frame_y >= carrot_origin_y) &&
                        (location_in_frame_y <= (carrot_origin_y+carrot_height))){
                    
                    [self show_chinese_translation:@"胡萝卜" pinyin:@"húluóbo" price:frame_words[1].price touch_loc: touchLocationInView];

                    
                }
                
                else if((touchLocationInView.x >= green_squash_origin_x) &&
                        (touchLocationInView.x <= (green_squash_origin_x + green_squash_width)) &&
                        (touchLocationInView.y >= green_squash_origin_y) &&
                        (touchLocationInView.y <= (green_squash_origin_y+green_squash_height))){
                    
                    [self show_chinese_translation:@"绿色的瓜" pinyin:@"lǜsè de guā" price:frame_words[2].price touch_loc: touchLocationInView];

                    
                }
                
                
                else if(((touchLocationInView.x >= yellow_squash_origin_x )
                         && (touchLocationInView.x <= (yellow_squash_origin_x + yellow_squash_width))
                         && (touchLocationInView.y >= yellow_squash_origin_y)
                         && (touchLocationInView.y <= (yellow_squash_origin_y +yellow_squash_height)))
                        )
                {
                    
                    [self show_chinese_translation:@"黄色的瓜" pinyin:@"huángsè de guā" price:frame_words[3].price touch_loc: touchLocationInView];

                }
                
                
                
                else if((touchLocationInView.x >= baby_bok_choy_origin_x) &&
                        (touchLocationInView.x <= (baby_bok_choy_origin_x + baby_bok_choy_width)) &&
                        (location_in_frame_y >= baby_bok_choy_origin_y) &&
                        (location_in_frame_y <= (baby_bok_choy_origin_y+baby_bok_choy_height))){
                    
                    [self show_chinese_translation:@"青菜" pinyin:@"qīngcài" price:frame_words[4].price touch_loc: touchLocationInView];

                    
                    
                }
                
                else if((touchLocationInView.x >= cabbage_origin_x) &&
                        (touchLocationInView.x <= (cabbage_origin_x + cabbage_width)) &&
                        (location_in_frame_y >= cabbage_origin_y) &&
                        (location_in_frame_y <= (cabbage_origin_y+cabbage_height))){
                    
                    [self show_chinese_translation:@"圆白菜" pinyin:@"yuánbáicài" price:frame_words[5].price touch_loc: touchLocationInView];

                    
                }
                
                
                else if((touchLocationInView.x >= red_cabbage_origin_x) &&
                        (touchLocationInView.x <= (red_cabbage_origin_x + red_cabbage_width)) &&
                        (location_in_frame_y >= red_cabbage_origin_y) &&
                        (location_in_frame_y <= (red_cabbage_origin_y+red_cabbage_height))){
                    
                    [self show_chinese_translation:@"红色的圆白菜" pinyin:@"hóngsè de yuánbáicài" price:frame_words[6].price touch_loc: touchLocationInView];

                    
                    
                }
                
                else if((touchLocationInView.x >= bok_choy_origin_x) &&
                        (touchLocationInView.x <= (bok_choy_origin_x + bok_choy_width)) &&
                        (location_in_frame_y >= bok_choy_origin_y) &&
                        (location_in_frame_y <= (bok_choy_origin_y+bok_choy_height))){
                    
                    [self show_chinese_translation:@"白菜" pinyin:@"báicài" price:frame_words[7].price touch_loc: touchLocationInView];

                }
                
            }
                
                
                
                
            
           

            
            if((_aisle == 3) && ([node.name isEqualToString: @"lettuce"])){
                
                _store_chat_window.hidden = true;
                _store_chat_longer_sentence.hidden = true;
                
            
                std::vector<ChineseWord> frame_words = item_listing.words_by_image[_aisle];
                for (UIView *subview in [self.view subviews]) {
                    //  Only remove the subviews with tag not equal to 1
                    if (subview.tag == 9) {
                        [subview removeFromSuperview];
                    }
                }
                
               
                // want to have the picture divided up so that can give character upon touch
                // original pic's dimensions:
                CGFloat o_tw = 490.0f;
                CGFloat o_th = 368.0f;
                
                // size of pic in the view:
                CGFloat s_tw = node.frame.size.width;
                CGFloat s_th = node.frame.size.height;
                
                
                // position relative to frame of the pic:
                CGPoint positionInScene = [node.parent convertPoint:node.position
                                                           fromNode:node.parent];
                
                // the pic is centered by its midpoint
                //   --> synthetically changing the 'origin' if you will so that I can use coordinates based
                //       at the bottom left-hand corner of original image
                CGFloat origin_x =  positionInScene.x - 0.5*s_tw ;
                CGFloat origin_y =  positionInScene.y - 0.5*s_th;
                
                // PROBLEM:
                //     Based on axis with top-leftmost corner as (0,0). (In general won't matter)
                //     Sizes ORIGINAL PIC's total width o_tw, total height o_th; scaled image's s_tw, s_th
                //     Take element p:
                //         p's width p_w, height p_h
                // 
                //          /                    \  |  s_tw   0    |
                //         | p_w/o_tw , p_h/o_th  | |   0    s_th  |
                //          \                    /
                // 
                
                // flipping:
                //     take distance between point and origin, then origin - (that distance)
                
                
                // red potatoes:
                CGFloat red_potato_width = (90.0f/o_tw) * s_tw;
                CGFloat red_potato_height = (60.0f/o_th) * s_th;
                
                // yellow_potatoes:
                CGFloat yellow_potato_width = (106.0f/o_tw) * s_tw;
                CGFloat yellow_potato_height = (60.0f/o_th) * s_th;
                
                // crawfish boil potatoes:
                CGFloat crawfish_potato_width =  (105.0f/o_tw) * s_tw;
                CGFloat crawfish_potato_height = (65.0f/o_th) * s_th;

                // (side) lettuce:
                CGFloat lettuce_width =  (143.0f/o_tw) * s_tw;
                CGFloat lettuce_height = (65.0f/o_th) * s_th;
                
                
                // green_beans:
                CGFloat green_bean_width1 =  (255.0f/o_tw)* s_tw;
                CGFloat green_bean_height1 = (43.0f/o_th) * s_th;
                CGFloat green_bean_width2 =  (90.0f/o_tw)* s_tw;
                CGFloat green_bean_height2 = (100.0f/o_th) * s_th;

                
                // parsley:
                CGFloat parsley_width =  (170.0f/o_tw) * s_tw;
                CGFloat parsley_height = (55.0f/o_th) * s_th;
                
                // cucumbers:
                CGFloat cucumber_width =  (260.0f/o_tw) * s_tw;
                CGFloat cucumber_height = (50.0f/o_th) * s_th;
                
                // romaine lettuce
                CGFloat romaine_lettuce_width1 =  (188.0f/o_tw) * s_tw;
                CGFloat romaine_lettuce_height1 = (115.0f/o_th) * s_th;
                CGFloat romaine_lettuce_width2 =  (84.0f/o_tw) * s_tw;
                CGFloat romaine_lettuce_height2 = (35.0f/o_th) * s_th;
                
                // red leaf lettuce:
                CGFloat red_leaf_lettuce_width =  (160.0f/o_tw) * s_tw;
                CGFloat red_leaf_lettuce_height = (130.0f/o_th) * s_th;
                
                // green leaf lettuce:
                CGFloat green_leaf_lettuce_width =  (95.0f/o_tw) * s_tw;
                CGFloat green_leaf_lettuce_height = (150.0f/o_th) * s_th;
                
                
                // PROBLEM:
                //    Now locate within the frame. Then can partition grid superficially.
                //    Given corner locations in original picture, determine location.
                //      -->Same procedure. Just need origin bc have width, height.
                
                // buffer for the anomalies (don't reach bottom of frame, needed the mod to touchLocationInView.y)
                CGFloat buffer = 0.1*s_th;
                
                // cucumbers:
                CGFloat cucumber_origin_x = (230.0f/o_tw) * s_tw + origin_x;
                CGFloat cucumber_origin_y =  origin_y + ((173.0f/o_th) * s_th) - 0.5f*s_th ;
                
                // red potatoes:
                CGFloat red_potato_origin_x = (120.0f/o_tw) * s_tw + origin_x;
                CGFloat red_potato_origin_y = origin_y + ((223.0f/o_th) * s_th) - 0.5f*s_th;
                
                
                // green beans:
                CGFloat green_bean_origin_x1 =  (90.0f/o_tw) * s_tw + origin_x;
                CGFloat green_bean_origin_y1 =  origin_y + ((0.0f/o_th) * s_th + 0.5f*s_th);
                CGFloat green_bean_origin_x2 =  (140.0f/o_tw) * s_tw + origin_x;
                CGFloat green_bean_origin_y2 =  origin_y + ((48.0f/o_th) * s_th + 0.5f*s_th);

                
                // yellow potatoes:
                CGFloat yellow_potato_origin_x = (242.0f/o_tw) * s_tw + origin_x;
                CGFloat yellow_potato_origin_y = origin_y + ((223.0f/o_th) * s_th)- 0.5f*s_th;
                
                // crawfish boil potatoes:
                CGFloat crawfish_potato_origin_x = (0.0f/o_tw) * s_tw + origin_x;
                CGFloat crawfish_potato_origin_y = origin_y + ((223.0f/o_th) * s_th)- 0.5f*s_th;
                
                // (side) lettuce potatoes:
                CGFloat lettuce_origin_x = (367.0f/o_tw) * s_tw + origin_x;
                CGFloat lettuce_origin_y = origin_y + ((223.0f/o_th) * s_th)- 0.5f*s_th;
                
                // parsley:
                CGFloat parsley_origin_x = (50.0f/o_tw) * s_tw + origin_x;
                CGFloat parsley_origin_y = origin_y + ((173.0f/o_th) * s_th - 0.5f*s_th);
                
                // romaine:
                CGFloat romaine_lettuce_origin_x1 =  (42.0f/o_tw) * s_tw + origin_x;
                CGFloat romaine_lettuce_origin_y1 =  origin_y + ((78.0f/o_th) * s_th );
                CGFloat romaine_lettuce_origin_x2 =  (46.0f/o_tw) * s_tw + origin_x;
                CGFloat romaine_lettuce_origin_y2 =  origin_y + ((48.0f/o_th) * s_th );
                
                // red leaf lettuce:
                CGFloat red_leaf_lettuce_origin_x = (230.0f/o_tw) * s_tw + origin_x;
                CGFloat red_leaf_lettuce_origin_y = origin_y + ((68.0f/o_th) * s_th);
                
                // green leaf lettuce:
                CGFloat green_leaf_lettuce_origin_x = (395.0f/o_tw) * s_tw + origin_x;
                CGFloat green_leaf_lettuce_origin_y = origin_y + ((48.0f/o_th) * s_th );
                
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                
                // this following CGFloat came from hours of banging my head over pears and limes
                // being flipped (for whatever reason).
                // Actually, reason:
                //      The touchLocationInView.y was way higher than the positions of the fruits within the frame.
                //      So, the x is pared down to the frame, but the y isn't.
                //           HOWEVER: This only is a problem for a few of them (pear, lime2).
                CGFloat location_in_frame_y = touchLocationInView.y - node.frame.origin.y  + 0.5*s_th;
                
                
                bool starter = false;
                if(starter == true){
                    ;
                }
                
                else if((touchLocationInView.x >= cucumber_origin_x) &&
                        (touchLocationInView.x <= (cucumber_origin_x + cucumber_width) ) &&
                        (location_in_frame_y >= cucumber_origin_y)
                        && (location_in_frame_y <= (cucumber_height +cucumber_origin_y) ) )
                {
                    [self show_chinese_translation:@"黄瓜" pinyin:@"huángguā" price:frame_words[0].price touch_loc: touchLocationInView];

                    
                }
                
                else if((touchLocationInView.x >= red_potato_origin_x) &&
                        (touchLocationInView.x <= (red_potato_origin_x + red_potato_width)) &&
                        (touchLocationInView.y  >= red_potato_origin_y) &&
                        (touchLocationInView.y   <= (red_potato_origin_y+red_potato_height))){
                    
                    [self show_chinese_translation:@"红土豆" pinyin:@"hóngtǔdòu" price:frame_words[1].price touch_loc: touchLocationInView];

                    
                }
                
                else if((touchLocationInView.x >= crawfish_potato_origin_x) &&
                        (touchLocationInView.x <= (crawfish_potato_origin_x + crawfish_potato_width)) &&
                        (touchLocationInView.y  >= crawfish_potato_origin_y) &&
                        (touchLocationInView.y   <= (crawfish_potato_origin_y+crawfish_potato_height))){
                    
                    [self show_chinese_translation:@"红土豆" pinyin:@"hóngtǔdòu" price:frame_words[2].price touch_loc: touchLocationInView];

                    
                }
                
                else if((touchLocationInView.x >= lettuce_origin_x) &&
                        (touchLocationInView.x <= (lettuce_origin_x + lettuce_width)) &&
                        (touchLocationInView.y  >= lettuce_origin_y) &&
                        (touchLocationInView.y   <= (lettuce_origin_y+lettuce_height))){
                    
                    [self show_chinese_translation:@"生菜" pinyin:@"shēngcài" price:frame_words[3].price touch_loc: touchLocationInView];

                    
                }
                
                else if(((touchLocationInView.x >= green_bean_origin_x1 )
                         && (touchLocationInView.x <= (green_bean_origin_x1 + green_bean_width1))
                         &&(location_in_frame_y >= green_bean_origin_y1)
                         && (location_in_frame_y <= (green_bean_origin_y1+green_bean_height1)))
                        ||
                        ( (touchLocationInView.x >= green_bean_origin_x2) &&
                         (touchLocationInView.x <= (green_bean_origin_x2 + green_bean_width2))&&
                         (location_in_frame_y >= green_bean_origin_y2) &&
                         (location_in_frame_y <= (green_bean_origin_y2+ green_bean_height2)))
                        )
                {
                    
                    [self show_chinese_translation:@"青刀豆" pinyin:@"qīng dāo dòu" price:frame_words[4].price touch_loc: touchLocationInView];

                }
                
                
                
                else if((touchLocationInView.x >= yellow_potato_origin_x) &&
                        (touchLocationInView.x <= (yellow_potato_origin_x + yellow_potato_width)) &&
                        (touchLocationInView.y >= yellow_potato_origin_y) &&
                        (touchLocationInView.y <= (yellow_potato_origin_y+yellow_potato_height)))
                {
                    
                    
                    
                    [self show_chinese_translation:@"土豆" pinyin:@"tǔdòu" price:frame_words[5].price touch_loc: touchLocationInView];
                    
                }
                
                else if((touchLocationInView.x >= parsley_origin_x) &&
                        (touchLocationInView.x <= (parsley_origin_x + parsley_width)) &&
                        (location_in_frame_y >= parsley_origin_y) &&
                        (location_in_frame_y <= (parsley_origin_y+parsley_height))){
                    
                    [self show_chinese_translation:@"欧芹" pinyin:@"ōu qín" price:frame_words[5].price touch_loc: touchLocationInView];
                   
                }
                
                
                else if((touchLocationInView.x >= red_leaf_lettuce_origin_x) &&
                        (touchLocationInView.x <= (red_leaf_lettuce_origin_x + red_leaf_lettuce_width)) &&
                        (location_in_frame_y >= red_leaf_lettuce_origin_y) &&
                        (location_in_frame_y <= (red_leaf_lettuce_origin_y+red_leaf_lettuce_height))){
                    
                    [self show_chinese_translation:@"红色的生菜" pinyin:@"hóngsè de shēngcài" price:frame_words[6].price touch_loc: touchLocationInView];
                    
                }
                
                
                else if((touchLocationInView.x >= green_leaf_lettuce_origin_x) &&
                        (touchLocationInView.x <= (green_leaf_lettuce_origin_x + green_leaf_lettuce_width)) &&
                        (location_in_frame_y >= green_leaf_lettuce_origin_y) &&
                        (location_in_frame_y <= (green_leaf_lettuce_origin_y+green_leaf_lettuce_height))){
                    
                    
                    [self show_chinese_translation:@"绿色的生菜" pinyin:@"lǜsè de shēngcài" price:frame_words[7].price touch_loc: touchLocationInView];
                   
                }
                
                else if(((touchLocationInView.x >= romaine_lettuce_origin_x1 )
                         && (touchLocationInView.x <= (romaine_lettuce_origin_x1 + romaine_lettuce_width1))
                         &&(location_in_frame_y >= romaine_lettuce_origin_y1)
                         && (location_in_frame_y <= (romaine_lettuce_origin_y1+romaine_lettuce_height1)))
                        ||
                        ( (touchLocationInView.x >= romaine_lettuce_origin_x2) &&
                         (touchLocationInView.x <= (romaine_lettuce_origin_x2 + romaine_lettuce_width2))&&
                         (location_in_frame_y >= romaine_lettuce_origin_y2) &&
                         (location_in_frame_y  <= (romaine_lettuce_origin_y2+ romaine_lettuce_height2)))
                        )
                {
                    [self show_chinese_translation:@"长叶生菜" pinyin:@"cháng yè shēngcài" price:frame_words[8].price touch_loc: touchLocationInView];
                    
                }
                
                
                
                
            }
 
            
            
        }// for all nodes
    }// for all touches
}// end of function call
// -(void)handle_shopping:(NSString *) purchase_request

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _user_input0 = textField.text;
    if(![_user_input0 isEqualToString:@""]){
        [self handle_shopping:_user_input0];
        [textField resignFirstResponder];
    }
    return YES;
}



// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    
    _user_input0 = @"";
    return YES;
    
    
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(BOOL)textFieldDidEndEditing:(UITextField *)textField
{
    _user_input0 = textField.text;
    [textField resignFirstResponder];
    return YES;
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(BOOL)textFieldDidChange:(UITextField *)textField
{
    _store_chat_window.hidden = false;
    _store_chat_longer_sentence.hidden = true;
    return YES;
    
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@end
