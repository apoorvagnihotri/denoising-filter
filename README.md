# Intro
I try to implement a wiener filter given [here](), in this assignment. 

---

# Usage
Run `main.m` matlab code, it uses the inbuilt image of `peppers.png`. It runs and tries to find the best SNR ratio. `main.m` uses `wiener_filter.m` file that contains the main filter.

---

# Theory
In Wiener filter, we try to reconstruct an image that has been convolved with a known error function `h(t)`. The convolved image also contains an additive white noise (Gaussian). The filter minimizes the root mean squared error between the reconstructed denoised image and the original image. The error metric that Weiner filter reduces is MSE is directly proportional to the L2 distance between reconstructed and the original image.

While calculating the "deblurring filter" that needs to be convolved with the distorted image the filter needs S_xx, i.e. the PSD of the original image. But this can't be possible as we are to generate this original image itself. The filter gets around this by multiple ways, the way that I have used in my implementation is to use the empirical fact that the PSD of all the natural images is nearly similar, therefore a PSD of another uncorrupted image can be used to estimate the PSD of the original image.

We calculate the PSD of 10 images with similar dimensions, average out this PSD and use this value for the value of S_xx in the Weiner filter Equations to be used as an estimate for the image that we need to reconstruct.

## Equations

![](https://i.imgur.com/lVO7dQv.png)
This equation is what I have implemented. This equation's LHS is the deblurring filter that would need to be convolved with the original image.

Here:
```text
H           : DTFT of the blur function
S_xx        : PSD of the original image (estimated using 10 other images)
S_nn        : PSD of the additive noise
W           : DTFT of the deblur function
f1, f2      : coordinates in the frequency domain
```

---

# Assumptions
* I have assumed the PSD of the original image directly in the function wiener_filter as the PSD of natural images are similar and can be used to estimate others.

---

# Requirements
```text
MATLAB                                           Version 9.5         (R2018b)
toolboxes installed:                                                         
  Simulink                                       Version 9.2         (R2018b)
  Control System Toolbox                         Version 10.5        (R2018b)
  DSP System Toolbox                             Version 9.7         (R2018b)
  Data Acquisition Toolbox                       Version 3.14        (R2018b)
  Deep Learning Toolbox                          Version 12.0        (R2018b)
  Image Processing Toolbox                       Version 10.3        (R2018b)
  Instrument Control Toolbox                     Version 3.14        (R2018b)
  Optimization Toolbox                           Version 8.2         (R2018b)
  Signal Processing Toolbox                      Version 8.1         (R2018b)
  Simulink Control Design                        Version 5.2         (R2018b)
  Statistics and Machine Learning Toolbox        Version 11.4        (R2018b)
  Symbolic Math Toolbox                          Version 8.2         (R2018b)
```

---

# Sample Results
Image 1:
Original Image:
![original](https://i.imgur.com/D5jrHDd.jpg)
Blurred + Noise Added Image:
![distorted](https://i.imgur.com/vZyZQxR.jpg)
Recontructed Image:
![reconstructed](https://i.imgur.com/IgUGH8p.jpg)

Image 2:
Original Image:
![original](https://i.imgur.com/9qVAxEF.jpg)
Blurred + Noise Added Image:
![distorted](https://i.imgur.com/nyDSQr2.jpg)
Recontructed Image:
![reconstructed](https://i.imgur.com/5Jtmi0v.jpg)

Image 3:
Original Image:
![original](https://i.imgur.com/JMFrwhP.png)
Blurred + Noise Added Image:
![distorted](https://i.imgur.com/B994u3R.png)
Recontructed Image:
![reconstructed](https://i.imgur.com/fgWCjyr.png)

---

# Metrics
| Sr | dim | σ_blurr | σ_noise |  PSNR_original | MSE_original | MSE_restored    | PSNR_restored    |
|----|-----|---------|---------|----------------|--------------|-----------------|------------------|
| 1  | 12  |   5     | 0.2     |   13.2 dB      |   92.33      |     58.55       |     16.7 dB      |
| 2  | 12  |   10    | 0.2     |   13.2 dB      |   92.52      |     58.97       |     16.8 dB      |
| 3  | 12  |   10    | 0.4     |   9.38 dB      |   102.1      |     57.80       |     17.0 dB      |
| 4  | 12  |   10    | 1.0     |   6.46 dB      |   108.4      |     47.60       |     16.5 dB      |
| 5  | 7   |   9     | 0.8     |   6.97 dB      |   107.4      |     49.70       |     18.0 dB      |

---
