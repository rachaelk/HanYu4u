// 
//   Dialog12.m
//   HanYu4u
// 
//   Created by Rachael Keller on 8/11/14.
//   Copyright (c) 2014 Rachael Keller. All rights reserved.
// 

// FILE:Dialog3
// PURPOSE: NUMBERS
//   Here the user will test his or her skills in numbers.
//   


#import "Dialog3.h"
#import "Base_Scene.h"


@implementation Dialog3
@synthesize flashed_number = _flashed_number;
@synthesize go_back = _go_back;
@synthesize flashed_number_content= _flashed_number_content;
@synthesize flashed_number_label = _flashed_number_label;
@synthesize aisle_master;
@synthesize border_frame = _border_frame;
@synthesize input_hanyu0;
@synthesize tap = _tap;
@synthesize score0 = _score0;
@synthesize response = _response;
@synthesize emphasize100 = _emphasize100;
@synthesize emphasize1000 = _emphasize1000;
@synthesize emphasize10000 = _emphasize10000;
@synthesize emph = _emph;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
static inline int skRand(int low, int high){
    
    return arc4random()%(high-low) + low;// why no +1? high is already +1, of sorts.
    // high = length(array of nodes), and array is indexed [0,high-1].
    // so the count is (high-1)-low+1, or high-low.
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(void)dismissKeyboard{
    [input_hanyu0 resignFirstResponder];
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:0];
        
        
        
    }
    return self;
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(void)didMoveToView:(SKView *)view {
    
    _emph =100;
    // SET Keyboard for the lesson:
    NSMutableArray *k =[[NSMutableArray alloc] initWithObjects: @" ", @" ", @" ",@"万", @"千", @"百", @"零", @"个", @" ",  @" ",  @" ", @"一", @"二", @"两", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", nil];
    
    NSMutableArray *kshift = [[NSMutableArray alloc] initWithObjects: @" ", @" ", @" ",@"万", @"千", @"百", @"零", @"个", @" ",  @" ",  @" ", @"一", @"二", @"两", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", nil];
    
    NSMutableArray *kalt = [[NSMutableArray alloc] initWithObjects:@" ", @" ", @" ",@"万", @"千", @"百", @"零", @"个", @" ",  @" ",  @" ", @"一", @"二", @"两", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", nil];
    
    [GameState sharedInstance].keyboard_characters = k;
    [GameState sharedInstance].keyboard_characters_shift = kshift;
    [GameState sharedInstance].keyboard_characters_alt = kalt;
    
    
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
    
    
    _customKeyboard = [[PMCustomKeyboard alloc] init];
    
    _response = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
    _response.name = @"response";
    _response.fontSize = 14;
    _response.text = @" ";
    _response.zPosition = 1;
    _response.fontColor = [SKColor colorWithRed:1 green:0 blue:0 alpha:1];
    
    
    _emphasize100 = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
    _emphasize100.name = @"emph100";
    _emphasize100.fontSize = 12;
    _emphasize100.text = @"强调100s";
    _emphasize100.zPosition = 1;
    _emphasize100.fontColor = [SKColor colorWithRed:1 green:0 blue:0 alpha:1];
    
    _emphasize1000 = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
    _emphasize1000 .name = @"emph1000";
    _emphasize1000 .fontSize = 12;
    _emphasize1000 .text = @"强调1000s";
    _emphasize1000 .zPosition = 1;
    _emphasize1000 .fontColor = [SKColor colorWithRed:1 green:0 blue:0 alpha:1];
    
    _emphasize10000 = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
    _emphasize10000.name = @"emph10000";
    _emphasize10000.fontSize = 12;
    _emphasize10000.text = @"强调10000s";
    _emphasize10000.zPosition = 1;
    _emphasize10000.fontColor = [SKColor colorWithRed:1 green:0 blue:0 alpha:1];
    
    
    
    [self addChild:_emphasize100];
    [self addChild:_emphasize1000];
    [self addChild:_emphasize10000];
    
    
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
    
    _emphasize100.position = CGPointMake(CGRectGetMidX(self.frame),0.5*(_go_back.position.y + CGRectGetMidY(self.frame)));
    
    _emphasize1000.position =CGPointMake(_emphasize100.position.x, _emphasize100.position.y - 20);
    
    _emphasize10000.position =CGPointMake(_emphasize1000.position.x, _emphasize1000.position.y - 20);
    
    
    
    _flashed_number = skRand(0, 99999);
    _flashed_number_content = [NSString stringWithFormat:@"%d", _flashed_number];
    _flashed_number_label = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
    _flashed_number_label.name = @"flashed_number";
    _flashed_number_label.fontSize = 14;
    _flashed_number_label.text = _flashed_number_content;
    _flashed_number_label.fontColor = [SKColor colorWithRed:0 green:1 blue:1 alpha:1];
    
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
    input_hanyu0.hidden = false;
    _flashed_number_label.position = CGPointMake(CGRectGetMidX(self.frame), 0.5*(input_hanyu0.frame.origin.x+0.5*input_hanyu0.frame.size.height+CGRectGetMaxY(self.frame)));
    _response.position = CGPointMake(CGRectGetMidX(self.frame), 0.5*(_flashed_number_label.position.x+CGRectGetMinY(self.frame)));
    _flashed_number_label.hidden= false;
    
    [_customKeyboard setTextView:input_hanyu0];
    
    // the following block makes it such that tapping outside the textfield dismisses the keyboard~~~
    [self.view addSubview:input_hanyu0];
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    _tap.numberOfTapsRequired = 2; // if this is not specified, computer gets confused-- can't tell what is purposeful click
    [self.view addGestureRecognizer:_tap];
    [self addChild:_flashed_number_label];
    [self addChild:_response];
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        
        NSArray *nodes= [self nodesAtPoint:[touch locationInNode:self]];
        CGPoint touchLocationInView = [touch locationInView:self.scene.view];
        
        for (SKNode *node in nodes) {
            
            if( [node.name isEqualToString:@"emph100"]){
                _emph = 999;
            }
            if( [node.name isEqualToString:@"emph1000"]){
                _emph = 9999;
            }
            if( [node.name isEqualToString:@"emph10000"]){
                _emph = 99999;
            }
            
            if( [node.name isEqualToString:@"go_back"]){
                
                for (UIView *subview in [self.view subviews]) {
                    
                    // if (subview.tag == 7 || subview.tag == 9) {
                    [subview removeFromSuperview];
                    //  }
                }
                
                
                SKView *spriteView = (SKView *) self.view;
                Base_Scene *newScene = [Base_Scene sceneWithSize:spriteView.bounds.size];
                [spriteView presentScene:newScene];
                
            }
            
            
            
        }
    }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _user_input0 = textField.text;
    if(![_user_input0 isEqualToString:@""]){
        int amount = [self parse_amounts:_user_input0];
        if (amount != _flashed_number){
            _response.text = @"错，再试试吧";
        }
        else{
            _response.text = @"对！";
            [GameState sharedInstance].score += 10;
            [_score0 setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
            _flashed_number = skRand(0, _emph);
            _flashed_number_content = [NSString stringWithFormat:@"%d", _flashed_number];
            _flashed_number_label.text = _flashed_number_content;
            
        }
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
    return YES;
    
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@end
