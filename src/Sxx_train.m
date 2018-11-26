function Sxx = Sxx_train(fileName, m, n)
    I_train = im2double(imread(fileName));
    I_train = rgb2gray(I_train);
    sx = fft2(I_train, m, n);
    Sxx = (abs(sx).^2)./numel(sx); % Computing PSD of original img
end

