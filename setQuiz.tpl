<!DOCTYPE html>
<html lang="en">

<head>
<title>QuizMe - Edit a Quiz</title>
<link rel="stylesheet" type="text/css" href="/static/bootstrap/css/bootstrap.css">



</head>

<body>
<div class="container-fluid">


<h2>Edit the quiz information below for username <span class = "text-success">{{username}}</span>.</h2>

<form class = "form-horizontal" action = "/setQuiz/{{username}}/" method = "POST">
<label>Username</label><input type = text name = "username" value = "{{username}}"><p>
<label>Student ID</label><input type = text name = "studentID" value = "{{studentID}}"><p>
<label>password</label><input type = password name = "password" value = "{{password}}"><p>
<label>Current Quiz Questions:</label><input type = text name = "questions" value = "{{questions}}"><p>
<label>Previous Quiz Questions:</label><input type = text name = "usedQuestions" value = "{{usedQuestions}}"><p>
<label>Course</label><input type = text name = "course" value = "{{course}}"><p>



<button type = "submit" class = "btn">Submit</button>
</form>