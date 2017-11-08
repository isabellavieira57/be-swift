# -*- coding: utf-8 -*-
from firebase import firebase as fb
import csv
import json

def saveToFirebase (firebase):
	with open('questoes.csv', 'r') as csvfile:
		reader = csv.DictReader(csvfile)
		for row in reader: 
			print "id: ", row["id"]

			correct_answer = row["correct_answer"].split(",")
			correct_answers = []
			for i in correct_answer:
				correct_answers.append(i)
			print "correct_answers: ", correct_answers

			multiple_choice = row["options"].split(",")
			options = []
			for i in multiple_choice:
				options.append(i)
			print "options: ", options

			topics = row["topic"].split(",")
			tags = []
			for i in topics:
				tags.append(i)
			print "tags: ", tags

			challenge = {
					'id': int(row["id"]),	
					'question': row["question"],
					'example_code': row["example_code"],
					'options': options,
					'estimated_time': int(row["estimated_time"]),
					'mechanics': row["mechanics"],
					'level': row["level"],			
					'correct_answer': correct_answers,
					'feedback': row["feedback"],
					'tags': tags,
					'resource_link': row["resource_link"],
			}
			sent = json.dumps(challenge)
			jsonData = json.loads(sent)
			print "Dados: ", jsonData
			firebase.post("level-1", jsonData)

firebase = fb.FirebaseApplication('https://be-swift.firebaseio.com/', None)
print "Salvando no Firebase... \n"
saveToFirebase (firebase)
print "Done! \n"