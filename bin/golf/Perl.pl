<>=~/ \d*/;$h=$&;$h/=2,$-++while$h>$`;print$-,$/,$'<<$-

$n=<>;$s=0;$s+=$n**$_ for(0..<>-1);print$s;

$k=<>;
for(1..<>){chomp($x=<>);print(index($x,$k)!=-1?"yes
":"no
")}

[[BASH]]

read;awk '{m=$2-$1;m=m<0?-m:m;print(m>50?100-m:m)}'

sed -r "s/\b(\w'?\w)+\b/\U&/g"
