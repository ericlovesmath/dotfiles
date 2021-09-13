[[INPUT]]

a=$<.read
s=*$<
w,x,y,z=$<.read.split.map &:to_i
p `dd`.scan(/\d+/) # Exracts all lines as one and gets all integers

[[MAPS+LISTS]]
puts gets.gsub(/./,"A"=>"T","T"=>"A","C"=>"G","G"=>"C")
$<.map{p"%b"%_1=~/$/}
f,_,*x=$<.read.split.map &:to_i

[[OUTPUT]]
print n>0?$<.read.count("*")*100/n/n:0,"%"
# print doesn't append newlines

a=0
$<.each_byte{|c|a+=c%2>0?c:0}
p a

gets
puts$<.min_by{|i|i.split.sum{_1.to_i**2}}


p gets.to_i.digits(2).sum
p gets.to_i.to_s(2).chars.map{|c|c.to_i}.sum

10.to_i.step(1,-1).map{p _1} # [10, 9, 8 ...2, 1]

w=gets.upcase.gsub /\W/,''

r={}
w="OLZEASGTBQ"
for i in 0..9
r.merge!w[i]=>i,w[i].downcase=>i
end
a=gets
r.each do|f,e|
a.gsub!(f,e.to_s)
end
puts a

m=~/_/i # Char (_) in string (m)

[97,98,99,100].pack('c*') => "abcd" # ord map to chr

d.join(',') -> d*?,

val in list -> list===val

a = %w(a b c) => ["a","b","c"]

true&&n=3 # If TRUE
false||n=3 # Unless FALSE

"\n" -> $/

"hello\n"=~/$/ # "hello\n".size-1 #=> 5

a=1[n] # a=n==0?1:0

-~n # n+1, doesn't need parenthesis
~-n # n-1, doesn't need parenthesis

list|[] # list.uniq

p list-[p] # list.compact (Removes nil or 0)

"foo"["f"] # Check string in string

!p = True
!0 = False

a.*b+c  # Make * a lower order of operations

# seeing what range wasn't covered
gets
l=[0]*24
$<.map{a,b=_1.split.map &:to_i
l[a,m=b-a]=[1]*m}
p l.sum

# ALECMAN'S ABSOLUTELY SEXY SOLUTION USING ALL THE TRICKS
#a,b=$<.map{_1.split.sum &:to_i}
#$><<a*100/b<<?%

$><<(gets=~/_/?:snake_case:$_=~/\A[A-Z]/?:PascalCase:'camelCase')

_,d=*$<
p (0..6).map{|i|d.split.count{(_1.to_i+i)%7<5}}.max

_,*l=`dd`.split
p (0..6).map{|o|l.map{(_1.to_i+o)%7}.count{_1<5}}.max

# Alternative to gsub("a","")
999.times{s.slice!'()'}

n=gets.to_i
n=n.digits.sum while n>9
p n

p,a,b=$*
p=p.to_i
b=b.to_i

#p "-=qwertyuiop[]asdfghjkl;'zxcvbnm,./","[]',.pyfgcrl/=aoeuidhtns-;qjkxbmwvz"

if a.length>n to if a[n] for -6 bytes

(n+10**i).to_s
"#{n+10**i}"

a=[1,2]
a=1,2

n = 77 # (binary 01001101)
n[3] # => 1

x=gets
puts x

gets
puts $_ # better

# bad
"\n"
# good
$/

puts [:hello]*10 # 10.times{puts:hello}

$><<$<.map{_,a,b,c=_1.split.map &:to_i
[a,b-c,b,_1[/\w+/]]}.max[3]

a=1[n] # a=n==0?1:0

d=->i{a=i.to_s(2);a==a.reverse}
i=(1..gets.to_i).select{d[_1]}
n=i.sum/i.size
puts "#{n} is#{d[n]?'':'n\'t'} a palindrome in binary"

f=->x{(k='%b'%x)==k.reverse}
l=(1..gets.to_i).filter &f
puts"#{r=l.sum/l.size} is#{f[r]?'':"n't"} a palindrome in binary"

(a+b/2)/b # Rounding a/b when they are integers without using to_f

n=eval`dd`
$><<"%.1f %.1f %.1f"%[n.real,n.imaginary,n.polar[0]]
a=Complex(gets)
$><<[a.real,a.imag,a.abs].map{1.0*_1.round(1)}*" "

n=gets.to_i
a=1
i=0
x=[]
n>0?n.to_s(2).chars.map{_1.to_i==a ?i+=1:(x+=[i];a^=i=1)}:0
$><<(x+[i])*""

# I swear to god I will never understand regex code like this
# Problem was 143 -> '0b10001111' -> 134
puts gets<?1?0:('%b'%$_).gsub(/(.)\1*/,&:size)

gets
puts$<.map{|s|t=s.scan(/[a-z]/i).uniq.select{1<s.count(_1)}
t[0]?t*'':'NONE'}

# MATCH ALL LETTERS LOWERCASE OR UPPERCASE WITH /[a-z]/i
#
# AND MATCH NUMBER SPACE WORD WITH "(\d+) (.+)"

_,n,d,a=`dd`.split
puts "YOU_CAN%s_MAKE_A_SOUP_IN_%d_DAYS"%[n.to_i<=a.chars.count{_1<=d}?"":"NOT",d]

puts`dd`.to_r.to_s.chomp('/1').sub ?/,' / '
# Instead of
a,b=gets.to_r.to_s.split "/"
puts b.to_i<2?a:a+" / "+b
# I don't know what .chomp('/1') does 
# Rational("3/2")

f=[0,0,0,1]
999.times{f<<f[-3..].sum}
gets
p$<.sum{f[_1.to_i]}%(10**9+7)

gets
puts $<.map{_1.scan(/\w+/)}.map{|a,b,c|a+"/"+(c=='jpg'||c=='png' ? b.gsub(/[A-Z]/){'_'+_1.downcase} : b)+"."+c}
