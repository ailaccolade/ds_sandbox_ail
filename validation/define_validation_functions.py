# -*- coding: utf-8 -*-
"""
Created on Mon Aug 29 12:39:48 2016

@author: anna.lang
"""
import pandas as pd
#import pytest 



def is_categorical(path, categorical_cols):
    d = pd.read_csv(path) 
    cats_in_d_list = list(d.select_dtypes(include=['O']).columns)
    assert cats_in_d_list == categorical_cols
                 
def check_num_cols(path, expected_num_cols):
    d = pd.read_csv(path)
    n = len(d.columns)
    assert n == expected_num_cols


def check_full(path, full_cols):
    d = pd.read_csv(path)
    d_sub = d[full_cols]
    assert d_sub.isnull().any().any() == False
  
def date_time_makes_sense(path):
    d = pd.read_csv(path)
    start = d['start_time']
    end = d['end_time']
    assert start>=end
    
