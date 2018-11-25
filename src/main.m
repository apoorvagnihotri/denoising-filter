I = im2double(imread('peppers.png'));
I = rgb2gray(I);
imshow(I);
title('Original Image');

n = 12;
sigma_ = 20;
blur_filter = fspecial('gaussian', n, sigma_);
blurred = imfilter(I, blur_filter, 'conv', 'circular');
figure, imshow(blurred);
title('Simulate Blur');

noise_mean = 0.1;
noise_var = 0.01;
blurred_noisy = imnoise(blurred, 'gaussian', noise_mean, noise_var);
figure, imshow(blurred_noisy);
title('Simulate Blur and Noise');

nsr = 0.08; % usually psd of a natural image remains same
output = wiener_filter(blurred_noisy, blur_filter, nsr);
figure, imshow(output)
title('restored image with exact spectrum')
