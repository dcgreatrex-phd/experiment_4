function test()

sdArray = [];
sumArray = [];
for i = 1:100000
    IOIarray = ex4_compute_ioiarray_old(0, 5, 0.250);
    sdArray(end + 1) = std(IOIarray);
    sumArray(end + 1) = sum(IOIarray);
end
m = mean(sdArray);
s = std(sdArray);
mup1 = m + (s * 0.5)
mup2 = m + (s * 2.5)
mdown1 = m - (s * 0.5)
mdown2 = m - (s * 2.5)
figure;
plot(sdArray);
figure;
plot(sumArray);