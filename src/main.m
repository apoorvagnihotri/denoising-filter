% read the image
clear;
file = 'peppers.png';
I = im2double(imread(file));
I = rgb2gray(I);
imshow(I);
title('Original Image');
imwrite(I, strcat("../result/", "Original_", file));

% blurr the image
n = 12;
sigma_ = 5;
blur_filter = fspecial('gaussian', n, sigma_);
blurred = imfilter(I, blur_filter, 'conv', 'circular');
figure, imshow(blurred);
title('Simulate Blur');
imwrite(blurred, strcat("../result/", "Blurred_", file));

% additive noise
noise_mean = 0.0;
noise_var = 0.04;
blurred_noisy = imnoise(blurred, 'gaussian', noise_mean, noise_var);
figure, imshow(blurred_noisy);
title('Simulate Blur and Noise');
imwrite(blurred_noisy, strcat("../result/", "Blurred_n_Noise_", file));

% run weiner filter
output = wiener_filter(I, blurred_noisy, blur_filter, noise_var^(0.5));

% printing the corrected image after gamma correction
figure, imshow(output);
title('restored image with exact spectrum')
imwrite(output, strcat("../result/", "Reconstructed_", file));

% converting to uint8
I = uint8(imadjust(I) * 255);
output = uint8(imadjust(output) * 255);
blurred_noisy = uint8(imadjust(blurred_noisy) * 255);

% calculate mse and psnr
mse_original = mse(blurred_noisy, I);
mse_reconstructed = mse(output, I);
psnr_original = psnr(blurred_noisy, I);
psnr_reconstructed = psnr(output, I);
fprintf('dim: %d \n', n);
fprintf('blur_sigma(filter): %f \n', sigma_);
fprintf('noise_sigma(additive): %f \n', noise_var^0.5);
fprintf('Original PSNR: %9.7f dB \n', psnr_original);
fprintf('Final PSNR: %9.7f dB \n', psnr_reconstructed);
fprintf('Original MSE: %7.2f \n', mse_original);
fprintf('Final MSE: %7.2f \n', mse_reconstructed);
