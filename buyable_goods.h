//
//  buyable_goods.cpp
//  HanYu4u
//
//  Created by Rachael Keller on 7/29/14.
//  Copyright (c) 2014 Rachael Keller. All rights reserved.
//

//FILE:BUYABLE_GOODS
//PURPOSE:
//   To provide the information (chinese/english) for each image on which items
//   will apppear on the screen.
//TO DO:
//   Deconstruct images into associated blocks
//   Map blocks to the items they are.

#ifndef zhongwen_7_28_14
#define zhongwen_7_28_14

#include <fstream>
#include <algorithm>
#include <unistd.h>
#include <stdio.h>
#include <time.h>
#include <iostream>
#include <vector>
#include <list>
#include <string>
#include <cctype>
#include <stack>
#include <map>





class ChineseWord{
public:
    
    //NUTS AND BOLTS:
    std::string pinyin; //holds the pinyin of the word
    std::string character; //holds the character of the word
    std::string english; //holds the english translation
    std::vector<float> origin_x;
    std::vector<float> origin_y;
    std::vector<float> width;
    std::vector<float> height;
    float price;

    //has already been flashed recently
    
    //instantiations:
    ChineseWord(): pinyin("pinyin"), character("character"), english("english"), origin_x(), origin_y(), width(), height(), price(){}
    
};



class stack_holder{
public:
    std::stack<ChineseWord> output;
    std::list<ChineseWord> for_later_use;
};




class character_and_pinyin{
public:
    
    
    //KNUTS AND BOLTS:
    std::vector<ChineseWord> items; //vector to hold each lesson's words
    stack_holder s;
    
    //The following vector of vectors holds all of the lessons.
    //Each element will point to its ordered equivalent.
    //(i.e. Lesson 1 -> v[0] (first), Lesson 2 -> v[1] (second), etc.)
    std::vector<std::vector<ChineseWord> > words_by_image;
    std::string break_up_string(std::string& s);
    std::string break_up_pinyin(std::string& s);
    std::vector<float> break_up_parameters(std::string& s);
    std::vector<float> parameters;
    std::vector<std::vector<ChineseWord> > readFile();
    std::string::iterator it_pinyin;
    std::string::iterator iter_end_input;
    
    //INSTANTIATION:
    character_and_pinyin(): items(), words_by_image(){readFile();}
    
};


//Check to see if the char c is a string or not; if so, return TRUE
inline bool space(char c){
    return isspace(c);
}



//FUNCTION: break_up_string
//RETURNS: a string of continous non-space chars
//PURPOSE:
//   To break up the string given in the argument.
inline std::string character_and_pinyin:: break_up_string(std::string& s){
    
    //Using find_if() algorithm (defined in <algorithms> to check each char in the string
    std::string::iterator it = find_if(s.begin(), s.end(), space);
    
    
    if(it != s.end())  //if there is no space, find_if returns s.end()
    {
        //cut the string up:
        std::string s_word(s.begin(), it); //there's some continuous characters up to it (the iter)
        std::string s_new(it+1, s.end());  //get the rest of the chars past the space
        s = s_new; //the string inputted is now the original string - the first 'word'
        return s_word;
        
    }
    else //no space
        return s;
    
}


//Check to see if the char c is a string or not; if so, return TRUE
inline bool star(char c){
    if(c == '*'){
        return true;
    }
    else{
        return false;
    }
}

//FUNCTION: break_up_pinyin
//RETURNS: a string of continous non-space chars
//PURPOSE:
//   To break up the string given in the argument.
inline std::string character_and_pinyin:: break_up_pinyin(std::string& s){
    
    //Using find_if() algorithm (defined in <algorithms> to check each char in the string
    it_pinyin = find_if(s.begin(), s.end(), star);
    
    
    while(it_pinyin != s.end())  //if there is no space, find_if returns s.end()
    {
        //cut the string up:
        std::string s_part1(s.begin(), it_pinyin); //there's some continuous characters up to it (the iter)
        std::string s_part2(it_pinyin+1, s.end());  //get the rest of the chars past the space
        s = s_part1 + " " + s_part2; //the string inputted is now the original string - the first 'word'
        it_pinyin = find_if(s.begin(), s.end(), star);
    }
    return s;
    
    
}

