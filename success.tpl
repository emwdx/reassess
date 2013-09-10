<!DOCTYPE html>
<html lang="en">

<head>
<title>QuizMe - Success!</title>
<link rel="stylesheet" type="text/css" href="/static/bootstrap/css/bootstrap.css">



</head>

<body>
<div class="container-fluid">

%if(function == 'addDB'):
%message = 'The question has been added to the database with ID of <span class = "text-success">%s.'%newID
%elif(function == 'editDB'):

%elif(function == 'setQuiz'):
%message = 'Quiz has been assigned to user <span class = "text-success">%s</span>.'%(username)

%elif(function == 'setClassQuiz'):
%message = 'Quizzes have been assigned to course <p class = "text-success">%s</p>.'%(course)

%elif(function == 'deleteDB'):
%message = 'Question <span class = "text-success">%s</span> has been deleted from the database.'%(questionID)

%end

<div class = "row-fluid">
<div class = "span6 offset3">
<h2>{{!message}}</h2>
</div>
</div>
</div>
</body>
</html>