pragma solidity ^0.4.21;
contract DsRpower {

    /*
     * Fixed-point exponentiation by squaring with fixed-point base as parameter.
     *
     * Overflow-safe multiplication and addition are inlined as an optimization.
     */

    function rpow(uint x, uint n, uint base) public pure returns (uint z) {
        assembly {
          switch eq(mod(n, 2), 0)
          case 0 { z := base }
          default { z := x }
	  let half := div(base, 2) // Used for rounding.
	  for { n := div(n, 2) } n { n := div(n,2) } {
	      x := rmul(x, x, base, half)
	      if mod(n,2) {
		 z := rmul(z, x, base, half)
              }
          }
	  function rmul(_x, _y, _base, _half) -> xy {
	      xy := mul(_x, _y)
	      if and(_y, iszero(eq(div(xy, _y), _x))) { fail() }
	      let xyRound := add(xy, _half) if lt(xyRound, xy) { fail() }
	      xy := div(xyRound, _base)
	  }
	  function fail() { revert(0, 0) }
        }
    }
}
