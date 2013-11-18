/*
  <computadores.c>
  
  Programa que lee un fichero e inserta en
  un vector de tres dimensiones las lineas, palabras
  y letras de manera independiente.

  valgrind tested ;-)

  Autor: Luis Martin Gil. luismartingil
  Anyo: 2005

*/

#include <stdio.h>
#include <stdlib.h>
//#include <limits.h>

/*  Programa principal. */
int main (int argc, char *argv[]) {
  
  char ***vector;        // Estructura donde se guardara internamente
                         // el fichero.
  FILE *f1;              // Fichero de entrada.
  int error = 0;         // Variable que indica si ha habiado errores.
  char c = ' ';          // Caracter temporal con el que se recorre el fichero.
  int i, j, k;           // Contadores varios.
  
  i = 0;
  j = 0;
  k = 0;
  
  /*  Comprobamos los argumentos de entrada que sean
      los apropiados. Es este caso, un unico argumento que
      es el nombre del fichero de entrada. */  
  if (argc != 2) {
    printf ("Uso : %s <fichero_datos>\n",
	    argv[0]);
    exit (1);
  }
  
  /*  Si los argumentos son correctos... */
  else {
    
    /*  Abrimos el fichero de entrada pasado
	como parametro a la llamada. */
    if ((f1 = fopen (argv[1], "r")) == NULL) {
      error = -1;
      perror (argv[1]);
      exit (1);
    }
    
    /*  INICIO - Lectura del fichero utilizando memoria dinamica. */
    /*  La memoria dinamica consiste en reservar unicamente
	la memoria que necesitamos mediante una operacion
	malloc, y mas adelante con realloc para coger mas memoria. */
    if ((vector = (char ***) malloc (sizeof (char **))) == NULL)
      error = -1;
    while (!ferror (f1) &&
	   !feof (f1) &&
	   (error >= 0)) {      
      
      j = 0;
      k = 0;
      if ((vector[i] = (char **) malloc (sizeof (char *))) == NULL)
	error = -1;
      while ((c != '\n') &&
	     (c != EOF) &&
	     (error >= 0)) {
	
	k = 0;
	if ((vector[i][j] = (char *) malloc (sizeof (char))) == NULL)
	  error = -1;	
	c = fgetc(f1);
	while ((c != ' ') &&
	       (c != '\n') &&
	       (c != EOF) &&
	       (error >= 0)) {
	  	  
	  vector[i][j][k] = c;

	  /*  Imprimimos el vector, para ver que es correcto...
	      Descomentar la linea de abajo para verlo... */
	  printf ("Vector[%d][%d][%d]=%c\n", i, j, k, vector[i][j][k]);
	  
	  k++;
	  if ((vector[i][j] = (char *) realloc ((char *) vector[i][j],
						(k + 1) * sizeof (char)))
	      == NULL)
	    error = -1;
	  
	  /*  Cogemos el caracter del fichero. */
	  c = fgetc(f1);
	}	
	vector[i][j][k] = '\0';	
	
	j++;
	if ((vector[i] = (char **) realloc ((char **) vector[i],
					    (j + 1) * sizeof (char *)))
	    == NULL)
	  error = -1;
      }      
      vector[i][j] = '\0';
      
      /* Si es un retorno de linea, se camufla y se
	 pone como si fuera otro caracter para poder
	 seguir leyendo la siguiente linea. */
      if (c == '\n')
	c = ' ';
			    

      i++;
      if ((vector = (char ***) realloc ((char ***) vector,
					(i + 1) * sizeof (char **)))
	  == NULL)
	error = -1;
    }    
    vector[i] = '\0';    

    /*  Cerramos los ficheros. */    
    fclose (f1);
    
    /*  FIN - De la lectura. */        
    
    /*  Comprobamos los posibles errores que
	se hayan dado por insuficiencia de memoria... */
    if (error < 0) {
      printf ("No hay memoria disponible\n");
      exit(-1);
    }




    /*  EJEMPLO de como recorrer la estructura "vector": */
    /*  En la variable "vector" tendriamos todo fichero
	separado completamente. */
    /*  Aqui se utilizaria la variable vector para lo que fuera.
	En este caso, como ejemplo, vamos a imprimir por la pantalla
	todo el vector caracter a caracter... */
    i = 0;
    j = 0;
    k = 0;
    while (vector[i] != '\0') {
      while (vector[i][j] != '\0') {
	printf ("\"");
	while (vector[i][j][k] != '\0') {
	  printf ("%c", vector[i][j][k]);
	  k++;
	}
	printf ("\"");
	printf (" ");
	k=0;
	j++;
      }
      printf ("\n");
      j=0;
      i++;
    }   
    


        
    /*  Necesario en memoria dinamica. */
    /*  Liberamos la memoria utilizada por la variable "vector". */
    i = 0;
    j = 0;    
    while (vector[i] != '\0') {
      while (vector[i][j] != '\0') {
	free (vector[i][j]);
	j++;
      }
      free (vector[i][j]);      
      free (vector[i]);
      j=0;
      i++;
    }
    free (vector[i]);    
    free (vector);    
  }

  exit (0);
  return error;  
}
