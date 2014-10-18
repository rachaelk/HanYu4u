//
//  MarketPlace.m
//  HanYu4u
//
//  Created by Rachael Keller on 7/31/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

#import "MarketPlace.h"
#import "Base_Scene.h"
#import "buyable_goods.h"

#include <iostream>

@implementation MarketPlace



@synthesize go_back = _go_back;
@synthesize stick_figure = _stick_figure;
@synthesize input_hanyu0;
@synthesize tap = _tap;
@synthesize lblScore = _lblScore;

@synthesize store_chat_window = _store_chat_window;

@synthesize store_chat_longer_sentence = _store_chat_longer_sentence;

@synthesize request_cheaper = _request_cheaper;
@synthesize request_meiyou_qian = _request_meiyou_qian;
@synthesize request_poor_student = _request_poor_student;
@synthesize request_material = _request_material;
@synthesize request_wait = _request_wait;

@synthesize dialogue_master = _dialogue_master;
@synthesize probability_success_haggle = _probability_success_haggle;

@synthesize trophy_prices = _trophy_prices;
@synthesize trophy_considered = _trophy_considered;
@synthesize choice_made = _choice_made;
@synthesize iterations_wait = _iterations_wait;
@synthesize iterations_cheaper = _iterations_cheaper;
@synthesize iterations_no_money = _iterations_no_money;
@synthesize iterations_poor_student = _iterations_poor_student;



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
static inline int skRand(int low, int high){
    
    return arc4random()%(high-low) + low;//why no +1? high is already +1, of sorts.
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(void)dismissKeyboard{
    [input_hanyu0 resignFirstResponder];
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(int)parse_amounts:(NSString *) s1_amount{
    
    int amount = 0;
    NSArray *chinese_numbers = [[NSArray alloc] initWithObjects: @"十", @"九", @"八", @"七",@"六", @"五", @"四", @"三",@"二", @"一", nil];
    
    NSArray *chinese_amounts = [[NSArray alloc] initWithObjects:  @"十", @"九", @"八", @"七",@"六", @"五", @"四", @"三",@"两", @"一", nil];
    
    if (s1_amount.length > 0){
        //IF INPUT AN AMOUNT:
        
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        if(s1_amount.length == 1)
        {
            NSLog(@"bought <=10");
            
            for (int i = 0; i < chinese_amounts.count; ++i){
                if ([s1_amount isEqualToString:chinese_amounts[i]]){
                    amount = i+1; //1 is mapped to 0, 2 to 1, etc.
                }
            }
            NSLog(@"%d",amount);
        }
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        else if (s1_amount.length == 2)
        {
            NSString *s1_amount_first_char = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            //~~~~~~~~~~~~~~~~~
            //Cases eleven, twelve, ..., nineteen:
            if ([s1_amount_first_char isEqualToString: @"十"])
            {
                NSLog(@"bought 10+some");
                //map second character to integers
                amount = 10;
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_second_char isEqualToString:chinese_amounts[i]]){
                        amount += 10-i; //1 is mapped to 9, 2 to 8, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            //~~~~~~~~~~~~~~~~~
            //Cases ten, twenty, thirty, ..., ninety
            else if ([s1_amount_second_char isEqualToString: @"十"])
            {
                
                NSLog(@"bought some tens");
                //map first char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
            }
            //~~~~~~~~~~~~~~~~~
            //Cases one hundred, two hundred, ..., nine hundred
            else if ([s1_amount_second_char isEqualToString: @"百"])
            {
                NSLog(@"bought some hundred");
                //map first char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                
            }
            else
            {
                NSLog(@"buy less ba");
            }
            
        }
        
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //Cases ninety-five, thirty-two, one hundred sixty (yi bai liu), etc.
        else if (s1_amount.length == 3)
        {
            NSString *s1_amount_first_char = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_amount_third_char = [s1_amount substringWithRange:NSMakeRange(2, 1)];
            
            //~~~~~~~~~~~~~~~~~
            //Cases fifty-six, thirty-five, etc.:
            if ([s1_amount_second_char isEqualToString: @"十"])
            {
                NSLog(@"bought some tens + some digits");
                //map first and third character to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_amounts[i]]){
                        amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
            }
            //~~~~~~~~~~~~~~~~~
            //Cases one hundred fifty, two hundred sixty, etc
            else if ([s1_amount_second_char isEqualToString: @"百"])
            {
                if([s1_amount_third_char isEqualToString: @"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    amount += 10;
                }
                else{
                    NSLog(@"bought some hundred + some tens");
                    //map first and third char to integers
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
            }
            else
            {
                NSLog(@"buy less ba");
            }
            
        }
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //Cases e.g. 103 yi bai ling san, can do more
        else if (s1_amount.length == 4)
        {
            NSString *s1_amount_first_char  = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_amount_third_char  = [s1_amount substringWithRange:NSMakeRange(2, 1)];
            NSString *s1_amount_fourth_char = [s1_amount substringWithRange:NSMakeRange(3, 1)];
            
            //~~~~~~~~~~~~~~~~~
            //Cases one hundred three, two hundred four, ...,
            if ([s1_amount_second_char isEqualToString: @"百"])
            {
                if ([s1_amount_third_char isEqualToString: @"零"])
                {
                    NSLog(@"bought some hundred + some tens");
                    //map first and third char to integers
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_amounts.count; ++i){
                        if ([s1_amount_fourth_char isEqualToString:chinese_amounts[i]]){
                            amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                else if([s1_amount_third_char isEqualToString:@"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    amount += 10;
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                
                else if ([s1_amount_fourth_char isEqualToString: @"十"])
                {
                    NSLog(@"bought some hundred + some tens");
                    //map first and third char to integers
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                
            }
            else if ([s1_amount_second_char isEqualToString: @"千"]){
                if ([s1_amount_fourth_char isEqualToString: @"百"])
                {
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    
                }
                else if ([s1_amount_third_char isEqualToString: @"零"])
                {
                    if([s1_amount_fourth_char isEqualToString: @"十"]){
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                                amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                            }
                        }
                        amount += 10;
                    }
                    else{
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                                amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                            }
                        }
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                                amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
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
                            amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    
                }
                else if([s1_amount_third_char isEqualToString: @"零"] ){
                    if([s1_amount_fourth_char isEqualToString: @"十"]){
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                                amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
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
        
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //Cases e.g. 125, 13100, 1310
        else if (s1_amount.length == 5){
            NSString *s1_amount_first_char  = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_amount_third_char  = [s1_amount substringWithRange:NSMakeRange(2, 1)];
            NSString *s1_amount_fourth_char = [s1_amount substringWithRange:NSMakeRange(3, 1)];
            NSString *s1_amount_fifth_char  = [s1_amount substringWithRange:NSMakeRange(4, 1)];
            
            //~~~~~~~~~~~~~~~~~
            //Cases one hundred three, two hundred four, ...,
            if ([s1_amount_second_char isEqualToString: @"百"]){
                //map first char -> number of hundreds
                //map third char -> number of tens
                //fourth -> shi
                //map fifth char -> number of singles
                
                
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                
                NSLog(@"%d",amount);
                
                
            }
            if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_fourth_char isEqualToString:@"百"]){
                
                //x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            
            
            if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_fourth_char isEqualToString:@"千"] ){
                
                
                
                //x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                
                NSLog(@"%d",amount);
                
            }
            if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_third_char isEqualToString:@"零"]){
                
                
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                if([s1_amount_fourth_char isEqualToString: @"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    amount += 10;
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                else{
                    
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                NSLog(@"%d",amount);
                
            }
            else if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_third_char isEqualToString:@"零"]){
                if([s1_amount_fourth_char isEqualToString: @"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    amount += 10;
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                else{
                    //x10000 + y1000 + z100 = 13,100 and etc.
                    NSLog(@"bought some hundred + some tens");
                    //map first and third char to integers
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
            }
            else if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_fourth_char isEqualToString:@"百"]& [s1_amount_fifth_char isEqualToString:@"十"]){
                
                //x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                amount += 10; //from the final shi
                NSLog(@"%d",amount);
            }
            else if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_third_char isEqualToString:@"零"]){
                
                //x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
            }
            else{
                NSLog(@"buy less ba");
            }
        }
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //Cases e.g. 125, 13100, 1310 三千四百五十, 三万四千五百
        else if (s1_amount.length == 6){
            NSString *s1_amount_first_char  = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_amount_third_char  = [s1_amount substringWithRange:NSMakeRange(2, 1)];
            NSString *s1_amount_fourth_char = [s1_amount substringWithRange:NSMakeRange(3, 1)];
            NSString *s1_amount_fifth_char  = [s1_amount substringWithRange:NSMakeRange(4, 1)];
            NSString *s1_amount_sixth_char  = [s1_amount substringWithRange:NSMakeRange(5, 1)];
            
            //~~~~~~~~~~~~~~~~~
            //Cases one hundred three, two hundred four, ...,
            if (([s1_amount_second_char isEqualToString: @"千"]) & ([s1_amount_fourth_char isEqualToString: @"百"])& ([s1_amount_sixth_char isEqualToString: @"十"])){
                //map first char -> number of hundreds
                //map third char -> number of tens
                //fourth -> shi
                //map fifth char -> number of singles
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
            }
            else if (([s1_amount_second_char isEqualToString: @"万"]) & ([s1_amount_fourth_char isEqualToString: @"千"])& ([s1_amount_sixth_char isEqualToString: @"百"])){
                //map first char -> number of hundreds
                //map third char -> number of tens
                //fourth -> shi
                //map fifth char -> number of singles
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                
                
                NSLog(@"%d",amount);
                
                
            }
            else if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_fourth_char isEqualToString:@"百"]){
                
                //x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                if([s1_amount_fifth_char isEqualToString:@"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    amount += 10; //just one shi
                    for (int i = 0; i < chinese_amounts.count; ++i){
                        if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                else{
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_amounts.count; ++i){
                        if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                NSLog(@"%d",amount);
                
            }
            
            //1035: 一千零三十五
            else if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_third_char isEqualToString:@"零"]){
                
                //x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            else if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_fourth_char isEqualToString:@"千"]){
                
                //x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            else if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_third_char isEqualToString:@"零"]){
                
                //x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            
            else if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_fourth_char isEqualToString:@"千"]& [s1_amount_fifth_char isEqualToString:@"零"]){
                
                //x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            
            else if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_third_char isEqualToString:@"零"]){
                
                //x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            else if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_fourth_char isEqualToString:@"百"]& [s1_amount_fifth_char isEqualToString:@"零"]){
                
                //x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]] || [s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            else{
                NSLog(@"buy less ba");
            }
            
        }
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //Cases e.g. 三千四百五十六
        else if (s1_amount.length == 7){
            NSString *s1_amount_first_char  = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_amount_third_char  = [s1_amount substringWithRange:NSMakeRange(2, 1)];
            NSString *s1_amount_fourth_char = [s1_amount substringWithRange:NSMakeRange(3, 1)];
            NSString *s1_amount_fifth_char  = [s1_amount substringWithRange:NSMakeRange(4, 1)];
            NSString *s1_amount_sixth_char = [s1_amount substringWithRange:NSMakeRange(5, 1)];
            NSString *s1_amount_seventh_char  = [s1_amount substringWithRange:NSMakeRange(6, 1)];
            
            //~~~~~~~~~~~~~~~~~
            //Cases one hundred three, two hundred four, ...,
            if ([s1_amount_second_char isEqualToString: @"百"]){
                //map first char -> number of hundreds
                //map third char -> number of tens
                //fourth -> shi
                //map fifth char -> number of singles
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_numbers[i]] || [s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_amounts[i]]){
                        amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
                
            }
            //Cases e.g. 三千四百五十六
            if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_fourth_char isEqualToString:@"百"]){
                
                //x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_amounts[i]]){
                        amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                if([s1_amount_sixth_char isEqualToString:@"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_seventh_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                NSLog(@"%d",amount);
                
            }
            if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_fourth_char isEqualToString:@"千"] && [s1_amount_sixth_char isEqualToString:@"百"]){
                
                //x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                amount += 10;
                NSLog(@"%d",amount);
                
            }
            
            
            if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_fourth_char isEqualToString:@"千"]& [s1_amount_fifth_char isEqualToString:@"零"]){
                if([s1_amount_sixth_char isEqualToString: @"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                            amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    amount += 10;
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_seventh_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                else{
                    //x10000 + y1000 + z100 = 13,100 and etc.
                    NSLog(@"bought some hundred + some tens");
                    //map first and third char to integers
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                            amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_third_char isEqualToString:chinese_amounts[i]]){
                            amount += (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
            }
            
            else{
                NSLog(@"buy less ba");
            }
            
        }
        //Cases e.g. 三千四百五十六
        else if (s1_amount.length == 8){
            NSString *s1_amount_first_char  = [s1_amount substringWithRange:NSMakeRange(0, 1)];
            NSString *s1_amount_second_char = [s1_amount substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_amount_third_char  = [s1_amount substringWithRange:NSMakeRange(2, 1)];
            NSString *s1_amount_fourth_char = [s1_amount substringWithRange:NSMakeRange(3, 1)];
            NSString *s1_amount_fifth_char  = [s1_amount substringWithRange:NSMakeRange(4, 1)];
            NSString *s1_amount_sixth_char = [s1_amount substringWithRange:NSMakeRange(5, 1)];
            NSString *s1_amount_seventh_char  = [s1_amount substringWithRange:NSMakeRange(6, 1)];
            NSString *s1_amount_eighth_char  = [s1_amount substringWithRange:NSMakeRange(7, 1)];
            
            //~~~~~~~~~~~~~~~~~
            //Cases one hundred three, two hundred four, ...,
            if ([s1_amount_second_char isEqualToString: @"万"] && [s1_amount_fourth_char isEqualToString:@"千"]){
                
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]] || [s1_amount_first_char isEqualToString:chinese_numbers[i]]){
                        amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_amounts[i]]||[s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                if([s1_amount_fifth_char isEqualToString:@"零"] && [s1_amount_seventh_char isEqualToString:@"十"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_eighth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                }
                else if([s1_amount_sixth_char isEqualToString:@"百"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    if([s1_amount_eighth_char isEqualToString:@"十"]){
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_seventh_char isEqualToString:chinese_numbers[i]]){
                                amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                            }
                        }
                    }
                    else if([s1_amount_seventh_char isEqualToString:@"零"]){
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_eighth_char isEqualToString:chinese_numbers[i]]){
                                amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                            }
                        }
                    }
                }
                NSLog(@"%d",amount);
                
            }
            if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_fourth_char isEqualToString:@"百"]){
                
                //x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_third_char isEqualToString:@"零"]&&[s1_amount_fifth_char isEqualToString:@"百"]&&[s1_amount_seventh_char isEqualToString:@"十"]){
                
                //x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_eighth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            if (([s1_amount_second_char isEqualToString: @"千"])& [s1_amount_third_char isEqualToString:@"零"]&&[s1_amount_fifth_char isEqualToString:@"百"]&&[s1_amount_seventh_char isEqualToString:@"十"]){
                
                //x1000 + y100 + z10 = 1310 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_fourth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_sixth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_eighth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            
            
            if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_fourth_char isEqualToString:@"千"] &&[s1_amount_sixth_char isEqualToString:@"百"] && [s1_amount_eighth_char isEqualToString:@"十"] ){
                
                //x10000 + y1000 + z100 = 13,100 and etc.
                NSLog(@"bought some hundred + some tens");
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_seventh_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                NSLog(@"%d",amount);
                
            }
            
            if (([s1_amount_second_char isEqualToString: @"万"])& [s1_amount_fourth_char isEqualToString:@"千"] &&[s1_amount_sixth_char isEqualToString:@"百"] && [s1_amount_seventh_char isEqualToString:@"零"] ){
                
                //
                //map first and third char to integers
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_amounts[i]]){
                        amount += (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_amounts.count; ++i){
                    if ([s1_amount_eighth_char isEqualToString:chinese_numbers[i]]){
                        amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
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
            
            //~~~~~~~~~~~~~~~~~
            //Cases one hundred three, two hundred four, ...,
            if ([s1_amount_second_char isEqualToString: @"万"] && [s1_amount_fourth_char isEqualToString:@"千"]){
                
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_first_char isEqualToString:chinese_amounts[i]]){
                        amount = (10-i)*10000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                for (int i = 0; i < chinese_numbers.count; ++i){
                    if ([s1_amount_third_char isEqualToString:chinese_amounts[i]]){
                        amount += (10-i)*1000; //1 is mapped to 0, 2 to 1, etc.
                    }
                }
                
                if([s1_amount_sixth_char isEqualToString:@"百"]){
                    for (int i = 0; i < chinese_numbers.count; ++i){
                        if ([s1_amount_fifth_char isEqualToString:chinese_numbers[i]]){
                            amount += (10-i)*100; //1 is mapped to 0, 2 to 1, etc.
                        }
                    }
                    if([s1_amount_eighth_char isEqualToString:@"十"]){
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_seventh_char isEqualToString:chinese_numbers[i]]){
                                amount += (10-i)*10; //1 is mapped to 0, 2 to 1, etc.
                            }
                        }
                        for (int i = 0; i < chinese_numbers.count; ++i){
                            if ([s1_amount_ninth_char isEqualToString:chinese_numbers[i]]){
                                amount += (10-i); //1 is mapped to 0, 2 to 1, etc.
                            }
                        }
                    }
                }
            }
        }
        else{
            NSLog(@"ok buy less");
            //^do above in text box
        }
        
    }//if block end for length of amount > 0
    
    //if amount string is zero, user meant 1!
    
    else{
        NSLog(@"default at 1!");
        //^do above in text box
        amount = 1;
    }
    NSLog(@"parser parsed amount:");
    NSLog(@"%d",amount);
    return amount;
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(void)unhide_dialogue_choices{

    for (SKLabelNode *label in _dialogue_master.children){
        label.hidden = false;
    }

    
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(void)handle_shopping:(NSString *) purchase_request{
    NSLog(@"girls just wanna have fun~~");
    
    NSRange r= [purchase_request rangeOfString:@"个"]; //loc of measure word
    //r.location
    if (r.location != NSNotFound){
        NSString *s1 = [purchase_request substringWithRange:NSMakeRange(0, r.location)]; //second argument of NSMakeRange is length
        NSString *s2 = [purchase_request substringWithRange:NSMakeRange(r.location+1, (purchase_request.length-1)-r.location)];
        NSLog(s1);
        //no using unichar, can't handle the encoding for symbols
        NSString *s1_begin = [s1 substringWithRange:NSMakeRange(0, 1)];
        
        int amount = 0; //amount!!
        //First extract the number
        if([s1_begin isEqualToString:@"我"]){
            
            NSString *s1_second_char = [s1 substringWithRange:NSMakeRange(1, 1)];
            NSString *s1_third_char = [s1 substringWithRange:NSMakeRange(2, 1)];
            
            
            if( //handle two-character combos before the number:
               ( ([s1_second_char isEqualToString: @"想"]) && ([s1_third_char isEqualToString: @"要"]))
               || (([s1_second_char isEqualToString: @"想"]) && ([s1_third_char isEqualToString: @"买"]))
               || (([s1_second_char  isEqualToString: @"要"]) && ([s1_third_char isEqualToString: @"买"]))
               )
            {
                NSString *s1_amount = [s1 substringWithRange:NSMakeRange(3, (s1.length)-3)];//length - 3 prev chars
                amount = [self parse_amounts:s1_amount];
                NSLog(@"out of the woooooooods~");
                NSLog(@"%d",amount);
            }
        }
        
        else{
            _store_chat_window.hidden = true;
            _store_chat_longer_sentence.hidden = false;
        }
    }
    else{
        _store_chat_window.hidden = true;
        _store_chat_longer_sentence.hidden = false;
    }
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(void)seller_responses:(NSString*)store_owner_response{
    
    for (UIView *subview in [self.view subviews]) {
        // Only remove the subviews with tag not equal to 1
        if (subview.tag == 9) {
            [subview removeFromSuperview];
        }
    }
    
    UILabel *explanationField = [[UILabel alloc] initWithFrame:self.frame];
    explanationField.tag = 9;
    [explanationField setFont:[UIFont fontWithName:@"EuphemiaUCAS-Bold" size:8.0f]];
    explanationField.textColor=[UIColor blackColor];
    explanationField.backgroundColor=[UIColor whiteColor];
    explanationField.alpha = 0.8;
    explanationField.numberOfLines = 2;
    //string of explanation~~~~~~~~~~~
    NSString *explanation=store_owner_response;
    //~~~~~~~~~~~~~~~~~~~end explanation
    explanationField.text = explanation;
    explanationField.adjustsFontSizeToFitWidth = true;
    explanationField.textAlignment = NSTextAlignmentCenter;
    CGPoint positionInScene = CGPointMake(_stick_figure.position.x + 0.5*_stick_figure.frame.size.width, _stick_figure.position.y + 0.1* _stick_figure.frame.size.height);
    
    CGFloat xPosition = positionInScene.x;
    CGFloat yPosition = positionInScene.y;
    
    CGRect labelFrame = explanationField.frame;
    [explanationField adjustsFontSizeToFitWidth ];
    explanationField.frame = labelFrame;
    [explanationField sizeToFit];
    
    CGRect frame = explanationField.frame;
    frame.origin.y= yPosition;//pass the cordinate which you want
    frame.origin.x= xPosition;//pass the cordinate which you want
    explanationField.frame= frame;
    
    
    explanationField.layer.borderColor = [UIColor blackColor].CGColor;
    explanationField.layer.borderWidth = 1.0;
    
    [self.view addSubview:explanationField];
    
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(void)handle_haggle:(float)requested_price actual_price:(float)actual_price probability_change:(float)prob_change magnitude_change:(float)magn_change{
    if(_price_userRequest < 0.2* actual_price){
        //if someone tries to haggle this hard, seller knows the guy is looking for impossible deals
        prob_change = 0.8;
        _probability_success_haggle = prob_change * _probability_success_haggle;
        [self seller_responses:@"不好啊，我为做好这个付的钱比你刚才说的更多啊！肯定不能啊。"];
    }
    else if(_price_userRequest > 0.8* actual_price){
        //definitely sold
    }
    int upper_bound = 1000;
    int k = skRand(0, upper_bound);
    if(k <= prob_change * upper_bound){
        
        _probability_success_haggle = 1.2* _probability_success_haggle; //it's going well, one success
        int mid_price = 0.5*(_price_userRequest + actual_price);
        NSLog(@"%d",mid_price);
        actual_price = mid_price + magn_change*abs(actual_price - mid_price);
        
        _trophy_prices[_trophy_considered] =[NSString stringWithFormat:@"%f",actual_price];
        
        NSString *s1 = @"好，";
        NSString *s2 = [NSString stringWithFormat:@"%0.2f", actual_price];
        NSString *s3 = @"快，好吗?";
        NSString *response=[NSString stringWithFormat:@"%@%@%@",s1, s2, s3];
        [self seller_responses:response];
        
    }
    
    
}




//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(void)show_dialogue:(NSString*)store_owner_question item_cost_text:(NSString*)item_cost_text price:(float)price touch_loc:(CGPoint)touchLocationInView{
    
    for (UIView *subview in [self.view subviews]) {
        // Only remove the subviews with tag not equal to 1
        if (subview.tag == 9) {
            [subview removeFromSuperview];
        }
    }
    
    UILabel *explanationField = [[UILabel alloc] initWithFrame:self.frame];
    explanationField.tag = 9;
    [explanationField setFont:[UIFont fontWithName:@"EuphemiaUCAS-Bold" size:8.0f]];
    explanationField.textColor=[UIColor blackColor];
    explanationField.backgroundColor=[UIColor whiteColor];
    explanationField.alpha = 0.8;
    explanationField.numberOfLines = 4;
    //string of explanation~~~~~~~~~~~
    NSString *str1=store_owner_question;
    NSString *str2= item_cost_text;
    NSString *str3 = [NSString stringWithFormat:@"%.1f", price];
    NSString *str4 = @"快";
    NSString *explanation=[NSString stringWithFormat:@"%@\n%@\n%@%@\n",str1,str2, str3, str4];
    //~~~~~~~~~~~~~~~~~~~end explanation
    explanationField.text = explanation;
    explanationField.adjustsFontSizeToFitWidth = true;
    explanationField.textAlignment = NSTextAlignmentCenter;
    CGPoint positionInScene = CGPointMake(_stick_figure.position.x + 0.5*_stick_figure.frame.size.width, _stick_figure.position.y + 0.1* _stick_figure.frame.size.height);
    
    CGFloat xPosition = positionInScene.x;
    CGFloat yPosition = positionInScene.y;
    
    CGRect labelFrame = explanationField.frame;
    [explanationField adjustsFontSizeToFitWidth ];
    explanationField.frame = labelFrame;
    [explanationField sizeToFit];
    
    CGRect frame = explanationField.frame;
    frame.origin.y= yPosition;//pass the cordinate which you want
    frame.origin.x= xPosition;//pass the cordinate which you want
    explanationField.frame= frame;
    
    
    explanationField.layer.borderColor = [UIColor blackColor].CGColor;
    explanationField.layer.borderWidth = 1.0;
    
    [self.view addSubview:explanationField];
    
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:0];
        
    }
    return self;
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(void)didMoveToView:(SKView *)view {
    
    _probability_success_haggle = 0.01;
    _trophy_prices = [[NSMutableArray alloc] initWithObjects: @"30000", @"36000", @"900", @"9000", @"9000", nil];
    _choice_made = @"";
    //SET Keyboard for the lesson:
    
    NSMutableArray *k =[[NSMutableArray alloc] initWithObjects: @" ", @" ", @" ",@"万", @"千", @"百", @"零", @"个", @" ",  @" ",  @" ", @"一", @"二", @"两", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", nil];
    
    NSMutableArray *kshift = [[NSMutableArray alloc] initWithObjects: @" ", @" ", @" ",@"万", @"千", @"百", @"零", @"个", @" ",  @" ",  @" ", @"一", @"二", @"两", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", nil];
    
    NSMutableArray *kalt = [[NSMutableArray alloc] initWithObjects:@" ", @" ", @" ",@"万", @"千", @"百", @"零", @"个", @" ",  @" ",  @" ", @"一", @"二", @"两", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", nil];
    
    [GameState sharedInstance].keyboard_characters = k;
    [GameState sharedInstance].keyboard_characters_shift = kshift;
    [GameState sharedInstance].keyboard_characters_alt = kalt;
    
    
    _customKeyboard = [[PMCustomKeyboard alloc] init];
    
    // Score
    //~~~~~~~~~~~~~~~~~~~~~
    _lblScore = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    _lblScore.fontSize = 12;
    _lblScore.fontColor = [SKColor redColor];
    _lblScore.position = CGPointMake(self.frame.origin.x + 0.7*self.frame.size.width,self.frame.origin.y + 0.80*self.frame.size.height);
    [_lblScore setText:@"0"];
    [_lblScore setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
    [self addChild:_lblScore];
    
    //to be put next to score
    SKLabelNode *currency = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    currency.fontSize = 12;
    currency.fontColor = [SKColor redColor];
    [currency setText:@"RMB (快/元)"];
    currency.position = CGPointMake(0.5*(_lblScore.position.x + _lblScore.frame.size.width + self.frame.size.width),_lblScore.position.y);
    [self addChild:currency];
    
    int shifted_y = 10;
    double pad = 5;
    double padding = 0.2;
    
    //scene controller~~~~~~~~~~~~
    _go_back = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
    _go_back.name = @"go_back";
    _go_back.fontSize = 12;
    _go_back.text = @"Go Back";
    _go_back.zPosition = 1;
    _go_back.fontColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1];
    _go_back.position = CGPointMake(CGRectGetMinX(self.frame)+50, CGRectGetMinY(self.frame)+50);
    SKSpriteNode *button_dialog = [SKSpriteNode spriteNodeWithImageNamed:@"return"];
    button_dialog.xScale = 0.8;
    button_dialog.yScale = 0.55;
    button_dialog.zPosition = 0.5;
    button_dialog.position = CGPointMake(_go_back.position.x,_go_back.position.y+ padding* _go_back.frame.size.height);
    
    [self addChild:button_dialog];
    [self addChild: _go_back];
    //~~~~~~~~~~~~~~~~scene controller
    
    
    
    
    _store_chat_window = [SKSpriteNode spriteNodeWithImageNamed:@"store_chat_box"];
    [_store_chat_window setScale:0.5];
    _store_chat_window.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) - (2*pad)*shifted_y);
    _store_chat_window.hidden = true;
    
    _store_chat_longer_sentence = [SKSpriteNode spriteNodeWithImageNamed:@"chat_longer_sentence"];
    [_store_chat_longer_sentence setScale:0.5];
    _store_chat_longer_sentence.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) - (2*pad)*shifted_y);
    _store_chat_longer_sentence.hidden = true;
    
    
    
    input_hanyu0 = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width/4,0.5*(CGRectGetMinY(self.frame)+0.5*CGRectGetMaxY(self.frame) ), 150, 30)];
    input_hanyu0.borderStyle = UITextBorderStyleRoundedRect;
    input_hanyu0.textColor = [UIColor blackColor];
    input_hanyu0.font = [UIFont systemFontOfSize:12.0];
    input_hanyu0.placeholder = @"你想多少钱？加油！";
    input_hanyu0.backgroundColor = [UIColor whiteColor];
    input_hanyu0.autocorrectionType = UITextAutocorrectionTypeNo;
    input_hanyu0.tag = 7;
    input_hanyu0.clearButtonMode = UITextFieldViewModeWhileEditing;
    [input_hanyu0 setDelegate:self];
    [input_hanyu0 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    input_hanyu0.hidden = true;
    
    [_customKeyboard setTextView:input_hanyu0];
    
    //the following block makes it such that tapping outside the textfield dismisses the keyboard~~~
    [self.view addSubview:input_hanyu0];
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    _tap.numberOfTapsRequired = 2; //if this is not specified, computer gets confused-- can't tell what is purposeful click
    [self.view addGestureRecognizer:_tap];
    
    

    
    SKSpriteNode *table = [SKSpriteNode spriteNodeWithImageNamed:@"goods_table"];
    [table setScale:0.27];
    table.xScale=0.3;
    table.yScale=0.27;
    table.zPosition = 0.8;
    table.position =  CGPointMake(CGRectGetMidX(self.frame)+10, CGRectGetMidY(self.frame)-60);
    table.name = @"table";
    table.hidden = false;
    [self addChild: table];
    
    SKSpriteNode *trophy_happyMan = [SKSpriteNode spriteNodeWithImageNamed:@"trophy_happyMan"];
    [trophy_happyMan setScale:0.25];
    trophy_happyMan.zPosition = 1;
    trophy_happyMan.position =  CGPointMake( table.position.y - (0.3*table.frame.size.width - table.frame.origin.x), table.position.y+(pad-1)*shifted_y);
    trophy_happyMan.name = @"trophy_happyMan";
    trophy_happyMan.hidden = false;
    
    SKSpriteNode *trophy_catThing = [SKSpriteNode spriteNodeWithImageNamed:@"trophy_catThing"];
    [trophy_catThing setScale:0.2];
    trophy_catThing.zPosition = 1;
    trophy_catThing.position =  CGPointMake(trophy_happyMan.position.x+40, trophy_happyMan.position.y -shifted_y );
    trophy_catThing.name = @"trophy_catThing";
    trophy_catThing.hidden = false;
    
    SKSpriteNode *trophy_happyManFeather = [SKSpriteNode spriteNodeWithImageNamed:@"trophy_happyManFeather"];
    [trophy_happyManFeather setScale:0.25];
    trophy_happyManFeather.zPosition = 1;
    trophy_happyManFeather.position =  CGPointMake(trophy_catThing.position.x+40, trophy_catThing.position.y - shifted_y);
    trophy_happyManFeather.name = @"trophy_happyManFeather";
    trophy_happyManFeather.hidden = false;
    
    SKSpriteNode *trophy_Horse = [SKSpriteNode spriteNodeWithImageNamed:@"trophy_Horse"];
    [trophy_Horse setScale:0.35];
    trophy_Horse.zPosition = 1;
    trophy_Horse.position =  CGPointMake(trophy_happyManFeather.position.x+40, trophy_happyManFeather.position.y + shifted_y);
    trophy_Horse.name = @"trophy_Horse";
    trophy_Horse.hidden = false;
    
    
    SKSpriteNode *trophy_oldMan = [SKSpriteNode spriteNodeWithImageNamed:@"trophy_oldMan"];
    [trophy_oldMan setScale:0.25];
    trophy_oldMan.zPosition = 1;
    trophy_oldMan.position =  CGPointMake(trophy_Horse.position.x + 40, trophy_Horse.position.y);
    trophy_oldMan.name = @"trophy_oldMan";
    trophy_oldMan.hidden = false;
    
    
    
    
    _stick_figure = [SKSpriteNode spriteNodeWithImageNamed:@"stick_figure"];
    //[sn setScale:SKSceneScaleModeAspectFill * 0.2];
    [_stick_figure setScale: 0.45];
    _stick_figure.zPosition = 1;
    _stick_figure.position = CGPointMake(CGRectGetMinX(self.frame)+30, CGRectGetMidY(self.frame)-pad*shifted_y );
    _stick_figure.name = @"stick_figure";
    
    _store_chat_window.position = CGPointMake(_stick_figure.position.x + 0.8*_stick_figure.frame.size.width, _stick_figure.position.y + 0.5*_stick_figure.frame.size.height);
    _store_chat_window.zPosition = 1.2;
    _store_chat_longer_sentence.position = CGPointMake(_stick_figure.position.x + 0.8*_stick_figure.frame.size.width, _stick_figure.position.y + 0.5*_stick_figure.frame.size.height);
    _store_chat_longer_sentence.zPosition = 1.2;
    
    [self addChild:_stick_figure];
    self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    self.anchorPoint = CGPointZero;
    
    
    
    self.dialogue_master = [SKNode node];
    
    
    
    _request_cheaper = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
    _request_cheaper.name = @"cheaper";
    _request_cheaper.fontSize = 12;
    _request_cheaper.text = @"可以便宜一点儿吗？";
    _request_cheaper.zPosition = 1;
    _request_cheaper.fontColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1];
    _request_cheaper.position = CGPointMake(CGRectGetMidX(self.frame), table.position.y- 0.5*table.frame.size.height);
    _request_cheaper.hidden = true;
    
    _request_meiyou_qian = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
    _request_meiyou_qian.name = @"no_money";
    _request_meiyou_qian.fontSize = 12;
    _request_meiyou_qian.text = @"不过我没有钱呢。。能不能降价啊？";
    _request_meiyou_qian.zPosition = 1;
    _request_meiyou_qian.fontColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1];
    _request_meiyou_qian.position = CGPointMake(_request_cheaper.position.x, _request_cheaper.position.y - 20);
    _request_meiyou_qian.hidden = true;
    
    _request_wait = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
    _request_wait.name = @"wait";
    _request_wait.fontSize = 12;
    _request_wait.text = @"考虑一下";
    _request_wait.zPosition = 1;
    _request_wait.fontColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1];
    _request_wait.position = CGPointMake(_request_meiyou_qian.position.x, _request_meiyou_qian.position.y - 20);
    _request_wait.hidden = true;
    
    _request_material = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
    _request_material.name = @"material";
    _request_material.fontSize = 12;
    _request_material.text = @"材料是什么？";
    _request_material.zPosition = 1;
    _request_material.fontColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _request_material.position = CGPointMake(_request_wait.position.x, _request_wait.position.y - 20);
    _request_material.hidden = true;
    
    _request_poor_student = [SKLabelNode labelNodeWithFontNamed:@"EuphemiaUCAS-Bold"];
    _request_poor_student.name = @"poor_student";
    _request_poor_student.fontSize = 12;
    _request_poor_student.text = @"我很喜欢，但是我是一个穷的学生。。";
    _request_poor_student.zPosition = 1;
    _request_poor_student.fontColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _request_poor_student.position = CGPointMake(_request_material.position.x, _request_material.position.y - 20);
    _request_poor_student.hidden = true;

    [_dialogue_master addChild:_request_poor_student];
    [_dialogue_master addChild:_request_meiyou_qian];
    [_dialogue_master addChild:_request_wait];
    [_dialogue_master addChild:_request_material];
    [_dialogue_master addChild:_request_cheaper];
    [self addChild:_dialogue_master];
    
    
    
    SKSpriteNode *background_image = [SKSpriteNode spriteNodeWithImageNamed:@"beijing_restaurant"];
    [background_image setScale:SKSceneScaleModeAspectFill];
    background_image.zPosition = -0.7;
    background_image.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)  );
    background_image.name = @"background_image";
    [self addChild:background_image];
    
    
    [self addChild:_store_chat_window];
    [self addChild:_store_chat_longer_sentence];
    [self addChild:trophy_catThing];
    [self addChild:trophy_happyMan];
    [self addChild:trophy_happyManFeather];
    [self addChild:trophy_Horse];
    [self addChild:trophy_oldMan];


    _iterations_cheaper = 0;
    _iterations_wait = 0;
    _iterations_no_money = 0;
    _iterations_poor_student = 0;
    
    
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
            
            
            
            if( [node.name isEqualToString:@"stick_figure"]){
                
                for (UIView *subview in [self.view subviews]) {
                    
                    if (subview.tag == 9) {
                        [subview removeFromSuperview];
                    }
                }
                
                _store_chat_window.hidden = false;
                input_hanyu0.hidden = false;
                
                
            }
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~INITIALIZE HAGGLE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //~~~~~~~~~~~~~~~~~~~~~~~TROPHIES BEGIN
            if([node.name isEqualToString: @"trophy_Horse"]){
                _trophy_considered = 0;
            [self show_dialogue:@"你喜欢那个吗？" item_cost_text:@"那个三万呢。" price:[_trophy_prices[_trophy_considered] intValue] touch_loc:touchLocationInView];
               
                [self unhide_dialogue_choices];
                
                
            }
            if([node.name isEqualToString: @"trophy_catThing"]){
                _trophy_considered = 1;
                [self show_dialogue:@"这个很有意思，是好久前做的。。" item_cost_text:@"三万六千吧。" price:[_trophy_prices[_trophy_considered] intValue] touch_loc:touchLocationInView];
                [self unhide_dialogue_choices];
                
                
            }
            if([node.name isEqualToString: @"trophy_happyMan"]){
                _trophy_considered = 2;

                [self show_dialogue:@"好看，对不对？喜欢吗？" item_cost_text:@"这个九千呢。" price:[_trophy_prices[_trophy_considered] intValue] touch_loc:touchLocationInView];
                [self unhide_dialogue_choices];

            }
            if([node.name isEqualToString: @"trophy_happyManFeather"]){
                _trophy_considered = 3;
                [self show_dialogue:@"想要这个吗？" item_cost_text:@"这个九千呢。" price:[_trophy_prices[_trophy_considered] intValue] touch_loc:touchLocationInView];
                [self unhide_dialogue_choices];
                
            }
            if([node.name isEqualToString: @"trophy_oldMan"]){
                _trophy_considered = 4;
                [self show_dialogue:@"你喜欢那个吗？" item_cost_text:@"九千。" price:[_trophy_prices[_trophy_considered] intValue] touch_loc:touchLocationInView];
                [self unhide_dialogue_choices];
                
            }
            //~~~~~~~~~~~~~~~~~~~~~~~TROPHIES END
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //from trophy touch:
            //call function that unhides the haggle label nodes
            //in unhide_node_function>>call probability_of_success_haggle from if node.name == blah blah
            //request price from user, if requested_price < 0.25*price -> prob_success goes down (probsucc-30%)
            //               seller responds with midpoint x, subtract off midpoint price and midpoint
            //allow further label_hitting, also wait function ('consider...'-->prob ^+20%)
            //meiyou_qian prob+20%
            //keyi pianyi yidianer +10%
            //qiong_xuesheng +30%
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //~~~~~~~~~~~~~~~~~~~~~~~DIALOGUE OPTIONS BEGIN
            if([node.name isEqualToString: @"poor_student"]){
                _iterations_poor_student += 1;
                if (_iterations_no_money < 3){
                    [self handle_haggle:[_user_input0 floatValue] actual_price:[_trophy_prices[_trophy_considered] intValue] probability_change:(0.9*(1-0.1*_iterations_poor_student)) magnitude_change:0.1]; //want magnitude of effect-- really is complement
                }
                else{
                    [self seller_responses:@"价格特别低，我不骗着你。"];
                }
                
            }
            if([node.name isEqualToString: @"no_money"]){
                _iterations_no_money += 1;
                if (_iterations_no_money < 6){
                    [self handle_haggle:[_user_input0 floatValue] actual_price:[_trophy_prices[_trophy_considered] intValue] probability_change:(0.8*(1-0.1*_iterations_no_money)) magnitude_change:0.3];
                }
                else{
                    [self seller_responses:@"我已经给你特别好的价格"];
                }
                
            }
            if([node.name isEqualToString: @"wait"]){
                _iterations_wait += 1;
                [self handle_haggle:[_user_input0 floatValue] actual_price:[_trophy_prices[_trophy_considered] intValue] probability_change:0.3 magnitude_change:0.7];
            }
            if([node.name isEqualToString: @"cheaper"]){
                //really handle in textFieldShouldReturn function block
                input_hanyu0.hidden = false;
                _choice_made = @"cheaper";
                    
                
                
            }
            
            
            
            
            
            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            
                
                
                
            
            
            
            
        }//for all nodes
    }//for all touches
}//end of function call
//-(void)handle_shopping:(NSString *) purchase_request

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _user_input0 = textField.text;
    if(![_user_input0 isEqualToString:@""]){
        float amount = [self parse_amounts:_user_input0];
        _price_userRequest = amount;
        if([_choice_made isEqualToString: @"cheaper"]){
            _iterations_cheaper += 1;
            float actual = [_trophy_prices[_trophy_considered] intValue];
            int price_diff = actual - amount;
            float relative_diff = price_diff / actual;
            if (relative_diff < 0.50){
                [self handle_haggle:amount actual_price:actual probability_change:0.95 magnitude_change:0.5];
            }
            else if (relative_diff >= 0.25 && relative_diff < 0.50){
                [self handle_haggle:amount actual_price:actual probability_change:0.9 magnitude_change:0.5];
            }
            else{
                [self handle_haggle:amount actual_price:actual probability_change:0.7 magnitude_change:0.5];
            }
            
            [self handle_haggle:amount actual_price:actual probability_change:0.8 magnitude_change:0.5];
        }
        
        [textField resignFirstResponder];
    }
    return YES;
}



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    
    _user_input0 = @"";
    return YES;
    
    
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(BOOL)textFieldDidEndEditing:(UITextField *)textField
{
    _user_input0 = textField.text;
    [textField resignFirstResponder];
    return YES;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(BOOL)textFieldDidChange:(UITextField *)textField
{

    return YES;
    
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@end
