using System;
using System.Collections.Generic;

/*
   Lukasz Kopyto
   nr indeksu 322997
   Lista nr 2
   Zadanie nr 4
   mcs zadanie_4.cs
   ./zadanie_4.exe
   */

public class LazyIntList
{
    //korzystam z wbudowanych list
    private List<int> elements = new List<int>();

    //metoda element dziala jak widac
    public int element(int i)
    {
        while (elements.Count <= i)
            elements.Add(elements.Count);

        return elements[i];
    }

    public virtual int size()
    {
        return elements.Count;
    }
}

public class LazyPrimeList : LazyIntList
{
    private List<int> primes = new List<int>();

    public override int size()
    {
        return primes.Count;
    }

    public new int element(int i)
    {
        int candidate; //kandydat na liczbe pierwsza
        if(primes.Count > 0) //jesli na liscie sa liczby pierwsze, to wez ostatnia powiekszona o 1, w pp nie ma jeszcze liczb wiec wez najmniejsza czyli 2
            candidate = primes[primes.Count - 1] + 1;
        else
            candidate = 2;

        while (primes.Count <= i) //w tej petli sobie wypelniam liste liczbami pierwszymi
        {
            if (IsPrime(candidate))
                primes.Add(candidate);
            candidate++;
        }
        return primes[i];
    }

    private bool IsPrime(int number) //prosty algorytm na liczby pierwsze
    {
        if(number == 1)
            return false;
        else
        {
            int i = 2;
            while(i*i <= number)
            {
                if(number % i == 0)
                    return false;
                i++;
            }
        }
        return true;
    }
}

class Program
{
    public static void Main()
    {
        LazyIntList lista = new LazyIntList();
        Console.WriteLine("LazyIntList:");
        Console.WriteLine("Rozmiar: " + lista.size());
        Console.WriteLine("Element(40): " + lista.element(40)); 
        Console.WriteLine("Rozmiar: " + lista.size()); 
        Console.WriteLine("Element(38): " + lista.element(38));
        Console.WriteLine("Rozmiar: " + lista.size());

        LazyPrimeList listaPierwszych = new LazyPrimeList();
        Console.WriteLine("LazyPrimeList 11 elementow:");
        listaPierwszych.element(10);        
        Console.WriteLine("Rozmiar: " + listaPierwszych.size());

        for(int i = 0; i<listaPierwszych.size(); i++)
            Console.WriteLine("Liczba numer {0}: " + listaPierwszych.element(i), i+1);
        Console.WriteLine("Element numer 7: " + listaPierwszych.element(6));
        Console.WriteLine("Rozmiar: " + listaPierwszych.size());
    }
}

