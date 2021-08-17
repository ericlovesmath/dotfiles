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
f=lambda n,i=2:n<2and{1}or n%i and f(n,i+1)or{i}|f(n/i)    # {1, 2, 3, 5}
f=lambda n,i=2:n<2and{i}or n%i and f(n,i+1)or{i}|f(n/i,i)  #*{2, 3, 5}
f=lambda n:all(n%m for m in range(2,n))                    # is n prime?
f=lambda n:1>>n or n*f(n-1)                                # factorial
f=lambda n:sum(k/n*k%n>n-2for k in range(n*n))             # totient phi(n) (not recursive)
f=lambda n:[k/n for k in range(n*n)if k/n*k%n==1]          # coprimes up to n (not recursive)

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

Use a=b=c=0 instead of a,b,c=0,0,0.
Use a,b,c='123' instead of a,b,c='1','2','3'

# Don't use, use below
if a<b:return a
else:return b

return(b,a)[a<b]

I=input
R=range


#Use extended iterable unpacking to turn something into a list (-4 bytes):

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
