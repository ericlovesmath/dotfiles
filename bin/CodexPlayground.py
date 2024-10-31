# Function that returns the first n prime numbers
def prime_numbers(n):
    primes = []
    i = 2
    while len(primes) < n:
        if is_prime(i):
            primes.append(i)
        i += 1
    return primes

# Function that checks if the input is prime
def is_prime(n):
    if n < 2:
        return False
    elif n == 2:
        return True
    else:
        for i in range(2,n):
            if n % i == 0:
                return False
        return True

print(prime_numbers(10))

# Class that defines a binary tree
class BinaryTree:
    def __init__(self, root):
        self.root = root
        self.left = None
        self.right = None
    
    def insert_left(self, node):
        if self.left == None:
            self.left = BinaryTree(node)
    
    def insert_right(self, node):
        self.right = BinaryTree(node)
    
    def get_left(self):
        return self.left
    
    def get_right(self):
        return self.right
    
    def get_root(self):
        return self.root
    
    def set_root(self, root):
        self.root = root

# Code golf fizzbuzz
def fizzbuzz(n):
    for i in range(1,n+1):
        if i % 3 == 0 and i % 5 == 0:
            print('FizzBuzz')
        elif i % 3 == 0:
            print('Fizz')
        elif i % 5 == 0:
            print('Buzz')
        else:
            print(i)

fizzbuzz(15)

