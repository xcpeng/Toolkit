import pymongo
import uuid
url = "mongodb_url"
myclient = pymongo.MongoClient(url, uuidRepresentation='standard')

#client.<database_name>.<collection_name>.delete_one({'_id': <id>})
mydb = myclient["a"]
collection = mydb['b']
cursor = collection.find({})
collection.delete_one({'_id':uuid.UUID('{uu-id}')})
a = 0
for document in cursor:
    if document['a'] == 'x':
        a+=1
        print(document)
print(a)
