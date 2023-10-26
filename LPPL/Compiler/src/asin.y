/*****************************************************************************/
/** Ejemplo  S E M - 2                    2023-2024 <jmbenedi@prhlt.upv.es> **/
/*****************************************************************************/
%{
#include <stdio.h>
#include <string.h>
#include "header.h"
%}

%token  MAS_  MENOS_  POR_  DIV_ ASIG_
%token  AND_ OR_ IGUAL_ DIST_ NEG_
%token  MAYOR_ MENOR_ MAYORIG_ MENORIG_
%token  INT_ BOOL_ TRUE_ FALSE_
%token  APAR_ CPAR_ ACOR_ CCOR_ ALLAV_ CLLAV_
%token  PUNT_ COM_ PYC_
%token  READ_ PRINT_
%token  IF_ ELSE_ WHILE_ STRUCT_
%token  RETURN_
%token  CTE_ ID_
%error-verbose

%%

programa:   listDecla
        ;

listDecla:  decla
        |   listDecla decla
        ;

decla   :   declaVar
        |   declaFunc
        ;

declaVar:   tipoSimp ID_ PYC_
        |   tipoSimp ID_ ACOR_ CTE_ CCOR_ PYC_
        |   STRUCT_ ALLAV_ listCamp CLLAV_ ID_ PYC_
        ;

tipoSimp:   INT_
        |   BOOL_
        ;

listCamp:   tipoSimp ID_ PYC_
        |   listCamp tipoSimp ID_ PYC_
        ;

declaFunc:  tipoSimp ID_ APAR_ paramForm CPAR_ ALLAV_ declaVarLocal listInst RETURN_  APAR_ expre CPAR_ PYC_ CLLAV_
        ;

paramForm: 
        | listParamForm
        ;

listParamForm:  tipoSimp ID_
        | tipoSimp ID_ COM_ listParamForm
        ;

declaVarLocal: 
        | declaVarLocal declaVar
        ;

listInst: 
        | listInst inst
        ;

inst    : ALLAV_ listInst CLLAV_
        | instExpre
        | instEntSal
        | instSelec
        | instIter
        ;

instExpre: expre PYC_
        | PYC_
        ;

instEntSal: READ_ APAR_ ID_ CPAR_ PYC_
        | PRINT_ APAR_ expre CPAR_
        ;

instSelec: IF_ APAR_ expre CPAR_ inst ELSE_ inst
        ;

instIter: WHILE_ APAR_ expre CPAR_ inst
        ;

expre:    expreLogic
        | ID_ ASIG_ expre
        | ID_ ACOR_ expre CCOR_ ASIG_ expre
        | ID_ PUNT_ ID_ ASIG_ expre
        ;

expreLogic: expreIgual
        | expreLogic opLogic expreIgual
        ;

expreIgual: expreRel
        | expreIgual opIgual expreRel
        ;

expreRel: expreAd
        | expreRel opRel expreAd
        ;

expreAd : expreMul
        | expreAd opAd expreMul
        ;

expreMul: expreUna
        | expreMul opMul expreUna
        ;

expreUna: expreSufi
        | opUna expreUna
        | opIncre ID_
        ;

expreSufi: const
        | APAR_ expre CPAR_
        | ID_
        | ID_ opIncre
        | ID_ PUNT_ ID_
        | ID_ ACOR_ expre CCOR_
        | ID_ APAR_ paramAct CPAR_

const   : CTE_
        | TRUE_
        | FALSE_
        ;

paramAct: 
        | listParamAct
        ;

listParamAct: expre
        | expre COM_ listParamAct
        ;

opLogic : AND_
        | OR_
        ;

opIgual : IGUAL_
        | DIST_
        ;

opRel   : MAYOR_
        | MENOR_
        | MAYORIG_
        | MENORIG_
        ;

opAd    : MAS_
        | MENOS_
        ;

opMul   : POR_
        | DIV_
        ;
 
opUna   : MAS_
        | MENOS_
        | NEG_
        ;

opIncre : MAS_ MAS_
        | MENOS_ MENOS_
        ;

%%
