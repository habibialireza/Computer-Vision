Here you can find my project for this course. 
The goal of the project was to come up with a method for stereo matching. 

I implemented two method: 1-a classical machine learning method called block matching 2-a more modern method using deep learning

Block matching: in this method i basically compared individual blocks in the two pictures and found the coresponding points in them by finding the most alike block, then I calculated the disparity map using these points.

Deep learning method: in this method I used a database called Kitti2015 to train my deep learning model. My model's architecture is apparent in the notebook. I basically concatonated the left and right images
in the third dimention(the color channel) the I used an architecture similar to autoencoders to make my model learn to make disparity maps out of the input concatonated image. Furthermore, I performed multilevel thresholding on the output image for better results.
