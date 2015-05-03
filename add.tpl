<!DOCTYPE html>
<html lang="en">

<head>
<title>QuizMe - Add a question</title>
<link rel="stylesheet" type="text/css" href="/static/bootstrap/css/bootstrap.css">

</head>

<body>


<h2>Add a question below:</h2>

<form class = "form-horizontal" action = "/add/" method = "POST" enctype="multipart/form-data">

<div class="control-group">
Question Text:<textarea rows = "4" cols = "50" name = "questionText" class = "input"  /></textarea>
Question Answer:<input type = "text" name = "questionAnswer" class = "input-small" />
   

Image name: <input type = "file" name = "image" class = "input-small" />
</div>
<div class = "control-group">
Course:
<select name = 'course'>
  <option value = 'geo'>Geometry</option>
  <option value = 'alg2'>Advanced Algebra</option>
  <option value = 'calc'>Calculus</option>
  <option value = 'phys'>Physics</option>
  <option value = 'ibmath'>IB Math</option>
  <option value = 'ibphysics'>IB Physics</option>
 </select>

Unit:
<select name = 'unit' >
  <option value = '1'>1</option>
  <option value = '2'>2</option>
  <option value = '3'>3</option>
  <option value = '4'>4</option>
  <option value = '5'>5</option>
  <option value = '6'>6</option>
  <option value = '7'>7</option>
  <option value = '8'>8</option>
  <option value = '9'>9</option>
   <option value = '10'>10</option>
   </select>
Standard:
<select name = 'standard' >
  <option value = '1'>1</option>
  <option value = '2'>2</option>
  <option value = '3'>3</option>
  <option value = '4'>4</option>
  <option value = '5'>5</option>
  <option value = '6'>6</option>
  <option value = '7'>7</option>
  <option value = '8'>8</option>
  
   </select>
   
</div>
Standard Text<input type = "text" name = "standardText" class = "input-small" />
<button type = "submit" class = "btn">Submit</button>
</form>


