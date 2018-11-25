# Intro
I try to implement a wiener filter given [here](), in this assignment. 

---

# Usage
Run `main.m` matlab code, it uses the inbuilt image of `peppers.png`. It runs and tries to find the best snr ratio. `main.m` uses `wiener_filter.m` file that contains the main filter.

---

# Theory


---

# Requirements
```matlab
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

# Results
Original Image:
![original](https://i.imgur.com/hazRI7w.png)

Blurred + Noise Added Image:
![distorted](https://i.imgur.com/NvSDNJw.png)

Recontructed Image:
![reconstructed](https://i.imgur.com/t1vai5E.png)

---

# Conclusions
* We can add a forgiveness metric to the algorithms to allow for slightly non-linear trajectory of a point of interest. This would take `f_pixels`, which would accept any point even on the wrong side of a line until its distance crosses `f_pixels`.
* This `f_pixels` approach could also be used to solve the issue of very narrow TERs as seen in the case of `I3`.

---

# Future Work
* Forgiveness matric to make the valid regions more robust to a nonlinear motion of the point of interest.
* Forgiveness metric to make the valid regions more wide in the case of narrow TERs.
* Convert the code to be more modular to accept any custom fundamental matrices that user might want to give.

---
