<!DOCTYPE html>
<html lang="en">
<script type="text/javascript" src="/static/mathjax/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>

<head>
<title>QuizMe</title>
<link rel="stylesheet" type="text/css" href="/static/bootstrap/css/bootstrap.css">
</head>

<body>


%number = 1
%length = len(questions)

<div class="container-fluid">

%for question in questions:

<! -This starts the question>
<div class = "row-fluid">
<div class = "span12">
<h3>{{questions[number-1][5]}}</h3>
</div>
</div>
<div class = "row-fluid">
<div class = "span12">
<hr>
<h3>Question ID {{questions[number-1][6]}} <a href = "/edit/{{questions[number-1][6]}}">(Edit)</a></h3>
</div>
</div>

%if(questions[number-1][2]!=''):

<div class="row-fluid">
    <div class="span5">
     <img src = "{{questions[number-1][2]}}"> 
    </div>
    
    <div class="span7">
      <div class = "hero-unit" >
      <h3>{{! questions[number-1][0]}}</h3>
      %if(showAnswers==True):
      <p class =  "text-error">Answer: {{! questions[number-1][1]}}</p>
      %end
      
      <div>
    </div>
  </div>
</div>

%else:
<div class="row-fluid">
    
    
    <div class="span12">
      <div class = "hero-unit" >
      <h3>{{! questions[number-1][0]}}</h3>
      %if(showAnswers==True):
      <p class =  "text-error">Answer: {{! questions[number-1][1]}}</p>
      %end
      
      <div>
    </div>
  </div>
</div>
%end
<! - This ends the question unit >
%number +=1
%end

</div>
</body>
</html>

