p gets.bytes.sum{|n|n.odd?? n:0}G

a=0
$<.each_byte{|c|a+=c%2>0?c:0}
p a

gets
puts$<.min_by{|i|i.split.sum{_1.to_i**2}}

a=$<.read
p a.sum/a.size

w,x,y,z=$<.read.split.map &:to_i
p Math.sqrt((y-w)**2+(z-x)**2).to_i
Integer.sqrt(25)

puts gets.gsub(/./,"A"=>"T","T"=>"A","C"=>"G","G"=>"C")

p gets.to_i.digits(2).sum
p gets.to_i.to_s(2).chars.map{|c|c.to_i}.sum

w=gets.to_i;h=gets.to_i
s=*$<
p (0...h).sum{|i|(0...w).count{|j|s[i][j][/\S/]&&((s[i][j+1]+s[i+1][j]+s[i][j-1]+s[i-1][j])*2)[/\S\S/]}}

PERL print<>+<>*(<>-1)

gets
$<.map{p"%b"%_1=~/$/}

gets.to_i.times do
p gets.to_i.to_s(2).size
end

f=->x{gets.split.map &:to_i}
x=f[0]
p (1..f[0][0]).min_by{x.zip(f[0]).sum{|a,b|(a-b)**2}}

s.to_i.step(1,-1){|i|puts s*i}

values.find_all { |x| values.count(x) == 1 }

puts gets.split.map(&:to_i).sort.join.gsub(/^0*\d/){|c|c.reverse}

w=gets.upcase.gsub /\W/,''
p w.sum-64*w.size

p (l=gets.upcase.scan(/\w/)*'').sum-64*l.size

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

x,n,t=$<.read.split.map &:to_i
p [x-t*60/n,0].max

$x=<>;
$n=<>;
$t=<>;
$a = $x-int($t*60/$n);
print $a>0 ? $a : "0";

puts$<.read.split.drop(1).sort_by(&:to_i)*" "

m=gets
puts(m=~/_/i?"snake_case":(m[0]==m[0].upcase ? "Pascal":"camel")+"Case")

[97,98,99,100].pack('c*')
=> "abcd"

s=gets
p (s.scan(/[A-Z]/).size-s.scan(/[a-z]/).size).abs()

p `dd`.scan(/\d+/).size-1
# Ignores second line somehow?

f,_,*x=$<.read.split.map &:to_i
p *x.map{|i|2*(f-i)}

n=gets.to_i
print n>0?$<.read.count("*")*100/n/n:0,"%"
# print doesn't append newlines

gets
$<.read.split{|i|p i[..2].sum==i[3..].sum}

p (gets.to_i**gets.to_i).digits.sum

eval("p gets.split.map(&:to_i).sort[1];"*gets.to_i)

gets
p ([*0..100]-gets.split.map(&:to_i))[0]
# Subtract arrays

p gets.upcase.scan(/\w/).uniq.size==26
p !!gets.scan(/[a-z]/i).uniq[25]

#upto example
'1'.upto('3'){puts "cat"}
#or
'a'.upto('c'){puts "cat"}

Call chars with ?, rather than ','
d.join(',') -> d\*?,

val in list -> list===val

a = %w(a b c) => ["a","b","c"]

# bad
(0..n-1).each{|n|p n}

# good
(0...n).each{|n|p n}

# bad
if true
  n=3
end

# good
true&&n=3
# bad
unless false
  n=3
end

# good
false||n=3

"\n" -> $/

# puts -> $><<w

# bad
10.times{puts:hello}

# good
puts [:hello]*10

# bad
"hello\n".size-1 #=> 5

# good
"hello\n"=~/$/ #=> 5

# bad
a=-10

# good
a=~9

# bad
a=n==0?1:0

# good
a=1[n]

(n+1) = -~n
(n-1) = ~-n

.uniq = |[]

p list-[p] = removes [nil]

# bad
a=[a,b+1].max

# good
a>b||a=b+1

$ Check string in string
‘foo’[‘f’] #=> ‘f’

require 'date'; z = Date::DAYNAMES

!p = True, !0 = False

a*(b+c) # too long
a*b+c   # wrong
a.*b+c  # 1 byte saved!

require 'date'
a,b=*$<.map{d,m,y=_1.split(".").map(&:to_i);Date.new(y,m,d)}
n=((b-a)/365).to_i
puts n<0? "Invalid Date":n

f=gets.chomp
a=gets
x='</[{()}]\>'
d={}
(0..9).map{|i|d[x[i]]=x[-1-i]}
puts a+f+(a.reverse.chars.map{|c|d.key?(c) ?d[c]:c}).join
