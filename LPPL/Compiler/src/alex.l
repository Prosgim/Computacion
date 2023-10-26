/*****************************************************************************/
/**  Ejemplo de FLEX: S E M - 1           2023-2024 <jmbenedi@prhlt.upv.es> **/
/*****************************************************************************/
%{
#include <stdio.h>
#include <string.h>
#include "header.h"

#define  retornar(x) {if (verbosidad) ECHO; return(x);}
%}
/*-----------------------------------------------------------------------------
  Estas opciones evitan "warnings" innecesarios y permiten obtener el
  numero de linea actual en la variable global "yylineno".
-----------------------------------------------------------------------------*/
%option noinput       
%option nounput       
%option yylineno  

delimitador    [ \t\n]+
digito         [0-9]
constante		({digito}+|\.{digito}+|{digito}+\.{digito}*)
letra			[a-zA-Z]
identificador	(letra)({letra}|{digito}|\_)*
palreservada	{minus}+
comentario		\/\/.*\n

%%
{delimitador}  { if (verbosidad) ECHO; }
"+"			{ retornar (MAS_);      }
"-"         { retornar (MENOS_);    }
"*"         { retornar (POR_);      }
"/"         { retornar (DIV_);      }
"="			{ retornar (ASIG_);	}

"&&"		{ retornar (AND_);      }
"||"		{ retornar (OR_);      }
"=="		{ retornar (IGUAL_);      }
"!="		{ retornar (DIST_);      }
"!"			{ retornar (NEG_);	}

">"			{ retornar (MAYOR_);	}
"<"			{ retornar (MENOR_);	}
">="		{ retornar (MAYORIG_);	}
"<="		{ retornar (MENORIG_);	}


"int"		{ retornar (INT_);	}
"bool"		{ retornar (BOOL_);	}
"true"		{ retornar (TRUE_);	}
"false"		{ retornar (FALSE_);	}


"("			{ retornar (APAR_);     }
")"         { retornar (CPAR_);     }
"["			{ retornar (ACOR_);	}
"]"			{ retornar (CCOR_);	}
"{"			{ retornar (CLLAV_);	}
"}"			{ retornar (CLLAV_);	}


"."			{retornar (PUNT_);	}
","			{retornar (COM_);	}
";"			{retornar (PYC_);	}

"read"		{retornar (READ_);	}
"print"		{retornar (PRINT_);	}

"if"		{retornar (IF_);	}
"else"		{retornar (ELSE_);	}
"while"		{retornar (WHILE_);	}
"struct"	{retornar (STRUCT_);}

"return"	{retornar ("RETURN_");	}

{constante}       { retornar (CTE_);      }
{identificador}		{retornar (ID_);	}
.	       { yyerror("Caracter desconocido"); }

%%
/*****************************************************************************/
