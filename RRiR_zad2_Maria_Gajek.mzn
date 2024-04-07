int: n;
set of int: N=1..n+1;
int: a = 0;
int: b = 2;
float: h = (b-a)/n;
array[int] of var float: startx = [(i-1)*h | i in N];
array[N,N] of var float: B;
array[N] of var float: wynik;
array[N] of var float: L;



% funkcja wejsciowa u
function var float: u(var float:x) = sum(i in N)(wynik[i]*ei(i-1,x));
array[N] of var float: U = [ u(startx[i]) | i in N];

 %wyznaczenie funkcji testujących
function var float: ei(var int: i, var float: x)=max(0,1-abs(n/2*(x-2*i/n)));

 %wyznaczenie pochodnych funkcji testujących
function var float: d_ei(var int: i, var float: x) = 
if (x>=2*i/n /\ x<= 2/n*(i+1)) then -n/2
elseif(x>=2*(i-1)/n /\ x<2*i/n) then n/2
else 0 endif;


% liczenie całek w czesci B(ei,ej)
function var float: integralOfB(var int: i1, var int: i2)=
let  {var float: a=max(0,2*( max(i1,i2) -1)/n);
      var float: b=min(2,2*( min(i1,i2) +1)/n);} in 
((b-a)/2) * 
(d_ei(i1,((b-a)/2) *(-1/sqrt(3))+(b+a)/2) *d_ei(i2,((b-a)/2) *(-1/sqrt(3))+(b+a)/2)+
 d_ei(i1,((b-a)/2) *( 1/sqrt(3))+(b+a)/2) *d_ei(i2,((b-a)/2) *( 1/sqrt(3))+(b+a)/2)-
   ei(i1,((b-a)/2) *(-1/sqrt(3))+(b+a)/2) *  ei(i2,((b-a)/2) *(-1/sqrt(3))+(b+a)/2)-
   ei(i1,((b-a)/2) *( 1/sqrt(3))+(b+a)/2) *  ei(i2,((b-a)/2) *( 1/sqrt(3))+(b+a)/2));

% liczenie całek w części L(ej)
function var float: integralOfL(var int: i)=
let  {var float: a=max(0,2*(i-1)/n);
      var float: b=min(2,2*(i+1)/n);}
in 
((b-a)/2) * ei(i,((b-a)/2) * (-1/sqrt(3)) +(b+a)/2) * sin(((b-a)/2)*(-1/sqrt(3))+(b+a)/2)+ 
((b-a)/2) * ei(i,((b-a)/2) * ( 1/sqrt(3)) +(b+a)/2) * sin(((b-a)/2)*( 1/sqrt(3))+(b+a)/2);

%przypisanie całek i obliczeń do odpowiedniej części macierzy B
constraint forall(i, j in 2..n+1 where j>=i)(B[i,j]=integralOfB(i-1,j-1)-ei(i-1,2)*ei(j-1,2));
%z warunku dirichleta
constraint forall(i in 2..n+1)(B[1,i]=0 /\ B[i,1]=0);
%reszta przypisania
constraint forall(i, j in N where j>=i)(B[i,j]=B[j,i]);
%przypisanie całek  do odpowiedniej części macierzy L
constraint forall(j in 2..n+1)(L[j]=integralOfL(j-1));
constraint B[1,1]=1;
constraint L[1]=0;
constraint forall(i in N)(sum(j in N)(B[i,j]*wynik[j])=L[i]);
solve satisfy;

output ["B:\n"]++[show(B[i,j]) ++ if j=n+1 then "\n" else " | " endif | i, j in N]++["\n"]++["L: " ++show(i in N)(L[i])++ "\n"] ++["\n"]++["wyniki / ai:"++show(i in N)(wynik[i]) ++ "\n\n"]++["startx: "++show(i in N)(startx[i]) ++"\n"]
++["\n"]++["u: "++ show(i in N)(U[i])++"\n\n"]++["Skopuj poniższe linijki do pliku TuSkopiowacDoRysowania.txt:\n"]++[show(startx[i])++";"++show(U[i])++"\n"| i in N]
