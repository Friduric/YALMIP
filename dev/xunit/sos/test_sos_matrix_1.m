function test_sos_matrix_1

sdpvar x y
P = [1+x^2 -x+y+x^2;-x+y+x^2 2*x^2-2*x*y+y^2];
m = size(P,1);
v = monolist([x y],degree(P)/2);
Q = sdpvar(length(v)*m);
R = kron(eye(m),v)'*Q*kron(eye(m),v)-P;
s = coefficients(R(findelements(triu(R))),[x y]);
sol = solvesdp((Q >= 0) + (s==0));
diff = (clean(P - kron(eye(m),v)'*double(Q)*kron(eye(m),v),1e-6));

mbg_asserttolequal(sol.problem,0);
mbg_asserttolequal(diff,[0 0;0 0]);
