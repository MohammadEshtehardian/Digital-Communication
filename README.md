# Digital Communication
This repository includes my codes of my project from digital communications course. In this project I simulated a digital communication system that used **QPSK** as its modulation and I examined the effect of **Channel Coding** and **Differential Encoding** on this system.

## Functions

In this part of documentation I will explain all the functions of my simulator. These explanations are in the table below:

| Function | Explanation | Inputs | Outputs |
| -------- | ----------- | ------ | ------- |
| ZeroRemover | Removing the begining of the signal which doesn't have useful information | <ul><li>$x[n]$ (samples of a signal)</li></ul>  | <ul><li>$y_0[n]$ (redundant samples of the begining)</li><li>$y[n]$ (samples of input with information)</li></ul>|
| BitReducer | Reducing the number of bits in each sample of the signal | <ul><li>$x[n]$ (samples of a signal)</li><li>$n$ (number of bits for quantization)</li></ul> | <ul><li>$y[n]$ (new quantized signal)</li><li>$y_{bin}[n]$ (string of 0 and 1 which is bits of new quantized signal) </li></ul> |
| 
