p gets.bytes.sum{|n|n.odd?? n:0}

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
