# -*- coding: utf-8 -*-
"""
Created on Tue Aug 30 13:07:12 2016

@author: anna.lang
"""
#import dummy data tables - to be updated in aws env

# Test for Session Level Data 

import pytest
from define_validation_functions import *

pth = "/Users/anna.lang/Work/repo/ds_sandbox_ail/validation/iris.csv"
test_list = ['Species']
num_cols = 6
full_cols = ['Species', 'Sepal.Length']

def run_categorical_tests(path, categorical_cols, num_cols, full_cols): 
    is_categorical(path, categorical_cols)
    check_num_cols(path, num_cols)
    check_full(path, full_cols)

run_categorical_tests(pth, test_list, num_cols, full_cols)