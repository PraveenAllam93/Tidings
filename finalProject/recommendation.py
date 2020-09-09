import pandas as pd
import numpy as np
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import pickle

def get_title_from_index(index):
    return df[df.id == index]["course_title"].values[0]
def get_index_from_title(title):
    return df[df.event_name == title]["id"].values[0]



df = pd.read_csv(r'C:\Users\harin\Documents\Projects\tidings\Recommendtaions\tidings data.csv')

features = ["event_name","type","organized_by","description"]

for feature in features:
    df[feature] = df[feature].fillna('')

def combine_features(row):

    try:
        return row['type']+" "+row['organized_by']+" "+row['description']
    except:
        print ("Error:", row)

df["combined_feature"] = df.apply(combine_features,axis=1)

cv = CountVectorizer()
count_matrix = cv.fit_transform(df["combined_feature"])

cosine_sim = cosine_similarity(count_matrix) 
course_user_likes = input("Search course of Your choice : ")

course_index = get_index_from_title(course_user_likes)

similar_courses = list(enumerate(cosine_sim[course_index]))

sorted_similar_courses = sorted(similar_courses,key=lambda x:x[1],reverse=True)[1:]

pickle.dump(sorted_similar_courses,open("model.pkl","wb"))
model = pickle.load((open('model.pkl','rb')))