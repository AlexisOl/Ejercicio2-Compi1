import java.util.ArrayList;
%%
%class CounterVocals
%standalone

%unicode
%line
%column 
%int
%public
Letras = [a-z|A-Z]
Numeros = [0-9]
Especial = [ , \n , \t, \r]+


 /*Ingreso de cinco variables contadoras que determinaran la cantidad de palabras con esas caracteristicas*/

%{
	/*Inicio de palabra*/
	public void inicio() {
		System.out.println("Inicio de palabra");
	}

	/*Para deterctar la fila y columna de los numeros enteros*/


	private ArrayList <String> numbersInformation = new ArrayList<String>();
	
	private void appendNumbers(){
		numbersInformation.add("El numero: "+ yytext() +" en la fila: "+(yyline+1)+" Y columna: " +(yycolumn +1 ));
	}
	public ArrayList<String> getNumbersInformation() {
		return numbersInformation;
	}

/* ---------------------------------------------------------------------------------    */
	/*Para las detectar las palabras con distinta cantidad de vocales*/

	private int cantidadParcial = 0;
	private int cantidadDeVocalesTotales =0;


	private int countVocals1 = 0;
	private int countVocals2 = 0;
	private int countVocals3 = 0;
	private int countVocals4 = 0;
	private int countVocals5 = 0;
	

	public void SetcantidadParcial(int cantidadParcial) {
		this.cantidadParcial =  cantidadParcial;
	}

	public int getcantidadParcial() {
		return cantidadParcial;
	}

	private void increasecantidadDeVocalesTotales() {
		cantidadDeVocalesTotales++;
	}

	public int getcantidadDeVocalesTotales() {
		return cantidadDeVocalesTotales;
	}
	private void increaseVocals1() {
		countVocals1++;
		asiganacionParcial();

	}

	public int getCountVocals1() {
		return countVocals1;
	}

	private void increaseVocals2() {
		countVocals2++;
		asiganacionParcial();

	}

	public int getCountVocals2() {
		return countVocals2;
	}

	private void increaseVocals3() {
		countVocals3++;
		asiganacionParcial();

	}

	public int getCountVocals3() {
		return countVocals3;
	}

	private void increaseVocals4() {
		countVocals4++;
		asiganacionParcial();

	}

	public int getCountVocals4() {
		return countVocals4;
	}
	private void increaseVocals5() {
		countVocals5++;
		asiganacionParcial();
	}

	public int getCountVocals5() {
		return countVocals5;
	}

	public void DeterminarTipo() {
		switch ((getcantidadDeVocalesTotales() - getcantidadParcial())) {

			case 1:	
					increaseVocals1();
					break;
			case 2:	
					increaseVocals2();
					break;
			case 3:	
					increaseVocals3();
					break;
			case 4:	
					increaseVocals4();
					break;
			case 5:	
					increaseVocals5();
					break;
			default: 
					asiganacionParcial();
					break;

		}
	}

	/*Se ingresa la cantidad de vocales en la variable parcial*/

	public void asiganacionParcial() {
		SetcantidadParcial(getcantidadDeVocalesTotales());
	}

%}

%eof{
	System.out.println(getcantidadDeVocalesTotales());
	System.out.println("Cantidad de Palabras con una vocal"+ String.valueOf(getCountVocals1()));
	System.out.println("Cantidad de Palabras con dos vocales"+ getCountVocals2());
	System.out.println("Cantidad de Palabras con tres vocales"+ getCountVocals3());
	System.out.println("Cantidad de Palabras con cuatro vocales"+ getCountVocals4());
	System.out.println("Cantidad de Palabras con cinco vocales"+ getCountVocals5());
	for (String cadena: numbersInformation) {
      
      System.out.println(cadena);
    }

%eof}
%%

/*Reglas lexicas*/
/*([a-zA-Z][0-9]) {inicio();}*/

/*EN CASO DE TODAS LAS VOCALES*/
(a|A|e|E|i|I|o|O|u|U) {increasecantidadDeVocalesTotales();}

/*EN CASO DE ESPACIOS Y SALTOS DE LINEA*/
{Especial} {DeterminarTipo();}

/*En caso de los numeros*/
{Numeros} {appendNumbers();}

/*Si viene algo distinto no hace nada*/
[^] {}