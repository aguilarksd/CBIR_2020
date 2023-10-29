# MATLAB Code of Content-Based Image Retrieval (CBIR)

## Overview

This MATLAB code is designed for Content-Based Image Retrieval (CBIR) using various image descriptors and distance measures. The code allows you to train and test CBIR systems on different datasets and evaluate their performance.

## Dataset

- **Corel-1k** 
- **Corel-5k** 
- **Corel-CBIR** 
- **Caltech-101** 

## Descriptors

- **Correlated MicroStructure Descriptor (CMSD), and three variants**
- **MultiIntegration Features Histogram (MIFH), and five variants**
- **Structure Elements' Descriptor (SED)**
- **Micro-structure descriptor (MSD)**
- **Complete Multi-Texton Histogram (CMTH)**	
- **Color Layout Descriptor (CLD)**
- **Edge Histogram Descriptor (EHD)** 

## Metrics

- **Average Precision (AP)**: Measures the precision of each query's retrieved images. The average precision is computed for each query, and the overall AP is the mean of these values.

- **Average Recall (AR)**: Computes the recall for each query, indicating how many relevant images were retrieved. The average recall is the mean recall across all queries.

- **Mean Average Precision (MAP)**: This metric calculates the mean of the average precision (AP) values for all queries. It provides an overall assessment of retrieval quality, with higher MAP values signifying better performance.

- **ANMRR (Average Normalized Mean Reciprocal Rank)**: ANMRR evaluates the average normalized mean reciprocal rank across queries. It measures the quality of the ranking of relevant images in the retrieval results. A lower ANMRR is indicative of better performance.

## Code Structure

The code is structured into several functions and scripts:

1. `Do_Traning.m`: This script is responsible for training the CBIR system. It extracts image descriptors from a given dataset, saves the descriptors, and associates them with the images and their class labels. The trained data is saved for later testing.

2. `Do_Testing.m`: This script performs the testing phase of the CBIR system. It retrieves images from the database based on query images, evaluates their similarity using different distance measures, and calculates retrieval metrics.

3. `Get_DB_D.m`: This function is used to extract and save image descriptors for each image in the dataset.

4. `Get_Ev_D.m`: This function handles the evaluation phase of the CBIR system. It calculates retrieval metrics and saves the results.

5. Other utility functions are provided to calculate metrics, retrieve images, and manage data.

## Usage

To use this code, follow these steps:

1. Modify the database (`DB`) and image descriptors (`N_Des`) as needed to match your dataset and descriptor configurations.

2. Run the `Do_Traning.m` script to train the CBIR system and extract descriptors for your dataset.

3. Run the `Do_Testing.m` script to perform testing and evaluation. Make sure to set the query image list (`qi`) based on your requirements.

4. Review the results, including precision, recall, mean average precision (MAP), and average normalized mean reciprocal rank (ANMRR).

## Configuration

- `DB`: List of datasets you want to use for training and testing.
- `N_Des`: List of image descriptors along with their parameters.
- `Met`: List of distance measures to be used in the evaluation.
- `qi`: Set to 1 if you have a query image list or 0 if you don't.

## Results

The code generates retrieval results, including precision, recall, MAP, and ANMRR, and saves them for analysis. These metrics can help you evaluate the performance of your CBIR system.

## Dependencies

This code requires MATLAB to run. Ensure you have the necessary MATLAB toolboxes and dependencies for image processing.

## Conclusion

This code provides a framework for content-based image retrieval using different descriptors and distance measures. You can adapt and extend it to your specific use case by customizing the datasets, descriptors, and evaluation metrics.

## Reference

Aguilar-Domínguez, Kevin Salvador, Raúl Pinto-Elías, Juan Gabriel González-Serna, and Andrea Magadán-Salazar. "Image Description Using the Relation Between Color and Texture in Retrieval Task." Traitement du Signal 39, no. 1 (2022).

https://www.iieta.org/journals/ts/paper/10.18280/ts.390103
