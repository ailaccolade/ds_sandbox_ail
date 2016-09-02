# -*- coding: utf-8 -*-
"""
Created on Mon Aug 29 12:39:48 2016

@author: anna.lang
"""
import pandas as pd
#import pytest 
from datetime import datetime
from nltk import wordpunct_tokenize 
from nltk.corpus import stopwords


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
  
def date_time_makes_sense(path, start_time_col, end_time_col):
    d = pd.read_csv(path)
    start = pd.to_datetime(d[start_time_col])
    end = pd.to_datetime(d[end_time_col])
    assert (start >= end).all
    
def check_for_English(path):
    d = pd.read_csv(path)
    d_chat = d.loc[d['Widget_Action'] == 'enter_text']
    text = d_chat['Action_content'].astype('str')    
    for line in text:
        tokens = wordpunct_tokenize(line)
    words = [word.lower() for word in tokens]
    stopwords_set = set(stopwords.words('English'))
    words_set = set(words)
    common_elements = words_set.intersection(stopwords_set)
    assert (common_elements > 0).all


  
    
    


d = pd.read_csv('/Users/anna.lang/Work/repo/ds_sandbox_ail/validation/NUI_sandbox_Session.csv')
p = '/Users/anna.lang/Work/repo/ds_sandbox_ail/validation/NUI_sandbox_Session.csv'
date_time_makes_sense(p, 'Date_time_start', 'Date_time_end')

chat_p = '/Users/anna.lang/Work/repo/ds_sandbox_ail/validation/NUI_sandbox_Chat_screen.csv'
chat_d = pd.read_csv(chat_p)
d_chat = chat_d.loc[chat_d['Widget_Action'] == 'enter_text']
text = d_chat['Action_content'].astype('str')

for line in text:
    tokens = wordpunct_tokenize(line)


words = [word.lower() for word in tokens]
stopwords_set = set(stopwords.words('English'))
words_set = set(words)
common_elements = words_set.intersection(stopwords_set)
assert (common_elements > 0)