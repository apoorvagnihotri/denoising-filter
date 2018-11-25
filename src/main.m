I = im2double(imread('peppers.png'));
I = rgb2gray(I);
imshow(I);
title('Original Image');

n = 12;
sigma_ = 5;
blur_filter = fspecial('gaussian', n, sigma_);
blurred = imfilter(I, blur_filter, 'conv', 'circular');
figure, imshow(blurred);
title('Simulate Blur');

noise_mean = 0.0;
noise_var = 0.04;
blurred_noisy = imnoise(blurred, 'gaussian', noise_mean, noise_var);
figure, imshow(blurred_noisy);
title('Simulate Blur and Noise');

% trying to find best possible nsr in a range
msee = 100;
for k = 0.01:0.02:1.1
    output = wiener_filter(blurred_noisy, blur_filter, k);
    msew = mse(output, I);
    if (msew < msee)
	    msee = msew;
	    nsr = k;
	end
end

% printing out the optimal values
fprintf('optimal k: %f: \n', nsr);
psnr = 10*log10(256*256/msee);
fprintf('dim: %d \n', n);
fprintf('blur_sigma: %f \n', sigma_);
fprintf('noise_sigma: %f \n', noise_var^0.5);
fprintf('PSNR: %9.7f dB \n', psnr);
fprintf('MSE: %7.2f \n', msee);

% printing the corrected image
figure, imshow(imadjust(output));
title('restored image with exact spectrum')
