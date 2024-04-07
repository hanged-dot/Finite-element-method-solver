Program został napisany w języku MiniZinc a obliczenia zostały wykonane za pomocą solvera Gurobi. 
Jak używać:
1. Zainstalować program MiniZinc IDE 
2. Założyć konto na stronie Gurobi w wersji Academic i zamówić darmowy trial licencji (może być wersja Online Course) i pobrać program Gurobi Optimaizer Software
3. Uruchomić program Gurobi Optimaizer Software i wpisac numer licencji
4. Uruchomić program MiniZinc i w zakładce MiniZinc-> Preferences-> Solvers wybrać w polu "solver" opcje Gurobi a w polu "Required solver flags"  a koło "--gurobi-dll" dopisać ścieżkę do pliku dll z folderu bin z folderu w którym zanstalowany został program Gurobi np. "--gurobi-dll C:\gurobi1100\win64\bin\gurobi110.dll"
5. Wcisnąc OK i otworzyć projekt RRiR_zad2
6. Wcisnąć przycisk run i wpisać wymagane parametry

Jak zobaczyć rysunek funkcji U:
1.Wykonać program
2.Przekopiować odpowiedni fragment do pliku TuSkopiowacDoRysowania.txt
3.Otworzyć plik Rysowanie.xlsx
4.Odświerzyć dane z pliku