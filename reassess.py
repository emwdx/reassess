from bottle import *
import sqlite3, csv

baseDir = '/static/reassess/'
save_path = '/Users/weinbergmath/Sites/reassess/images/'
courses = ['geo','alg2','calc','phys']


HOST = '172.27.8.150'

def addBaseDir(questions):
    for question in questions:
        if(question[2]!=''):
            question[2] = baseDir + question[2]
    return questions

def createQuestionDatabase():
    
    database = sqlite3.connect('questions.db')
    database.execute("CREATE TABLE questions (id INTEGER PRIMARY KEY, questionText NOT NULL, questionAnswer memo, image text,  course char(15) NOT NULL, unit INTEGER, standard INTEGER, standardText text NOT NULL)")
    database.commit()        

def createQuizDatabase():
    
    database = sqlite3.connect('quizzes.db')
    database.execute("CREATE TABLE quizzes (id INTEGER PRIMARY KEY, username NOT NULL, studentID INTEGER, password TEXT, questions TEXT, usedQuestions TEXT, course TEXT )")
    database.commit()        

#createQuestionDatabase()
#createQuizDatabase()

def addstudents(studentinfo):
    
    database = sqlite3.connect('quizzes.db')
    print("INSERT INTO quizzes(username, studentID, password, questions, usedQuestions, course) VALUES (%s,%s,%s,%s,%s,%s)"%(studentinfo[0],studentinfo[1], studentinfo[2], studentinfo[3], studentinfo[4], studentinfo[5]) )
    database.execute("INSERT INTO quizzes(username, studentID, password, questions, usedQuestions, course) VALUES(?,?,?,?,?,?)",(studentinfo[0],studentinfo[1], studentinfo[2], studentinfo[3], studentinfo[4], studentinfo[5]) )
    database.commit()

def readInputFile(filename):
    dataList = []
    with open(filename, newline='') as f:
        reader = csv.reader(f, delimiter=';', quoting=csv.QUOTE_NONE)
        for row in reader:
            print(row)
            addstudents(row)

#readInputFile('students.csv')

def getQuizByUsername(username):
    conn = sqlite3.connect('quizzes.db')
    c = conn.cursor()
    c.execute("SELECT username, studentID, password, questions, usedQuestions, course FROM quizzes WHERE username LIKE '%s'"%(username))
    retrievedQuiz = list(c.fetchall())
    
    if(len(retrievedQuiz)==0):
        return []
    else:
        return retrievedQuiz[0]

def getQuizByCourse(course):
    conn = sqlite3.connect('quizzes.db')
    c = conn.cursor()
    c.execute("SELECT username, studentID, password, questions, usedQuestions, course FROM quizzes WHERE course LIKE '%s'"%(course))
    retrievedQuiz = list(c.fetchall())
    
    if(len(retrievedQuiz)==0):
        return []
    else:
        return retrievedQuiz


def addQuestionToDatabase(question):
    
    database = sqlite3.connect('questions.db')
    c = database.cursor()
    #print("INSERT INTO questions( questionText, questionAnswer, image, course, unit, standard, standardText) VALUES (%s,%s,%s,%s,%s,%s,%s)"%(question[0],question[1],question[2],question[3],question[4],question[5],question[6]) )
    database.execute("INSERT INTO questions( questionText, questionAnswer, image, course, unit, standard, standardText)VALUES (?,?,?,?,?,?,?)",(question[0],question[1],question[2],question[3],question[4],question[5], question[6]))
    new_id = c.lastrowid
    database.commit()
    c.execute("SELECT id FROM questions WHERE questionText LIKE '%s'"%(question[0]))
    new_id = list(c.fetchone())
    c.close()
    
    
    return new_id

def getQuestionFromDatabase(questionIDs):
    questions=[]
    conn = sqlite3.connect('questions.db')
    c = conn.cursor()
    for question in questionIDs:
         c.execute("SELECT questionText, questionAnswer,image,course,unit,standard,standardText FROM questions WHERE id LIKE '%s'"%(question))
         retrievedQuestion = list(c.fetchone())
         questions.append(retrievedQuestion)
    return questions

