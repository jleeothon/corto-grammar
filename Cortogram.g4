grammar Cortogram;


program :
    statement+;

statement :
    declaration NEWLINE
    |
    definition NEWLINE
    |
    scopeStatement NEWLINE
    |
    expression NEWLINE
    ;

/* Declaration, Definition */

declaration :
    typeLabel VALID_NAME
    ;

definition :
    declaration ':' initializerList
    |
    declaration initializerBraces
    ;

scopeStatement :
    prescopeStatement
    |
    postscopeStatement
    ;

prescopeStatement :
    (declaration | definition) ':::' INDENT statement+ DEDENT;

postscopeStatement :
    (declaration | definition) '::' INDENT statement+ DEDENT;

/* Initializer */

initializerList :
    (initializerElem (',' initializerElem)*)?
    ;

initializerBraces :
    '{' initializerList '}'
    ;

initializerElem :
    initializerValue
    |
    initializerValue '=' initializerValue
    ;

initializerValue :
    identifier
    |
    literal
    |
    initializerBraces
    |
    anonymousType
    ;

/* Expression */

expression :
    additiveExpression
    ;

additiveExpression :
    multiplicativeExpression (('+' | '-') multiplicativeExpression)*
    ;

multiplicativeExpression :
    unaryExpression (('*' | '/' | '%') unaryExpression)*
    ;

unaryExpression :
    prefixOperator postfixExpression
    |
    postfixExpression
    ;

postfixExpression :
    postfixExpression postfixOperation
    |
    atomExpression
    ;

atomExpression :
    '(' expression ')'
    |
    atom
    ;

prefixOperator :
    'not'
    ;

postfixOperation :
    memberAccess
    |
    methodCall
    |
    initializerBraces
    ;

memberAccess :
    '.' VALID_NAME
    ;

methodCall :
    '.' VALID_NAME '(' ')'
    ;

atom :
    identifier
    |
    literal
    ;

typeLabel :
    (
        identifier
        |
        anonymousType
    ) '&'?
    ;

anonymousType :
    identifier initializerBraces
    ;


identifier :
    VALID_NAME
    ;

literal :
    INT
    ;

INDENT : 'INDENT' ;
DEDENT : 'DEDENT' ;

VALID_NAME :
    ('a'..'z' | 'A'..'Z' | '_')
    ('a'..'z' | 'A'..'Z' | '_' | '0'..'9')*
    ;

INT :
    [0-9]+
    ;

NEWLINE : '\n';

WHITESPACE :
    ' ' -> skip
    ;
