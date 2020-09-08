import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import pandas as pd
import json

cred = credentials.Certificate('tidingsproject.json')

firebase_admin.initialize_app(cred)

db = firestore.client()

event_ref = db.collection('Posts')
docs = event_ref.stream()

D = {}

for doc in docs:
    D[doc.id] = str(doc.to_dict())
    print('{} => {}'.format(doc.id, doc.to_dict()))

keys = []
values = []

items = D.items() 
for item in items: 
    keys.append(item[0]), values.append(item[1])


string = values[0]

#Now removing { and }
s = string.replace("{" ,"")
finalstring = s.replace("}" , "")

#Splitting the string based on , we get key value pairs
list = finalstring.split(",")

dictionary ={}
for i in list:
    keyvalue = i.split(":")

    #Replacing the single quotes in the leading.
    m= keyvalue[0].strip('\'')
    m = m.replace("\"", "")
    m = m.replace("'","")
    keyvalue[1] = keyvalue[1].replace("'","")
    dictionary[m] = keyvalue[1].strip('\'')

df = pd.DataFrame([dictionary])

print(df.head())
