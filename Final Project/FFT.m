function single_sided_power_spectrum = FFT(X)
    %%% single_sided_power_spectrum
    L=length(X);
    Y=fft(X);
    p2=(abs(Y)/L).^2;
    p1= p2(1:floor(L/2)+1);
    p1(2:end-1) = 2*p1(2:end-1);
    single_sided_power_spectrum=p1;
    
end


