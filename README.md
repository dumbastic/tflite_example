# Bangkit Final Project

JKT5-A Team:  
- Dommy Asfiandy  
- Indra Wijaya  
- Romansya Setyo Utomo  
- Shafiya Ayu Adzhani  
    
The code is based on this tutorial:  
https://heartbeat.fritz.ai/building-a-cross-platform-image-classifier-with-flutter-and-tensorflow-lite-c7789af9b33a    

Dataset:  
https://www.kaggle.com/rajeshbhattacharjee/rice-diseases-using-cnn-and-svm    

Notebook:    
https://colab.research.google.com/drive/1_QBCQsqNIjZUyUEoiBrHGntZBY87bUlu?usp=sharing      

Step to implement:  
1. Download dataset from Kaggle
2. Go to https://teachablemachine.withgoogle.com/
3. Create image project
4. Upload training set for each class
5. Adjust parameters: Epochs, Batch Size, Learning Rate
6. Start training
7. Export model, choose TensorFlow Lite
8. Download my model (tflite)
9. Place tflite file in assets folder inside this flutter project
10. Debug and release project using Visual Studio Code
11. Publish in Google Play
