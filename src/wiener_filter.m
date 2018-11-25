% Main function for giving out a result.
function out_img = wiener_filter(img, blur_filter, nsr)
	[m,n]=size(img);
    H = fft2(blur_filter, m, n);              % Compute DFT of blur_filter
    H_conj = conj(H);                         % Magnitude (element-wise)
    df = H_conj./((abs(H).^2) + nsr);         % deblur_filter
    
    G = fft2(img);                            % convert the distorted to fft
    FFimg = G.*df;
    out_img = real(ifft2(FFimg));              % convert the corrected to time
end
