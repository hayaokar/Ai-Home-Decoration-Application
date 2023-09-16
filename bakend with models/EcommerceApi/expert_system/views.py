from django.shortcuts import render
from experta import *
from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
# Create your views here.
global api
global choices
class design(KnowledgeEngine):
    @Rule(Fact(Room=W()))
    def ask_choice_room(self):
        self.declare(Fact(response="The Room for 1-bed room 2-children room\n"))
    @Rule(Fact(room="1"))
    def ask_budget(self):
        global api
        global choices
        self.declare(Fact(response="is your budget 1-more than 3500  2-less than 3500?\n"))
        api = "http://10.0.2.2:8000/expert/get_u_budget/"
        choices=['1-more than 3500','2-less than 2355']

    
    
    @Rule(Fact(u_budget="1"))
    def ask_space32(self):
        global api
        global choices
        self.declare(Fact(response="is your space 1- <11 m m  2- >11 m ?\n"))
        api = "http://10.0.2.2:8000/expert/get_space/"
        choices=['1- space <11 m','2- space >11 m']
    @Rule(Fact(space="1"))
    def ask_sun1(self):
        global api
        global choices
        self.declare(Fact(response="Does the sun enter the room ?\n 1-Yes 2-medium 3-No"))
        api = "http://10.0.2.2:8000/expert/get_sun1/"
        choices=['1- the sun enter the room','2- the sun enter the room partially','3- the sun does\'nt enter the room' ]
    
    @Rule(Fact(sun1='1'))
    def ask_color11(self):
        global api
        global choices
        self.declare(Fact(response="Which colors do you prefer ?\n 1-Dark colors  2-Bright colors \n"))
        api = "http://10.0.2.2:8000/expert/get_color1/"
        choices=['1- prefer dark colors','2- prefer bright colors' ]
    @Rule(Fact(color1="1"))
    def Design122(self):
            global api
            api="end"
            self.declare(Fact(response="Suggested stores : Catchy Home store / life line store .\n"
              "The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white) steel \n"
               "Tables :  one meduim size , steel legged, marble faced table \n"
              "Lightning : no need for extra lightning since your room is shiny enough \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains \n"
               "Carpet : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books,...\n"
               " TV will be putted on wall since there is no much space for that we didn' suggested TV table"))
    @Rule(Fact(color1="2"))
    def Design222(self):
            global api
            api="end"
            self.declare(Fact(response="Suggested stores : Catchy Home store / life line store .\n"
               "The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white) steel \n"
               "Tables :  one meduim size , steel legged , marble faced table \n"
              "Lightning : no need for extra lightning since your room is shiny enough \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books,vase...\n"
               "Notes :\n TV will be putted on wall since there is no much space for that we didn' suggested TV table"
               ))
    @Rule(Fact(sun1="2"))
    def ask_color22(self):
        global api
        global choices
        self.declare(Fact(response="Which colors do you prefer ?\n 1-Dark colors  2-Bright colors \n"))
        api = "http://10.0.2.2:8000/expert/get_color2/"
        choices=['1- prefer dark colors','2- prefer bright colors' ]
    @Rule(Fact(color2="1"))
    def Design91(self):
            global api
            api="end"
            self.declare(Fact(response="Suggested stores : Catchy Home store / life line store .\n"
                "The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 2 glow-lamps on the wall \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes :\n we didn't suggested you vases since there are children under 12 .\n"
               "TV will be putted on wall since there is no much space for that we didn't suggested TV table\n"))
    @Rule(Fact(color2="2"))
    def Design102(self):
            global api
            api="end"
            self.declare(Fact(response="Suggested stores : Catchy Home store / life line store .\n"
                "The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 2 glow-lamps on the wall \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books,vase...\n"
               "Notes :\n"
               "TV will be putted on wall since there is no much space for that we didn't suggested TV table\n"))
    @Rule(Fact(sun1="3"))
    def  ask_color33(self):
        global api
        global choices
        self.declare(Fact(response="Which colors do you prefer ?\n 1-Dark colors  2-Bright colors \n"))
        api = "http://10.0.2.2:8000/expert/get_color3/"
        choices=['1- prefer dark colors','2- prefer bright colors' ]
    @Rule(Fact(color3="1"))
    def Design11(self):
            global api
            api="end"
            self.declare(Fact(response="Suggested stores : Catchy Home store / life line store .\n"
                "The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 large lamps in the corner and 4 glow-lamps 2 on each wall \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes :\n we didn't suggested you vases since there are children under 12 .\n"
               "TV will be putted on wall since there is no much space for that we didn't suggested TV table\n"
               "Since you have choosen dark colors and sun don't enter the room or enters it rarely we tried to give you"
               "our best suggestion even it may will not fit in the room due to space "))
    @Rule(Fact(color3="2"))
    def Design12(self):
            global api
            api="end"
            self.declare(Fact(response="Suggested stores : Catchy Home store / life line store .\n"
                "The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 large lamps in the corner and 4 glow-lamps 2 on each wall \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books,vase...\n"
               "Notes :\n"
               "TV will be putted on wall since there is no much space for that we didn't suggested TV table\n"
               "Since you have choosen dark colors and sun don't enter the room or enters it rarely we tried to give you"
               "our best suggestion even it may will not fit in the room due to space "))
    @Rule(Fact(space="2"))
    def ask_sun24(self):
            global api
            api = "http://10.0.2.2:8000/expert/get_sun2/"
            self.declare(Fact(response="Does the sun enter the room ?\n 1-Yes 2-medium 3-No"))
    @Rule(Fact(sun2="1"))
    def ask_color44(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_color4/"
        self.declare(Fact(response="Which colors do you prefer ?\n 1-Dark colors  2-Bright colors \n"))
    @Rule(Fact(color4="1"))
    def Design77(self):
            global api
            api="end"
            self.declare(Fact(response="Suggested stores : Catchy Home store / life line store .\n"
            "The suggested furniture will be as follow \n"
              "Sofas :  2 triple sofas with a (Gold/white) steel \n"
               "Tables :  one meduim size , steel legged, marble faced table \n"
              "Lightning : no need for extra lightning since your room is shiny enough \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Carpet : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books,...\n"
               " TV will be putted on wall since there is no much space for that we didn' suggested TV table"))
    @Rule(Fact(color4="2"))
    def Design88(self):
            global api
            api="end"
            self.declare(Fact(response="Suggested stores : Catchy Home store / life line store .\n"
                "The suggested furniture will be as follow \n"
            "Sofas :  2 double sofas with a (Gold/white) steel \n"
            "Tables :  one meduim size steel legged marble face table \n"
            "Lightning : 1 large lamp in the corner and 2 glow-lamps on the wall \n"
            "Painting : one abstract large size painting \n"
            "Shelfs : one shelf \n"
            "Curtains : sheer curtains "
            "Rug : one meduim size circular carpet \n"
            "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
            "Notes :\n we didn't suggested you vases since there are children under 12 .\n "
            "TV will be putted on wall since there is no much space for that we didn' suggested TV table."
            "Since you choosed Bright colors this helped in lihgting so we didn't need to add much lightning"))
    @Rule(Fact(sun2="2"))
    def ask_colorss(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_color5/"
        self.declare(Fact(response="Which colors do you prefer ?\n 1-Dark colors  2-Bright colors \n"))
    @Rule(Fact(color5="1"))
    def Design49(self):
            global api
            api="end"
            self.declare(Fact(response="Suggested stores : Catchy Home store / life line store .\n"
                "The suggested furniture will be as follow \n"
              "Sofas :  2 triple sofas with a (Gold/white) steel \n"
               "Tables :  one meduim size , steel legged , marble faced table \n"
              "Lightning : one small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books,vase...\n"
               "Notes :\n "
               "TV will be putted on wall since there is no much space for that we didn' suggested TV table"))
    @Rule(Fact(color5="2"))
    def Design104(self):
            global api
            api="end"
            self.declare(Fact(response="Suggested stores : Catchy Home store / life line store .\n"
                "The suggested furniture will be as follow \n"
              "Sofas :  2 triple sofas with a (Gold/white) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 large lamp in the corner and 2 glow-lamps on the wall \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes :\n we didn't suggested you vases since there are children under 12 .\n "
               "TV will be putted on wall since there is no much space for that we didn' suggested TV table."
               "Since you choosed Bright colors this helped in lihgting so we didn't need to add much lightning"))
    @Rule(Fact(sun2="3"))
    def  ask_color66(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_color6/"
        self.declare(Fact(response="Which colors do you prefer ?\n 1-Dark colors  2-Bright colors \n")) 
    @Rule(Fact(color6="1"))
    def Design131(self):  
        global api
        api="end"
        self.declare(Fact(response="Suggested stores : Catchy Home store / life line store .\n"
                "The suggested furniture will be as follow \n"
              "Sofas :  2 triple sofas with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books,vase...\n"
               "Notes :\n"
                "Since you have choosen dark colors and sun don't enter the room or enters it rarely we tried to give you"
               "TV will be putted on wall since there is no much space for that we didn't suggested TV table\n"))
    @Rule(Fact(color6="2"))
    def Design125(self):
        global api
        api="end"
        self.declare(Fact(response="Suggested stores : Catchy Home store / life line store .\n"
                "The suggested furniture will be as follow \n"
              "Sofas :  2 triple sofas with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 large lamps in the corner and 4 glow-lamps 2 on each wall \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books,vase...\n"
               "Notes :\n"
               "TV will be putted on wall since there is no much space for that we didn't suggested TV table\n"
               "our best suggestion even it may will not fit in the room due to space "
             "Since you choosed Bright colors this helped in lihgting so we didn't need to add much lightning"))
    @Rule(Fact(u_budget="2"))
    def message323(self):
        global api
        global choices
        api="end"
        choices=""
        self.declare(Fact(response="you are ready yet.\n"))

    @Rule(Fact(room="2"))
    def ask_budget24(self):
        global api
        global choices
        api = "http://10.0.2.2:8000/expert/get_your_budget/"
        choices=['1-more than 3500','2-less than 2355']
        self.declare(Fact(response="is your budget 1-more than 3500  2-less than 3500?\n"))
    @Rule(Fact(your_budget="1"))
    def ask_space11(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_space1/"
        self.declare(Fact(response="Does the room need a play area? 1- >11 m  2- <11 m \n"))
    @Rule(Fact(space1="1"))
    def ask_type1(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_room_type1/"
        self.declare(Fact(response="Do you want to design a unisex room or a private room for each gender? 1-yes 2-no ?\n"))
    @Rule(Fact(room_type1="1"))
    def ask_age34(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_age1/"
        self.declare(Fact(response="what is the rang of your children's age : 1- >12  2- <12 ?\n"))
    @Rule(Fact(age1="1"))
    def ask_num1(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_num1/"
        self.declare(Fact(response="How many children will be sharing the room? 1- (1 or 2) 2-(3 or 4)\n"))
    @Rule(Fact(num1="1"))
    def ask_special1(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_special1_1/"
        self.declare(Fact(response="Are there special needs to be considered? Like allergies or disabilities? 1-yes  2-no\n"))
    @Rule(Fact(special1_1 ="1"))
    def play1(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_play1/"
        self.declare(Fact(response="Does the room need a play area? 1-yes  2-no \n"))
    @Rule(Fact(play1="1"))
    def Design1_1(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas :  1 sofa with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
	           "play ground: in order to give your child a place to play. add a small area and put all your child toys in it."
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
    @Rule(Fact(play1="2"))
    def Design2(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas : 1 sofa with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
    @Rule(Fact(special1_1="2"))
    def play2ed(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_play2/"
        self.declare(Fact(response="Does the room need a play area?? 1-yes  2-no \n"))
    @Rule(Fact(play2="1"))
    def Design33(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas :  1 sofa with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
	           "play ground: in order to give your child a place to play. add a small area and put all your child toys in it."
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
    @Rule(Fact(play2="2"))
    def Design4(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas : 1 sofa with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
    @Rule(Fact(num1="2") )
    def ask_special212(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_special2_1/"
        self.declare(Fact(response="Are there special needs to be considered? Like allergies or disabilities? 1-yes  2-no"))
    @Rule(Fact(special2_1="1"))
    def play32(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_play3/"
        self.declare(Fact(response="Does the room need a play area?? 1-yes  2-no"))
    @Rule(Fact(play3="1"))
    def Design5(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
	           "play ground: in order to give your child a place to play. add a medium area and put all your child toys in it because number of chlidren more than 1."
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
    @Rule(Fact(play3="2"))
    def Design6(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas : 1 sofa with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
        
    @Rule(Fact(special2_1="2"))
    def play4(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_play4/"
        self.declare(Fact(response="Does the room need a play area?? 1-yes  2-no"))
    @Rule(Fact(play4="1"))
    def Design7(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
	           "play ground: in order to give your child a place to play. add a medium area and put all your child toys."
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
    @Rule(Fact(play4="2"))
    def Design8(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas : 1 sofa with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
    @Rule(Fact(age1="2"))
    def ask_num29(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_num2/"
        self.declare(Fact(response="How many children will be sharing the room? 1- (1 or 2) 2-(3 or 4)"))
    @Rule(Fact(num2="1") )
    def ask_special3_1(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_special3_1/"
        self.declare(Fact(response="Are there special needs to be considered? Like allergies or disabilities? 1-yes  2-no"))
    @Rule(Fact(special3_1="1"))
    def play5(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_play5/"
        self.declare(Fact(response="Does the room need a play area?? 1-yes  2-no"))
    @Rule(Fact(play5="1"))
    def Design94(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas :  1 sofa with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
	           "play ground: in order to give your child a place to play. add a small area and put all your child toys in it."
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
    @Rule(Fact(play5="2"))
    def Design10(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas : 1 sofa with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
    @Rule(Fact(special3_1="2"))
    def play6(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_play6/"
        self.declare(Fact(response="Does the room need a play area?? 1-yes  2-no"))
    @Rule(Fact(play6="1"))
    def Design11(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas :  1 sofa with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
	           "play ground: in order to give your child a place to play. add a small area and put all your child toys in it."
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
    @Rule(Fact(play6="2"))
    def Design12(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas : 1 sofa with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
              
    @Rule(Fact(num2="2"))
    def ask_special3_2(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_special3_2/"
        self.declare(Fact(response="Are there special needs to be considered? Like allergies or disabilities? 1-yes  2-no"))
    @Rule(Fact(special3_2="1"))
    def play7(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_play7/"
        self.declare(Fact(response="Does the room need a play area?? 1-yes  2-no \n"))
    @Rule(Fact(play7="1"))
    def Design13(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas : 1 sofa with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
    @Rule(Fact(play7="2"))
    def Design14(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas : 1 sofa with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
    @Rule(Fact(special3_2="2"))
    def play8(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_play8/"
        self.declare(Fact(response="Does the room need a play area?? 1-yes  2-no \n"))
    @Rule(Fact(play8="1"))
    def Design15(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas : 1 sofa with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes : we didn’t add any harmful pieces in order to make it a safe place for your child"
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
    @Rule(Fact(play8="2"))
    def Design16(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white/black) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 small lamp \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "play ground: in order to give your child a place to play. add a small area and put all your child toys in it."
               "Notes : we didn’t recommend any glass masterpiece because your child is still young "
               "TV will be putted on wall since there is no much space for that we didn't suggest TV table\n"))
        
    
    @Rule(Fact(room_type1="2"))
    def ask_age(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_age2_1/"
        self.declare(Fact(response="what is age rang of children : 1- >12  2- <12 ?\n"))
    @Rule(Fact(age2_1="1"))
    def ask_num2_1(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_num2_1/"
        self.declare(Fact(response="How many children will be sharing the room? 1- (1 or 2) 2-(3 or 4)\n"))
    @Rule(Fact(num2_1="1"))
    def ask_color21(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_color21/"
        self.declare(Fact(response="Which colors do you prefer ?\n 1-Dark colors  2-Bright colors \n"))
    @Rule(Fact(color21="1"))
    def Design17(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white) steel \n"
               "Tables :  one meduim size , steel legged, marble faced table \n"
              "Lightning : no need for extra lightning since your room is shiny enough \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains \n"
               "Carpet : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books,...\n"
               " TV will be putted on wall since there is no much space for that we didn' suggested TV table"))
    @Rule(Fact(color21="2"))
    def Design2r(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white) steel \n"
               "Tables :  one meduim size , steel legged , marble faced table \n"
              "Lightning : no need for extra lightning since your room is shiny enough \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books,vase...\n"
               "Notes :\n TV will be putted on wall since there is no much space for that we didn' suggested TV table"))
        
    @Rule(Fact(num2_1="2"))
    def  ask_colore(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_color22/"
        self.declare(Fact(response="Which colors do you prefer ?\n 1-Dark colors  2-Bright colors \n"))
    @Rule(Fact(color22="1"))
    def Designr3(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white) steel \n"
               "Tables :  1 meduim size , steel legged , marble faced ,table \n"
              "Lightning : 1 small lamp \n"
               "Painting : 1 abstract large size painting \n"
               "Shelfs : 1 shelf \n"
               "Curtains : sheer curtains "
               "Rug : 1 meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes :\n we didn't suggested you vases since there are children under 12 .\n"
               "TV will be putted on wall since there is no much space for that we didn' suggested TV table"))
    @Rule(Fact(color22="2"))
    def Design4(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white) steel \n"
               "Tables :  1 meduim size , steel legged , marble faced table \n"
              "Lightning : 1 small lamp \n"
               "Painting : 1 abstract large size painting \n"
               "Shelfs : 1 shelf \n"
               "Curtains : sheer curtains "
               "Rug : 1 meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books,vase...\n"
               "Notes :\n "
               "TV will be putted on wall since there is no much space for that we didn' suggested TV table\n"))
        
    @Rule(Fact(age2_1="2"))
    def ask_num2_144(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_num2_2/"
        self.declare(Fact(response="How many children will be sharing the room? 1- (1 or 2) 2-(3 or 4)\n"))
    @Rule(Fact(num2_2="1"))
    def ask_color3_1(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_color31/"
        self.declare(Fact(response="Which colors do you prefer ?\n 1-Dark colors  2-Bright colors \n"))
    @Rule(Fact(color31="1"))
    def Design17(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white) steel \n"
               "Tables :  one meduim size , steel legged, marble faced table \n"
              "Lightning : no need for extra lightning since your room is shiny enough \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains \n"
               "Carpet : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books,...\n"
               " TV will be putted on wall since there is no much space for that we didn' suggested TV table"))
    @Rule(Fact(color31="2"))
    def Design212(self):
        global api
        api="end"
        self.declare(Fact(response= "The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 large lamp in the corner and 2 glow-lamps on the wall \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes :\n we didn't suggested you vases since there are children under 12 .\n "
               "TV will be putted on wall since there is no much space for that we didn' suggested TV table."
               "Since you choosed Bright colors this helped in lihgting so we didn't need to add much lightning"))
    
    @Rule(Fact(num2_2="2"))
    def ask_color3_2(self):
        global api
        api = "http://10.0.2.2:8000/expert/get_color32/"
        self.declare(Fact(response="Which colors do you prefer ?\n 1-Dark colors  2-Bright colors \n"))
    @Rule(Fact(color32="1"))
    def Design17(self):
        global api
        api="end"
        self.declare(Fact(response="The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white) steel \n"
               "Tables :  one meduim size , steel legged, marble faced table \n"
              "Lightning : no need for extra lightning since your room is shiny enough \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains \n"
               "Carpet : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books,...\n"
               " TV will be putted on wall since there is no much space for that we didn' suggested TV table"))
    @Rule(Fact(color32="2"))
    def Design18(self):
        global api
        api="end"
        self.declare(Fact(response= "The suggested furniture will be as follow \n"
              "Sofas :  2 double sofas with a (Gold/white) steel \n"
               "Tables :  one meduim size steel legged marble face table \n"
              "Lightning : 1 large lamp in the corner and 2 glow-lamps on the wall \n"
               "Painting : one abstract large size painting \n"
               "Shelfs : one shelf \n"
               "Curtains : sheer curtains "
               "Rug : one meduim size circular carpet \n"
               "Masterpieces : 3 masterpieces small size e.g : frame, golden clock,books...\n"
               "Notes :\n we didn't suggested you vases since there are children under 12 .\n "
               "TV will be putted on wall since there is no much space for that we didn' suggested TV table."
               "Since you choosed Bright colors this helped in lihgting so we didn't need to add much lightning"))
        
    @Rule(Fact(space1="2"))
    def message_3(self):
        global api
        api="end"
        self.declare(Fact(response="Since you don't have enough space, we are going to suggest simple decor:"
              "Sofas :  1 double, 4 single wooden sofas and brokar or linen fabric \n"
               "Tables :  one meduim size and 2 small wooden legged table \n"
              "Lightning : crystal chandelier , 1 large lamps in the corner and 4 glow-lamps 2 on each wall\n"
               "Painting : one oily large size painting \n"
               "Curtains : window-scarf curtains \n"
               "Carpet : one meduim size carpet \n"
               "Pattern : wall panels \n "
               "Masterpieces : small size masterpieces e.g : vases,crystals, golden clock,...\n"
               "Notes : \nWe suggest you to add a (gilt/vintage/wooden) mirror and console.\n"
              "Since you have choosen dark colors and sun don't enter the room or enters it rarely we tried to give you"
               "our best suggestion even it may will not fit in the room due to space \n"))
        
    @Rule(Fact(your_budget="2"))
    def ask_space13(self):
        global api
        api="end"
        self.declare(Fact(response="you are not ready yet \n"))
engine = design()
    
@csrf_exempt 
def get_room(request):
    global engine
    
    engine.reset() 
    room = request.POST.get('room')
    if room not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    engine.declare(Fact(room=room))
    engine.run()
    #print(api)
    #print(choices)
    for i in range(len(engine.facts)):
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    if response:
        return JsonResponse({'message': response,'api':api,'choices':choices})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    

@csrf_exempt 
def get_u_budget(request):
    global engine
    u_budget = request.POST.get('u_budget') 
    if u_budget not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(u_budget=u_budget))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    print(api)
    if response:
        return JsonResponse({'message': response,'api':api,'choices':choices})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    

@csrf_exempt 
def get_space(request):
    global engine
    space = request.POST.get('space') 
    if space not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(space=space))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,'choices':choices})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_sun1(request):
    global engine
    sun1 = request.POST.get('sun1') 
    if sun1 not in ["1","2","3"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(sun1=sun1))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,'choices':choices})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_color1(request):
    global engine
    color1 = request.POST.get('color1') 
    if color1 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(color1=color1))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_color2(request):
    global engine
    color2 = request.POST.get('color2') 
    if color2 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(color2=color2))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_color3(request):
    global engine
    color3 = request.POST.get('color3') 
    if color3 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(color3=color3))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_sun2(request):
    global engine
    sun2 = request.POST.get('sun2') 
    if sun2 not in ["1","2","3"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(sun2=sun2))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_color4(request):
    global engine
    color4 = request.POST.get('color4') 
    if color4 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(color4=color4))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_color5(request):
    global engine
    color5 = request.POST.get('color5') 
    if color5 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(color5=color5))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_color6(request):
    global engine
    color6 = request.POST.get('color6') 
    if color6 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(color6=color6))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_your_budget(request):
    global engine
    your_budget = request.POST.get('your_budget') 
    if your_budget not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(your_budget=your_budget))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_space1(request):
    global engine
    space1 = request.POST.get('space1') 
    if space1 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(space1=space1))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_room_type1(request):
    global engine
    room_type1 = request.POST.get('room_type1') 
    if room_type1 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(room_type1=room_type1))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    

@csrf_exempt 
def get_age1(request):
    global engine
    age1 = request.POST.get('age1') 
    if age1 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(age1=age1))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_num1(request):
    global engine
    num1 = request.POST.get('num1') 
    if num1 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(num1=num1))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_special1_1(request):
    global engine
    special1_1 = request.POST.get('special1_1') 
    if special1_1 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(special1_1=special1_1))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_play1(request):
    global engine
    play1 = request.POST.get('play1') 
    if play1 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(play1=play1))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_play2(request):
    global engine
    play2 = request.POST.get('play2') 
    if play2 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(play2=play2))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_special2_1(request):
    global engine
    special2_1 = request.POST.get('special2_1') 
    if special2_1 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(special2_1=special2_1))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
@csrf_exempt 
def get_play3(request):
    global engine
    play3 = request.POST.get('play3') 
    if play3 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(play3=play3))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_play4(request):
    global engine
    play4 = request.POST.get('play4') 
    if play4 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(play4=play4))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_num2(request):
    global engine
    num2 = request.POST.get('num2') 
    if num2 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(num2=num2))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_special3_1(request):
    global engine
    special3_1 = request.POST.get('special3_1') 
    if special3_1 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(special3_1=special3_1))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_play5(request):
    global engine
    play5 = request.POST.get('play5') 
    if play5 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(play5=play5))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_play6(request):
    global engine
    play6 = request.POST.get('play6') 
    if play6 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(play6=play6))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
@csrf_exempt 
def get_special3_2(request):
    global engine
    special3_2 = request.POST.get('special3_2') 
    if special3_2 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(special3_2=special3_2))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_play7(request):
    global engine
    play7 = request.POST.get('play7') 
    if play7 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(play7=play7))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_play8(request):
    global engine
    play8 = request.POST.get('play8') 
    if play8 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(play8=play8))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_age2_1(request):
    global engine
    age2_1 = request.POST.get('age2_1') 
    if age2_1 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(age2_1=age2_1))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_num2_1(request):
    global engine
    num2_1 = request.POST.get('num2_1') 
    if num2_1 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(num2_1=num2_1))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_color21(request):
    global engine
    color21 = request.POST.get('color21') 
    if color21 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(color21=color21))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_color22(request):
    global engine
    color22 = request.POST.get('color22') 
    if color22 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(color22=color22))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_num2_2(request):
    global engine
    num2_2 = request.POST.get('num2_2') 
    if num2_2 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(num2_2=num2_2))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_color31(request):
    global engine
    color31 = request.POST.get('color31') 
    if color31 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(color31=color31))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    
@csrf_exempt 
def get_color32(request):
    global engine
    color32 = request.POST.get('color32') 
    if color32 not in ["1","2"]:
        return JsonResponse({'message': "please select a valid choice"},status=400)
    for i in engine.facts.keys():
            if(engine.facts[i].get('response')):
                engine.retract(engine.facts[i])
    engine.declare(Fact(color32=color32))
    engine.run()
    for i in engine.facts.keys():
        if(engine.facts[i].get('response')):
            response = engine.facts[i].get('response')
    print(engine.facts)
    if response:
        return JsonResponse({'message': response,'api':api,})
    else:
        return JsonResponse({'message': 'No response generated by the expert system.'})
    