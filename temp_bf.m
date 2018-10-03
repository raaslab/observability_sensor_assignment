A = [1:8];
P1 = nchoosek(A,2);

for t = 1 : 3
    P2 = [];
    for i = 1 : size(P1,1)
        B=nchoosek(setdiff(A,P1(i,:)),2);
        P2 = [P2; repmat(P1(i,:),size(B,1),1) B];
    end
    P1 = P2;
end
P1
%%
n = 14;
m = n/2;
a = factorial(n);
b = 2^m;
c = a/b;
d = zeros(c,n);