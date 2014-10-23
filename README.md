HanYu4u
=======

Chinese Learner App Code_Xcode (in works)

This code is written for an iOS app that will be a language learning tool for students of Chinese.
TO DO: 
    --more content
    --better user-interface
    --more error-handling
    --more commenting!

Game:
1. User learns words visually and interactively by clicking on words in Chinese sentences and seeing images. (Level code)
2. User earns money by answering correctly within Dialogs. (Dialog code)
3. User goes to SmallMarket to check out items in the aisles.
   Click on some item within an image, up pops a textbox with Chinese translation.
4. User enters the MarketPlace, where s/he can haggle with the store owner to get one or more of the items on the table.

Implemented code:
    Controllers:
        Intro_Controller -- root ViewController
        BaseStoryboard -- the BiewController for the level/dialog scenes
    Keyboard:
        PMCustomKeyboard
            This is a github project by Kulpreet Chilana.
            Modifications: I have made the keyboard customizable to each Level/Dialog, so that the user
            will only have the characters that they learn (and a few others) to choose in the dialogue.
            This way, the user is not bombarded with a huge number of choices in input and the new material
            is re-emphasized.
    Scenes:
        MyScene -- base scene called by Intro_Controller, the first ViewController
        SmallMarket -- has associated images/Chinese. This info comes from zhongwen.txt and buyablegoods.h parsing it.
        MarketPlace -- base level. Right now has probabilities associated with using x,y,z techniques etc.
            HOPES: As people progress in level, can unlock more and more phrases.
        Lessons/Dialogues:
             Dialog3 -- theme: numbers. User can test their knowledge of numbers in the CPU. 
                         Program should handle most if not all from 1-1000.
            Dialog1,Dialog2, Dialog10, Dialog11 and their associated Levels -- more content 
         
    C++ info:   
        buyablegoods.h -- parses the information from zhongwen.txt
        zhongwen.txt -- holds the information (chinese,pinyin, location) on objects within each image included in the program.
           FORMAT: chinese_character pinyin a b c d 
                  pinyin is broken by '*' where the individual syllables are NOT combined into one word
                  a,b,c,d are location constants within each image

Image 'fruits' with bananas, etc. is from Flickr under Creative Commons License.
