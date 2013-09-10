<!DOCTYPE html>
<html lang="en">

<head>
<title>QuizMe - Add a question</title>
<link rel="stylesheet" type="text/css" href="/static/bootstrap/css/bootstrap.css">
<script type="text/javascript" src="/static/mathjax/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>

</head>

<body>
<div class="container-fluid">
<div class = "row-fluid">
<div class = "span12">
<h1>Standard {{question[6]}}</h1>
</div>
</div>


%if(question[2]!=''):

<div class="row-fluid">
    <div class="span5">
     <img src = "{{question[2]}}"> 
    </div>
    
    <div class="span7">
      <div class = "hero-unit" >
      <h3>{{! question[0]}}</h3>
      %if(showAnswers==True):
      <p class =  "text-error">Answer: {{! question[1]}}</p>
      %end
      
      <div>
    </div>
  </div>
</div>

%else:
<div class="row-fluid">
    
    
    <div class="span12">
      <div class = "hero-unit" >
      <h4>{{! question[0]}}</h4>
      %if(showAnswers==True):
      <p class =  "text-error">Answer: {{! question[1]}}</p>
      %end
      
      <div>
    </div>
  </div>
</div>
%end


<h2>Edit the question below or <a href = "/delete/{{!question[7]}}">delete</a> this question.</h2>

<form class = "form-horizontal" action = "/edit/{{!question[7]}}" method = "POST" enctype="multipart/form-data">

<div class="control-group">
Question Text:<textarea rows = "4" cols = "50" name = "questionText" class = "input"  />{{!question[0]}}</textarea>
Question Answer:<input type = "text" name = "questionAnswer" class = "input-small" value = "{{!question[1]}}" />
</div>
Image name: <input type = "file" name = "image" class = "input-small" />
<div class = "control-group">
Course:
<select name = 'course'>
  <option value = 'geo' {{question[3][0]}}>Geometry</option>
  <option value = 'alg2' {{question[3][1]}}>Advanced Algebra</option>
  <option value = 'calc' {{question[3][2]}}>Calculus</option>
  <option value = 'phys' {{question[3][3]}}>Physics</option>
 </select>

Unit:
<select name = 'unit' >
  <option value = '1' {{question[4][0]}}>1</option>
  <option value = '2' {{question[4][1]}}>2</option>
  <option value = '3' {{question[4][2]}}>3</option>
  <option value = '4' {{question[4][3]}}>4</option>
  <option value = '5' {{question[4][4]}}>5</option>
  <option value = '6' {{question[4][5]}}>6</option>
  <option value = '7' {{question[4][6]}}>7</option>
  <option value = '8' {{question[4][7]}}>8</option>
  <option value = '9' {{question[4][8]}}>9</option>
   </select>
Standard:
<select name = 'standard' >
  <option value = '1' {{question[5][0]}}>1</option>
  <option value = '2' {{question[5][1]}}>2</option>
  <option value = '3' {{question[5][2]}}>3</option>
  <option value = '4' {{question[5][3]}}>4</option>
  <option value = '5' {{question[5][4]}}>5</option>
  <option value = '6' {{question[5][5]}}>6</option>
  <option value = '7' {{question[5][6]}}>7</option>
  <option value = '8' {{question[5][7]}}>8</option>
  <option value = '9' {{question[5][8]}}>9</option>
   </select>
   
</div>
Standard Text<input type = "text" name = "standardText" class = "input-large" value = "{{question[6]}}"/>
<button type = "submit" class = "btn">Submit</button>
</form>