//FUNCTION: break_up_pinyin
//RETURNS: a string of continous non-space chars
//PURPOSE:
//   To break up the string given in the argument.
inline std::vector<float> character_and_pinyin:: break_up_parameters(std::string& s){
   
    parameters.clear(); //reset the float
    
    //Using find_if() algorithm (defined in <algorithms> to check each char in the string
    //iter_end_input = find_if(s.begin(), s.end(), isspace);
    //std::string mini_string = std::string(s.begin(), iter_end_input - 1);
    //s = std::string(iter_end_input, s.end());//break off the component we're parsing
    it_pinyin = find_if(s.begin(), s.end(), star);
    while(it_pinyin != s.end())  //if there is no space, find_if returns s.end()
    {
        //cut the string up:
        std::string param = std::string(s.begin(), it_pinyin); //there's some continuous characters up to it (the iter)
        
        parameters.push_back(std::stof(param));
        s = std::string(it_pinyin+1, s.end());  //get the rest of the chars past the space
        it_pinyin = find_if(s.begin(), s.end(), star);
    }
    
    return parameters;
    
}


//FUNCTION: readFile()
//RETURNS: nothing (void); DOES input words into each of the classes of character_and_pinyin
//PURPOSE:
//  To read the master file containing the Chinese words and grammars and input the
//words and information into the containers defined above (in character_and_pinyin)
inline std::vector<std::vector<ChineseWord> > character_and_pinyin:: readFile(){
    
    class ChineseWord CW; //instantiate a ChineseWord class
    
    
    //go into the app's executionable data so that zhongwen.txt will float to
    //other devices
    NSString* my_text = [[ NSBundle mainBundle] pathForResource:@"zhongwen" ofType:@"txt"]; //have cocoa find my text file
    std::string path_text( [my_text UTF8String]); //convert path to std::string for input read
    
    std::ifstream read; //open the fstream read
    read.open(path_text.c_str(), std::fstream::in); //open the master file containing the words
    
    if (read.fail()){ //if error reading in, output to terminal
        std::cout<<"Bad file read" << path_text << std::endl;
    }
    
    std::string s; //initializing a temporary string for the following getline()
    std::string temp;
    //following while block reads in the file's character and pinyin
    //for each line, we read line > set CW's assets to the read stuff > store CW
    //so each time we go through the while block, we're rewriting our instantiated CW and the strings
    while(getline(read, s)){
        
        
        //the file is set up such that after each lesson's words, there's
        //a line "Lx---------------", where x = the number lesson the above
        //words were a part of or are in the same idea as
        if(s[0] == 'F'){
            
            words_by_image.push_back(items); //push back the words into their lesson's spot
            items.clear(); //clear the lesson_words for the next lesson's words
            
        }
        
        else{
            
            CW.character = break_up_string(s); //read in character (always first)
            CW.pinyin = break_up_string(s); //read in pinyin (always second)
            CW.pinyin = break_up_pinyin(CW.pinyin);
            temp = break_up_string(s);
            CW.origin_x = break_up_parameters(temp); //read in pinyin (always second)
            temp = break_up_string(s);
            CW.origin_y = break_up_parameters(temp); //read in pinyin (always second)
            temp = break_up_string(s);
            CW.width = break_up_parameters(temp); //read in pinyin (always second)
            temp = break_up_string(s);
            CW.height = break_up_parameters(temp); //read in pinyin (always second)
            
            CW.price = ceil(std::stof(break_up_string(s)));
            CW.english = s; //rest of s is the English translation
            items.push_back(CW); //push_back the words into its lesson group
        }
    }
    
    
    read.close(); //close file
    
    return words_by_image;
}


//************************************************************************
//************************************************************************


#endif