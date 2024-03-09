using System;

/*
   Lukasz Kopyto
   nr indeksu: 322 997
   Lista nr 2
   zadanie nr 1
   mcs zadanie_1.cs
   ./zadanie_1.exe
*/


class IntStream 
{

    //zmienna reprezentujaca aktualna wartosc strumienia
    int n;
    //konstruktor bezargumentowy inicjuje strumien na 0
    public IntStream()
    {
        this.n = 0;
    }
    //metoda wirtualna zwracajaca nastepny element strumienia, jesli jest osiagalny, wpp zwraca inforamcje oraz kod(w przyszlosci dodam obsluge bledow/wyjatkow)
    public virtual int next()
    {
        if(!eos())
        {
            this.n = this.n + 1;
            return this.n;
        }else
        {
            Console.WriteLine("Strumien zamkniety.");
            return -1;
        }
    }
    //metoda wirtualna koniec strumienia, zwraca prawde jesli strumien osiagnal max wartosc typu int
    public virtual bool eos()
    {
        int maxValue = int.MaxValue;

        if(this.n == maxValue)           
            return true;
        else
            return false;
    }
    //metoda ktora resetuje strumien, czyli ustawia go na wartosc 0
    public virtual void reset()
    {
        this.n = 0;
    }
}

class FibStream : IntStream
{
    //zmienne pomocnicze do obliczania kolejnych wartosci ciagu fibonacciego
    int previous = 0;
    int current = 1;

    //metoda koniec strumienia
    public override bool eos()
    {
        if(previous + current <= 0) //overflow, jesli przekroczymy rozmiar danych, to nastapi przepelnienie i zmienna sie przekreci        
            return true;
        else
            return false;
    }

    //metoda zwracajaca nastepny wyrac ciagu fibonacciego, oraz oblicza i modyfikuje odpowiednie zmienne
    public override int next()
    {
        int temp = this.previous;
        this.previous = this.current;
        this.current = this.previous + temp;

        return this.previous;
    }

    //metoda resetujaca strumien
    public override void reset()
    {
        this.previous = 0;
        this.current = 1;
    }
}

class RandomStream : IntStream 
{    
    int maxInt = int.MaxValue;
    //klasa Random potrzebna do losowania wartosci
    Random random = new Random();

    //strumien caly czas otwarty
    public override bool eos()
    {
        return false;
    }

    //losujemy wartosc z przedzialu od 0 do maxInt w pp blad
    public override int next()
    {   
        if(!eos())
            return random.Next(0, maxInt);
        else
        {
            Console.WriteLine("Blad. Zamkniety strumien.");
            return -1;
        }
    }   
}

class RandomWordStream : IntStream {

    //dwa nowe obiekty odpowiednich klas
    RandomStream rs = new RandomStream();
    FibStream fs = new FibStream();

    public string GenerateString(int length)
    {
        const string znaki = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"; //sposrod tych znakow bedziemy budowac nasz wyraz o dlugosci length
        char[] CharTable = new char[length]; //w tej tablicy

        for(int i = 0; i < length; i++)
        {
            int index = (rs.next()) % (znaki.Length); //wybieramy losowy znak
            CharTable[i] = znaki[index]; //i umieszczamy w tablicy znakow
        }

        return new string(CharTable); //rzutujemy ja na stringa i zwracamy
    }

    //metoda resetujaca strumien
    public override void reset()
    {
        fs.reset();
    }
    // i metoda ktora generuje nastepny wyraz o losowych znakach o dlugosci kolejnego wyrazu ciagu fibonacciego
    public new string next(){
        return GenerateString(fs.next());
    }
}


class Program 
{
    public static void Main()
    {
        RandomWordStream rws = new RandomWordStream();


        Console.WriteLine(rws.next());        
        Console.WriteLine(rws.next());        
        Console.WriteLine(rws.next());        
        Console.WriteLine(rws.next());        
        Console.WriteLine(rws.next());        
        Console.WriteLine(rws.next());        

        rws.reset();

        Console.WriteLine(rws.next());        
        Console.WriteLine(rws.next());        
        Console.WriteLine(rws.next());
    }
}
