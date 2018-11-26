% Main function for giving out a result.
function out_img = wiener_filter(original_img, img, blur_filter, sigma_)
    gamma = 1;                                % When we have a zero in Sxx,
                                              % we replace by gamma, for
                                              % avoiding NaN.
	[m,n]=size(img);
    H = fft2(blur_filter, m, n);              % Compute DFT of blur_filter
    H_conj = conj(H);                         % Magnitude (element-wise)
    Snn = ones(m,n).*(sigma_^2);
    sx = fft2(original_img);
    Sxx = (abs(sx).^2)./numel(sx);            % Computing PSD of original img
    Sxx(Sxx(:)==0)=gamma;
    k = Snn ./ Sxx;                           % finding the ratio of Sxx/Snn
    df = H_conj./((abs(H).^2) + k);           % deblur_filter
    
    G = fft2(img);                            % convert the distorted to fft
    FFimg = G.*df;
    out_img = imadjust(real(ifft2(FFimg)));   % convert the corrected to time
end
