My project genereates an array of 10 'static rings' around a point at the center of the screen, and an additional 'exapanding ring'.
The static rings do not change in diameter, but transform in appearance as the expanding ring makes contact.
The expanding ring reverses its growth direction when reaching the min/max diameter.

Static rings have 2 forms:
Activated: Ring perimeter uniform size. Lines form between the center point and the static ring's perimeter upon being 'activated' by the expanding ring.
Deactivated: Ring perimeter messy - elements varying sizes. Default state, becomes deactivated when expanding ring shrinks past it.

Upon a static ring changing states, a blue 'pulse' effect plays at the location of the static ring.
