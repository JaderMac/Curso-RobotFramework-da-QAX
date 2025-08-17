from robot.api.deco import keyword
from pymongo import MongoClient
import bcrypt

import  chave

db = chave.client['robotdb']

@keyword('Clean user from database')
def clean_user(user_email):
    users = db['users']
    tasks = db['tasks']
    
    o_usuario = users.find_one({ 'email' : user_email })

    if(o_usuario):
        tasks.delete_many({'user': o_usuario['_id']})
        users.delete_many({'email':user_email})

@keyword('Remove user from database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email':email})
    print('removing user by ' + email)    

@keyword('Insert user from database')
def insere_usuario(user):

    hash_pass = bcrypt.hashpw(user['password'].encode('utf-8'), bcrypt.gensalt(8))

    doc = {
        'name': user['name'],
        'email': user['email'],
        'password': hash_pass
    }
    
    users = db['users']
    users.insert_one(doc)
    
    print(user)