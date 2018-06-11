pragma solidity ^0.4.21;

contract DsRpow {

    /*
     * Fixed-point exponentiation by squaring with fixed-point base as parameter.
     *
     * Overflow-safe multiplication and addition are inlined as an optimization.
     */
    function rpow(uint x, uint n, uint base) public pure returns (uint z) {
        assembly {
            if and(eq(x, 0), eq(n, 0)) { fail() }
            switch x case 0 { z := 0 }
            default {
                let half := div(base, 2) // Used for rounding.

                for { z := base } n { } {
                    if mod(n, 2) {
                        /*
                         * Set z := z * x, with rounding, reverting on overflow.
                         */
                        let zx := mul(z, x)
                        if iszero(eq(div(zx, x), z)) { fail() }
                        let zxRound := add(zx, half) if lt(zxRound, zx) { fail() }
                        z := div(zxRound, base)
                    }
                    n := div(n, 2)
                    if gt(n, 0) {
                        /*
                         * Set x := x * x, with rounding, reverting on overflow.
                         */
                        let xx := mul(x, x)
                        if iszero(eq(div(xx, x), x)) { fail() }
                        let xxRound := add(xx, half) if lt(xxRound, xx) { fail() }
                        x := div(xxRound, base)
                    }
                }
            }

            function fail() { revert(0, 0) }
        }
    }
}