# Function that rotates a 2d matrix
def rotate_matrix(matrix):
    n = len(matrix)
    for layer in range(n//2):
        first = layer
        last = n - 1 - layer
        for i in range(first, last):
            offset = i - first
            top = matrix[first][i]
            matrix[first][i] = matrix[last-offset][first]
            matrix[last-offset][first] = matrix[last][last-offset]
            matrix[last][last-offset] = matrix[i][last]
            matrix[i][last] = top
    return matrix

print(rotate_matrix([ [10, 5], [1, 2] ]))

# Majority Vote Algorithm

# Function that returns the majority vote
def majority_vote(lst):
    for i in set(lst):
        if lst.count(i) > len(lst)/2:
            return i
    return None

spotify_client_id = "eee4022df8e54f46a8a01e1472533676" # Deleted
spotify_client_secret = "088a2a177bd347788f295bed0058edc1" # Deleted

# Get current playing song on Spotify
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials

client_credentials_manager = SpotifyClientCredentials(client_id=spotify_client_id, client_secret=spotify_client_secret)

sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

# Get a photo from NASA's API
import requests

nasa_api_key = "DEMO_KEY" # Deleted

r = requests.get(f"https://api.nasa.gov/planetary/apod?api_key={nasa_api_key}")

# Class that defines a linked list
class Node:
    def __init__(self, value):
        self.value = value
        self.next = None
    
    def __repr__(self):
        return str(self.value)

class LinkedList:
    def __init__(self):
        self.head = None
    
    def __str__(self):
        cur_head = self.head
        out_string = ""
        while cur_head:
            out_string += str(cur_head.value) + " -> "
            cur_head = cur_head.next
        return out_string
    
    def append(self, value):
        if self.head is None:
            self.head = Node(value)
    
    def size(self):
        size = 0
        node = self.head
        while node:
            size += 1
            node = node.next
        return size

name = "Eric Lee"
def whenWillIDie(name):
    name = "Eric"
    print("{} will die in {} years".format(name, 100 - age))
    print(name)

whenWillIDie(name)

def willIFindLove(name):
    print("Hi, %s. I can tell that you're lonely, and I feel bad for you. \
            I'm here to tell you that you WILL find love, and I have a good \
            feeling that you're going to meet the person of your dreams very soon." % name)
 
def meaningOfLife():
    return 42

# We can call this function in two ways
meaningOfLife()
meaning = meaningOfLife
meaning()  

def EnglishToSpanish(word):
    translation = ""
    try:
        translation = SpanishDictionary[word]
    except:
        translation = word + " does not exist in the Spanish dictionary"
    return translation

def SpanishToEnglish(word):
    translation = ""
    try:
        translation = EnglishDictionary[word]
    except:
        translation = word + " does not exist in the English dictionary"
    return translation

SpanishDictionary = {
    "Hola" : "Hello",
    "Mundo" : "World",
    "Adios" : "Goodbye",
    "Arbol" : "Tree",
    "Perro" : "Dog",
    "Gato" : "Cat",
    "Pato" : "Duck",
    "Pizza" : "Pizza",
    "Helado" : "Ice Cream",
    "Silla" : "Chair",
    "Mesa" : "Table",
    "Casa" : "House",
} 

EnglishDictionary = {
    "Hello" : "Hola",
    "World" : "Mundo",
    "Goodbye" : "Adios",
    "Tree" : "Arbol",
    "Dog" : "Perro",
    "Cat" : "Gato",
    "Duck" : "Pato",
    "Pizza" : "Pizza",
    "Ice Cream" : "Helado",
    "Chair" : "Silla",
    "Table" : "Mesa",
    "House" : "Casa",
}

def HowGayAmI(request):
    if request.user.is_authenticated:
        if request.method == 'POST':
            form = HowGayForm(request.POST)
            if form.is_valid():
                howgay = form.cleaned_data['howgay']
                howgay = int(howgay)
                avarage = UserData.objects.filter(user=request.user).avarage()
                if howgay > avarage:
                    return render(request, 'HowGayAmI/howgay.html', {'howgay': howgay, 'avarage': avarage, 'message': 'Ты е(ще не гей и не скоро станешь. Поднажми еще!', 'form': HowGayForm()})
                elif howgay == avarage:
                    return render(request, 'HowGayAm/howgay.html', {'howgay': howgay, 'avarage': avarage, 'message': 'Ты не геIй!', 'form': HowGayForm()})
                else:
                    return render(request, 'HowGayAm/howgay.html', {'howgay': howgay, 'avarage': avarage, 'message': 'Ты гей!', 'form': HowGayForm()})
        else:
            form = HowGayForm()
        return render(request, 'HowGayAmI/howgay.html', {'form': form})
    else:
        return HttpResponseRedirect('/login')


def CalculatePokerOdds(hole_cards, board_cards, deck, num_players):
    """
    Calculates the odds that a player wins a poker hand.
    """
    cards = hole_cards + board_cards
    cards_str = Card.print_pretty_cards(cards)
    num_cards = len(cards)
    num_simulations = NUM_SIMULATIONS
    # We generate num_simulations random boards. For each random board, we
    # compute the utility for the first player when the first player plays
    # optimally.
    utilities = [0] * num_simulations
    for i in range(num_simulations):
        # Generate a random board.
        random_board = []
        for j in range(num_cards - len(board_cards)):
            random_board.append(deck.draw(1))
        # Compute the value of the hand.
        utilities[i] = ComputeUtility(cards, random_board, num_players)
    #print(utilities)
    # Return the average value of the utilities.
    return sum(utilities) * 1.0 / num_simulations

def BoBurnham(bot, update):
    bot.send_message(chat_id=update.message.chat_id, text=BoBurnham_dict[random.randint(0, len(BoBurnham_dict)-1)])

# Function that searches product on Amazon and returns the price
def search_amazon(product):
    # Go to Amazon.com
    driver.get("https://www.amazon.com/")
    # Enter the product in the search bar and hit enter
    search_bar = driver.find_element_by_id("twotab-search-input")
    search_bar.send_keys(product)
    search_bar.send_keys(Keys.RETURN)
    # Get the price of the product
    price = driver.find_element_by_id("priceblock_ourprice").text
    return price

# Function that gets song lyrics from AZlyrics
def get_lyrics(url):
    # Request data from website
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    # Read data from website
    html = urllib.request.urlopen(req).read()
    # Parse html
    soup = BeautifulSoup(html, 'html.parser')
    # Get lyrics from html
    lyrics = str(soup)
    # Format lyrics
    lyrics = lyrics.split('<!-- Usage of azlyrics.com content by any third-party lyrics provider is prohibited by our licensing agreement. Sorry about that. -->')[1]
    lyrics = lyrics.split('<!-- MxM banner -->')[0]
    lyrics = lyrics.replace('<br>','').replace('</br>','').replace('</div>','').replace('<i>','').replace('</i>','').replace('<br/>','').strip()
    return lyrics

def maximumSubarraySum(A):
    max_so_far = 0
    max_ending_here = 0

    for i in A:
        max_ending_here = max_ending_here + i
        if max_ending_here < 0:
            max_ending_here = 0
        elif max_so_far < max_ending_here:
            max_so_far = max_ending_here

    return max_so_far

name = "Eddy Reyes"

def howPure(name):
    if name.lower() == "eddy reyes":
        return "100%"
    elif name.lower() == "joshua reyes":
        return "99%"
    else:
        return "0%"

print(howPure(name))

name = "Max Stoughton"

pure_names = ["Albus", "Cho", "Lily", "Lily Evans", "James", "James Potter", "Harry", "Harry Potter", "Hermione", "Hermione Granger", "Ron", "Ron Weasley", "Severus", "Severus Snape", "Draco"]

impure_names = ["Tom", "Tom Riddle", "Voldemort", "Lord Voldemort", "Tom Marvolo Riddle", "Tom Marvolo Riddle Jr.", "Ginny", "Ginny Weasley", "Tom (Chamber of Secrets)", "Tom (Prisoner of Azkaban)"]

def howPure(name):
    if name in pure_names:
        return "pure"
    elif name in impure_names:
        return "impure"
    else:
        return "unknown"

def FastInverseSquareRoot(x):
  # From: http://en.wikipedia.org/wiki/Fast_inverse_square_root
  #      http://www.toymaker.info/Games/html/3dmath.html
  xhalf = 0.5 * x
  y = x
  i = *(int*)&y
  i = 0x5f3759df - (i>>1);
  y = *(float*)&i;
  y = y*(1.5f-xhalf*y*y);
  return y;

vocab_terms = ['a', 'AAA', 'AAAS', 'aardvark', 'Aarhus', 'Aaron', 'ABA', 'Ababa',
 'aback', 'abacus', 'abalone', 'abandon', 'abase', 'abash', 'abate',
 'abbas', 'abbe', 'abbey', 'abbot', 'Abbott', 'abbreviate']

def googleVocab(vocab_terms):
    vocab_terms.sort()
    vocab_terms = [x for x in vocab_terms if x.isalpha()]
    vocab_terms = [x for x in vocab_terms if len(x)>1]
    vocab_terms = [x.lower() for x in vocab_terms]
    return vocab_terms

googleVocab(vocab_terms)

# owner: kfbZiC5BnjN1xVyLwkRqW4b7c6nxbwFec
# 
# This is a **private** key.
# 
# ---
# 
# The public key is:
# 
# 04b7761ef5e31b46fa7549e8cbd4e1027fec33ccee9c3df1e2f51d29e3e332c4c8e0859e76587491ca38761067c4fa1a6c188604e0fea8a7d089dfda25ea437be4
# 
# This is a **public** key, and the address corresponding to it is:
# 
# 1HUBHMij46Hae75JPdWjeZ5Q7KaL7EFRSD
# 
# ---
# 
# The private key is:
# 
# e24083c8d14f7c127e3c0d5b5f89e8b8a11a8c135f541f7e0f76633d264857b7
# 
# This is a **private** key.
# 
# ---
# 
# The public key is:
# 
# 0388460dc439f4c8f5bcfc268c36e11b4375cad5c3535c336cfdf8c32c3afad5c1
# 
# This is a **public** key, and the address corresponding to it is:
# 
# 1Csf6LVPkv24FBso

# Bitcoin wallet address
wallet_address = '1DQN7nHJ7FRMy7iucP8NFXa8Xa5KWKw8f8'

import re

def owo(
    text: str,
    owo_text: str = "OwO",
    owo_replace: str = "OwO",
    owo_revert: str = "OwO",
) -> str:
    """
    OwO's all the text
    :param text: The text to owo
    :param owo_text: What to owo the text with
    :param owo_replace: What to replace the vowels with
    :param owo_revert: What to replace the owo_text with
    :return: The owo'd text
    """
    text = text.replace(owo_text, owo_replace)
    text = text.replace("you", owo_text)
    text = text.replace("You", owo_text)
    text = re.sub(r"(\s?)(i|I)(\s?)", r"\1{}\3".format(owo_text), text)
    text = re.sub(r"ove", "uv", text)
    text = re.sub(r"\!+", " " + owo_revert + " ", text)
    text = text.replace(owo_replace, "ove")
    return text

import pygame

# Creeper Aw man
class Creeper(Entity):
    def __init__(self, world, loc):
        self.world = world
        self.loc = loc
        self.icon = pygame.image.loa("assets/creeper.png")
        self.icon = pygame.transform.scale(self.icon, (32, 32))
        self.icon.convert()
        self.icon.set_colorkey((255, 255, 255))
        self.world.add_entity(self)
        self.world.set_entity_icon(self, self.icon)
        self.world.set_entity_icon_offset(self, (32, 32))
        self.world.set_entity_icon_offset(self, (32, 32))
        self.world.set_entity_position(self, loc)

    def update(self, delta):
        self.world.set_entity_position(self, self.loc)

        # Check if the player is within range
        player = self.world.get_player()
        if abs(player.loc[0] - self.loc[0]) < 2 and abs(player.loc[1] - self.loc[1]) < 2:
            self.world.set_entity_icon_offset(self, (0, 0))
            self.world.set_entity_icon(self, self.d)


# How much wood would a woodchuck chuck if a woodchuck could chuck wood?
# He would chuck, he would, as much as he could chuck
# If a woodchuck could chuck wood?
#
# As much wood as a woodchuck could chuck,
# If a woodchuck could chuck wood.

# I'm sorry for the misleading variable names; I couldn't think of a better way.
#

# The list of keys we're looking for
keys = [
    "system_profiler:SPHardwareDataType:Model Identifier",
    "system_profiler:SPHardwareDataType:Processor Speed",
    "system_profiler:SPHardwareDataType:Number of Processors",
    "system_profiler:SPHardwareDataType:Memory"]

def integrateFunction( function, a, b, n=100 ):
    """
    Approximates the definite integral of a function from a to b by the
    trapezoidal rule, using n subintervals (with n+1 points).
    """
    h = (b-a)/float(n)
    s = 0.5*(function(a) + function(b))
    for i in range(1, n):
        s += function(a + i*h)
    return h*s

# shinzou wo sasageyo
# mou ichido onegaishimasu
# kawari ni itteyo
# 
# mou ichido onegaishimasu
# kawari ni itteyo
# 
# mou ichido onegaishimasu
# kawari ni itteyo
# 
# mou


# Lyrics to the Powerpuff Girls OP
# https://www.youtube.com/watch?v=G1IbRujko-A
#
# This code is a bit messy but it works

# Function that tells me my chances of getting into college
def college_chance(GPA, SAT, Creds):
    if GPA > 3.5 and SAT > 1700 and Creds > 30:
        print("You have a 70% chance of getting into college")
    elif GPA > 3.5 and SAT > 1700 and Creds < 30:
        print("You have a 65% chance of getting into college")
    elif GPA < 3.5 and SAT > 1700 and Creds > 30:
        print("You have a 65% chance of getting into college")
    elif GPA < 3.5 and SAT < 1700 and Creds > 30:
        print("You have a 60% chance of getting into college")
    elif GPA < 3.5 and SAT > 1700 and Creds < 30:
        print("You have a 55% chance of getting into college") 

GPA = int(input("What is your GPA? "))
SAT = int(input("What is your SAT score? "))
Creds = int(input("What is the number of credits you have? "))
college_chance(GPA, SAT, Creds)

def isAIEvil(s):
    if re.search(r"\bA[ei]\b",s) != None:
        return True
    else:
        return False
