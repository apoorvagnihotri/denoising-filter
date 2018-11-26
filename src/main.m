% clear variables
clear;

% training images directory
data_training = "../data/training/";

% read the testing image
data_testing = "../data/testing/";
file = '2.jpg';
I = im2double(imread(strcat(data_testing, file)));
I = rgb2gray(I);
imshow(I);
title('Original Image');
imwrite(I, strcat("../result/", "Original_", file));

% blurr the  testing image
dim = 12;
sigma_ = 5;
blur_filter = fspecial('gaussian', dim, sigma_);
blurred = imfilter(I, blur_filter, 'conv', 'circular');
figure, imshow(blurred);
title('Simulate Blur');
imwrite(blurred, strcat("../result/", "Blurred_", file));

% additive noise on the testing
noise_mean = 0.0;
noise_var = 0.04;
blurred_noisy = imnoise(blurred, 'gaussian', noise_mean, noise_var);
figure, imshow(blurred_noisy);
title('Simulate Blur and Noise');
imwrite(blurred_noisy, strcat("../result/", "Blurred_n_Noise_", file));

% get the Avg Sxx (PSD) of the training images (as it remains same)
nums = 10;
[m,n] = size(I);
Sxx_avg = zeros(m, n);
for k = 1:1:nums
    file_train = strcat(data_training, int2str(k), ".jpg");
    Sxx_avg = Sxx_avg + Sxx_train(file_train, m, n);
end
Sxx_avg = Sxx_avg ./ nums;

% run weiner filter on testing image, using PSD of training images
output = wiener_filter(Sxx_avg, blurred_noisy, blur_filter, noise_var^(0.5));

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
fprintf('dim: %d \n', dim);
fprintf('blur_sigma(filter): %f \n', sigma_);
fprintf('noise_sigma(additive): %f \n', noise_var^0.5);
fprintf('Original PSNR: %9.7f dB \n', psnr_original);
fprintf('Final PSNR: %9.7f dB \n', psnr_reconstructed);
fprintf('Original MSE: %7.2f \n', mse_original);
fprintf('Final MSE: %7.2f \n', mse_reconstructed);
