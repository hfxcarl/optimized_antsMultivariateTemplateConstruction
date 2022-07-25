#!/usr/bin/env python
from argparse import ArgumentParser
import os
import numpy as np
import SimpleITK as sitk


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("-o", "--output", type=str,
                        help="""
                        Name of output average file.
                        """)
    parser.add_argument('--file_list', type=str,
                        nargs="*",  # 0 or more values expected => creates a list
                        help="""
                        Specify a list of input files, space-seperated (i.e. file1 file2 ...).
                        """)
    parser.add_argument("--image_type", default='image',
                        choices=['image', 'warp'],
                        help="""
                        Specify whether the type of image is a nifti structural image,
                        or a set of non-linear (warp) transforms.
                        """)
    parser.add_argument("--method", default='trimmed_mean',
                        choices=['mean', 'median', 'trimmed_mean', 'efficient_trimean', 'huber'],
                        help="""
                        Specify the type of average to create from the image list.
                        """)
    parser.add_argument("--trim_percent", type=float, default=0.15,
                        help="""
                        Specify the fraction to trim off if using trimmed_mean.
                        """)
    parser.add_argument("--normalize", dest='normalize', action='store_true',
                        help="""
                        Whether to divide each image by its mean before computing average.
                        """)
    opts = parser.parse_args()

    if len(opts.file_list)==1:
        print("ONLY ONE INPUT PROVIDED TO --file_list. THE OUTPUT IS THE INPUT.")
        sitk.WriteImage(sitk.ReadImage(opts.file_list[0]), opts.output)
        import sys
        sys.exit()

    # takes an average out of the array values from a list of Niftis
    array_list = []
    for file in opts.file_list:
        if not os.path.isfile(file):
            raise ValueError(f"The provided file {file} does not exist.")
        array = sitk.GetArrayFromImage(sitk.ReadImage(file))
        shape = array.shape # we assume all inputs have the same shape
        array = array.flatten()
        if opts.normalize: # divide the image values by its mean
            array /= array.mean()
        array_list.append(array)

    concat_array = np.array(array_list)
    if opts.method == 'mean':
        average = np.mean(concat_array, axis=0)
    elif opts.method == 'median':
        average = np.median(concat_array,axis=0)
    elif opts.method == 'trimmed_mean':
        from scipy import stats
        average = stats.trim_mean(concat_array, opts.trim_percent, axis=0)
    elif opts.method == 'efficient_trimean': 
        # computes the average from the 20th,50th and 80th percentiles https://en.wikipedia.org/wiki/Trimean
        average = np.quantile(concat_array, (0.2,0.5,0.8),axis=0).mean(axis=0)
    elif opts.method == 'huber':
        import statsmodels.api as sm
        average = sm.robust.scale.huber(concat_array)[0]

    average = average.reshape(shape)

    if opts.image_type=='image':
        average_img = sitk.GetImageFromArray(average, isVector=False)
        average_img.CopyInformation(sitk.ReadImage(opts.file_list[0]))
        sitk.WriteImage(average_img, opts.output)
    elif opts.image_type=='warp':
        average_img = sitk.GetImageFromArray(average, isVector=True)
        average_img.CopyInformation(sitk.ReadImage(opts.file_list[0]))
        sitk.WriteImage(average_img, opts.output)