$fn = 99;

haack();

module haack(L = 40, R = 10, it = 1, C = 0) {
    translate([0, 0, L]) mirror([0, 0, 1])
        for (x=[0:it:L - it]) {
            translate([0, 0, x]) cylinder(r1=h(x, L, R, C), r2=h(x + it, L, R, C), h=it);
        }
}

PI=3.141592654;
function theta(x, L) = PI / 180 * acos(1 - 2 * x / L);
function h(x, L, R, C) =
    let(th = theta(x, L))
    R / sqrt(PI) * sqrt(th - sin(360 / PI * th) / 2 + C * pow(sin(180 / PI * th), 3));