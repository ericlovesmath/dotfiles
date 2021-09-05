# Shorter for loops
for i in[0]*x:
exec's+=input();'*x

# Python read multiple lines
open(0).read()

#If prompting the user doesn't matter, this is slightly shorter than eval for 3 or more:
a,b,c=map(input,[1]*3)
a,b,c=map(input,'111')
#It's also shorter even if prompting is not ok:
a,b,c=map(input,['']*3)

x,y,X,Y=map(int,open(0).read().split())

# Function                                                   Output of f(360)
#========================================================================================
f=lambda n,i=2:n//i*[0]and[f(n,i+1),[i]+f(n//i)][n%i<1]      # [2, 2, 2, 3, 3, 5] (slow!)
f=lambda n,i=2:n<2and{1}or n%i and f(n,i+1)or{i}|f(n/i)    # {1, 2, 3, 5}
f=lambda n,i=2:n<2and{i}or n%i and f(n,i+1)or{i}|f(n/i,i)  #*{2, 3, 5}
f=lambda n,i=1,p=1:n*[0]and p%i*[i]+f(n-p%i,i+1,p*i*i)     # first n primes
f=lambda n,i=1,p=1:n*[0]and p%i*[i]+f(n-1,i+1,p*i*i)       # primes <= n
f=lambda n:all(n%m for m in range(2,n))                    # is n prime?
f=lambda n:1>>n or n*f(n-1)                                # factorial
f=lambda n:sum(k/n*k%n>n-2for k in range(n*n))             # totient phi(n) (not recursive)

# Strip newline from end of string or int
print(end=s)
print(1,end='')

# Arithmetic Tricks

Assumptions                  Version 1        Version 2
-------------------------------------------------------------------
n >= 0 float                 n==0             0**n
n >= 0 integer               n==0             1>>n
n >  0 integer               n!=1             1%n
n >  0 integer, Python 2     n==1             1/n
n, m float                   n!=m             n-m


# "not" a bool, where C is a bool.
# This works as making C negative converts it to 0 or 1
if~-a:

>>> L = ["", 1, 0, [5], [], None, (), (4, 2)]
>>> filter(None, L)
[1, [5], (4, 2)]

Use a,b,c='123' instead of a,b,c='1','2','3'

# Don't use, use below
return(b,a)[a<b]

I=input
R=range

# Double for loop
for i in range(m):
 for j in range(n):
  do_stuff(i,j)

for k in range(m*n):
  do_stuff(k/n,k%n)

# Map of lowercase and uppercase alphabet
map(chr,range(97,123))
map(chr,range(65,91))

if a and b -> if a*b -> if a&b

[a,b][x] # b if x else a

#math.floor(n)
n//1

