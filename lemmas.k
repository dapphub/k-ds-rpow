rule A *Int C /Int C => A
  requires A *Int C <Int pow256

rule A /Int B <Int pow256 => true
  requires A <Int pow256

rule Z *Int (X ^Int N) => Z
  requires N ==Int 0

rule Z *Int (X ^Int (N %Int 2)) => Z
  requires N ==Int 0

rule 0 ^Int N => 1
  requires N ==Int 0

rule 0 ^Int N => 0
  requires N >Int 0

// rule Z *Int (X ^Int (N /Int 2)) <Int pow256 ==K true
//   requires Z *Int (X ^Int ( N )) <Int pow256 ==K true

rule 0 <=Int (N /Int 2) => true
  requires 0 <=Int N

rule N /Int 2 <Int pow256 => true
  requires N <Int pow256

// rule Z *Int (X *Int X) ^Int (N /Int 2) => Z *Int X ^Int N
//   requires N modInt 2 ==Int 0
//
// rule Z *Int X *Int (X *Int X) ^Int (N /Int 2) => Z *Int X ^Int N
//   requires N modInt 2 ==Int 1

//                         Z       X       N       Base
syntax Int ::= "#rpow" "(" Int "," Int "," Int "," Int ")"  [function, smtlib(smt_rpow)]

rule #rpow(Z, X, 0, Base) => Z

rule X *Int X <Int #rpow(Z, X, N, Base) => true
  requires N >=Int 2
