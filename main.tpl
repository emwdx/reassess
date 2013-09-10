<!DOCTYPE html>
<html lang="en">

<head>
<title>QuizMe - Control Panel</title>
<link rel="stylesheet" type="text/css" href="/static/bootstrap/css/bootstrap.css">



</head>

<body>
<div class="container-fluid">
<div class = "row-fluid">
<div class = "span4 offset4">
<h1>What would you like to do?</h1>
</div>
</div>
<div class = "row-fluid">
<div class = "span4 offset4">
<a href = "/add/"><h3>Add a question to the database</h3></a><br>
<h3>View questions by course:</h3><br>
<ul>
<li><a href = "/course/calc">Calculus</a></li>
<li><a href = "/course/alg2">Algebra 2</a></li>
<li><a href = "/course/geo">Geometry</a></li>
<li><a href = "/course/phys">Physics</a></li>
</ul>
</div>
</div>
<div class = "row-fluid">
<div class = "span4 offset4">
<h3>Assign a quiz by class:</h3><br>

<ul>
<li><a href = "/setClassQuiz/calc/">Calculus</a></li>
<li><a href = "/setClassQuiz/math10/">Algebra 2</a></li>
<li><a href = "/setClassQuiz/math9/">Geometry</a></li>
<li><a href = "/setClassQuiz/phys/">Physics</a></li>
</ul>
</div>
</div>
</div>
</body>
</html>