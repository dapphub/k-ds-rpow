pragma solidity ^0.4.21;
contract DsRpow {

    /*
     * Fixed-point exponentiation by squaring with fixed-point base as parameter.
     *
     * Overflow-safe multiplication and addition are inlined as an optimization.
     */

    function rpow(uint x, uint n, uint base) public pure returns (uint z) {
        assembly {
    switch x case 0 {switch n case 0 {z := base} default {z := 0}}
    default {
      switch mod(n, 2)
             case 0 { z := base }
             default { z := x }
       let half := div(base, 2) // Used for rounding.
                for { n := div(n, 2) } n { n := div(n,2) } {
          let xx := mul(x, x)
                if iszero(eq(div(xx, x), x)) { revert(0,0) }
          let xxRound := add(xx, half) if lt(xxRound, xx) { revert(0,0) }
          x := div(xxRound, base)
             if mod(n,2) {
                     let zx := mul(z, x)
                 if and(iszero(eq(x,0)), iszero(eq(div(zx, x), z))) { revert(0,0) }
                 let zxRound := add(zx, half) if lt(zxRound, zx) { revert(0,0) }
           z := div(zxRound, base)
                   }
                }
          }
        }
    }
}