def getQuestionByID(questionID):
    conn = sqlite3.connect('questions.db')
    c = conn.cursor()
    for question in questionIDs:
         c.execute("SELECT id, questionText,image,course,unit,standard FROM questions WHERE id LIKE '%s'"%(questionID))
         retrievedQuestion = list(c.fetchone())
         
    return retrievedQuestion

def removeQuestionByID(questionID):
    conn = sqlite3.connect('questions.db')
    c = conn.cursor()
    c.execute("DELETE from questions WHERE id = %s"%(questionID))
    conn.commit()

def getQuestionByCourse(course):
    conn = sqlite3.connect('questions.db')
    c = conn.cursor()
    c.execute("SELECT questionText,questionAnswer, image,unit,standard, standardText,id FROM questions WHERE course LIKE '%s' ORDER BY unit, standard"%(course))
    retrievedQuestions = list(c.fetchall())
    questions = []
    for question in retrievedQuestions:
        #print(question[6])
        questions.append(list(question))
    
         
    return questions

@route('/delete/<questionID>')
def deleteEntry(questionID):
    removeQuestionByID(questionID)
    return template('success.tpl', function = 'deleteDB', questionID = questionID)
    
@route('/course/<course>')
def showQuestionsByCourse(course):
    questions = getQuestionByCourse(course)
    questions = addBaseDir(questions)
    return  template('qList.tpl', questions = questions, showAnswers = True)

@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root = '/Users/weinbergmath/Sites/')

@get('/edit/<questionID>')
def editQuestion(questionID):
        conn = sqlite3.connect('questions.db')
        c = conn.cursor()
        c.execute("SELECT questionText, questionAnswer,image,course,unit,standard,standardText,id FROM questions WHERE id LIKE '%s'"%(questionID))
        question = list(c.fetchone())
        #print(question)
        courseIndex = courses.index(question[3])
        unitIndex = question[4]-1
        standardIndex = question[5]-1
 
        course = ['','','','']
        unit = ['','','','','','','','','']
        standard = ['','','','','','','','','']
        course[courseIndex] = 'selected'
        unit[unitIndex] = 'selected'
        standard[standardIndex] = 'selected'
        if(question[2]!=''):
            question[2]= baseDir + question[2]
            
        image = save_path+question[2]
        question[3] = course
        question[4] = unit
        question[5] = standard
 
        
 
        return template('edit.tpl', question = question, showAnswers = True, image = image)
    
@post('/edit/<questionID>')
def changeQuestion(questionID):
        questionText = request.forms.get('questionText')
        questionAnswer = request.forms.get('questionAnswer')
        image = request.files.image
        course = request.forms.get('course')
        unit =request.forms.get('unit')
        standard = request.forms.get('standard')
        standardText = request.forms.get('standardText')
        if(image and image.file):
    #           save_path = '/Users/weinbergmath/Sites/reassess/images/'
               filedata = image.file.read()
               filename = image.filename
               saveFile = open(save_path+filename,'bw')
               saveFile.write(filedata)
               saveFile.close()
               image = 'images/'+filename
                
        else:
            conn = sqlite3.connect('questions.db')
            c = conn.cursor()
            c.execute("SELECT image FROM questions WHERE id LIKE '%s'"%(questionID))
            image = list(c.fetchone())[0]
            print(image)
            

       
        question = [questionText,questionAnswer,image,course,unit,standard,standardText,questionID]
        #print(question)
        conn = sqlite3.connect('questions.db')
        c = conn.cursor()
        c.execute("UPDATE questions SET questionText=?, questionAnswer=?,image=?,course=?,unit=?,standard=?,standardText=? WHERE id LIKE ?",(questionText,questionAnswer,image,course,unit,standard,standardText, questionID))
        conn.commit()
        q1 = getQuestionFromDatabase([questionID])
        q1 = addBaseDir(q1)
        showAnswers = True
        return  template('quiz.tpl', questions = q1, showAnswers = showAnswers)
        
@get('/add/')
def getQuestion():

    return template('add.tpl')



@post('/add/')
def addQuestion():
    questionText = request.forms.get('questionText')
    questionAnswer = request.forms.get('questionAnswer')
    image = request.files.image
    course = request.forms.get('course')
    unit =request.forms.get('unit')
    standard = request.forms.get('standard')
    standardText = request.forms.get('standardText')
     
    if(image and image.file):