# math.ceil(n)
-(-n//1)

A = [1,2,3,4,5,6,7]
print(*A) # "1 2 3 4 5 6 7"

a = 'geeksforgeeks'
*x,= a     # List
x = {*a}   # Set
x = (*a,)  # Tuple
*x,r=a     # Pop()

a = "Hello" if foo() else "Goodbye"

print(*range(n,11*n,n))

a==0 -> a<1

a,b,c=map(int,open(0))

l=[input()for i in[0]*int(input())]

print(*min(INPUT,key=lambda x:CONDITION))
eval("[*map(int,input().split())],"*int(input()))

re.split('[^a-zA-Z]', string_to_split)
"TEXT".split(/[^A-Za-z]/)

# Ignore for first iteration
s=1
while CONDITION or s:
    DOSOMETHING
    s=0

print(*ans,sep='')

print(''.join([x for _, x in sorted(zip(n, t))]))

# Split every n characters
s = STRING OR INPUT
n = 2
s = [s[i:i+n] for i in range(0, len(s), n)]

print(*[n for i in[0]*int(input())if(n:=input())and CONDITIONS]or[IF EMPTY])

# FLoat drop .0
a="%g"%(n)
a=f"{n:g}"
a=f"{n:.99g}"

x=n=input()
while len(n)>1:n=str(sum(map(lambda a:int(a)**2,n)))
print(x,f"IS {'UN'*(n!='1')}HAPPY")

#You can "input()" instead of "print()"

i,s=0,""
for c in input():
 if c=='.':s+=chr(i)
 else:i=i+(1*c=='+')-(1*c=='-')
 if(i>255 or i<0):print("UONVD"[i>255::2]+"ERFLOW");exit()
print(s)

a,x,t=0,"",0
for i in input():
 if"+"==i:a+=1;t=1*(a>255)
 elif"-"==i:a-=1;t=2*(a<0)
 else:x+=chr(a)
print([x,"OVERFLOW","UNDERFLOW"][t])

set1.intersection(set2)

t,a,b=map(int,open(0))

max(round(a,2),0)

print(sum(map("88690".count,input())))

if CONDITION: SOMETHING
# to place nested in one line (doesn't run something if CONDITION is already true
CONDITION and SOMETHING

# Fibbonacci
phi = (1+5**.5)/2
n = int(input())
print(round(n*phi))

# I'm just proud of this one
# Given n, find the next smallest number that doesn't share digits with n
# If its impossible, return "Impossible"
I=input
n=I()
a=int(n)
if len(set(n))>5:I("Impossible");exit()
while 1:a+=1;any(i in n for i in str(a))or I(a) # Abuse of ternary statements

f,d,*m=open(0)


return X==5 and Y==6 #19 Chars
return(X,Y)==(5,6) #18 Chars

print(['hello','world'][X]) #27 Chars
print(X*'world'or'hello') #25 Chars

print(['much','code','wow'][X]) #31 Chars
print('mcwuoocdwhe'[X::3]) #26 Chars

for a in range(X):
 for b in range(Y):print(a,b) #48 Chars
for a in range(X*Y):print(a//X,a%X) #35 Chars

for a in range(4):print(a) #26 Chars
for a in 0,1,2,3:print(a) #25 Chars

#Getting last item
A=L[-1] #7 Chars
*_,A=L #6 Chars

#Removing first item
L.pop(0) #8 Chars
L=L[1:] #7 Chars
_,*L=L #6 Chars

#Removing last item
L=L[:-1] #8 Chars
L.pop() #7 Chars
*L,_=L #6 Chars

L.insert(i,A) #13 Chars #Inserting items into a list
L[:i]+=A #8 Chars

A = combinations("ABC",2) # [('A', 'B'), ('A', 'C'), ('B', 'C')]
print(len(A)) # TypeError!
print(len(list(A))) # 19 Chars
print(len([*A])) # 16 Chars

if A and not B:
    foo()

is the same as:

if A>B:
    foo()


Store lookup tables as magic numbers

Say you want to hardcode a Boolean lookup table, like which of the first twelve English numbers contain an n.

0: False
1: True
2: False
3: False
4: False
5: False
6: False
7: True
8: False
9: True
10:True
11:True
12:False

Then, you can implement this lookup table concisely as:
3714>>i&1
with the resulting 0 or 1 being equal to False to True.
The idea is that the magic number stores the table as a bitstring bin(3714) = 0b111010000010, with the n-th digit (from the end) corresponding the the nth table entry. We access the nth entry by bitshifting the number n spaces to the right and taking the last digit by &1.

a=1;b=2;c=[]
a,b,*c=1,2

set(T)
{*T}
list(T)
[*T]
tuple(T)
(*T,)

n choose k -> ((2**n+1)**n>>n*k)%2**n

L=[1,2,3,1,2,3]
a=2
b=3
print map({a:b}.get,L,L)
[1, 3, 3, 1, 3, 3]  #Output

"tex".center(7, "-") -> f"{'tex':-^7}"

*l,=b"golf" => l=[103, 111, 108, 102]

exec(bytes('ⱰⱭ渪漽数⡮⤰朊椽瑮瀨献汰瑩⤨ㅛ⥝瀊楲瑮木猾浵椨瑮椨㸩湩⡴⥭潦⁲⁩湩渠愩摮琢畲≥牯昢污敳⤢','u16')[2:])
