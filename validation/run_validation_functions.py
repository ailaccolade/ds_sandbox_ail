# -*- coding: utf-8 -*-
"""
Created on Tue Aug 30 13:07:12 2016

@author: anna.lang
"""
#import dummy data tables - to be updated in aws env

# Test for Session Level Data 

import pytest
from define_validation_functions import *

def run_tests(path, categorical_cols, num_cols, full_cols): 
    is_categorical(path, categorical_cols)
    check_num_cols(path, num_cols)
    check_full(path, full_cols)

#Simple Iris test case 
Iris_pth = "/Users/anna.lang/Work/repo/ds_sandbox_ail/validation/iris.csv"
Iris_Cats_list = ['Species']
Iris_n_cols = 6
Iris_no_blanks_cols = ['Species', 'Sepal.Length', 'Sepal.Width', 'Petal.Length']
run_tests(Iris_pth, test_list, num_cols, full_cols)

#Simple Session Data test case 
Sess_pth = "/Users/anna.lang/Work/repo/ds_sandbox_ail/validation/NUI_sandbox_Session.csv"
Sess_num_cols = 8
Sess_full_cols = ['Session_id', 'Date_time_start', 'Date_time_end','Data_feed_v']
run_tests(Sess_pth, full_cols, Sess_num_cols, Sess_full_cols)


