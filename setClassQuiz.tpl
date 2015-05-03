<!DOCTYPE html>
<html lang="en">

<head>
<title>QuizMe - Class Quiz View</title>
<link rel="stylesheet" type="text/css" href="/static/bootstrap/css/bootstrap.css">



</head>

<body>
<div class="container-fluid">


<h2>Edit the quiz information below for the <span class = "text-success">{{courseQuizzes[0][5]}}</span> class:</h2>
<div class = "row-fluid">
<div class = "span6 offset3">
<form class = "form" action = "/setClassQuiz/{{courseQuizzes[0][5]}}/" method = "POST">
<table class = "table table-bordered table-striped">
%for quiz in courseQuizzes:
<tr><td><a href = "/quizSol2/{{quiz[0]}}/">{{quiz[0]}}</a></td><td><input type = text name = "{{quiz[0]}}" value = "{{quiz[3]}}" </td><td>Used Questions:<input type = text name = "{{quiz[0]}}_used" value = "{{quiz[4]}}"> </td></tr>
%end
</table>
<button type = "submit" class = "btn">Submit</button>
</form>
</div>
</div>
</div>
</body>
</html>