#           save_path = '/Users/weinbergmath/Sites/reassess/images/'
           filedata = image.file.read()
           filename = image.filename
           saveFile = open(save_path+filename,'bw')
           saveFile.write(filedata)
           saveFile.close()
           image = 'images/'+filename
            
    else:
           image = ''
    question = [questionText,questionAnswer,image,course,unit,standard,standardText]
  
    newID =  addQuestionToDatabase(question)
    
 
    return template('success.tpl', function = 'addDB', newID = newID)

    
@get('/')
def front():
 
     return  template('frontpage.tpl')




     
@get('/main/')
def front():
 
     return  template('main.tpl')



@get('/q/<questionNumber>')
def showQuestion(questionNumber):

    q1 = getQuestionFromDatabase([questionNumber])
    q1 = addBaseDir(q1)
    showAnswers = True
    return  template('quiz.tpl', questions = q1, showAnswers = showAnswers)


@get('/quiz/<username>/')
def generateQuizFromDB(username,key = ''):
    
    questionList = getQuizByUsername(username)[3]
    
    if(questionList!=[]):
        questionList = questionList.split(',')
        print(questionList)
        for question in questionList:
            question = int(question)
        questions = getQuestionFromDatabase(questionList)
        questions = addBaseDir(questions)
        if(key=='14159'):
            showAnswers = True
        else:
            showAnswers = False
 
        return  template('quiz.tpl', questions = questions, showAnswers = showAnswers)
    else:
        return "User name isn't found!"

@get('/quizSol/<username>/')
def generateQuizFromDB(username,key = '14159'):
    
    questionList = getQuizByUsername(username)[3]
    
    if(questionList!=[]):
        questionList = questionList.split(',')
        print(questionList)
        for question in questionList:
            question = int(question)
        questions = getQuestionFromDatabase(questionList)
        questions = addBaseDir(questions)
        if(key=='14159'):
            showAnswers = True
        else:
            showAnswers = False
 
        return  template('quiz.tpl', questions = questions, showAnswers = showAnswers)
    else:
        return "User name isn't found!"


@get('/setQuiz/<username>/')
def setQuiz(username):
    retrievedQuiz = getQuizByUsername(username)
    
    if(retrievedQuiz!=[]):
            return template('setQuiz.tpl', username = retrievedQuiz[0],studentID = retrievedQuiz[1], password = retrievedQuiz[2], questions = retrievedQuiz[3], usedQuestions = retrievedQuiz[4], course = retrievedQuiz[5])
    else:
        return "User name isn't found!"

@post('/setQuiz/<username>/')
def changeQuiz(username):
        username = request.forms.get('username')
        studentID = request.forms.get('studentID')
        password = request.forms.get('password')
        questions = request.forms.get('questions')
        usedQuestions =request.forms.get('usedQuestions')
        course = request.forms.get('course')
 
        conn = sqlite3.connect('quizzes.db')
        c = conn.cursor()
        c.execute("UPDATE quizzes SET username=?, studentID=?,password=?,questions=?,usedQuestions=?,course=? WHERE username LIKE ?",(username,studentID,password,questions,usedQuestions,course,username))
        conn.commit()
 
        return template('success.tpl', function = 'setQuiz', username = username)

@get('/setClassQuiz/<course>/')
def getClassQuizInfo(course):
    courseQuizzes = getQuizByCourse(course)
       
    return template('setClassQuiz.tpl', courseQuizzes = courseQuizzes)

@post('/setClassQuiz/<course>/')
def setClassQuiz(course):
    courseQuizzes = getQuizByCourse(course)
    conn = sqlite3.connect('quizzes.db')
    c = conn.cursor()
 
    for quiz in courseQuizzes:
        quizQuestions = request.forms.get(quiz[0])
        c.execute("UPDATE quizzes SET questions=? WHERE username LIKE ?",(quizQuestions,quiz[0]))
    conn.commit()

    return template('success.tpl',course = course, function = 'setClassQuiz')
        

run(host = HOST, port = 8080, debug = True)




